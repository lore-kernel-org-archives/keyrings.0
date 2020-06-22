From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 22 Jun 2020 11:21:36 +0000
Subject: [PATCH] KEYS: asymmetric: fix error return code in software_key_query()
Message-Id: <20200622112136.72745-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Vitaly Chikunov <vt@altlinux.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org

Fix to return negative error code -ENOMEM from kmalloc() error handling
case instead of 0, as done elsewhere in this function.

Fixes: f1774cb8956a ("X.509: parse public key parameters from x509 for akcipher")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 crypto/asymmetric_keys/public_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d7f43d4ea925..c15bde024b4c 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -119,6 +119,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
+	ret = -ENOMEM;
 	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
 		      GFP_KERNEL);
 	if (!key)
