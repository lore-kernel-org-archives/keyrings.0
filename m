From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Date: Wed, 04 Oct 2017 11:18:22 +0000
Subject: [PATCH] KEYS: Fix the wrong index when checking the existence of second id
Message-Id: <20171004111822.11141-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>

Fix the wrong index number when checking the existence of second
id in function of finding asymmetric key. The id_1 is the second
id that the index in array must be 1 but not 0.

Fix: 9eb029893(KEYS: Generalise x509_request_asymmetric_key())

Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 3a3b028..39aecad 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -107,7 +107,7 @@ struct key *find_asymmetric_key(struct key *keyring,
 	if (id_0 && id_1) {
 		const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
 
-		if (!kids->id[0]) {
+		if (!kids->id[1]) {
 			pr_debug("First ID matches, but second is missing\n");
 			goto reject;
 		}
-- 
2.10.2

