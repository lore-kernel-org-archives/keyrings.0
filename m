From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue, 25 Aug 2020 21:50:40 +0000
Subject: [PATCH] keys: Print more useful debug info if encryption algo is not available
Message-Id: <20200825215040.307947-1-anatol.pomozov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, keyrings@vger.kernel.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 security/keys/encrypted-keys/encrypted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 192e531c146f..c09d48f53682 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -84,8 +84,8 @@ static int aes_get_sizes(void)
 
 	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm)) {
-		pr_err("encrypted_key: failed to alloc_cipher (%ld)\n",
-		       PTR_ERR(tfm));
+		pr_err("encrypted_key: failed to alloc_cipher for %s (%ld)\n",
+		       blkcipher_alg, PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
 	ivsize = crypto_skcipher_ivsize(tfm);
-- 
2.28.0
