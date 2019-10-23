From: David Howells <dhowells@redhat.com>
Date: Wed, 23 Oct 2019 20:18:36 +0000
Subject: [RFC PATCH 10/10] pipe: Check for ring full inside of the spinlock in pipe_write() [ver #2]
Message-Id: <157186191654.3995.6474781916564747415.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
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
index 3df93990dd9d..6a982a88f658 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -462,6 +462,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			spin_lock_irq(&pipe->wait.lock);
 
 			head = pipe->head;
+			if (pipe_full(head, pipe->tail, max_usage)) {
+				spin_unlock_irq(&pipe->wait.lock);
+				continue;
+			}
+
 			pipe_commit_write(pipe, head + 1);
 
 			/* Always wake up, even if the copy fails. Otherwise
