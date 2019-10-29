From: zhengbin <zhengbin13@huawei.com>
Date: Tue, 29 Oct 2019 09:33:32 +0000
Subject: [PATCH] KEYS: trusted: Remove set but not used variable 'keyhndl'
Message-Id: <1572341612-31893-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com, sumit.garg@linaro.org, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: yi.zhang@huawei.com, zhengbin13@huawei.com

Fixes gcc '-Wunused-but-set-variable' warning:

security/keys/trusted-keys/trusted_tpm1.c: In function tpm_unseal:
security/keys/trusted-keys/trusted_tpm1.c:588:11: warning: variable keyhndl set but not used [-Wunused-but-set-variable]

It is introduced by commit 00aa975bd031 ("KEYS: trusted:
Create trusted keys subsystem"), but never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index eb5074e..d2c5ec1 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -585,7 +585,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	uint32_t authhandle2 = 0;
 	unsigned char cont = 0;
 	uint32_t ordinal;
-	uint32_t keyhndl;
 	int ret;

 	/* sessions for unsealing key and data */
@@ -601,7 +600,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}

 	ordinal = htonl(TPM_ORD_UNSEAL);
-	keyhndl = htonl(SRKHANDLE);
 	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
--
2.7.4
