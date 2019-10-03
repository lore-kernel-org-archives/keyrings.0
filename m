From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 03 Oct 2019 12:50:09 +0000
Subject: [PATCH v2] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191003125009.30195-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Only the kernel random pool should be used for generating random numbers.
TPM contributes to that pool among the other sources of entropy. In here it
is not, agreed, absolutely critical because TPM is what is trusted anyway
but in order to remove tpm_get_random() we need to first remove all the
call sites.

Cc: stable@vger.kernel.org
Fixes: 0c36264aa1d5 ("KEYS: asym_tpm: Add loadkey2 and flushspecific [ver #2]")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2:
* Changed two remaining call sites to use get_random_bytes()
* Removed "stating the obvious" comments.
 crypto/asymmetric_keys/asym_tpm.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 76d2ce3a1b5b..4eaf57483b9a 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/random.h>
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 #include <crypto/akcipher.h>
@@ -53,12 +54,7 @@ static int tpm_loadkey2(struct tpm_buf *tb,
 		return ret;
 	}
 
-	/* generate odd nonce */
-	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
-	if (ret < 0) {
-		pr_info("tpm_get_random failed (%d)\n", ret);
-		return ret;
-	}
+	get_random_bytes(nonceodd, TPM_NONCE_SIZE);
 
 	/* calculate authorization HMAC value */
 	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
@@ -139,12 +135,7 @@ static int tpm_unbind(struct tpm_buf *tb,
 		return ret;
 	}
 
-	/* generate odd nonce */
-	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
-	if (ret < 0) {
-		pr_info("tpm_get_random failed (%d)\n", ret);
-		return ret;
-	}
+	get_random_bytes(nonceodd, TPM_NONCE_SIZE);
 
 	/* calculate authorization HMAC value */
 	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
@@ -225,12 +216,7 @@ static int tpm_sign(struct tpm_buf *tb,
 		return ret;
 	}
 
-	/* generate odd nonce */
-	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
-	if (ret < 0) {
-		pr_info("tpm_get_random failed (%d)\n", ret);
-		return ret;
-	}
+	get_random_bytes(nonceodd, TPM_NONCE_SIZE);
 
 	/* calculate authorization HMAC value */
 	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
-- 
2.20.1
