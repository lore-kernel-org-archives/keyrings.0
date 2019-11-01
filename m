From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:34:57 +0000
Subject: [RFC PATCH 06/11] pipe: Advance tail pointer inside of wait spinlock in pipe_read() [ver #3]
Message-Id: <157262969721.13142.294641621235161592.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Advance the pipe ring tail pointer inside of wait spinlock in pipe_read()
so that the pipe can be written into with kernel notifications from
contexts where pipe->mutex cannot be taken.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 69afeab8a73a..ea134f69a292 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -325,9 +325,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
+				spin_lock_irq(&pipe->wait.lock);
 				tail++;
 				pipe->tail = tail;
-				do_wakeup = 1;
+				do_wakeup = 0;
+				wake_up_interruptible_sync_poll_locked(
+					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+				spin_unlock_irq(&pipe->wait.lock);
+				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -359,6 +364,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (do_wakeup) {
 			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
  			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+			do_wakeup = 0;
 		}
 		pipe_wait(pipe);
 	}
