From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:47:41 +0000
Subject: [PATCH 03/23] KEYS: fix refcount_inc() on zero
Message-Id: <149692966132.11452.11344589657708880218.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

If a key's refcount is dropped to zero between key_lookup() peeking at
the refcount and subsequently attempting to increment it, refcount_inc()
will see a zero refcount.  Here, refcount_inc() will WARN_ONCE(), and
will *not* increment the refcount, which will remain zero.

Once key_lookup() drops key_serial_lock, it is possible for the key to
be freed behind our back.

This patch uses refcount_inc_not_zero() to perform the peek and increment
atomically.

Fixes: fff292914d3a2f1e ("security, keys: convert key.usage from atomic_t to refcount_t")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: David Windsor <dwindsor@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---

 security/keys/key.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 455c04d80bbb..d84ee2a87da6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -660,14 +660,11 @@ struct key *key_lookup(key_serial_t id)
 	goto error;
 
 found:
-	/* pretend it doesn't exist if it is awaiting deletion */
-	if (refcount_read(&key->usage) = 0)
-		goto not_found;
-
-	/* this races with key_put(), but that doesn't matter since key_put()
-	 * doesn't actually change the key
+	/* A key is allowed to be looked up only if someone still owns a
+	 * reference to it - otherwise it's awaiting the gc.
 	 */
-	__key_get(key);
+	if (!refcount_inc_not_zero(&key->usage))
+		goto not_found;
 
 error:
 	spin_unlock(&key_serial_lock);

