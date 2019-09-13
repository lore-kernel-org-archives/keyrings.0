From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 13 Sep 2019 18:51:36 +0000
Subject: [PATCH v4] KEYS: trusted: correctly initialize digests and fix locking issue
Message-Id: <20190913185136.780-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jsnitsel@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com, Roberto Sassu <roberto.sassu@huawei.com>

Commit 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to
tpm_pcr_extend()") modifies tpm_pcr_extend() to accept a digest for each
PCR bank. After modification, tpm_pcr_extend() expects that digests are
passed in the same order as the algorithms set in chip->allocated_banks.

This patch fixes two issues introduced in the last iterations of the patch
set: missing initialization of the TPM algorithm ID in the tpm_digest
structures passed to tpm_pcr_extend() by the trusted key module, and
unreleased locks in the TPM driver due to returning from tpm_pcr_extend()
without calling tpm_put_ops().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
---
 drivers/char/tpm/tpm-interface.c | 14 +++++++++-----
 security/keys/trusted.c          |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..d9ace5480665 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -320,18 +320,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	if (!chip)
 		return -ENODEV;
 
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
-			return -EINVAL;
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
+			rc = EINVAL;
+			goto out;
+		}
+	}
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
-		tpm_put_ops(chip);
-		return rc;
+		goto out;
 	}
 
 	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
 			     "attempting extend a PCR value");
+
+out:
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ade699131065..1fbd77816610 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1228,11 +1228,16 @@ static int __init trusted_shash_alloc(void)
 
 static int __init init_digests(void)
 {
+	int i;
+
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
 	if (!digests)
 		return -ENOMEM;
 
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+
 	return 0;
 }
 
-- 
2.17.1
