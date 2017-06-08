From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:48:32 +0000
Subject: [PATCH 10/23] KEYS: encrypted: use constant-time HMAC comparison
Message-Id: <149692971287.11452.3700184292634708953.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

MACs should, in general, be compared using crypto_memneq() to prevent
timing attacks.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 702c80662069..5c98c2fe03f0 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -30,6 +30,7 @@
 #include <linux/scatterlist.h>
 #include <linux/ctype.h>
 #include <crypto/aes.h>
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <crypto/skcipher.h>
@@ -534,8 +535,8 @@ static int datablob_hmac_verify(struct encrypted_key_payload *epayload,
 	ret = calc_hmac(digest, derived_key, sizeof derived_key, p, len);
 	if (ret < 0)
 		goto out;
-	ret = memcmp(digest, epayload->format + epayload->datablob_len,
-		     sizeof digest);
+	ret = crypto_memneq(digest, epayload->format + epayload->datablob_len,
+			    sizeof(digest));
 	if (ret) {
 		ret = -EINVAL;
 		dump_hmac("datablob",

