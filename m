From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 15 Sep 2017 22:37:23 +0000
Subject: [PATCH] security: keys: switch big_key encryption to AES in CTR mode
Message-Id: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

The ECB chaining mode only supports inputs that are a multiple of the
blocksize. Furthermore, it is not recommended for direct use, given
that it may reveal recurring patterns in the plaintext, due to the
lack of feedback between input blocks. So let's solve both issues at
once, and switch to AES in CTR mode.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 security/keys/big_key.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 835c1ab30d01..66ee432dad43 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -50,6 +50,7 @@ enum big_key_op {
  * Key size for big_key data encryption
  */
 #define ENC_KEY_SIZE	16
+#define ENC_IV_SIZE	16
 
 /*
  * big_key defined keys take an arbitrary string as the description and an
@@ -70,7 +71,7 @@ struct key_type key_type_big_key = {
  * Crypto names for big_key data encryption
  */
 static const char big_key_rng_name[] = "stdrng";
-static const char big_key_alg_name[] = "ecb(aes)";
+static const char big_key_alg_name[] = "ctr(aes)";
 
 /*
  * Crypto algorithms for big_key data encryption
@@ -83,7 +84,8 @@ static struct crypto_skcipher *big_key_skcipher;
  */
 static inline int big_key_gen_enckey(u8 *key)
 {
-	return crypto_rng_get_bytes(big_key_rng, key, ENC_KEY_SIZE);
+	return crypto_rng_get_bytes(big_key_rng, key,
+				    ENC_KEY_SIZE + ENC_IV_SIZE);
 }
 
 /*
@@ -105,7 +107,8 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
 				      NULL, NULL);
 
 	sg_init_one(&sgio, data, datalen);
-	skcipher_request_set_crypt(req, &sgio, &sgio, datalen, NULL);
+	skcipher_request_set_crypt(req, &sgio, &sgio, datalen,
+				   key + ENC_KEY_SIZE);
 
 	if (op = BIG_KEY_ENC)
 		ret = crypto_skcipher_encrypt(req);
@@ -157,7 +160,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		memset(data + datalen, 0x00, enclen - datalen);
 
 		/* generate random key */
-		enckey = kmalloc(ENC_KEY_SIZE, GFP_KERNEL);
+		enckey = kmalloc(ENC_KEY_SIZE + ENC_IV_SIZE, GFP_KERNEL);
 		if (!enckey) {
 			ret = -ENOMEM;
 			goto error;
-- 
2.11.0

