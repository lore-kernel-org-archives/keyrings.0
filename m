From: David Howells <dhowells@redhat.com>
Date: Wed, 23 Oct 2019 20:18:19 +0000
Subject: [RFC PATCH 08/10] pipe: Rearrange sequence in pipe_write() to preallocate slot [ver #2]
Message-Id: <157186189940.3995.3273332042636743290.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>dhowells@redhat.com, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org@vger.kernel.org, linux-kernel@vger.kernel.org

Rearrange the sequence in pipe_write() so that the allocation of the new
buffer, the allocation of a ring slot and the attachment to the ring is
done under the pipe wait spinlock and then the lock is dropped and the
buffer can be filled.

The data copy needs to be done with the spinlock unheld and irqs enabled,
so the lock needs to be dropped first.  However, the reader can't progress
as we're holding pipe->mutex.

We also need to drop the lock as that would impact others looking at the
pipe waitqueue, such as poll(), the consumer and a future kernel message
writer.

We just abandon the preallocated slot if we get a copy error.  Future
writes may continue it and a future read will eventually recycle it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index e3a8f10750c9..1bfad2212b95 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -386,7 +386,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	unsigned int head, tail, max_usage, mask;
+	unsigned int head, max_usage, mask;
 	ssize_t ret = 0;
 	int do_wakeup = 0;
 	size_t total_len = iov_iter_count(from);
@@ -404,14 +404,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	tail = pipe->tail;
 	head = pipe->head;
 	max_usage = pipe->max_usage;
 	mask = pipe->ring_size - 1;
 
 	/* We try to merge small writes */
 	chars = total_len & (PAGE_SIZE-1); /* size of the last buffer */
-	if (!pipe_empty(head, tail) && chars != 0) {
+	if (!pipe_empty(head, pipe->tail) && chars != 0) {
 		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
 		int offset = buf->offset + buf->len;
 
@@ -440,8 +439,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			break;
 		}
 
-		tail = pipe->tail;
-		if (!pipe_full(head, tail, max_usage)) {
+		head = pipe->head;
+		if (!pipe_full(head, pipe->tail, max_usage)) {
 			struct pipe_buffer *buf = &pipe->bufs[head & mask];
 			struct page *page = pipe->tmp_page;
 			int copied;
@@ -454,40 +453,56 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				}
 				pipe->tmp_page = page;
 			}
+
+			/* Allocate a slot in the ring in advance and attach an
+			 * empty buffer.  If we fault or otherwise fail to use
+			 * it, either the reader will consume it or it'll still
+			 * be there for the next write.
+			 */
+			spin_lock_irq(&pipe->wait.lock);
+
+			head = pipe->head;
+			pipe_commit_write(pipe, head + 1);
+
 			/* Always wake up, even if the copy fails. Otherwise
 			 * we lock up (O_NONBLOCK-)readers that sleep due to
 			 * syscall merging.
 			 * FIXME! Is this really true?
 			 */
-			do_wakeup = 1;
-			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
-			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
-				if (!ret)
-					ret = -EFAULT;
-				break;
-			}
-			ret += copied;
+			wake_up_interruptible_sync_poll_locked(
+				&pipe->wait, EPOLLIN | EPOLLRDNORM);
+
+			spin_unlock_irq(&pipe->wait.lock);
+			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 
 			/* Insert it into the buffer array */
+			buf = &pipe->bufs[head & mask];
 			buf->page = page;
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
-			buf->len = copied;
+			buf->len = 0;
 			buf->flags = 0;
 			if (is_packetized(filp)) {
 				buf->ops = &packet_pipe_buf_ops;
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			}
-
-			head++;
-			pipe_commit_write(pipe, head);
 			pipe->tmp_page = NULL;
 
+			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
+			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
+				if (!ret)
+					ret = -EFAULT;
+				break;
+			}
+			ret += copied;
+			buf->offset = 0;
+			buf->len = copied;
+
 			if (!iov_iter_count(from))
 				break;
 		}
 
-		if (!pipe_full(head, tail, max_usage))
+		if (!pipe_full(head, pipe->tail, max_usage))
 			continue;
 
 		/* Wait for buffer space to become available. */
