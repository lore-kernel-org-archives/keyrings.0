From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 06 Dec 2019 01:29:36 +0000
Subject: [PATCH v1 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <20191206012936.2814-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
In-Reply-To: <20191206012936.2814-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys should be queued for measurement if a custom IMA policy
is not yet loaded. Keys queued for measurement, if any, should be
processed when a custom IMA policy is loaded.

This patch updates the IMA hook function ima_post_key_create_or_update()
to queue the key if a custom IMA policy has not yet been loaded.
And, ima_update_policy() function, which is called when
a custom IMA policy is loaded, is updated to process queued keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 9 +++++++++
 security/integrity/ima/ima_policy.c          | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fbdbe9c261cb..510b29d17a7b 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -155,6 +155,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool key_queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -162,6 +164,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len = 0))
 		return;
 
+	if (!ima_process_keys_for_measurement)
+		key_queued = ima_queue_key_for_measurement(keyring, payload,
+							   payload_len);
+
+	if (key_queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 73030a69d546..4dc8fb9957ac 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -808,6 +808,12 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/*
+	 * Custom IMA policies have been setup.
+	 * Process key(s) queued up for measurement now.
+	 */
+	ima_process_queued_keys_for_measurement();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1
