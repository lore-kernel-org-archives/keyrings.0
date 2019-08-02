From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 02 Aug 2019 15:07:33 +0000
Subject: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190802150733.1972-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, tyhicks@canonical.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, Roberto Sassu <roberto.sassu@huawei.com>

Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
TPM") allows the trusted module to be loaded even a TPM is not found to
avoid module dependency problems.

However, trusted module initialization can still fail if the TPM is
inactive or deactivated. This patch ignores tpm_get_random() errors in
init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
random data.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/keys/trusted.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..34f04ffcf2e5 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* This happens if the TPM didn't return random data */
+	if (!digests)
+		return -EFAULT;
+
 	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
 }
 
@@ -1233,10 +1237,8 @@ static int __init init_digests(void)
 	int i;
 
 	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
+	if (ret < 0 || ret < TPM_MAX_DIGEST_SIZE)
+		return 0;
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
-- 
2.17.1
