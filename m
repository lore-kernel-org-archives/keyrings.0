From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:07 +0000
Subject: [PATCH v3 6/9] KEYS: Measure key if the IMA policy allows measurement for the given keyring
Message-Id: <20191031011910.2574-7-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

process_buffer_measurement() does not know which keyring the given key
is being linked to. It needs the keyring name to determine whether 
or not the given key needs to be measured.

This patch adds a new parameter "keyring" to process_buffer_measurement()
to convey which keyring the given key is linked to.

If KEYRING_CHECK alone is set in the policy, all keys are measured.
If a list of keyrings is also specified in the policy then only keys
linked to those keyrings will be measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 +-
 security/integrity/ima/ima_main.c  | 24 +++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |  3 ++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ded78af94e69..f8bf5c24e0d0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -225,7 +225,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cbc7de87106f..bd835ec89ead 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -612,12 +612,22 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
+ * @keyring: keyring for the measurement
+ *
+ *	The following scenarios are possible with respect to
+ *	the parameter "keyring":
+ *	1, keyring is NULL. In this case buffer is measured.
+ *	2, keyring is not NULL, but ima_get_action returned
+ *	   a NULL keyrings. In this case also the buffer is measured.
+ *	3, keyring is not NULL and ima_get_action returned
+ *	   a non-NULL keyrings. In this case measure the buffer
+ *	   only if the given keyring is present in the keyrings.
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr)
+				int pcr, const char *keyring)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -647,8 +657,10 @@ void process_buffer_measurement(const void *buf, int size,
 			return;
 	}
 
-	if (keyrings != NULL)
-		keyrings = NULL;
+	if ((keyring != NULL) && (keyrings != NULL)
+	    && (strstr(keyrings, keyring) = NULL)) {
+		return;
+	}
 
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
@@ -698,7 +710,8 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0) {
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0,
+					   NULL);
 	}
 }
 
@@ -722,7 +735,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
-				   KEYRING_CHECK, 0);
+				   KEYRING_CHECK, 0,
+				   keyring->description);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 5625381c5a97..805dcacb48e6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -317,7 +317,8 @@ void ima_measure_queued_keys(void)
 		process_buffer_measurement(entry->public_key,
 					   entry->public_key_len,
 					   entry->keyring_name,
-					   KEYRING_CHECK, 0);
+					   KEYRING_CHECK, 0,
+					   entry->keyring_name);
 		list_del(&entry->list);
 		ima_free_measure_key_entry(entry);
 	}
-- 
2.17.1
