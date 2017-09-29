From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 29 Sep 2017 09:21:04 +0000
Subject: [PATCH 1/3] crypto: dh_helper - return unsigned int for dh_data_size()
Message-Id: <20170929092106.24276-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: herbert@gondor.apana.org.au, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Tudor Ambarus <tudor.ambarus@microchip.com>

p->key_size, p->p_size, p->g_size are all of unsigned int type.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/dh_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 8ba8a3f..69869da 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -28,7 +28,7 @@ static inline const u8 *dh_unpack_data(void *dst, const void *src, size_t size)
 	return src + size;
 }
 
-static inline int dh_data_size(const struct dh *p)
+static inline unsigned int dh_data_size(const struct dh *p)
 {
 	return p->key_size + p->p_size + p->g_size;
 }
-- 
2.9.4

