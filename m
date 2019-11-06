From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 06 Nov 2019 19:01:08 +0000
Subject: [PATCH v4 02/10] IMA: Added KEYRING_CHECK func in IMA policy to measure keys
Message-Id: <20191106190116.2578-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

IMA policy needs to support a func to enable measurement of
asymmetric keys.

This patch defines a new IMA policy func namely KEYRING_CHECK to
measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 6 ++++++
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_policy.c  | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29aaedf33246..341df49b5ad1 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,6 +30,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[KEYRING_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -113,3 +114,8 @@ Description:
 		Example of appraise rule allowing modsig appended signatures:
 
 			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
+
+		Example of measure rule using KEYRING_CHECK to measure
+		all keys:
+
+			measure func=KEYRING_CHECK
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df4ca482fb53..7f23405b2718 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -193,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(KEYRING_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f19a895ad7cd..4344b7354fc5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -373,7 +373,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func = KEXEC_CMDLINE) {
+	if ((func = KEXEC_CMDLINE) || (func = KEYRING_CHECK)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func = func))
 			return true;
 		return false;
-- 
2.17.1
