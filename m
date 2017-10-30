From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Oct 2017 15:38:16 +0000
Subject: [PATCH 4/4] KEYS: Use reduce_timer() to shorten gc timeout
Message-Id: <150937789693.31781.1027077289972169712.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
In-Reply-To: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
To: tglx@linutronix.de
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org

Use reduce_timer() to shorten the garbage collector timeout instead of
checking the old timeout and overwriting it without using a lock.  This
should avoid timeout-updating races causing timeouts to get extended.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/gc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index c99700e82ad6..4e3407c16e5d 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -32,7 +32,6 @@ DECLARE_WORK(key_gc_work, key_garbage_collector);
 static void key_gc_timer_func(unsigned long);
 static DEFINE_TIMER(key_gc_timer, key_gc_timer_func, 0, 0);
 
-static time64_t key_gc_next_run = TIME64_MAX;
 static struct key_type *key_gc_dead_keytype;
 
 static unsigned long key_gc_flags;
@@ -63,11 +62,10 @@ void key_schedule_gc(time64_t gc_at)
 	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
 		schedule_work(&key_gc_work);
-	} else if (gc_at < key_gc_next_run) {
+	} else {
 		kdebug("DEFERRED");
-		key_gc_next_run = gc_at;
 		expires = jiffies + (gc_at - now) * HZ;
-		mod_timer(&key_gc_timer, expires);
+		reduce_timer(&key_gc_timer, expires);
 	}
 }
 
@@ -87,7 +85,6 @@ void key_schedule_gc_links(void)
 static void key_gc_timer_func(unsigned long data)
 {
 	kenter("");
-	key_gc_next_run = TIME64_MAX;
 	key_schedule_gc_links();
 }
 

