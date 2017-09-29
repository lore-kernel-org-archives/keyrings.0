From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 29 Sep 2017 09:21:06 +0000
Subject: [PATCH 3/3] KEYS: dh - make some length variables unsigned
Message-Id: <20170929092106.24276-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
In-Reply-To: <20170929092106.24276-1-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Tudor Ambarus <tudor.ambarus@microchip.com>

Both crypto_kpp_maxsize() and crypto_dh_key_len() are returning
unsigned integers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 security/keys/dh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index d1ea9f3..89e9255 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -242,8 +242,8 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 {
 	long ret;
 	ssize_t dlen;
-	int secretlen;
-	int outlen;
+	unsigned int secretlen;
+	unsigned int outlen;
 	struct keyctl_dh_params pcopy;
 	struct dh dh_inputs;
 	struct scatterlist outsg;
-- 
2.9.4

