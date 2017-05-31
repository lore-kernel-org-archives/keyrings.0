From: David Howells <dhowells@redhat.com>
Date: Wed, 31 May 2017 12:20:44 +0000
Subject: Re: [PATCH] KEYS: fix refcount_inc() on zero
Message-Id: <26155.1496233244@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495820254-6651-1-git-send-email-mark.rutland@arm.com>
In-Reply-To: <1495820254-6651-1-git-send-email-mark.rutland@arm.com>
To: linux-security-module@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> wrote:

> This patch uses refcount_inc_not_zero() to perform the peek and
> increment atomically.

I think the helper is unnecessary.  Better to adjust the comment if you really
want to explain it.  Anyone editing the code should be that this is inside a
critical section.

> A helper with lockdep annotation is added to document why this is safe.

This doesn't explain why this is safe.

> +	/*
> +	 * Pretend it doesn't exist if it is awaiting deletion. This races with
> +	 * key_put(), but we can peek at the key until we drop key_serial_lock.
>  	 */

With your change, there is no race with key_put() - so the second sentence is
unnecessary.

I've adjusted your patch - see attached.

David
---
commit f66bf831c45306ebbc28aecd407e238983457251
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Fri May 26 18:37:34 2017 +0100

    KEYS: fix refcount_inc() on zero
    
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
