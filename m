From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:08 +0000
Subject: [PATCH v3 7/9] KEYS: Queue key for measurement if IMA is not yet initialized. Measure queued keys wh
Message-Id: <20191031011910.2574-8-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

Keys need to be queued when the IMA hook to measure keys is called before
IMA is initialized. Keys queued for measurement need to be processed when
IMA initialization is completed.

This patch adds the call to queue and de-queue keys for measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 7 ++++++-
 security/integrity/ima/ima_main.c | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..91eaa5f2d008 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -131,5 +131,10 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_measure_queued_keys();
+	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bd835ec89ead..2ad05563542c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -732,6 +732,11 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (key->type != &key_type_asymmetric)
 		return;
 
+	if (!ima_policy_flag) {
+		ima_queue_key_for_measurement(keyring, key);
+		return;
+	}
+
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
-- 
2.17.1
