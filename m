From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 06 Nov 2019 19:01:15 +0000
Subject: [PATCH v4 09/10] IMA: Call queue and dequeue functions to measure keys
Message-Id: <20191106190116.2578-10-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Keys should be queued for measurement if IMA is not yet initialized.
Keys queued for measurement, if any, need to be processed when IMA
initialization is completed.

This patch updates the IMA hook for key_create_or_update 
to call ima_queue_or_process_key_for_measurement() and
adds the call to process queued keys upon IMA initialization
completion.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 1 +
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a810af6df587..74817a9f78e5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -137,6 +137,7 @@ int __init ima_init(void)
 		return rc;
 
 	ima_initialized = true;
+	ima_measure_queued_keys();
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 56540357c854..8733990867f2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,7 +757,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	if ((keyring != NULL) && (key != NULL))
-		return;
+		ima_queue_or_process_key_for_measurement(keyring, key);
 }
 
 static int __init init_ima(void)
-- 
2.17.1
