From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 23 May 2017 13:19:04 +0000
Subject: [PATCH v3 10/11] crypto: ecc - don't be selfish on pubkeys
Message-Id: <1495545545-16872-11-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

Rename ecdh_make_pub_key() to ecc_make_pub_key().
This function might as well be used by ecdsa.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/ecc.c  | 4 ++--
 crypto/ecc.h  | 4 ++--
 crypto/ecdh.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index e3a2b8f..6c33c43 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -927,8 +927,8 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
 	return 0;
 }
 
-int ecdh_make_pub_key(unsigned int curve_id, unsigned int ndigits,
-		      const u64 *private_key, u64 *public_key)
+int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
+		     const u64 *private_key, u64 *public_key)
 {
 	int ret = 0;
 	struct ecc_point *pk;
diff --git a/crypto/ecc.h b/crypto/ecc.h
index af2ffdb..673c834 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -54,8 +54,8 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
  * Returns 0 if the public key was generated successfully, a negative value
  * if an error occurred.
  */
-int ecdh_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
-		      const u64 *private_key, u64 *public_key);
+int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
+		     const u64 *private_key, u64 *public_key);
 
 /**
  * crypto_ecdh_shared_secret() - Compute a shared secret
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index b2b12cd..fb9bc2e 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -87,8 +87,8 @@ static int ecdh_compute_value(struct kpp_request *req)
 
 		buf = ctx->shared_secret;
 	} else {
-		ret = ecdh_make_pub_key(ctx->curve_id, ctx->ndigits,
-					ctx->private_key, ctx->public_key);
+		ret = ecc_make_pub_key(ctx->curve_id, ctx->ndigits,
+				       ctx->private_key, ctx->public_key);
 		buf = ctx->public_key;
 		/* Public part is a point thus it has both coordinates */
 		nbytes *= 2;
-- 
2.7.4

