From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 17 May 2017 15:00:35 +0000
Subject: [PATCH v2 08/11] crypto: testmgr - check err on akcipher maxsize
Message-Id: <1495033238-26016-9-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

crypto_akcipher_maxsize() returns minimum length for output buffer
or error code if key hasn't been set.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/testmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6f5f3ed..87a4abd 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -2150,6 +2150,11 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 
 	err = -ENOMEM;
 	out_len_max = crypto_akcipher_maxsize(tfm);
+	if (out_len_max < 0) {
+		err = out_len_max;
+		goto free_req;
+	}
+
 	outbuf_enc = kzalloc(out_len_max, GFP_KERNEL);
 	if (!outbuf_enc)
 		goto free_req;
-- 
2.7.4

