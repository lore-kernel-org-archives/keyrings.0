From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 23 Oct 2019 00:18:17 +0000
Subject: [PATCH v1 5/6] KEYS: measure queued keys
Message-Id: <20191023001818.3684-6-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Cc: nramas@linux.microsoft.com

Call process_buffer_measurement to measure keys that
are added and updated in the system.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c  | 23 +++++++++++++++++++++
 security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8e965d18fb21..7c2afb954f19 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -678,6 +678,29 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/*
+ * ima_post_key_create_or_update
+ * @keyring points to the keyring to which the key belongs
+ * @key points to the key being created or updated
+ * @cred cred structure
+ * @flags flags passed to key_create_or_update function
+ * @create flag to indicate whether the key was created or updated
+ *
+ * IMA hook called when a new key is created or updated.
+ *
+ * On success return 0.
+ * Return appropriate error code on error
+ */
+int ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create)
+{
+	if (key->type != &key_type_asymmetric)
+		return 0;
+
+	return ima_measure_key(keyring, key);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a262e289615b..0da11a292f99 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -322,7 +322,12 @@ static struct ima_trusted_key_entry *ima_alloc_trusted_queue_entry(
 int ima_measure_key(struct key *keyring, struct key *key)
 {
 	int rc = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int action;
 	struct ima_trusted_key_entry *entry = NULL;
+	const struct public_key *pk;
+	u32 secid;
 	enum ima_hooks func;
 	bool queued = false;
 
@@ -344,16 +349,43 @@ int ima_measure_key(struct key *keyring, struct key *key)
 
 	mutex_unlock(&ima_trusted_keys_mutex);
 
+	if ((rc = 0) && !queued) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0,
+					func, &pcr, &template_desc);
+		if (action & IMA_MEASURE) {
+			pk = key->payload.data[asym_crypto];
+			process_buffer_measurement(pk->key, pk->keylen,
+						   key->description,
+						   pcr, template_desc);
+		}
+	}
+
 	return rc;
 }
 
 void ima_measure_queued_trusted_keys(void)
 {
 	struct ima_trusted_key_entry *entry, *tmp;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int action;
+	u32 secid;
 
 	mutex_lock(&ima_trusted_keys_mutex);
 
 	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0,
+					entry->func, &pcr,
+					&template_desc);
+		if (action & IMA_MEASURE) {
+			process_buffer_measurement(entry->public_key,
+						   entry->public_key_len,
+						   entry->key_description,
+						   pcr,
+						   template_desc);
+		}
 		list_del(&entry->list);
 		ima_free_trusted_key_entry(entry);
 	}
-- 
2.17.1
