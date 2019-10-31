From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:02 +0000
Subject: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key create or update
Message-Id: <20191031011910.2574-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

Asymmetric keys used for verifying file signatures or certificates
are currently not included in the IMA measurement list.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      |  2 ++
 security/integrity/ima/ima_main.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 997a57137351..22d0628faf56 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,8 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
 
 #include "../integrity.h"
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 492b8f241d39..18e1bc105be7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -635,6 +635,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
@@ -695,6 +698,29 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	pk = key->payload.data[asym_crypto];
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description,
+				   NONE, 0);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.17.1
