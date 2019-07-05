From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 05 Jul 2019 16:37:35 +0000
Subject: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190705163735.11539-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, tyhicks@canonical.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, Roberto Sassu <roberto.sassu@huawei.com>

Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
TPM") allows the trusted module to be loaded even a TPM is not found to
avoid module dependency problems.

Unfortunately, this does not completely solve the issue, as there could be
a case where a TPM is found but is not functional (the TPM commands return
an error). Specifically, after the tpm_chip structure is returned by
tpm_default_chip() in init_trusted(), the execution terminates after
init_digests() returns -EFAULT (due to the fact that tpm_get_random()
returns a positive value, but less than TPM_MAX_DIGEST_SIZE).

This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
TPM_ERR_DISABLED errors.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm.h  | 2 --
 include/linux/tpm.h     | 3 +++
 security/keys/trusted.c | 6 +++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39..a216ac396711 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -54,8 +54,6 @@ enum tpm_addr {
 
 #define TPM_WARN_RETRY          0x800
 #define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
 #define TPM_ERR_INVALID_POSTINIT 38
 
 #define TPM_HEADER_SIZE		10
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..efd3ccbb6aee 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,6 +26,9 @@
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 #define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
 
+#define TPM_ERR_DEACTIVATED     0x6
+#define TPM_ERR_DISABLED        0x7
+
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..430d85090b3b 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* This can happen if the TPM is inactive. */
+	if (!digests)
+		return -EINVAL;
+
 	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
 }
 
@@ -1233,7 +1237,7 @@ static int __init init_digests(void)
 	int i;
 
 	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
+	if (ret < 0 || ret = TPM_ERR_DEACTIVATED || ret = TPM_ERR_DISABLED)
 		return ret;
 	if (ret < TPM_MAX_DIGEST_SIZE)
 		return -EFAULT;
-- 
2.17.1
