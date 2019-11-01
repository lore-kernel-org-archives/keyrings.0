From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:34:18 +0000
Subject: [RFC PATCH 02/11] Remove the nr_exclusive argument from __wake_up_sync_key() [ver #3]
Message-Id: <157262965796.13142.7304635748939123321.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the nr_exclusive argument from __wake_up_sync_key() and derived
functions as everything seems to set it to 1.  Note also that if it wasn't
set to 1, it would clear WF_SYNC anyway.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

 include/linux/wait.h |    8 ++++----
 kernel/exit.c        |    2 +-
 kernel/sched/wait.c  |   14 ++++----------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3eb7cae8206c..bb7676d396cd 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -201,9 +201,9 @@ void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
-void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 
 #define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
@@ -214,7 +214,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
-#define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE, 1)
+#define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE)
 
 /*
  * Wakeup macros to be used to report events to the targets.
@@ -228,7 +228,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 #define wake_up_interruptible_poll(x, m)					\
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)					\
-	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, 1, poll_to_key(m))
+	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
 
 #define ___wait_cond_timeout(condition)						\
 ({										\
diff --git a/kernel/exit.c b/kernel/exit.c
index a46a50d67002..a1ff25ef050e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1435,7 +1435,7 @@ static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
 void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 {
 	__wake_up_sync_key(&parent->signal->wait_chldexit,
-				TASK_INTERRUPTIBLE, 1, p);
+			   TASK_INTERRUPTIBLE, p);
 }
 
 static long do_wait(struct wait_opts *wo)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index c1e566a114ca..b4b52361dab7 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -169,7 +169,6 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
  * __wake_up_sync_key - wake up threads blocked on a waitqueue.
  * @wq_head: the waitqueue
  * @mode: which threads
- * @nr_exclusive: how many wake-one or wake-many threads to wake up
  * @key: opaque value to be passed to wakeup targets
  *
  * The sync wakeup differs that the waker knows that it will schedule
@@ -183,26 +182,21 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
  * accessing the task state.
  */
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
-			int nr_exclusive, void *key)
+			void *key)
 {
-	int wake_flags = 1; /* XXX WF_SYNC */
-
 	if (unlikely(!wq_head))
 		return;
 
-	if (unlikely(nr_exclusive != 1))
-		wake_flags = 0;
-
-	__wake_up_common_lock(wq_head, mode, nr_exclusive, wake_flags, key);
+	__wake_up_common_lock(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 
 /*
  * __wake_up_sync - see __wake_up_sync_key()
  */
-void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode, int nr_exclusive)
+void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode)
 {
-	__wake_up_sync_key(wq_head, mode, nr_exclusive, NULL);
+	__wake_up_sync_key(wq_head, mode, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
