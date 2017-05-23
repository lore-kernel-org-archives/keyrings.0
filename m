From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 23 May 2017 13:19:03 +0000
Subject: [PATCH v3 09/11] crypto: KEYS: check err on akcipher maxsize
Message-Id: <1495545545-16872-10-git-send-email-tudor.ambarus@microchip.com>
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
 crypto/asymmetric_keys/public_key.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d3a989e..2b2f8bf 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -123,6 +123,11 @@ int public_key_verify_signature(const struct public_key *pkey,
 
 	ret = -ENOMEM;
 	outlen = crypto_akcipher_maxsize(tfm);
+	if (outlen < 0) {
+		ret = outlen;
+		goto error_free_req;
+	}
+
 	output = kmalloc(outlen, GFP_KERNEL);
 	if (!output)
 		goto error_free_req;
-- 
2.7.4

