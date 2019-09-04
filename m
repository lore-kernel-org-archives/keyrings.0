From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 04 Sep 2019 18:50:57 +0000
Subject: [PATCH v2] KEYS: trusted: correctly initialize digests and fix locking issue
Message-Id: <20190904185057.8400-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com, Roberto Sassu <roberto.sassu@huawei.com>

This patch fixes two issues introduced with commit 0b6cf6b97b7e ("tpm: pass
an array of tpm_extend_digest structures to tpm_pcr_extend()").

It initializes the algorithm in init_digests() for trusted keys, and moves
the algorithm check in tpm_pcr_extend() before locks are taken in
tpm_find_get_ops().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
---
 drivers/char/tpm/tpm-interface.c | 8 ++++----
 security/keys/trusted.c          | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..1fffa91fc148 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -316,14 +316,14 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	chip = tpm_find_get_ops(chip);
-	if (!chip)
-		return -ENODEV;
-
 	for (i = 0; i < chip->nr_allocated_banks; i++)
 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
 			return -EINVAL;
 
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
 		tpm_put_ops(chip);
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
