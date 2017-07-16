From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 16 Jul 2017 17:21:13 +0000
Subject: [PATCH] security/keys: ensure RNG is seeded before use
Message-Id: <20170716172113.6223-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Otherwise, we might use bad random numbers which, particularly in the
case of IV generation, could be quite bad. It makes sense to use the
synchronous API here, because we're always in process context (as the
code is littered with GFP_KERNEL and the like). However, we can't change
to using a blocking function in key serial allocation, because this will
block booting in some configurations, so here we use the more
appropriate get_random_u32, which will use RDRAND if available.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
---
 security/keys/encrypted-keys/encrypted.c | 8 +++++---
 security/keys/key.c                      | 8 +++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 69855ba0d3b3..7640fa46b3e5 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -759,10 +759,12 @@ static int encrypted_init(struct encrypted_key_payload *epayload,
 
 	__ekey_init(epayload, format, master_desc, datalen);
 	if (!hex_encoded_iv) {
-		get_random_bytes(epayload->iv, ivsize);
+		ret = get_random_bytes_wait(epayload->iv, ivsize);
+		if (unlikely(ret))
+			return ret;
 
-		get_random_bytes(epayload->decrypted_data,
-				 epayload->decrypted_datalen);
+		ret = get_random_bytes_wait(epayload->decrypted_data,
+					    epayload->decrypted_datalen);
 	} else
 		ret = encrypted_key_decrypt(epayload, format, hex_encoded_iv);
 	return ret;
diff --git a/security/keys/key.c b/security/keys/key.c
index 83da68d98b40..ee443d2a4f7e 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -139,12 +139,10 @@ static inline void key_alloc_serial(struct key *key)
 	struct rb_node *parent, **p;
 	struct key *xkey;
 
-	/* propose a random serial number and look for a hole for it in the
-	 * serial number tree */
+	/* propose a non-negative random serial number and look for a hole for
+	 * it in the serial number tree */
 	do {
-		get_random_bytes(&key->serial, sizeof(key->serial));
-
-		key->serial >>= 1; /* negative numbers are not permitted */
+		key->serial = get_random_u32() >> 1;
 	} while (key->serial < 3);
 
 	spin_lock(&key_serial_lock);
-- 
2.13.3

