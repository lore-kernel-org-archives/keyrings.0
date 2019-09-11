From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 11 Sep 2019 11:33:50 +0000
Subject: [PATCH] KEYS: asym_tpm: Use common tpm_buf for asymmetric keys
Message-Id: <1568200910-31368-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jarkko.sakkinen@linux.intel.com, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>

Switch to utilize common heap based tpm_buf code for TPM based
asymmetric keys rather than using stack based tpm_buf code.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 crypto/asymmetric_keys/asym_tpm.c | 99 ++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index ec3f309..d16d893 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -21,10 +21,6 @@
 #define TPM_ORD_LOADKEY2	65
 #define TPM_ORD_UNBIND		30
 #define TPM_ORD_SIGN		60
-#define TPM_LOADKEY2_SIZE		59
-#define TPM_FLUSHSPECIFIC_SIZE		18
-#define TPM_UNBIND_SIZE			63
-#define TPM_SIGN_SIZE			63
 
 #define TPM_RT_KEY                      0x00000001
 
@@ -68,16 +64,13 @@ static int tpm_loadkey2(struct tpm_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_LOADKEY2_SIZE + keybloblen);
-	store32(tb, TPM_ORD_LOADKEY2);
-	store32(tb, keyhandle);
-	storebytes(tb, keyblob, keybloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_LOADKEY2);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, keyblob, keybloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -101,12 +94,9 @@ static int tpm_loadkey2(struct tpm_buf *tb,
  */
 static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
 {
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_FLUSHSPECIFIC_SIZE);
-	store32(tb, TPM_ORD_FLUSHSPECIFIC);
-	store32(tb, handle);
-	store32(tb, TPM_RT_KEY);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_FLUSHSPECIFIC);
+	tpm_buf_append_u32(tb, handle);
+	tpm_buf_append_u32(tb, TPM_RT_KEY);
 
 	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 }
@@ -155,17 +145,14 @@ static int tpm_unbind(struct tpm_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_UNBIND_SIZE + bloblen);
-	store32(tb, TPM_ORD_UNBIND);
-	store32(tb, keyhandle);
-	store32(tb, bloblen);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_UNBIND);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append_u32(tb, bloblen);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -241,17 +228,14 @@ static int tpm_sign(struct tpm_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_SIGN_SIZE + bloblen);
-	store32(tb, TPM_ORD_SIGN);
-	store32(tb, keyhandle);
-	store32(tb, bloblen);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_SIGN);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append_u32(tb, bloblen);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -519,7 +503,7 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 			   struct kernel_pkey_params *params,
 			   const void *in, void *out)
 {
-	struct tpm_buf *tb;
+	struct tpm_buf tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
@@ -533,14 +517,14 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	if (strcmp(params->encoding, "pkcs1"))
 		return -ENOPKG;
 
-	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	r = tpm_buf_init(&tb, 0, 0);
+	if (r)
+		return r;
 
 	/* TODO: Handle a non-all zero SRK authorization */
 	memset(srkauth, 0, sizeof(srkauth));
 
-	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
 				tk->blob, tk->blob_len, &keyhandle);
 	if (r < 0) {
 		pr_devel("loadkey2 failed (%d)\n", r);
@@ -550,16 +534,16 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	/* TODO: Handle a non-all zero key authorization */
 	memset(keyauth, 0, sizeof(keyauth));
 
-	r = tpm_unbind(tb, keyhandle, keyauth,
+	r = tpm_unbind(&tb, keyhandle, keyauth,
 		       in, params->in_len, out, params->out_len);
 	if (r < 0)
 		pr_devel("tpm_unbind failed (%d)\n", r);
 
-	if (tpm_flushspecific(tb, keyhandle) < 0)
+	if (tpm_flushspecific(&tb, keyhandle) < 0)
 		pr_devel("flushspecific failed (%d)\n", r);
 
 error:
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	pr_devel("<=%s() = %d\n", __func__, r);
 	return r;
 }
@@ -643,7 +627,7 @@ static int tpm_key_sign(struct tpm_key *tk,
 			struct kernel_pkey_params *params,
 			const void *in, void *out)
 {
-	struct tpm_buf *tb;
+	struct tpm_buf tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
@@ -681,15 +665,14 @@ static int tpm_key_sign(struct tpm_key *tk,
 		goto error_free_asn1_wrapped;
 	}
 
-	r = -ENOMEM;
-	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
-	if (!tb)
+	r = tpm_buf_init(&tb, 0, 0);
+	if (r)
 		goto error_free_asn1_wrapped;
 
 	/* TODO: Handle a non-all zero SRK authorization */
 	memset(srkauth, 0, sizeof(srkauth));
 
-	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
 			 tk->blob, tk->blob_len, &keyhandle);
 	if (r < 0) {
 		pr_devel("loadkey2 failed (%d)\n", r);
@@ -699,15 +682,15 @@ static int tpm_key_sign(struct tpm_key *tk,
 	/* TODO: Handle a non-all zero key authorization */
 	memset(keyauth, 0, sizeof(keyauth));
 
-	r = tpm_sign(tb, keyhandle, keyauth, in, in_len, out, params->out_len);
+	r = tpm_sign(&tb, keyhandle, keyauth, in, in_len, out, params->out_len);
 	if (r < 0)
 		pr_devel("tpm_sign failed (%d)\n", r);
 
-	if (tpm_flushspecific(tb, keyhandle) < 0)
+	if (tpm_flushspecific(&tb, keyhandle) < 0)
 		pr_devel("flushspecific failed (%d)\n", r);
 
 error_free_tb:
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 error_free_asn1_wrapped:
 	kfree(asn1_wrapped);
 	pr_devel("<=%s() = %d\n", __func__, r);
-- 
2.7.4
