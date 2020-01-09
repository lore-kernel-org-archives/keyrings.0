From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 09 Jan 2020 17:50:46 +0000
Subject: [PATCH] IMA: fix measuring early boot asymmetric keys
Message-Id: <20200109175046.4024-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

As a result of the asymmetric public keys subtype being defined as a
tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
be built as a kernel module. To prevent this from happening,
an intermediate Kconfig boolean option named
IMA_MEASURE_ASYMMETRIC_KEYS has been defined.

This patch uses this new config CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
to declare the early boot key measurement functions.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kbuild test robot <lkp@intel.com> # redefinition of
ima_init_key_queue() function.
Suggested-by: James.Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: e164a1695a57 ("IMA: Define workqueue for early boot key measurements")
Fixes: 1df595b4e120 ("IMA: Defined timer to free queued keys")
---
 security/integrity/ima/ima.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c483215a9ee5..6bb3152b3e24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,7 +205,7 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
-#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
 /*
  * To track keys that need to be measured.
  */
@@ -220,7 +220,7 @@ void ima_init_key_queue(void);
 #else
 static inline void ima_process_queued_keys(void) {}
 static inline void ima_init_key_queue(void) {}
-#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+#endif /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-- 
2.17.1
