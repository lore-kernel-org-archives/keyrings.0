From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 31 Mar 2019 14:46:12 +0000
Subject: [PATCH] KEYS: asym_tpm: move setting set_pub_key parameters into derive_pub_key
Message-Id: <20190331144612.22029-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

The only reason for derive_pub_key() is to take a TPM-blob formatted
public key and convert it to ASN.1 format understood by
crypto_akcipher_set_pub_key. Because we are changing set_pub_key input
format (adding key parameters) - update that function to generate proper
zero values instead of generating them each time after the call.

Suggested-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
This should be applied after "crypto: add EC-RDSA (GOST 34.10) algorithm" patchset.

 crypto/asymmetric_keys/asym_tpm.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index d95d7ec50e5a..b138acf3a5e6 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -276,6 +276,10 @@ static int tpm_sign(struct tpm_buf *tb,
 
 	return datalen;
 }
+
+/* Room to fit two u32 zeros for algo id and parameters length. */
+#define SETKEY_PARAMS_SIZE (sizeof(u32) * 2)
+
 /*
  * Maximum buffer size for the BER/DER encoded public key.  The public key
  * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
@@ -286,8 +290,9 @@ static int tpm_sign(struct tpm_buf *tb,
  *     - 257 bytes of n
  *   - max 2 bytes for INTEGER e type/length
  *     - 3 bytes of e
+ * - 4+4 of zeros for set_pub_key parameters (SETKEY_PARAMS_SIZE)
  */
-#define PUB_KEY_BUF_SIZE (4 + 4 + 257 + 2 + 3)
+#define PUB_KEY_BUF_SIZE (4 + 4 + 257 + 2 + 3 + SETKEY_PARAMS_SIZE)
 
 /*
  * Provide a part of a description of the key for /proc/keys.
@@ -364,6 +369,8 @@ static uint32_t derive_pub_key(const void *pub_key, uint32_t len, uint8_t *buf)
 	cur = encode_tag_length(cur, 0x02, sizeof(e));
 	memcpy(cur, e, sizeof(e));
 	cur += sizeof(e);
+	/* Zero parameters to satisfy set_pub_key ABI. */
+	memset(cur, 0, SETKEY_PARAMS_SIZE);
 
 	return cur - buf;
 }
@@ -395,12 +402,6 @@ static int determine_akcipher(const char *encoding, const char *hash_algo,
 	return -ENOPKG;
 }
 
-static u8 *tpm_pack_u32(u8 *dst, u32 val)
-{
-	memcpy(dst, &val, sizeof(val));
-	return dst + sizeof(val);
-}
-
 /*
  * Query information about a key.
  */
@@ -428,14 +429,11 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
 	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
 					 der_pub_key);
 
-	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
+	pkey = kmalloc(der_pub_key_len + SETKEY_PARAMS_SIZE, GFP_KERNEL);
 	if (!pkey)
 		goto error_free_tfm;
-	memcpy(pkey, der_pub_key, der_pub_key_len);
+	memcpy(pkey, der_pub_key, der_pub_key_len + SETKEY_PARAMS_SIZE);
 	ptr = pkey + der_pub_key_len;
-	/* Set dummy parameters to satisfy set_pub_key ABI. */
-	ptr = tpm_pack_u32(ptr, 0); /* algo */
-	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
 
 	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
 	if (ret < 0)
@@ -493,13 +491,11 @@ static int tpm_key_encrypt(struct tpm_key *tk,
 	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
 					 der_pub_key);
 
-	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
+	pkey = kmalloc(der_pub_key_len + SETKEY_PARAMS_SIZE, GFP_KERNEL);
 	if (!pkey)
 		goto error_free_tfm;
-	memcpy(pkey, der_pub_key, der_pub_key_len);
+	memcpy(pkey, der_pub_key, der_pub_key_len + SETKEY_PARAMS_SIZE);
 	ptr = pkey + der_pub_key_len;
-	ptr = tpm_pack_u32(ptr, 0); /* algo */
-	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
 
 	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
 	if (ret < 0)
@@ -798,13 +794,11 @@ static int tpm_key_verify_signature(const struct key *key,
 	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
 					 der_pub_key);
 
-	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
+	pkey = kmalloc(der_pub_key_len + SETKEY_PARAMS_SIZE, GFP_KERNEL);
 	if (!pkey)
 		goto error_free_tfm;
-	memcpy(pkey, der_pub_key, der_pub_key_len);
+	memcpy(pkey, der_pub_key, der_pub_key_len + SETKEY_PARAMS_SIZE);
 	ptr = pkey + der_pub_key_len;
-	ptr = tpm_pack_u32(ptr, 0); /* algo */
-	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
 
 	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
 	if (ret < 0)
-- 
2.11.0
