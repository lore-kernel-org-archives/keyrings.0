From: David Howells <dhowells@redhat.com>
Date: Wed, 23 Oct 2019 20:18:02 +0000
Subject: [RFC PATCH 06/10] pipe: Advance tail pointer inside of wait spinlock in pipe_read() [ver #2]
Message-Id: <157186188205.3995.4257625973468561091.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
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
index 12e47cae9425..1274305772fb 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,9 +324,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
+				spin_lock_irq(&pipe->wait.lock);
 				tail++;
 				pipe_commit_read(pipe, tail);
-				do_wakeup = 1;
+				do_wakeup = 0;
+				wake_up_interruptible_sync_poll_locked(
+					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+				spin_unlock_irq(&pipe->wait.lock);
+				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -358,6 +363,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (do_wakeup) {
 			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
  			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+			do_wakeup = 0;
 		}
 		pipe_wait(pipe);
 	}
