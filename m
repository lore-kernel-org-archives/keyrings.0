From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 01 Feb 2019 10:06:37 +0000
Subject: [PATCH v9 2/6] tpm: rename and export tpm2_digest and tpm2_algorithms
Message-Id: <20190201100641.26936-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
In-Reply-To: <20190201100641.26936-1-roberto.sassu@huawei.com>
To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com, Roberto Sassu <roberto.sassu@huawei.com>

Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
that these can be used by other kernel subsystems (e.g. IMA).

Also, set the length of the digest array in tpm_digest to a new constant
named TPM_MAX_DIGEST_SIZE, equal to SHA512_DIGEST_SIZE.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           | 13 +------------
 drivers/char/tpm/tpm1-cmd.c      |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 18 +++++++++---------
 include/linux/tpm.h              | 19 +++++++++++++++++++
 include/linux/tpm_eventlog.h     |  9 ++-------
 6 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 619a2ad3bece..2a85194413e2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -488,7 +488,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest *digest_list;
+	struct tpm_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6b94306ab7c5..e961e5c5d197 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -122,17 +122,6 @@ enum tpm2_return_codes {
 	TPM2_RC_RETRY		= 0x0922,
 };
 
-enum tpm2_algorithms {
-	TPM2_ALG_ERROR		= 0x0000,
-	TPM2_ALG_SHA1		= 0x0004,
-	TPM2_ALG_KEYEDHASH	= 0x0008,
-	TPM2_ALG_SHA256		= 0x000B,
-	TPM2_ALG_SHA384		= 0x000C,
-	TPM2_ALG_SHA512		= 0x000D,
-	TPM2_ALG_NULL		= 0x0010,
-	TPM2_ALG_SM3_256	= 0x0012,
-};
-
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		        = 0x011F,
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
@@ -561,7 +550,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 564d599e89ea..1f8699d428be 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -715,7 +715,7 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks[0] = TPM2_ALG_SHA1;
+	chip->allocated_banks[0] = TPM_ALG_SHA1;
 	chip->nr_allocated_banks = 1;
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 158c34721c8a..db8e05c8dad3 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -33,11 +33,11 @@ struct tpm2_hash {
 };
 
 static struct tpm2_hash tpm2_hash_map[] = {
-	{HASH_ALGO_SHA1, TPM2_ALG_SHA1},
-	{HASH_ALGO_SHA256, TPM2_ALG_SHA256},
-	{HASH_ALGO_SHA384, TPM2_ALG_SHA384},
-	{HASH_ALGO_SHA512, TPM2_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
@@ -192,7 +192,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, TPM2_ALG_SHA1);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
 	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
@@ -226,7 +226,7 @@ struct tpm2_null_auth_area {
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -449,7 +449,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* public */
 	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM2_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
 	tpm_buf_append_u16(&buf, hash);
 
 	/* policy */
@@ -464,7 +464,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM2_ALG_NULL);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
 	tpm_buf_append_u16(&buf, 0);
 
 	/* outside info */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 13563b8c0c3a..9fe8c9816cf0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,12 +22,31 @@
 #ifndef __LINUX_TPM_H__
 #define __LINUX_TPM_H__
 
+#include <crypto/hash_info.h>
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
+#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
 
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+};
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[TPM_MAX_DIGEST_SIZE];
+} __packed;
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index f47342361e87..81519f163211 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,7 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <crypto/hash_info.h>
+#include <linux/tpm.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
@@ -105,16 +105,11 @@ struct tcg_event_field {
 	u8 event[0];
 } __packed;
 
-struct tpm2_digest {
-	u16 alg_id;
-	u8 digest[SHA512_DIGEST_SIZE];
-} __packed;
-
 struct tcg_pcr_event2_head {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[];
+	struct tpm_digest digests[];
 } __packed;
 
 #endif
-- 
2.17.1
