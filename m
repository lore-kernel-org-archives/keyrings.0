From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 23 Oct 2019 23:39:50 +0000
Subject: [PATCH v2 4/4] KEYS: Enabled ima policy to measure keys added to builtin_trusted_keys keyring
Message-Id: <20191023233950.22072-5-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
In-Reply-To: <20191023233950.22072-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Cc: nramas@linux.microsoft.com

Updated ima policy handler to check if the ima policy enables
measurement of keys added to the builtin_trusted_keys keyring.

With this patch measurement of keys added to the builtin_trusted_keys
keyring is enabled end-to-end.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
