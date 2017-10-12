From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:17:02 +0000
Subject: [PATCH 09/15] KEYS: Fix the wrong index when checking the existence of second id
Message-Id: <150783942283.10956.5950640563358295848.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Lee, Chun-Yi <joeyli.kernel@gmail.com>

Fix the wrong index number when checking the existence of second
id in function of finding asymmetric key. The id_1 is the second
id that the index in array must be 1 but not 0.

Fix: 9eb029893(KEYS: Generalise x509_request_asymmetric_key())

Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asymmetric_type.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index e4b0ed386bc8..a597f5c5a222 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -105,7 +105,7 @@ struct key *find_asymmetric_key(struct key *keyring,
 	if (id_0 && id_1) {
 		const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
 
-		if (!kids->id[0]) {
+		if (!kids->id[1]) {
 			pr_debug("First ID matches, but second is missing\n");
 			goto reject;
 		}

