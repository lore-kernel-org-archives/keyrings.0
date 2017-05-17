From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 17 May 2017 15:00:32 +0000
Subject: [PATCH v2 05/11] crypto: ecdh - fix ecdh_max_size
Message-Id: <1495033238-26016-6-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

The function should return minimum size for output buffer
or error code if key hasn't been set.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/ecdh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index c1f0163..830dfb6 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -107,10 +107,10 @@ static int ecdh_compute_value(struct kpp_request *req)
 static int ecdh_max_size(struct crypto_kpp *tfm)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
-	int nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
-	/* Public key is made of two coordinates */
-	return 2 * nbytes;
+	/* Public key is made of two coordinates, add one to the left shift  */
+	return ctx->ndigits ? ctx->ndigits << (ECC_DIGITS_TO_BYTES_SHIFT + 1) :
+			      -EINVAL;
 }
 
 static void no_exit_tfm(struct crypto_kpp *tfm)
-- 
2.7.4

