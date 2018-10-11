From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 11 Oct 2018 06:56:10 +0000
Subject: [PATCH -next] KEYS: trusted: remove set but not used variable ''
Message-Id: <1539241599-140866-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: James Bottomley <jejb@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

security/keys/trusted.c: In function 'tpm_unseal':
security/keys/trusted.c:592:11: warning:
 variable 'keyhndl' set but not used [-Wunused-but-set-variable]
  uint32_t keyhndl;

It never used since introduction in 
commit d00a1c72f7f4 ("keys: add new trusted key-type")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/keys/trusted.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ff67893..169df79 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -589,7 +589,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	uint32_t authhandle2 = 0;
 	unsigned char cont = 0;
 	uint32_t ordinal;
-	uint32_t keyhndl;
 	int ret;
 
 	/* sessions for unsealing key and data */
@@ -605,7 +604,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	keyhndl = htonl(SRKHANDLE);
 	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
