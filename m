From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 23 May 2017 13:19:05 +0000
Subject: [PATCH v3 11/11] crypto: dh - fix memleak in setkey
Message-Id: <1495545545-16872-12-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

setkey can be called multiple times during the existence
of the transformation object. In case of multiple setkey calls,
the old key was not freed and we leaked memory.
Free the old MPI key if any.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/dh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/dh.c b/crypto/dh.c
index 3d35ba9..8eb433d 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -85,6 +85,9 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	struct dh_ctx *ctx = dh_get_ctx(tfm);
 	struct dh params;
 
+	/* Free the old MPI key if any */
+	dh_free_ctx(ctx);
+
 	if (crypto_dh_decode_key(buf, len, &params) < 0)
 		return -EINVAL;
 
-- 
2.7.4

