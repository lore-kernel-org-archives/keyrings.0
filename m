From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:17:33 +0000
Subject: [PATCH 13/15] KEYS: load key flags and expiry time atomically in key_validate()
Message-Id: <150783945342.10956.11064832686161197456.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In key_validate(), load the flags and expiry time once atomically, since
these can change concurrently if key_validate() is called without the
key semaphore held.  And we don't want to get inconsistent results if a
variable is referenced multiple times.  For example, key->expiry was
referenced in both 'if (key->expiry)' and in 'if (now.tv_sec >key->expiry)', making it theoretically possible to see a spurious
EKEYEXPIRED while the expiration time was being removed, i.e. set to 0.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/permission.c |    7 ++++---
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
 

