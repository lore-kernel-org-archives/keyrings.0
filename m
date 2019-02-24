From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:08:20 +0000
Subject: [PATCH v5 02/10] crypto: akcipher - check the presence of callback before the call
Message-Id: <20190224060828.2527-3-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Because with introduction of EC-RDSA and change in workings of RSA in
regard to sign/verify, akcipher could have not all callbacks defined,
check the presence of callbacks before calling them to increase
robustness.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 include/crypto/akcipher.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 2d690494568c..f537fad1989f 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -268,7 +268,10 @@ static inline unsigned int crypto_akcipher_maxsize(struct crypto_akcipher *tfm)
 {
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
 
-	return alg->max_size(tfm);
+	if (alg->max_size)
+		return alg->max_size(tfm);
+	else
+		return 0;
 }
 
 /**
@@ -287,10 +290,11 @@ static inline int crypto_akcipher_encrypt(struct akcipher_request *req)
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
 	struct crypto_alg *calg = tfm->base.__crt_alg;
 	unsigned int src_len = req->src_len;
-	int ret;
+	int ret = -ENOSYS;
 
 	crypto_stats_get(calg);
-	ret = alg->encrypt(req);
+	if (alg->encrypt)
+		ret = alg->encrypt(req);
 	crypto_stats_akcipher_encrypt(src_len, ret, calg);
 	return ret;
 }
@@ -311,10 +315,11 @@ static inline int crypto_akcipher_decrypt(struct akcipher_request *req)
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
 	struct crypto_alg *calg = tfm->base.__crt_alg;
 	unsigned int src_len = req->src_len;
-	int ret;
+	int ret = -ENOSYS;
 
 	crypto_stats_get(calg);
-	ret = alg->decrypt(req);
+	if (alg->decrypt)
+		ret = alg->decrypt(req);
 	crypto_stats_akcipher_decrypt(src_len, ret, calg);
 	return ret;
 }
@@ -334,10 +339,11 @@ static inline int crypto_akcipher_sign(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
 	struct crypto_alg *calg = tfm->base.__crt_alg;
-	int ret;
+	int ret = -ENOSYS;
 
 	crypto_stats_get(calg);
-	ret = alg->sign(req);
+	if (alg->sign)
+		ret = alg->sign(req);
 	crypto_stats_akcipher_sign(ret, calg);
 	return ret;
 }
@@ -357,10 +363,11 @@ static inline int crypto_akcipher_verify(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
 	struct crypto_alg *calg = tfm->base.__crt_alg;
-	int ret;
+	int ret = -ENOSYS;
 
 	crypto_stats_get(calg);
-	ret = alg->verify(req);
+	if (alg->verify)
+		ret = alg->verify(req);
 	crypto_stats_akcipher_verify(ret, calg);
 	return ret;
 }
-- 
2.11.0
