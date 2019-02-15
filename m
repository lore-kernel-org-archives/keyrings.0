From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:07:23 +0000
Subject: [RFC PATCH 01/27] containers: Rename linux/container.h to linux/container_dev.h
Message-Id: <155024684311.21651.6261046862181321227.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Rename linux/container.h to linux/container_dev.h so that linux/container.h
can be used for containers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/acpi/container.c      |    2 +-
 drivers/base/container.c      |    2 +-
 include/linux/container.h     |   25 -------------------------
 include/linux/container_dev.h |   25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/container.h
 create mode 100644 include/linux/container_dev.h

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 12c240903c18..435db0694405 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -23,7 +23,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/acpi.h>
-#include <linux/container.h>
+#include <linux/container_dev.h>
 
 #include "internal.h"
 
diff --git a/drivers/base/container.c b/drivers/base/container.c
index 1ba42d2d3532..1ff01ead2b2a 100644
--- a/drivers/base/container.c
+++ b/drivers/base/container.c
@@ -6,7 +6,7 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
-#include <linux/container.h>
+#include <linux/container_dev.h>
 
 #include "base.h"
 
diff --git a/include/linux/container.h b/include/linux/container.h
deleted file mode 100644
index 3c03e6fd2035..000000000000
--- a/include/linux/container.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Definitions for container bus type.
- *
- * Copyright (C) 2013, Intel Corporation
- * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/device.h>
-
-/* drivers/base/power/container.c */
-extern struct bus_type container_subsys;
-
-struct container_dev {
-	struct device dev;
-	int (*offline)(struct container_dev *cdev);
-};
-
-static inline struct container_dev *to_container_dev(struct device *dev)
-{
-	return container_of(dev, struct container_dev, dev);
-}
diff --git a/include/linux/container_dev.h b/include/linux/container_dev.h
new file mode 100644
index 000000000000..3c03e6fd2035
--- /dev/null
+++ b/include/linux/container_dev.h
@@ -0,0 +1,25 @@
+/*
+ * Definitions for container bus type.
+ *
+ * Copyright (C) 2013, Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+
+/* drivers/base/power/container.c */
+extern struct bus_type container_subsys;
+
+struct container_dev {
+	struct device dev;
+	int (*offline)(struct container_dev *cdev);
+};
+
+static inline struct container_dev *to_container_dev(struct device *dev)
+{
+	return container_of(dev, struct container_dev, dev);
+}
