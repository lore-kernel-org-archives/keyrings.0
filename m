From: David Howells <dhowells@redhat.com>
Date: Mon, 09 Mar 2020 12:17:49 +0000
Subject: [RFC PATCH 04/17] pipe: Add O_NOTIFICATION_PIPE [ver #4]
Message-Id: <158375626967.334846.484230574013552912.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc: dhowells@redhat.comdhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indicate
that the pipe being created is going to be used for notifications.  This
suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
pipe as calling iov_iter_revert() on a pipe when a kernel notification
message has been inserted into the middle of a multi-buffer splice will be
messy.

The flag is given the same value as O_EXCL as it seems unlikely that
this flag will ever be applicable to pipes and I don't want to use up
another O_* bit unnecessarily.  An alternative could be to add a pipe3()
system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 5f3d21e8a34b..9df72227f515 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -3,6 +3,9 @@
 #define _UAPI_LINUX_WATCH_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/fcntl.h>
+
+#define O_NOTIFICATION_PIPE	O_EXCL	/* Parameter to pipe2() selecting notification pipe */
 
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
