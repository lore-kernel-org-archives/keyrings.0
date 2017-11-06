From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 06 Nov 2017 02:30:47 +0000
Subject: [PATCH v2 4/5] crypto: qat - Clean up error handling in qat_dh_set_secret()
Message-Id: <20171106023048.8067-5-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171106023048.8067-1-ebiggers3@gmail.com>
In-Reply-To: <20171106023048.8067-1-ebiggers3@gmail.com>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Stephan Mueller <smueller@chronox.de>, qat-linux@intel.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

Update the error handling in qat_dh_set_secret() to mirror
dh_set_secret().  The new version is less error-prone because freeing
memory and setting the pointers to NULL is now only done in one place.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 6f5dd68449c6..7655fdb499de 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -462,11 +462,8 @@ static int qat_dh_set_params(struct qat_dh_ctx *ctx, struct dh *params)
 	}
 
 	ctx->g = dma_zalloc_coherent(dev, ctx->p_size, &ctx->dma_g, GFP_KERNEL);
-	if (!ctx->g) {
-		dma_free_coherent(dev, ctx->p_size, ctx->p, ctx->dma_p);
-		ctx->p = NULL;
+	if (!ctx->g)
 		return -ENOMEM;
-	}
 	memcpy(ctx->g + (ctx->p_size - params->g_size), params->g,
 	       params->g_size);
 
@@ -507,18 +504,22 @@ static int qat_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 
 	ret = qat_dh_set_params(ctx, &params);
 	if (ret < 0)
-		return ret;
+		goto err_clear_ctx;
 
 	ctx->xa = dma_zalloc_coherent(dev, ctx->p_size, &ctx->dma_xa,
 				      GFP_KERNEL);
 	if (!ctx->xa) {
-		qat_dh_clear_ctx(dev, ctx);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_clear_ctx;
 	}
 	memcpy(ctx->xa + (ctx->p_size - params.key_size), params.key,
 	       params.key_size);
 
 	return 0;
+
+err_clear_ctx:
+	qat_dh_clear_ctx(dev, ctx);
+	return ret;
 }
 
 static unsigned int qat_dh_max_size(struct crypto_kpp *tfm)
-- 
2.15.0

