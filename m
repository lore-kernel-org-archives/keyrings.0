From: David Howells <dhowells@redhat.com>
Date: Wed, 23 Oct 2019 20:18:28 +0000
Subject: [RFC PATCH 09/10] pipe: Remove redundant wakeup from pipe_write() [ver #2]
Message-Id: <157186190801.3995.3420819228734631242.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Remove a redundant wakeup from pipe_write().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 1bfad2212b95..3df93990dd9d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -516,11 +516,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
