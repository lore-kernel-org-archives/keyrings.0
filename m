From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 11 Nov 2019 19:32:58 +0000
Subject: [PATCH v5 05/10] IMA: Measure key if the IMA policy allows measurement for the keyring to which the 
Message-Id: <20191111193303.12781-6-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

process_buffer_measurement() needs to check if the keyring to which
the given key is linked to is listed in the keyrings option in
the IMA policy.

This patch adds a new parameter "keyring" to process_buffer_measurement().

If process_buffer_measurement() is called with func KEYRING_CHECK and
the name of the keyring to which the key is linked to, then the given
key is measured if:
  1, IMA policy did not specify "keyrings=" option.
  2, Or, the given keyring name is listed in the "keyrings=" option.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 387829afb9a2..f15199f7ff2a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -221,7 +221,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 47ad4f56c0a8..a9649b04b9f1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -330,7 +330,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc = -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr);
+						   pcr, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 68e15ff1fe8d..1bd5dbd8a077 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -632,12 +632,22 @@ int ima_load_data(enum kernel_load_data_id id)
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
@@ -656,6 +666,13 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	/*
+	 * If IMA is not yet initialized or IMA policy is empty
+	 * then there is no need to measure.
+	 */
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
@@ -671,6 +688,11 @@ void process_buffer_measurement(const void *buf, int size,
 			return;
 	}
 
+	if ((keyring != NULL) && (keyrings != NULL)
+	    && (strstr(keyrings, keyring) = NULL)) {
+		return;
+	}
+
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
@@ -719,7 +741,7 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0, NULL);
 }
 
 static int __init init_ima(void)
-- 
2.17.1
