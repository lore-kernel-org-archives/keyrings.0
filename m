From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:06 +0000
Subject: [PATCH v3 5/9] KEYS: Updated ima_get_action() to return keyrings if specified in the policy
Message-Id: <20191031011910.2574-6-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

Information regarding what keyrings need to be measured is missing.
ima_get_action() needs to retrieve the keyrings, if specified for
KEYRING_CHECK. 

This patch adds a new out parameter to ima_get_action() to return
keyrings read from the policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      | 3 ++-
 security/integrity/ima/ima_api.c  | 6 ++++--
 security/integrity/ima/ima_main.c | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3539a159a7ac..ded78af94e69 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -212,7 +212,8 @@ struct ima_measure_key_entry {
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+		   struct ima_template_desc **template_desc,
+		   char **keyrings);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f488d1cead79..77ac076672e1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,6 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr  * @template_desc: pointer filled in if matched measure policy sets template+ * @keyrings: pointer filled in if matched measure policy sets keyrings  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic@@ -184,14 +185,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+		   struct ima_template_desc **template_desc,
+		   char **keyrings)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, NULL);
+				template_desc, keyrings);
 }
 
 /*
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 72ae0878ec5d..cbc7de87106f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc);
+				&template_desc, NULL);
 	violation_check = ((func = FILE_CHECK || func = MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -627,6 +627,7 @@ void process_buffer_measurement(const void *buf, int size,
 					    .buf = buf,
 					    .buf_len = size};
 	struct ima_template_desc *template = NULL;
+	char *keyrings = NULL;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -641,11 +642,14 @@ void process_buffer_measurement(const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template);
+					&pcr, &template, &keyrings);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
 
+	if (keyrings != NULL)
+		keyrings = NULL;
+
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
-- 
2.17.1
