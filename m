From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Mon, 05 Oct 2020 14:46:28 +0000
Subject: [PATCH] X.509: fix error return value on the failed path
Message-Id: <20201005144628.83875-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gilad Ben-Yossef <gilad@benyossef.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

When memory allocation fails, an appropriate return value
should be set.

Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/public_key_sm2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key_sm2.c b/crypto/asymmetric_keys/public_key_sm2.c
index 7325cf21dbb4..66b614e1eccd 100644
--- a/crypto/asymmetric_keys/public_key_sm2.c
+++ b/crypto/asymmetric_keys/public_key_sm2.c
@@ -36,8 +36,10 @@ int cert_sig_digest_update(const struct public_key_signature *sig,
 
 	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
 	desc = kzalloc(desc_size, GFP_KERNEL);
-	if (!desc)
+	if (!desc) {
+		ret = -ENOMEM;
 		goto error_free_tfm;
+	}
 
 	desc->tfm = tfm;
 
-- 
2.24.3 (Apple Git-128)
