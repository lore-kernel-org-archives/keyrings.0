From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:17:41 +0000
Subject: [PATCH 14/15] KEYS: load key flags and expiry time atomically in keyring_search_iterator()
Message-Id: <150783946092.10956.10684012274871383502.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Similar to the case for key_validate(), we should load the key ->flags
and ->expiry once atomically in keyring_search_iterator(), since they
can be changed concurrently whenever the key semaphore isn't held.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 816948abff89..1ef5c7caf15c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -566,6 +566,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	/* skip invalidated, revoked and expired keys */
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
+		time_t expiry = READ_ONCE(key->expiry);
+
 		if (kflags & ((1 << KEY_FLAG_INVALIDATED) |
 			      (1 << KEY_FLAG_REVOKED))) {
 			ctx->result = ERR_PTR(-EKEYREVOKED);
@@ -573,7 +575,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 			goto skipped;
 		}
 
-		if (key->expiry && ctx->now.tv_sec >= key->expiry) {
+		if (expiry && ctx->now.tv_sec >= expiry) {
 			if (!(ctx->flags & KEYRING_SEARCH_SKIP_EXPIRED))
 				ctx->result = ERR_PTR(-EKEYEXPIRED);
 			kleave(" = %d [expire]", ctx->skipped_ret);

