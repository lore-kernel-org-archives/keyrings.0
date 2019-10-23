From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 23 Oct 2019 00:18:15 +0000
Subject: [PATCH v1 3/6] KEYS: ima hook to measure builtin_trusted_keys
Message-Id: <20191023001818.3684-4-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Cc: nramas@linux.microsoft.com

Add a new ima hook to measure keys added to builtin_trusted_keys
keyring.

Updated ima_match_rules function to handle the new ima hook.
This is used to determine if ima policy requires measurement
of keys added to builtin_trusted_keys keyring.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_api.c     | 1 +
 security/integrity/ima/ima_policy.c  | 5 ++++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index fc376a323908..25566c74e679 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[BUILTIN_TRUSTED_KEYS]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b6847ee1f47a..0d2908036882 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -189,6 +189,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(BUILTIN_TRUSTED_KEYS)	\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f614e22bf39f..cc04706b7e7a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -175,6 +175,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
  *	| KEXEC_CMDLINE
+ *	| BUILTIN_TRUSTED_KEYS
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..944636076152 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func = KEXEC_CMDLINE) {
+	if ((func = KEXEC_CMDLINE) || (func = BUILTIN_TRUSTED_KEYS)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func = func))
 			return true;
 		return false;
@@ -959,6 +959,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") = 0)
 				entry->func = KEXEC_CMDLINE;
+			else if (strcmp(args[0].from,
+					"BUILTIN_TRUSTED_KEYS") = 0)
+				entry->func = BUILTIN_TRUSTED_KEYS;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1
