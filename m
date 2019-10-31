From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:09 +0000
Subject: [PATCH v3 8/9] KEYS: Added a boolean flag for IMA initialization status.
Message-Id: <20191031011910.2574-9-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

IMA hook does not know whether a key can be measured right away or
the key needs to be queued to be measured at a later time.

This patch defines a flag to indicate the IMA initialization status.
IMA hook will use this flag to determine if a key can be measured
right away or the key needs to be queued to be measured at a later time.

ima_policy_flag cannot be relied upon for knowing IMA initialization
status because ima_policy_flag will be set to 0 when either IMA
is not initialized or the IMA policy itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      | 1 +
 security/integrity/ima/ima_init.c | 3 +++
 security/integrity/ima/ima_main.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f8bf5c24e0d0..5abc5a0b4591 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -54,6 +54,7 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern bool ima_initialized;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 91eaa5f2d008..8734ed5322c7 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,7 @@
 /* name for boot aggregate entry */
 static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+bool ima_initialized;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -135,6 +136,8 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
+	ima_initialized = true;
+
 	ima_measure_queued_keys();
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2ad05563542c..e4c5e7150611 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -732,7 +732,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (key->type != &key_type_asymmetric)
 		return;
 
-	if (!ima_policy_flag) {
+	if (!ima_initialized) {
 		ima_queue_key_for_measurement(keyring, key);
 		return;
 	}
-- 
2.17.1
