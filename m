From: David Howells <dhowells@redhat.com>
Date: Thu, 09 Nov 2017 12:35:07 +0000
Subject: [PATCH] Add a function to start/reduce a timer
Message-Id: <151023090769.23050.1801643667223880753.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: tglx@linutronix.de
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org

Add a function, similar to mod_timer(), that will start a timer it isn't
running and will modify it if it is running and has an expiry time longer
than the new time.  If the timer is running with an expiry time that's the
same or sooner, no change is made.

The function looks like:

	int timer_reduce(struct timer_list *timer, unsigned long expires);

This can be used by code such as networking code to make it easier to share
a timer for multiple timeouts.  For instance, in upcoming AF_RXRPC code,
the rxrpc_call struct will maintain a number of timeouts:

	unsigned long	ack_at;
	unsigned long	resend_at;
	unsigned long	ping_at;
	unsigned long	expect_rx_by;
	unsigned long	expect_req_by;
	unsigned long	expect_term_by;

each of which is set independently of the others.  With timer reduction
available, when the code needs to set one of the timeouts, it only needs to
look at that timeout and then call timer_reduce() to modify the timer,
starting it or bringing it forward if necessary.  There is no need to refer
to the other timeouts to see which is earliest and no need to take any lock
other than, potentially, the timer lock inside timer_reduce().

As an example, the expect_rx_by timeout above, which terminates a call if
we don't get a packet from the server within a certain time window, would
be set something like this:

	unsigned long now = jiffies;
	unsigned long expect_rx_by = now + packet_receive_timeout;
	WRITE_ONCE(call->expect_rx_by, expect_rx_by);
	timer_reduce(&call->timer, expect_rx_by);

The timer service code (which might, say, be in a work function) would then
check all the timeouts to see which, if any, had triggered, deal with
those:

	t = READ_ONCE(call->ack_at);
	if (time_after_eq(now, t)) {
		cmpxchg(&call->ack_at, t, now + MAX_JIFFY_OFFSET);
		set_bit(RXRPC_CALL_EV_ACK, &call->events);
	}

and then restart the timer if necessary by finding the soonest timeout that
hasn't yet passed and then calling timer_reduce().

The disadvantage of doing things this way rather than comparing the timers
each time and calling mod_timer() is that you *will* take timer events
unless you can finish what you're doing and delete the timer in time.

The advantage of doing things this way is that you don't need to use a lock
to work out when the next timer should be set, other than the timer's own
lock - which you might not have to take.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Thomas Gleixner <tglx@linutronix.de>
---

 include/linux/timer.h |    1 +
 kernel/time/timer.c   |   46 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 31ae9a88b9e4..0584a84109ba 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -215,6 +215,7 @@ extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
+extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 
 /*
  * The jiffies value which is added to now, when there is no timer
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f2674a056c26..48a28a0578d0 100644
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
@@ -950,7 +953,11 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		 * larger granularity than you would get from adding a new
 		 * timer with this expiry.
 		 */
-		if (timer->expires = expires)
+		long diff = timer->expires - expires;
+		if (diff = 0)
+			return 1;
+		if (options & MOD_TIMER_REDUCE &&
+		    diff <= 0)
 			return 1;
 
 		/*
@@ -962,6 +969,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
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
 
@@ -971,7 +985,10 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
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
@@ -981,7 +998,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 	}
 
 	ret = detach_if_pending(timer, base, false);
-	if (!ret && pending_only)
+	if (!ret && options & MOD_TIMER_PENDING_ONLY)
 		goto out_unlock;
 
 	debug_activate(timer, expires);
@@ -1042,7 +1059,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 {
-	return __mod_timer(timer, expires, true);
+	return __mod_timer(timer, expires, MOD_TIMER_PENDING_ONLY);
 }
 EXPORT_SYMBOL(mod_timer_pending);
 
@@ -1068,11 +1085,26 @@ EXPORT_SYMBOL(mod_timer_pending);
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	return __mod_timer(timer, expires, false);
+	return __mod_timer(timer, expires, 0);
 }
 EXPORT_SYMBOL(mod_timer);
 
 /**
+ * timer_reduce - modify a timer's timeout if it would reduce the timeout
+ * @timer: the timer to be modified
+ * @expires: new timeout in jiffies
+ *
+ * timer_reduce() is very similar to mod_timer(), except that it will only
+ * modify a running timer if that would reduce the expiration time (it will
+ * start a timer that isn't running).
+ */
+int timer_reduce(struct timer_list *timer, unsigned long expires)
+{
+	return __mod_timer(timer, expires, MOD_TIMER_REDUCE);
+}
+EXPORT_SYMBOL(timer_reduce);
+
+/**
  * add_timer - start a timer
  * @timer: the timer to be added
  *
@@ -1739,7 +1771,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	expire = timeout + jiffies;
 
 	setup_timer_on_stack(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire, false);
+	__mod_timer(&timer, expire, 0);
 	schedule();
 	del_singleshot_timer_sync(&timer);
 

