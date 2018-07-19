From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 19 Jul 2018 18:30:09 +0000
Subject: [RFCv2 RESEND 11/13] KEYS: asym_tpm: Implement signature verification
Message-Id: <20180719183011.8574-12-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This patch implements the verify_signature operation.  The public key
portion extracted from the TPM key blob is used.  The operation is
performed entirely in software using the crypto API.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 106 +++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index af661c9d55d7..571fb98e1af9 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -15,6 +15,7 @@
 #include <keys/asymmetric-subtype.h>
 #include "../../security/keys/trusted.h"
 #include <crypto/asym_tpm_subtype.h>
+#include <crypto/public_key.h>
 
 #define TPM_ORD_FLUSHSPECIFIC	186
 #define TPM_ORD_LOADKEY2	65
@@ -293,12 +294,16 @@ static int determine_akcipher(const char *encoding, const char *hash_algo,
 	pr_info("encoding: %s, hash_algo: %s\n",
 		encoding ? encoding : "", hash_algo ? hash_algo : hash_algo);
 
-	/* TODO: We don't support hashing yet */
-	if (hash_algo)
-		return -ENOPKG;
-
 	if (strcmp(encoding, "pkcs1") = 0) {
-		strcpy(alg_name, "pkcs1pad(rsa)");
+		if (!hash_algo) {
+			strcpy(alg_name, "pkcs1pad(rsa)");
+			return 0;
+		}
+
+		if (snprintf(alg_name, CRYPTO_MAX_ALG_NAME, "pkcs1pad(rsa,%s)",
+			     hash_algo) >= CRYPTO_MAX_ALG_NAME)
+			return -EINVAL;
+
 		return 0;
 	}
 
@@ -349,7 +354,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	info->max_dec_size = tk->key_len / 8;
 
 	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
-			      KEYCTL_SUPPORTS_DECRYPT;
+			      KEYCTL_SUPPORTS_DECRYPT |
+			      KEYCTL_SUPPORTS_VERIFY;
 
 	ret = 0;
 error_free_tfm:
@@ -494,6 +500,93 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	return ret;
 }
 
+/*
+ * Verify a signature using a public key.
+ */
+static int tpm_key_verify_signature(const struct key *key,
+				    const struct public_key_signature *sig)
+{
+	const struct tpm_key *tk = key->payload.data[asym_crypto];
+	struct crypto_wait cwait;
+	struct crypto_akcipher *tfm;
+	struct akcipher_request *req;
+	struct scatterlist sig_sg, digest_sg;
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
+	uint32_t der_pub_key_len;
+	void *output;
+	unsigned int outlen;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	BUG_ON(!tk);
+	BUG_ON(!sig);
+	BUG_ON(!sig->s);
+
+	if (!sig->digest)
+		return -ENOPKG;
+
+	ret = determine_akcipher(sig->encoding, sig->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
+					 der_pub_key);
+
+	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
+	if (ret < 0)
+		goto error_free_tfm;
+
+	ret = -ENOMEM;
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto error_free_tfm;
+
+	ret = -ENOMEM;
+	outlen = crypto_akcipher_maxsize(tfm);
+	output = kmalloc(outlen, GFP_KERNEL);
+	if (!output)
+		goto error_free_req;
+
+	sg_init_one(&sig_sg, sig->s, sig->s_size);
+	sg_init_one(&digest_sg, output, outlen);
+	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
+				   outlen);
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	/* Perform the verification calculation.  This doesn't actually do the
+	 * verification, but rather calculates the hash expected by the
+	 * signature and returns that to us.
+	 */
+	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+	if (ret)
+		goto out_free_output;
+
+	/* Do the actual verification step. */
+	if (req->dst_len != sig->digest_size ||
+	    memcmp(sig->digest, output, sig->digest_size) != 0)
+		ret = -EKEYREJECTED;
+
+out_free_output:
+	kfree(output);
+error_free_req:
+	akcipher_request_free(req);
+error_free_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	if (WARN_ON_ONCE(ret > 0))
+		ret = -EINVAL;
+	return ret;
+}
+
 /*
  * Parse enough information out of TPM_KEY structure:
  * TPM_STRUCT_VER -> 4 bytes
@@ -654,6 +747,7 @@ struct asymmetric_key_subtype asym_tpm_subtype = {
 	.destroy		= asym_tpm_destroy,
 	.query			= tpm_key_query,
 	.eds_op			= tpm_key_eds_op,
+	.verify_signature	= tpm_key_verify_signature,
 };
 EXPORT_SYMBOL_GPL(asym_tpm_subtype);
 
-- 
2.16.1

