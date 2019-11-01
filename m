From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 22:05:26 +0000
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
Message-Id: <13964.1572645926@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Side note: we have a couple of cases where I don't think we should use
> the "sync" version at all.
> 
> Both pipe_read() and pipe_write() have that
> 
>         if (do_wakeup) {
>                 wake_up_interruptible_sync_poll(&pipe->wait, ...
> 
> code at the end, outside the loop. But those two wake-ups aren't
> actually synchronous.

Changing those to non-sync:

BENCHMARK       BEST            TOTAL BYTES     AVG BYTES       STDDEV
=============== =============== =============== =============== ===============
pipe                  305816126     36255936983       302132808         8880788
splice                282402106     27102249370       225852078       210033443
vmsplice              440022611     48896995196       407474959        59906438

Changing the others in pipe_read() and pipe_write() too:

pipe                  305609682     36285967942       302383066         7415744
splice                282475690     27891475073       232428958       201687522
vmsplice              451458280     51949421503       432911845        34925242

The cumulative patch is attached below.  I'm not sure how well this should
make a difference with my benchmark programs since each thread can run on its
own CPU.

David
---
diff --git a/fs/pipe.c b/fs/pipe.c
index 9cd5cbef9552..c5e3765465f0 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -332,7 +332,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				do_wakeup = 1;
 				wake = head - (tail - 1) == pipe->max_usage / 2;
 				if (wake)
-					wake_up_interruptible_sync_poll_locked(
+					wake_up_locked_poll(
 						&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 				spin_unlock_irq(&pipe->wait.lock);
 				if (wake)
@@ -371,7 +371,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 	/* Signal writers asynchronously that there is more room. */
 	if (do_wakeup) {
-		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+		wake_up_interruptible_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
 	if (ret > 0)
@@ -477,7 +477,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * syscall merging.
 			 * FIXME! Is this really true?
 			 */
-			wake_up_interruptible_sync_poll_locked(
+			wake_up_locked_poll(
 				&pipe->wait, EPOLLIN | EPOLLRDNORM);
 
 			spin_unlock_irq(&pipe->wait.lock);
@@ -531,7 +531,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 	__pipe_unlock(pipe);
 	if (do_wakeup) {
-		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
+		wake_up_interruptible_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
 	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
