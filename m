From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Thu, 09 Jul 2020 08:40:15 +0000
Subject: [PATCH v5 8/8] integrity: Asymmetric digsig supports SM2-with-SM3 algorithm
Message-Id: <20200709084015.21886-9-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com, nramas@linux.microsoft.com, tusharsu@linux.microsoft.com, zohar@linux.ibm.com, vt@altlinux.org, gilad@benyossef.com, pvanleeuwen@rambus.com, zhang.jia@linux.alibaba.com
Cc: tianjia.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org

Asymmetric digsig supports SM2-with-SM3 algorithm combination,
so that IMA can also verify SM2's signature data.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/digsig_asymmetric.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 4e0d6778277e..9350fcfb9bf2 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -99,14 +99,22 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-	if (hdr->hash_algo = HASH_ALGO_STREEBOG_256 ||
-	    hdr->hash_algo = HASH_ALGO_STREEBOG_512) {
+	switch (hdr->hash_algo) {
+	case HASH_ALGO_STREEBOG_256:
+	case HASH_ALGO_STREEBOG_512:
 		/* EC-RDSA and Streebog should go together. */
 		pks.pkey_algo = "ecrdsa";
 		pks.encoding = "raw";
-	} else {
+		break;
+	case HASH_ALGO_SM3_256:
+		/* SM2 and SM3 should go together. */
+		pks.pkey_algo = "sm2";
+		pks.encoding = "raw";
+		break;
+	default:
 		pks.pkey_algo = "rsa";
 		pks.encoding = "pkcs1";
+		break;
 	}
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
-- 
2.17.1
