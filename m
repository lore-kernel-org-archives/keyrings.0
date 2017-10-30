From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Oct 2017 15:37:52 +0000
Subject: [PATCH 1/4] Add a function to start/reduce a timer
Message-Id: <150937787256.31781.8531811303029438707.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
In-Reply-To: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
To: tglx@linutronix.de
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org

Add a function, similar to mod_timer(), that will start a timer it isn't
running and will modify it if it is running and has an expiry time longer
than the new time.  If the timer is running with an expiry time that's the
same or sooner, no change is made.

The function looks like:

	int reduce_timer(struct timer_list *timer, unsigned long expires);

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Thomas Gleixner <tglx@linutronix.de>
---

 include/linux/timer.h |    1 +
 kernel/time/timer.c   |   49 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e6789b8757d5..6ec5d897606d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -187,6 +187,7 @@ extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
+extern int reduce_timer(struct timer_list *timer, unsigned long expires);
 
 /*
  * The jiffies value which is added to now, when there is no timer
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f2674a056c26..bd9369d7225e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -929,8 +929,11 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 	}
 }
 
+#define MOD_TIMER_PENDING_ONLY	0x01
+#define MOD_TIMER_REDUCE	0x02
+
 static inline int
-__mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
+__mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
 {
 	struct timer_base *base, *new_base;
 	unsigned int idx = UINT_MAX;
@@ -950,8 +953,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		 * larger granularity than you would get from adding a new
 		 * timer with this expiry.
 		 */
-		if (timer->expires = expires)
-			return 1;
+		if (options & MOD_TIMER_REDUCE) {
+			if (time_before_eq(timer->expires, expires))
+				return 1;
+		} else {
+			if (timer->expires = expires)
+				return 1;
+		}
 
 		/*
 		 * We lock timer base and calculate the bucket index right
@@ -962,6 +970,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		base = lock_timer_base(timer, &flags);
 		forward_timer_base(base);
 
+		if (timer_pending(timer) &&
+		    options & MOD_TIMER_REDUCE &&
+		    time_before_eq(timer->expires, expires)) {
+			ret = 1;
+			goto out_unlock;
+		}
+
 		clk = base->clk;
 		idx = calc_wheel_index(expires, clk);
 
@@ -971,7 +986,10 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		 * subsequent call will exit in the expires check above.
 		 */
 		if (idx = timer_get_idx(timer)) {
-			timer->expires = expires;
+			if (!(options & MOD_TIMER_REDUCE))
+				timer->expires = expires;
+			else if (time_after(timer->expires, expires))
+				timer->expires = expires;
 			ret = 1;
 			goto out_unlock;
 		}
@@ -981,7 +999,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 	}
 
 	ret = detach_if_pending(timer, base, false);
-	if (!ret && pending_only)
+	if (!ret && options & MOD_TIMER_PENDING_ONLY)
 		goto out_unlock;
 
 	debug_activate(timer, expires);
@@ -1042,7 +1060,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 {
-	return __mod_timer(timer, expires, true);
+	return __mod_timer(timer, expires, MOD_TIMER_PENDING_ONLY);
 }
 EXPORT_SYMBOL(mod_timer_pending);
 
@@ -1068,11 +1086,26 @@ EXPORT_SYMBOL(mod_timer_pending);
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	return __mod_timer(timer, expires, false);
+	return __mod_timer(timer, expires, 0);
 }
 EXPORT_SYMBOL(mod_timer);
 
 /**
+ * reduce_timer - modify a timer's timeout if it would reduce the timeout
+ * @timer: the timer to be modified
+ * @expires: new timeout in jiffies
+ *
+ * reduce_timer() is very similar to mod_timer(), except that it will only
+ * modify a running timer if that would reduce the expiration time (it will
+ * start a timer that isn't running).
+ */
+int reduce_timer(struct timer_list *timer, unsigned long expires)
+{
+	return __mod_timer(timer, expires, MOD_TIMER_REDUCE);
+}
+EXPORT_SYMBOL(reduce_timer);
+
+/**
  * add_timer - start a timer
  * @timer: the timer to be added
  *
@@ -1739,7 +1772,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	expire = timeout + jiffies;
 
 	setup_timer_on_stack(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire, false);
+	__mod_timer(&timer, expire, 0);
 	schedule();
 	del_singleshot_timer_sync(&timer);
 

