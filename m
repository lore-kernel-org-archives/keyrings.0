From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 02 Aug 2018 18:31:21 +0000
Subject: [RFCv3 13/13] KEYS: asym_tpm: Add support for the sign operation
Message-Id: <20180802183121.22909-14-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The sign operation can operate in a non-hashed mode by running the RSA
sign operation directly on the input.  This assumes that the input is
less than key_size_in_bytes - 11.  Since the TPM performs its own PKCS1
padding, it isn't possible to support 'raw' mode, only 'pkcs1'.

Alternatively, a hashed version is also possible.  In this variant the
input is hashed via the selected hash function first, converted to ASN.1
and then the sign operation is performed on the result.  This is similar
to what crypto/rsa-pkcs1pad.c tries to do.  However, it seems that
implementation is not actually computing a hash first!

ASN1 templates were copied from crypto/rsa-pkcs1pad.c.  There seems to
be no easy way to expose that functionality, but likely the templates
should be shared somehow.  For now only SHA1 & SHA256 templates are
supported to keep the code minimal for review purposes.

The sign operation is implemented via TPM_Sign operation on the TPM.
It is assumed that the TPM wrapped key provided uses
TPM_SS_RSASSAPKCS1v15_DER signature scheme.  This allows the TPM_Sign
operation to work on data up to key_len_in_bytes - 11 bytes long.

In theory, we could also use TPM_Unbind instead of TPM_Sign, but we would
have to manually pkcs1 pad the digest first.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 177 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 8789df029313..a8cc8fc7e3fb 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -443,7 +443,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 
 	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
 			      KEYCTL_SUPPORTS_DECRYPT |
-			      KEYCTL_SUPPORTS_VERIFY;
+			      KEYCTL_SUPPORTS_VERIFY |
+			      KEYCTL_SUPPORTS_SIGN;
 
 	ret = 0;
 error_free_tfm:
@@ -564,6 +565,177 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	return r;
 }
 
+/*
+ * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
+ */
+static const u8 digest_info_sha1[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
+	0x2b, 0x0e, 0x03, 0x02, 0x1a,
+	0x05, 0x00, 0x04, 0x14
+};
+
+static const u8 digest_info_sha256[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
+	0x05, 0x00, 0x04, 0x20
+};
+
+static const struct asn1_template {
+	const char	*name;
+	const u8	*data;
+	size_t		size;
+} asn1_templates[] = {
+#define _(X) { #X, digest_info_##X, sizeof(digest_info_##X) }
+	_(sha1),
+	_(sha256),
+	{ NULL }
+#undef _
+};
+
+static const struct asn1_template *lookup_asn1(const char *name)
+{
+	const struct asn1_template *p;
+
+	for (p = asn1_templates; p->name; p++)
+		if (strcmp(name, p->name) = 0)
+			return p;
+	return NULL;
+}
+
+static uint8_t *get_digest(const void *in, size_t in_len,
+			   const char *hash_algo, uint32_t *out_digest_len)
+{
+	struct crypto_ahash *tfm;
+	struct ahash_request *req;
+	struct scatterlist in_sg;
+	struct crypto_wait cwait;
+	const struct asn1_template *asn1;
+	void *digest;
+	uint32_t digest_len;
+	int r;
+
+	pr_devel("=>%s()\n", __func__);
+
+	asn1 = lookup_asn1(hash_algo);
+	if (!asn1)
+		return ERR_PTR(-ENOPKG);
+
+	tfm = crypto_alloc_ahash(hash_algo, 0, 0);
+	if (IS_ERR(tfm))
+		return ERR_CAST(tfm);
+
+	digest_len = crypto_ahash_digestsize(tfm);
+	pr_info("digest_len: %u\n", digest_len);
+
+	r = -ENOMEM;
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto error_free_tfm;
+
+	r = -ENOMEM;
+	/* Also request enough space for the ASN.1 template */
+	digest_len += asn1->size;
+	digest = kzalloc(digest_len, GFP_KERNEL);
+	if (!digest)
+		goto error_free_req;
+
+	sg_init_one(&in_sg, in, in_len);
+	ahash_request_set_crypt(req, &in_sg, digest + asn1->size, in_len);
+	crypto_init_wait(&cwait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				   CRYPTO_TFM_REQ_MAY_SLEEP,
+				   crypto_req_done, &cwait);
+
+	r = crypto_wait_req(crypto_ahash_digest(req), &cwait);
+
+	if (r)
+		kfree(digest);
+	else if (out_digest_len)
+		*out_digest_len = digest_len;
+
+	/* Copy the ASN.1 template before the digest */
+	memcpy(digest, asn1->data, asn1->size);
+
+error_free_req:
+	ahash_request_free(req);
+error_free_tfm:
+	crypto_free_ahash(tfm);
+
+	if (r)
+		return ERR_PTR(r);
+
+	return digest;
+}
+
+/*
+ * Sign operation is performed with the private key in the TPM.
+ */
+static int tpm_key_sign(struct tpm_key *tk,
+			struct kernel_pkey_params *params,
+			const void *in, void *out)
+{
+	struct tpm_buf *tb;
+	uint32_t keyhandle;
+	uint8_t srkauth[SHA1_DIGEST_SIZE];
+	uint8_t keyauth[SHA1_DIGEST_SIZE];
+	void *digest = NULL;
+	uint32_t digest_len;
+	uint32_t in_len = params->in_len;
+	int r;
+
+	pr_devel("=>%s()\n", __func__);
+
+	if (strcmp(params->encoding, "pkcs1"))
+		return -ENOPKG;
+
+	if (params->hash_algo) {
+		digest = get_digest(in, in_len, params->hash_algo, &digest_len);
+		if (IS_ERR(digest))
+			return PTR_ERR(digest);
+
+		pr_info("computing digest succeeded\n");
+		in = digest;
+		in_len = digest_len;
+	}
+
+	if (in_len > tk->key_len / 8 - 11) {
+		r = -EOVERFLOW;
+		goto error_free_digest;
+	}
+
+	r = -ENOMEM;
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		goto error_free_digest;
+
+	/* TODO: Handle a non-all zero SRK authorization */
+	memset(srkauth, 0, sizeof(srkauth));
+
+	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+			 tk->blob, tk->blob_len, &keyhandle);
+	if (r < 0) {
+		pr_devel("loadkey2 failed (%d)\n", r);
+		goto error_free_tb;
+	}
+
+	/* TODO: Handle a non-all zero key authorization */
+	memset(keyauth, 0, sizeof(keyauth));
+
+	r = tpm_sign(tb, keyhandle, keyauth, in, in_len, out, params->out_len);
+	if (r < 0)
+		pr_devel("tpm_sign failed (%d)\n", r);
+
+	if (tpm_flushspecific(tb, keyhandle) < 0)
+		pr_devel("flushspecific failed (%d)\n", r);
+
+error_free_tb:
+	kzfree(tb);
+error_free_digest:
+	kfree(digest);
+	pr_devel("<=%s() = %d\n", __func__, r);
+	return r;
+}
+
 /*
  * Do encryption, decryption and signing ops.
  */
@@ -581,6 +753,9 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	case kernel_pkey_decrypt:
 		ret = tpm_key_decrypt(tk, params, in, out);
 		break;
+	case kernel_pkey_sign:
+		ret = tpm_key_sign(tk, params, in, out);
+		break;
 	default:
 		BUG();
 	}
-- 
2.16.1

