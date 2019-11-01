From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:35:05 +0000
Subject: [RFC PATCH 07/11] pipe: Conditionalise wakeup in pipe_read() [ver #3]
Message-Id: <157262970587.13142.9476858866693533437.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Only do a wakeup in pipe_read() if we made space in a completely full
buffer.  The producer shouldn't be waiting on pipe->wait otherwise.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index ea134f69a292..c16950e36ded 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -328,11 +328,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				spin_lock_irq(&pipe->wait.lock);
 				tail++;
 				pipe->tail = tail;
-				do_wakeup = 0;
-				wake_up_interruptible_sync_poll_locked(
-					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+				do_wakeup = 1;
+				if (head - (tail - 1) == pipe->max_usage)
+					wake_up_interruptible_sync_poll_locked(
+						&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 				spin_unlock_irq(&pipe->wait.lock);
-				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+				if (head - (tail - 1) == pipe->max_usage)
+					kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -361,11 +363,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				ret = -ERESTARTSYS;
 			break;
 		}
-		if (do_wakeup) {
-			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
- 			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-			do_wakeup = 0;
-		}
 		pipe_wait(pipe);
 	}
 	__pipe_unlock(pipe);
