From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 26 May 2017 17:37:34 +0000
Subject: [PATCH] KEYS: fix refcount_inc() on zero
Message-Id: <1495820254-6651-1-git-send-email-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

If a key's refcount is dropped to zero between key_lookup() peeking at
the refcount and subsequently attempting to increment it, refcount_inc()
will see a zero refcount. Here, refcount_inc() will WARN_ONCE(), and
will *not* increment the refcount, which will remain zero.

Once key_lookup() drops key_serial_lock, it is possible for the key to
be freed behind our back.

This patch uses refcount_inc_not_zero() to perform the peek and
increment atomically. A helper with lockdep annotation is added to
document why this is safe.

Fixes: fff292914d3a2f1e ("security, keys: convert key.usage from atomic_t to refcount_t")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David Windsor <dwindsor@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 security/keys/key.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 455c04d..150f51d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -632,6 +632,12 @@ void key_put(struct key *key)
 }
 EXPORT_SYMBOL(key_put);
 
+static bool key_get_not_free(struct key *key)
+{
+	lockdep_assert_held(&key_serial_lock);
+	return refcount_inc_not_zero(&key->usage);
+}
+
 /*
  * Find a key by its serial number.
  */
@@ -660,14 +666,12 @@ struct key *key_lookup(key_serial_t id)
 	goto error;
 
 found:
-	/* pretend it doesn't exist if it is awaiting deletion */
-	if (refcount_read(&key->usage) = 0)
-		goto not_found;
-
-	/* this races with key_put(), but that doesn't matter since key_put()
-	 * doesn't actually change the key
+	/*
+	 * Pretend it doesn't exist if it is awaiting deletion. This races with
+	 * key_put(), but we can peek at the key until we drop key_serial_lock.
 	 */
-	__key_get(key);
+	if (!key_get_not_free(key))
+		goto not_found;
 
 error:
 	spin_unlock(&key_serial_lock);
-- 
1.9.1

