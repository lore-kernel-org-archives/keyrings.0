From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 29 May 2018 03:29:49 +0000
Subject: [RFC 10/10] KEYS: asym_tpm: Implement the encrypt operation
Message-Id: <20180529032949.30526-12-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180529032949.30526-11-denkenz@gmail.com>
In-Reply-To: <20180529032949.30526-11-denkenz@gmail.com>
To: keyrings@vger.kernel.org

This patch implements the pkey_decrypt operation using the private key
blob.  The blob is first loaded into the TPM via tpm_loadkey2.  Once the
handle is obtained, tpm_unbind operation is used to decrypt the data on
the TPM and the result is returned.  The key loaded by tpm_loadkey2 is
then evicted via tpm_flushspecific operation.

This patch assumes that the SRK authorization is a well known 20-byte of
zeros and the same holds for the key authorization of the provided key.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 62 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index a06950ff0939..cf5a35143fbc 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -348,7 +348,8 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	info->max_enc_size = len;
 	info->max_dec_size = tk->key_len / 8;
 
-	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT;
+	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
+			      KEYCTL_SUPPORTS_DECRYPT;
 
 	ret = 0;
 error_free_tfm:
@@ -417,6 +418,62 @@ static int tpm_key_encrypt(struct tpm_key *tk,
 	return ret;
 }
 
+/*
+ * Decryption operation is performed with the private key in the TPM.
+ */
+static int tpm_key_decrypt(struct tpm_key *tk,
+			   struct kernel_pkey_params *params,
+			   const void *in, void *out)
+{
+	struct tpm_buf *tb;
+	uint32_t keyhandle;
+	uint8_t srkauth[SHA1_DIGEST_SIZE];
+	uint8_t keyauth[SHA1_DIGEST_SIZE];
+	int r;
+
+	pr_devel("=>%s()\n", __func__);
+
+	if (params->hash_algo)
+		return -ENOPKG;
+
+	if (strcmp(params->encoding, "pkcs1"))
+		return -ENOPKG;
+
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	/* TODO: Handle a non-all zero SRK authorization */
+	memset(srkauth, 0, sizeof(srkauth));
+
+	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+				tk->blob, tk->blob_len, &keyhandle);
+	if (r < 0) {
+		pr_info("loadkey2 failed (%d)\n", r);
+		goto error;
+	}
+
+	pr_info("Got key handle: %u", keyhandle);
+
+	/* TODO: Handle a non-all zero key authorization */
+	memset(keyauth, 0, sizeof(keyauth));
+
+	r = tpm_unbind(tb, keyhandle, keyauth,
+		       in, params->in_len, out, params->out_len);
+	if (r < 0) {
+		pr_info("tpm_unbind failed (%d)\n", r);
+		goto error;
+	}
+
+	if (tpm_flushspecific(tb, keyhandle) < 0)
+		pr_info("flushspecific failed (%d)\n", r);
+
+error:
+	kzfree(tb);
+	pr_devel("<=%s() = %d\n", __func__, r);
+	return r;
+}
+
 /*
  * Do encryption, decryption and signing ops.
  */
@@ -431,6 +488,9 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
 	case kernel_pkey_encrypt:
 		ret = tpm_key_encrypt(tk, params, in, out);
 		break;
+	case kernel_pkey_decrypt:
+		ret = tpm_key_decrypt(tk, params, in, out);
+		break;
 	default:
 		BUG();
 	}
-- 
2.16.1

