From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Wed, 08 Jul 2020 08:28:11 +0000
Subject: [PATCH v4 1/8] crypto: sm3 - export crypto_sm3_final function
Message-Id: <20200708082818.5511-2-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200708082818.5511-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200708082818.5511-1-tianjia.zhang@linux.alibaba.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com, nramas@linux.microsoft.com, tusharsu@linux.microsoft.com, zohar@linux.ibm.com, gilad@benyossef.com, pvanleeuwen@rambus.com
Cc: tianjia.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, zhang.jia@linux.alibaba.com, linux-integrity@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org

Both crypto_sm3_update and crypto_sm3_finup have been
exported, exporting crypto_sm3_final, to avoid having to
use crypto_sm3_finup(desc, NULL, 0, dgst) to calculate
the hash in some cases.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sm3_generic.c | 7 ++++---
 include/crypto/sm3.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
index 3468975215ca..193c4584bd00 100644
--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -149,17 +149,18 @@ int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sm3_update);
 
-static int sm3_final(struct shash_desc *desc, u8 *out)
+int crypto_sm3_final(struct shash_desc *desc, u8 *out)
 {
 	sm3_base_do_finalize(desc, sm3_generic_block_fn);
 	return sm3_base_finish(desc, out);
 }
+EXPORT_SYMBOL(crypto_sm3_final);
 
 int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *hash)
 {
 	sm3_base_do_update(desc, data, len, sm3_generic_block_fn);
-	return sm3_final(desc, hash);
+	return crypto_sm3_final(desc, hash);
 }
 EXPORT_SYMBOL(crypto_sm3_finup);
 
@@ -167,7 +168,7 @@ static struct shash_alg sm3_alg = {
 	.digestsize	=	SM3_DIGEST_SIZE,
 	.init		=	sm3_base_init,
 	.update		=	crypto_sm3_update,
-	.final		=	sm3_final,
+	.final		=	crypto_sm3_final,
 	.finup		=	crypto_sm3_finup,
 	.descsize	=	sizeof(struct sm3_state),
 	.base		=	{
diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
index 1438942dc773..42ea21289ba9 100644
--- a/include/crypto/sm3.h
+++ b/include/crypto/sm3.h
@@ -35,6 +35,8 @@ struct shash_desc;
 extern int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 			      unsigned int len);
 
+extern int crypto_sm3_final(struct shash_desc *desc, u8 *out);
+
 extern int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, u8 *hash);
 #endif
-- 
2.17.1
