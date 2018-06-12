From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 12 Jun 2018 15:55:31 +0000
Subject: [RFCv2 10/13] KEYS: asym_tpm: Implement the decrypt operation
Message-Id: <20180612155534.4873-11-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
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
 crypto/asymmetric_keys/asym_tpm.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index edcb81fe8937..af661c9d55d7 100644
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
@@ -417,6 +418,58 @@ static int tpm_key_encrypt(struct tpm_key *tk,
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
+		pr_devel("loadkey2 failed (%d)\n", r);
+		goto error;
+	}
+
+	/* TODO: Handle a non-all zero key authorization */
+	memset(keyauth, 0, sizeof(keyauth));
+
+	r = tpm_unbind(tb, keyhandle, keyauth,
+		       in, params->in_len, out, params->out_len);
+	if (r < 0)
+		pr_devel("tpm_unbind failed (%d)\n", r);
+
+	if (tpm_flushspecific(tb, keyhandle) < 0)
+		pr_devel("flushspecific failed (%d)\n", r);
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
@@ -431,6 +484,9 @@ static int tpm_key_eds_op(struct kernel_pkey_params *params,
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

