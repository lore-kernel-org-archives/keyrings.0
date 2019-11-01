From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:35:24 +0000
Subject: [RFC PATCH 09/11] pipe: Remove redundant wakeup from pipe_write() [ver #3]
Message-Id: <157262972442.13142.11480420475866936493.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Remove a redundant wakeup from pipe_write().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index ce77ac0d8901..d7b8d3f22987 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -517,11 +517,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				ret = -ERESTARTSYS;
 			break;
 		}
-		if (do_wakeup) {
-			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
-			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-			do_wakeup = 0;
-		}
 		pipe->waiting_writers++;
 		pipe_wait(pipe);
 		pipe->waiting_writers--;
