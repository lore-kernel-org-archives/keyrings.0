From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 27 Sep 2017 19:50:44 +0000
Subject: [PATCH v3 4/7] KEYS: load key flags and expiry time atomically in key_validate()
Message-Id: <20170927195047.122358-5-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170927195047.122358-1-ebiggers3@gmail.com>
In-Reply-To: <20170927195047.122358-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In key_validate(), load the flags and expiry time once atomically, since
these can change concurrently if key_validate() is called without the
key semaphore held.  And we don't want to get inconsistent results if a
variable is referenced multiple times.  For example, key->expiry was
referenced in both 'if (key->expiry)' and in 'if (now.tv_sec >key->expiry)', making it theoretically possible to see a spurious
EKEYEXPIRED while the expiration time was being removed, i.e. set to 0.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/permission.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/permission.c b/security/keys/permission.c
index 732cc0beffdf..a72b4dd70c8a 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -88,7 +88,8 @@ EXPORT_SYMBOL(key_task_permission);
  */
 int key_validate(const struct key *key)
 {
-	unsigned long flags = key->flags;
+	unsigned long flags = READ_ONCE(key->flags);
+	time_t expiry = READ_ONCE(key->expiry);
 
 	if (flags & (1 << KEY_FLAG_INVALIDATED))
 		return -ENOKEY;
@@ -99,9 +100,9 @@ int key_validate(const struct key *key)
 		return -EKEYREVOKED;
 
 	/* check it hasn't expired */
-	if (key->expiry) {
+	if (expiry) {
 		struct timespec now = current_kernel_time();
-		if (now.tv_sec >= key->expiry)
+		if (now.tv_sec >= expiry)
 			return -EKEYEXPIRED;
 	}
 
-- 
2.14.2.822.g60be5d43e6-goog

