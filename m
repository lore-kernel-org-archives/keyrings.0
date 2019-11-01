From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:34:26 +0000
Subject: [RFC PATCH 03/11] Add wake_up_interruptible_sync_poll_locked() [ver #3]
Message-Id: <157262966653.13142.15080563290216609050.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Add a wakeup call for a case whereby the caller already has the waitqueue
spinlock held.  This can be used by pipes to alter the ring buffer indices
and issue a wakeup under the same spinlock.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

 include/linux/wait.h |    3 +++
 kernel/sched/wait.c  |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index bb7676d396cd..3283c8d02137 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -202,6 +202,7 @@ void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, vo
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
+void __wake_up_locked_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
 void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 
@@ -229,6 +230,8 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
 #define wake_up_interruptible_sync_poll(x, m)					\
 	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
+#define wake_up_interruptible_sync_poll_locked(x, m)				\
+	__wake_up_locked_sync_key((x), TASK_INTERRUPTIBLE, poll_to_key(m))
 
 #define ___wait_cond_timeout(condition)						\
 ({										\
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index b4b52361dab7..ba059fbfc53a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -191,6 +191,29 @@ void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 
+/**
+ * __wake_up_locked_sync_key - wake up a thread blocked on a locked waitqueue.
+ * @wq_head: the waitqueue
+ * @mode: which threads
+ * @key: opaque value to be passed to wakeup targets
+ *
+ * The sync wakeup differs in that the waker knows that it will schedule
+ * away soon, so while the target thread will be woken up, it will not
+ * be migrated to another CPU - ie. the two threads are 'synchronized'
+ * with each other. This can prevent needless bouncing between CPUs.
+ *
+ * On UP it can prevent extra preemption.
+ *
+ * If this function wakes up a task, it executes a full memory barrier before
+ * accessing the task state.
+ */
+void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
+			       unsigned int mode, void *key)
+{
+        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
+}
+EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);
+
 /*
  * __wake_up_sync - see __wake_up_sync_key()
  */
