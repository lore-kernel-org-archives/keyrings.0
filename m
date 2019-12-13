From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 13 Dec 2019 17:18:26 +0000
Subject: [PATCH v4 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <20191213171827.28657-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
In-Reply-To: <20191213171827.28657-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys created or updated before a custom IMA policy is loaded should
be queued and the keys should be processed after a custom policy
is loaded.

This patch defines workqueue for queuing keys when a custom IMA policy
has not yet been loaded.

A flag namely ima_process_keys is used to check if the key should be
queued or should be processed immediately.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 128 +++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f06238e41a7c..97f8a4078483 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,6 +205,21 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_key_entry {
+	struct list_head list;
+	void *payload;
+	size_t payload_len;
+	char *keyring_name;
+};
+void ima_process_queued_keys(void);
+#else
+static inline void ima_process_queued_keys(void) {}
+#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fea2e7dd3b09..ae6de1bb2e79 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -14,6 +14,134 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+/*
+ * Flag to indicate whether a key can be processed
+ * right away or should be queued for processing later.
+ */
+static bool ima_process_keys;
+
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_keys_mutex);
+static LIST_HEAD(ima_keys);
+
+static void ima_free_key_entry(struct ima_key_entry *entry)
+{
+	if (entry) {
+		kfree(entry->payload);
+		kfree(entry->keyring_name);
+		kfree(entry);
+	}
+}
+
+static struct ima_key_entry *ima_alloc_key_entry(
+	struct key *keyring,
+	const void *payload, size_t payload_len)
+{
+	int rc = 0;
+	struct ima_key_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+		entry->keyring_name = kstrdup(keyring->description,
+					      GFP_KERNEL);
+		entry->payload_len = payload_len;
+	}
+
+	if ((entry = NULL) || (entry->payload = NULL) ||
+	    (entry->keyring_name = NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&entry->list);
+
+out:
+	if (rc) {
+		ima_free_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+bool ima_queue_key(struct key *keyring, const void *payload,
+		   size_t payload_len)
+{
+	bool queued = false;
+	struct ima_key_entry *entry;
+
+	entry = ima_alloc_key_entry(keyring, payload, payload_len);
+	if (!entry)
+		return false;
+
+	mutex_lock(&ima_keys_mutex);
+	if (!ima_process_keys) {
+		list_add_tail(&entry->list, &ima_keys);
+		queued = true;
+	}
+	mutex_unlock(&ima_keys_mutex);
+
+	if (!queued)
+		ima_free_key_entry(entry);
+
+	return queued;
+}
+
+/*
+ * ima_process_queued_keys() - process keys queued for measurement
+ *
+ * This function sets ima_process_keys to true and processes queued keys.
+ * From here on keys will be processed right away (not queued).
+ */
+void ima_process_queued_keys(void)
+{
+	struct ima_key_entry *entry, *tmp;
+	LIST_HEAD(temp_ima_keys);
+	bool process = false;
+
+	if (ima_process_keys)
+		return;
+
+	/*
+	 * To avoid holding the mutex when processing queued keys,
+	 * transfer the queued keys with the mutex held to a temp list,
+	 * release the mutex, and then process the queued keys from
+	 * the temp list.
+	 *
+	 * Since ima_process_keys is set to true, any new key will be
+	 * processed immediately and not be queued.
+	 */
+	INIT_LIST_HEAD(&temp_ima_keys);
+
+	mutex_lock(&ima_keys_mutex);
+
+	if (!ima_process_keys) {
+		ima_process_keys = true;
+
+		if (!list_empty(&ima_keys)) {
+			list_for_each_entry_safe(entry, tmp, &ima_keys, list)
+				list_move_tail(&entry->list, &temp_ima_keys);
+			process = true;
+		}
+	}
+
+	mutex_unlock(&ima_keys_mutex);
+
+	if (!process)
+		return;
+
+	list_for_each_entry_safe(entry, tmp, &temp_ima_keys, list) {
+		process_buffer_measurement(entry->payload, entry->payload_len,
+					   entry->keyring_name, KEY_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_key_entry(entry);
+	}
+}
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1
