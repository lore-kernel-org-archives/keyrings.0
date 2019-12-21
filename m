From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Sat, 21 Dec 2019 01:52:56 +0000
Subject: [PATCH] IMA: Defined timer to process queued keys
Message-Id: <20191221015256.2775-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

keys queued for measurement should still be processed even if
a custom IMA policy was not loaded. Otherwise, the keys will
remain queued forever consuming kernel memory.

This patch defines a timer to handle the above scenario. The timer
is setup to expire 5 minutes after IMA initialization is completed.

If a custom IMA policy is loaded before the timer expires, the timer
is removed and any queued keys are processed. But if a custom policy
was not loaded, on timer expiration any queued keys are processed.

On timer expiration the keys are still processed. This will enable
keys to be measured in case the built-in IMA policy defines a key
measurement rule.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  2 ++
 security/integrity/ima/ima_asymmetric_keys.c | 34 ++++++++++++++++++++
 security/integrity/ima/ima_init.c            |  8 ++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 97f8a4078483..c483215a9ee5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -216,8 +216,10 @@ struct ima_key_entry {
 	char *keyring_name;
 };
 void ima_process_queued_keys(void);
+void ima_init_key_queue(void);
 #else
 static inline void ima_process_queued_keys(void) {}
+static inline void ima_init_key_queue(void) {}
 #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 4124f10ff0c2..92a7dcdf39a0 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/timer.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -26,6 +27,34 @@ static bool ima_process_keys;
 static DEFINE_MUTEX(ima_keys_mutex);
 static LIST_HEAD(ima_keys);
 
+/*
+ * If custom IMA policy is not loaded then keys queued up
+ * for measurement should be freed. This timer is used
+ * for handling this scenario.
+ */
+static long ima_key_queue_timeout = 300000; /* 5 Minutes */
+static struct timer_list ima_key_queue_timer;
+
+/*
+ * This timer callback function processes keys that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_timer_handler(struct timer_list *timer)
+{
+	ima_process_queued_keys();
+}
+
+/*
+ * This function sets up a timer to process queued keys in case
+ * custom IMA policy was never loaded.
+ */
+void ima_init_key_queue(void)
+{
+	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
+	mod_timer(&ima_key_queue_timer,
+		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
+}
+
 static void ima_free_key_entry(struct ima_key_entry *entry)
 {
 	if (entry) {
@@ -120,6 +149,11 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
+	/*
+	 * Timer is no longer needed since queued keys will be processed now.
+	 */
+	del_timer(&ima_key_queue_timer);
+
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		process_buffer_measurement(entry->payload, entry->payload_len,
 					   entry->keyring_name, KEY_CHECK, 0,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..195cb4079b2b 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -131,5 +131,11 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_init_key_queue();
+
+	return rc;
 }
-- 
2.17.1
