From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 17:35:32 +0000
Subject: [RFC PATCH 10/11] pipe: Check for ring full inside of the spinlock in pipe_write() [ver #3]
Message-Id: <157262973277.13142.11996381016183033698.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Make pipe_write() check to see if the ring has become full between it
taking the pipe mutex, checking the ring status and then taking the
spinlock.

This can happen if a notification is written into the pipe as that happens
without the pipe mutex.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index d7b8d3f22987..aba2455caabe 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -463,6 +463,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			spin_lock_irq(&pipe->wait.lock);
 
 			head = pipe->head;
+			if (pipe_full(head, pipe->tail, max_usage)) {
+				spin_unlock_irq(&pipe->wait.lock);
+				continue;
+			}
+
 			pipe->head = head + 1;
 
 			/* Always wake up, even if the copy fails. Otherwise
