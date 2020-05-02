From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 02 May 2020 05:31:21 +0000
Subject: [PATCH 19/20] KEYS: encrypted: use crypto_shash_tfm_digest()
Message-Id: <20200502053122.995648-20-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Cc: keyrings@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/encrypted-keys/encrypted.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index f6797ba44bf716..14cf81d1a30b14 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -323,19 +323,6 @@ static struct key *request_user_key(const char *master_desc, const u8 **master_k
 	return ukey;
 }
 
-static int calc_hash(struct crypto_shash *tfm, u8 *digest,
-		     const u8 *buf, unsigned int buflen)
-{
-	SHASH_DESC_ON_STACK(desc, tfm);
-	int err;
-
-	desc->tfm = tfm;
-
-	err = crypto_shash_digest(desc, buf, buflen, digest);
-	shash_desc_zero(desc);
-	return err;
-}
-
 static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
 		     const u8 *buf, unsigned int buflen)
 {
@@ -351,7 +338,7 @@ static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
 
 	err = crypto_shash_setkey(tfm, key, keylen);
 	if (!err)
-		err = calc_hash(tfm, digest, buf, buflen);
+		err = crypto_shash_tfm_digest(tfm, buf, buflen, digest);
 	crypto_free_shash(tfm);
 	return err;
 }
@@ -381,7 +368,8 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
-	ret = calc_hash(hash_tfm, derived_key, derived_buf, derived_buf_len);
+	ret = crypto_shash_tfm_digest(hash_tfm, derived_buf, derived_buf_len,
+				      derived_key);
 	kzfree(derived_buf);
 	return ret;
 }
-- 
2.26.2
