From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 23 Jan 2020 01:32:05 +0000
Subject: [PATCH v9 2/3] IMA: Call workqueue functions to measure queued keys
Message-Id: <20200123013206.8499-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200123013206.8499-1-nramas@linux.microsoft.com>
In-Reply-To: <20200123013206.8499-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: sashal@kernel.org, dhowells@redhat.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

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
 security/integrity/ima/ima_asymmetric_keys.c | 8 ++++++++
 security/integrity/ima/ima_policy.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fea2e7dd3b09..7678f0e3e84d 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,6 +30,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -37,6 +39,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len = 0))
 		return;
 
+	if (ima_should_queue_key())
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3b16b190ae9b..f2fc24511cf4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -807,6 +807,9 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/* Custom IMA policy has been loaded */
+	ima_process_queued_keys();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1
