From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 17 May 2017 15:00:36 +0000
Subject: [PATCH v2 09/11] crypto: testmgr - check err on kpp maxsize
Message-Id: <1495033238-26016-10-git-send-email-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com, Tudor Ambarus <tudor.ambarus@microchip.com>

crypto_kpp_maxsize() returns minimum length for output buffer
or error code if key hasn't been set.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/testmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 87a4abd..0bf9a00 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -2013,6 +2013,11 @@ static int do_test_kpp(struct crypto_kpp *tfm, const struct kpp_testvec *vec,
 		goto free_req;
 
 	out_len_max = crypto_kpp_maxsize(tfm);
+	if (out_len_max < 0) {
+		err = out_len_max;
+		goto free_req;
+	}
+
 	output_buf = kzalloc(out_len_max, GFP_KERNEL);
 	if (!output_buf) {
 		err = -ENOMEM;
-- 
2.7.4

