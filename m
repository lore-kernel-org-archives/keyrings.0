From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 16 Jan 2020 03:13:42 +0000
Subject: [PATCH] IMA: inconsistent lock state in ima_process_queued_keys
Message-Id: <20200116031342.3418-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, dvyukov@google.com, James.Bottomley@HansenPartnership.com, arnd@arndb.de, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org

ima_queued_keys() is called from a non-interrupt context, but
ima_process_queued_keys() may be called from both an interrupt
context (ima_timer_handler) and non-interrupt context
(ima_update_policy). Since the spinlock named ima_keys_lock is used
in both ima_queued_keys() and ima_process_queued_keys(),
irq version of the spinlock macros, spin_lock_irqsave() and
spin_unlock_irqrestore(), should be used[1].

This patch fixes the "inconsistent lock state" issue caused by
using the non-irq version of the spinlock macros in ima_queue_key()
and ima_process_queued_keys().

[1] Documentation/locking/spinlocks.rst

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")
Fixes: 9fb38e76b5f1 ("IMA: Define workqueue for early boot key measurements")
---
 security/integrity/ima/ima_asymmetric_keys.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 61e478f9e819..381f51708e7b 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -103,17 +103,18 @@ static bool ima_queue_key(struct key *keyring, const void *payload,
 {
 	bool queued = false;
 	struct ima_key_entry *entry;
+	unsigned long flags;
 
 	entry = ima_alloc_key_entry(keyring, payload, payload_len);
 	if (!entry)
 		return false;
 
-	spin_lock(&ima_keys_lock);
+	spin_lock_irqsave(&ima_keys_lock, flags);
 	if (!ima_process_keys) {
 		list_add_tail(&entry->list, &ima_keys);
 		queued = true;
 	}
-	spin_unlock(&ima_keys_lock);
+	spin_unlock_irqrestore(&ima_keys_lock, flags);
 
 	if (!queued)
 		ima_free_key_entry(entry);
@@ -131,6 +132,7 @@ void ima_process_queued_keys(void)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
+	unsigned long flags;
 
 	if (ima_process_keys)
 		return;
@@ -141,12 +143,12 @@ void ima_process_queued_keys(void)
 	 * First one setting the ima_process_keys flag to true will
 	 * process the queued keys.
 	 */
-	spin_lock(&ima_keys_lock);
+	spin_lock_irqsave(&ima_keys_lock, flags);
 	if (!ima_process_keys) {
 		ima_process_keys = true;
 		process = true;
 	}
-	spin_unlock(&ima_keys_lock);
+	spin_unlock_irqrestore(&ima_keys_lock, flags);
 
 	if (!process)
 		return;
-- 
2.17.1
