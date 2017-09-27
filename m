From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 27 Sep 2017 19:50:45 +0000
Subject: [PATCH v3 5/7] KEYS: load key flags and expiry time atomically in keyring_search_iterator()
Message-Id: <20170927195047.122358-6-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170927195047.122358-1-ebiggers3@gmail.com>
In-Reply-To: <20170927195047.122358-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Similar to the case for key_validate(), we should load the key ->flags
and ->expiry once atomically in keyring_search_iterator(), since they
can be changed concurrently whenever the key semaphore isn't held.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e54ad0ed7aa4..cb39b517f69c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -553,7 +553,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 {
 	struct keyring_search_context *ctx = iterator_data;
 	const struct key *key = keyring_ptr_to_key(object);
-	unsigned long kflags = key->flags;
+	unsigned long kflags = READ_ONCE(key->flags);
 
 	kenter("{%d}", key->serial);
 
@@ -565,6 +565,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	/* skip invalidated, revoked and expired keys */
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
+		time_t expiry = READ_ONCE(key->expiry);
+
 		if (kflags & ((1 << KEY_FLAG_INVALIDATED) |
 			      (1 << KEY_FLAG_REVOKED))) {
 			ctx->result = ERR_PTR(-EKEYREVOKED);
@@ -572,7 +574,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 			goto skipped;
 		}
 
-		if (key->expiry && ctx->now.tv_sec >= key->expiry) {
+		if (expiry && ctx->now.tv_sec >= expiry) {
 			if (!(ctx->flags & KEYRING_SEARCH_SKIP_EXPIRED))
 				ctx->result = ERR_PTR(-EKEYEXPIRED);
 			kleave(" = %d [expire]", ctx->skipped_ret);
-- 
2.14.2.822.g60be5d43e6-goog

