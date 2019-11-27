From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 27 Nov 2019 02:52:12 +0000
Subject: [PATCH v0 2/2] IMA: Call queue functions to measure keys
Message-Id: <20191127025212.3077-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
In-Reply-To: <20191127025212.3077-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Keys should be queued for measurement if custom IMA policies have
not yet been applied. Keys queued for measurement, if any, need to be
processed when custom IMA policies have been applied.

This patch adds the call to ima_queue_key_for_measurement() in
the IMA hook function if ima_process_keys_for_measurement flag is set
to false. And, the call to ima_process_queued_keys_for_measurement()
when custom IMA policies have been applied in ima_update_policy().

NOTE:
If the kernel is built with CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
enabled then the IMA policy should be applied as custom IMA policies.

Keys will be queued up until custom policies are applied and processed
when custom policies have been applied.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 16 ++++++++++++++++
 security/integrity/ima/ima_policy.c          | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 10deb77b22a0..adb7a307190f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -157,6 +157,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool key_queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -164,6 +166,20 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len = 0))
 		return;
 
+	if (!ima_process_keys_for_measurement)
+		key_queued = ima_queue_key_for_measurement(keyring,
+							   payload,
+							   payload_len);
+
+	/*
+	 * Need to check again if the key was queued or not because
+	 * ima_process_keys_for_measurement could have flipped from
+	 * false to true after it was checked above, but before the key
+	 * could be queued by ima_queue_key_for_measurement().
+	 */
+	if (key_queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 78b25f083fe1..a2e30a90f97d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -812,6 +812,18 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/*
+	 * Custom IMA policies have been setup.
+	 * Process key(s) queued up for measurement now.
+	 *
+	 * NOTE:
+	 *   Custom IMA policies always overwrite builtin policies
+	 *   (policies compiled in code). If one wants measurement
+	 *   of asymmetric keys then it has to be configured in
+	 *   custom policies and updated here.
+	 */
+	ima_process_queued_keys_for_measurement();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1
