From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 15 Jun 2020 06:46:59 +0000
Subject: [PATCH 20/29] docs: watch_queue.rst: supress some Sphinx warnings and move to core-api
Message-Id: <6aa020863c158e55387d6282a048f952c31998f6.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

Sphinx doesn't like multi-line literal blocks with ``foobar``:

    Documentation/watch_queue.rst:109: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:186: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:186: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:185: WARNING: Inline emphasis start-string without end-string.

So, let's use the "::" markup instead.

While we could do the fix only at the affected lines, let's
do the same change along the entire file, in order to preserve
the same look and feel at the entire doc.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/index.rst             |  1 +
 Documentation/{ => core-api}/watch_queue.rst | 34 ++++++++++++++------
 Documentation/security/keys/core.rst         |  2 +-
 include/linux/watch_queue.h                  |  2 +-
 init/Kconfig                                 |  2 +-
 kernel/watch_queue.c                         |  2 +-
 6 files changed, 30 insertions(+), 13 deletions(-)
 rename Documentation/{ => core-api}/watch_queue.rst (94%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 15ab86112627..ee6957100dec 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -40,6 +40,7 @@ Library functionality that is used throughout the kernel.
    generic-radix-tree
    packing
    timekeeping
+   watch_queue
    errseq
 
 Concurrency primitives
diff --git a/Documentation/watch_queue.rst b/Documentation/core-api/watch_queue.rst
similarity index 94%
rename from Documentation/watch_queue.rst
rename to Documentation/core-api/watch_queue.rst
index 849fad6893ef..ba47adc01239 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/core-api/watch_queue.rst
@@ -103,15 +103,19 @@ watch that specific key).
 
 To manage a watch list, the following functions are provided:
 
-  * ``void init_watch_list(struct watch_list *wlist,
-			   void (*release_watch)(struct watch *wlist));``
+  * ::
+
+      void init_watch_list(struct watch_list *wlist,
+			   void (*release_watch)(struct watch *wlist));
 
     Initialise a watch list.  If ``release_watch`` is not NULL, then this
     indicates a function that should be called when the watch_list object is
     destroyed to discard any references the watch list holds on the watched
     object.
 
-  * ``void remove_watch_list(struct watch_list *wlist);``
+  * ::
+
+      void remove_watch_list(struct watch_list *wlist);
 
     This removes all of the watches subscribed to a watch_list and frees them
     and then destroys the watch_list object itself.
@@ -125,14 +129,18 @@ records will be written into.  The workings of this are hidden entirely inside
 of the pipe device driver, but it is necessary to gain a reference to it to set
 a watch.  These can be managed with:
 
-  * ``struct watch_queue *get_watch_queue(int fd);``
+  * ::
+
+      struct watch_queue *get_watch_queue(int fd);``
 
     Since watch queues are indicated to the kernel by the fd of the pipe that
     implements the buffer, userspace must hand that fd through a system call.
     This can be used to look up an opaque pointer to the watch queue from the
     system call.
 
-  * ``void put_watch_queue(struct watch_queue *wqueue);``
+  * ::
+
+      void put_watch_queue(struct watch_queue *wqueue);
 
     This discards the reference obtained from ``get_watch_queue()``.
 
@@ -168,18 +176,24 @@ different ID are ignored.
 
 The following functions are provided to manage watches:
 
-  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue);``
+  * ::
+
+      void init_watch(struct watch *watch, struct watch_queue *wqueue);
 
     Initialise a watch object, setting its pointer to the watch queue, using
     appropriate barriering to avoid lockdep complaints.
 
-  * ``int add_watch_to_object(struct watch *watch, struct watch_list *wlist);``
+  * ::
+
+      int add_watch_to_object(struct watch *watch, struct watch_list *wlist);
 
     Subscribe a watch to a watch list (notification source).  The
     driver-settable fields in the watch struct must have been set before this
     is called.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist,
+  * ::
+
+      int remove_watch_from_object(struct watch_list *wlist,
 				   struct watch_queue *wqueue,
 				   u64 id, false);``
 
@@ -188,7 +202,9 @@ The following functions are provided to manage watches:
     (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue to
     indicate that the watch got removed.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true);``
+  * ::
+
+      int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true);
 
     Remove all the watches from a watch list.  It is expected that this will be
     called preparatory to destruction and that the watch list will be
diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index cdc42ccc12e4..e0f1211ca843 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1046,7 +1046,7 @@ The keyctl syscall functions are:
      "filter" is either NULL to remove a watch or a filter specification to
      indicate what events are required from the key.
 
-     See Documentation/watch_queue.rst for more information.
+     See Documentation/core-api/watch_queue.rst for more information.
 
      Note that only one watch may be emplaced for any particular { key,
      queue_fd } combination.
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 5e08db2adc31..0d8ba47446fa 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/watch_queue.rst
+ * See Documentation/core-api/watch_queue.rst
  */
 
 #ifndef _LINUX_WATCH_QUEUE_H
diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..3327f0eca1a3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -377,7 +377,7 @@ config WATCH_QUEUE
 	  with watches for key/keyring change notifications and device
 	  notifications.
 
-	  See Documentation/watch_queue.rst
+	  See Documentation/core-api/watch_queue.rst
 
 config CROSS_MEMORY_ATTACH
 	bool "Enable process_vm_readv/writev syscalls"
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index f74020f6bd9d..58a4e18390bf 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/watch_queue.rst
+ * See Documentation/core-api/watch_queue.rst
  */
 
 #define pr_fmt(fmt) "watchq: " fmt
-- 
2.26.2
