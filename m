From: Vitaly Chikunov <vt@altlinux.org>
Date: Thu, 11 Apr 2019 15:51:13 +0000
Subject: [PATCH v9 01/10] crypto: akcipher - default implementations for request callbacks
Message-Id: <20190411155122.13245-2-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190411155122.13245-1-vt@altlinux.org>
In-Reply-To: <20190411155122.13245-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Because with the introduction of EC-RDSA and change in workings of RSA
in regard to sign/verify, akcipher could have not all callbacks defined,
check the presence of callbacks in crypto_register_akcipher() and
provide default implementation if the callback is not implemented.

This is suggested by Herbert Xu instead of checking the presence of the
callback on every request.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/akcipher.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index 0cbeae137e0a..780daa436dac 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -119,10 +119,24 @@ static void akcipher_prepare_alg(struct akcipher_alg *alg)
 	base->cra_flags |= CRYPTO_ALG_TYPE_AKCIPHER;
 }
 
+static int akcipher_default_op(struct akcipher_request *req)
+{
+	return -ENOSYS;
+}
+
 int crypto_register_akcipher(struct akcipher_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
 
+	if (!alg->sign)
+		alg->sign = akcipher_default_op;
+	if (!alg->verify)
+		alg->verify = akcipher_default_op;
+	if (!alg->encrypt)
+		alg->encrypt = akcipher_default_op;
+	if (!alg->decrypt)
+		alg->decrypt = akcipher_default_op;
+
 	akcipher_prepare_alg(alg);
 	return crypto_register_alg(base);
 }
-- 
2.11.0
