From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:03 +0000
Subject: [PATCH v3 2/9] KEYS: Defined functions to queue and dequeue keys for measurement
Message-Id: <20191031011910.2574-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

Key measurements cannot be done if the IMA hook to measure keys is
called before IMA is initialized. Key measurement needs to be deferred
if IMA is not yet initialized. Queued keys need to be processed when
IMA initialization is completed.

This patch defines functions to queue and de-queue keys for measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       | 12 ++++
 security/integrity/ima/ima_queue.c | 92 ++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 22d0628faf56..b9600070e415 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -198,6 +198,16 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_measure_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *keyring_name;
+};
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
@@ -224,6 +234,8 @@ int ima_store_template(struct ima_template_entry *entry, int violation,
 		       const unsigned char *filename, int pcr);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
+int ima_queue_key_for_measurement(struct key *keyring, struct key *key);
+void ima_measure_queued_keys(void);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..f2503f10abf4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -46,6 +46,12 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_measure_keys_mutex);
+static LIST_HEAD(ima_measure_keys);
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -232,3 +238,89 @@ int __init ima_init_digests(void)
 
 	return 0;
 }
+
+static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->keyring_name != NULL)
+			kzfree(entry->keyring_name);
+		kzfree(entry);
+	}
+}
+
+static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
+	struct key *keyring,
+	struct key *key)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t keyring_name_len;
+	struct ima_measure_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	keyring_name_len = strlen(keyring->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->keyring_name +			kzalloc(keyring_name_len, GFP_KERNEL);
+	}
+
+	if ((entry = NULL) || (entry->public_key = NULL) ||
+	    (entry->keyring_name = NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->keyring_name, keyring->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
+	rc = 0;
+
+out:
+	if (rc) {
+		ima_free_measure_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+int ima_queue_key_for_measurement(struct key *keyring, struct key *key)
+{
+	int rc = 0;
+	struct ima_measure_key_entry *entry = NULL;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	entry = ima_alloc_measure_key_entry(keyring, key);
+	if (entry != NULL) {
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list, &ima_measure_keys);
+	} else
+		rc = -ENOMEM;
+
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	return rc;
+}
+
+void ima_measure_queued_keys(void)
+{
+	struct ima_measure_key_entry *entry, *tmp;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
+		process_buffer_measurement(entry->public_key,
+					   entry->public_key_len,
+					   entry->keyring_name,
+					   NONE, 0);
+		list_del(&entry->list);
+		ima_free_measure_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_measure_keys_mutex);
+}
-- 
2.17.1
