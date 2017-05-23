From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 23 May 2017 13:19:02 +0000
Subject: [PATCH v3 08/11] crypto: testmgr - check err on akcipher maxsize
Message-Id: <1495545545-16872-9-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495545545-16872-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

crypto_akcipher_maxsize() returns minimum length for output buffer
or error code if key hasn't been set. Check for error before
allocating memory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/testmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4f8029c..0bf9a00 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -2155,6 +2155,11 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 
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

