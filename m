From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 17 May 2017 15:00:31 +0000
Subject: [PATCH v2 04/11] crypto: dh - fix dh_max_size
Message-Id: <1495033238-26016-5-git-send-email-tudor.ambarus@microchip.com>
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
 crypto/dh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 7cec0498..325a5dd 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -148,7 +148,7 @@ static int dh_max_size(struct crypto_kpp *tfm)
 {
 	struct dh_ctx *ctx = dh_get_ctx(tfm);
 
-	return mpi_get_size(ctx->p);
+	return ctx->p ? mpi_get_size(ctx->p) : -EINVAL;
 }
 
 static void dh_exit_tfm(struct crypto_kpp *tfm)
-- 
2.7.4

