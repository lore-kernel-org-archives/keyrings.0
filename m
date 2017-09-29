From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 29 Sep 2017 09:21:05 +0000
Subject: [PATCH 2/3] crypto: dh_helper - return unsigned value for crypto_dh_key_len()
Message-Id: <20170929092106.24276-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
In-Reply-To: <20170929092106.24276-1-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Tudor Ambarus <tudor.ambarus@microchip.com>

DH_KPP_SECRET_MIN_SIZE and dh_data_size() are both returning
unsigned values.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/dh_helper.c  | 2 +-
 include/crypto/dh.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 69869da..a413b31 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -33,7 +33,7 @@ static inline unsigned int dh_data_size(const struct dh *p)
 	return p->key_size + p->p_size + p->g_size;
 }
 
-int crypto_dh_key_len(const struct dh *p)
+unsigned int crypto_dh_key_len(const struct dh *p)
 {
 	return DH_KPP_SECRET_MIN_SIZE + dh_data_size(p);
 }
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index f638998..71e1bb2 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -53,7 +53,7 @@ struct dh {
  *
  * Return: size of the key in bytes
  */
-int crypto_dh_key_len(const struct dh *params);
+unsigned int crypto_dh_key_len(const struct dh *params);
 
 /**
  * crypto_dh_encode_key() - encode the private key
-- 
2.9.4

