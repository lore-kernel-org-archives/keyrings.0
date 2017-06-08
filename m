From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:49 +0000
Subject: [PATCH 20/23] KEYS: DH: ensure the KDF counter is properly aligned
Message-Id: <149692978940.11452.2775787299367252465.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Accessing a 'u8[4]' through a '__be32 *' violates alignment rules.  Just
make the counter a __be32 instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephan Mueller <smueller@chronox.de>
---

 security/keys/dh.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 1c1cac677041..63ac87d430db 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -130,14 +130,6 @@ static void kdf_dealloc(struct kdf_sdesc *sdesc)
 	kzfree(sdesc);
 }
 
-/* convert 32 bit integer into its string representation */
-static inline void crypto_kw_cpu_to_be32(u32 val, u8 *buf)
-{
-	__be32 *a = (__be32 *)buf;
-
-	*a = cpu_to_be32(val);
-}
-
 /*
  * Implementation of the KDF in counter mode according to SP800-108 section 5.1
  * as well as SP800-56A section 5.8.1 (Single-step KDF).
@@ -154,16 +146,14 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 	unsigned int h = crypto_shash_digestsize(desc->tfm);
 	int err = 0;
 	u8 *dst_orig = dst;
-	u32 i = 1;
-	u8 iteration[sizeof(u32)];
+	__be32 counter = cpu_to_be32(1);
 
 	while (dlen) {
 		err = crypto_shash_init(desc);
 		if (err)
 			goto err;
 
-		crypto_kw_cpu_to_be32(i, iteration);
-		err = crypto_shash_update(desc, iteration, sizeof(u32));
+		err = crypto_shash_update(desc, (u8 *)&counter, sizeof(__be32));
 		if (err)
 			goto err;
 
@@ -189,7 +179,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 
 			dlen -= h;
 			dst += h;
-			i++;
+			counter = cpu_to_be32(be32_to_cpu(counter) + 1);
 		}
 	}
 

