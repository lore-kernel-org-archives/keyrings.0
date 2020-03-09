From: David Howells <dhowells@redhat.com>
Date: Mon, 09 Mar 2020 12:18:26 +0000
Subject: [RFC PATCH 08/17] pipe: Allow buffers to be marked read-whole-or-error for notifications [ver #4]
Message-Id: <158375630635.334846.14056952096999691585.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc: dhowells@redhat.comdhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Allow a buffer to be marked such that read() must return the entire buffer
in one go or return ENOBUFS.  Multiple buffers can be amalgamated into a
single read, but a short read will occur if the next "whole" buffer won't
fit.

This is useful for watch queue notifications to make sure we don't split a
notification across multiple reads, especially given that we need to
fabricate an overrun record under some circumstances - and that isn't in
the buffers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c                        |    8 +++++++-
 include/linux/pipe_fs_i.h        |    1 +
 kernel/watch_queue.c             |    2 +-
 samples/watch_queue/watch_test.c |    2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 36eedf8cb143..c98452868dde 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -320,8 +320,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			size_t written;
 			int error;
 
-			if (chars > total_len)
+			if (chars > total_len) {
+				if (buf->flags & PIPE_BUF_FLAG_WHOLE) {
+					if (ret = 0)
+						ret = -ENOBUFS;
+					break;
+				}
 				chars = total_len;
+			}
 
 			error = pipe_buf_confirm(pipe, buf);
 			if (error) {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8cd14d72dfd1..fee90981ba40 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -8,6 +8,7 @@
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
 #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
+#define PIPE_BUF_FLAG_WHOLE	0x10	/* read() must return entire buffer or error */
 
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index c103e34f8705..ad64ea300f6d 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -115,7 +115,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->ops = &watch_queue_pipe_buf_ops;
 	buf->offset = offset;
 	buf->len = len;
-	buf->flags = 0;
+	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	pipe->head = head + 1;
 
 	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 9bf60abf5c7e..924e13a49c37 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -63,7 +63,7 @@ static void saw_key_change(struct watch_notification *n, size_t len)
  */
 static void consumer(int fd)
 {
-	unsigned char buffer[4096], *p, *end;
+	unsigned char buffer[433], *p, *end;
 	union {
 		struct watch_notification n;
 		unsigned char buf1[128];
