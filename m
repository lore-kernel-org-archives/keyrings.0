From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 23 May 2017 14:27:17 +0000
Subject: [PATCH] X.509: Fix error code in x509_cert_parse()
Message-Id: <20170523142717.GA28346@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index c80765b211cf..1f69e948fb34 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -103,8 +103,10 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 	}
 
 	cert->pub->key = kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
-	if (!cert->pub->key)
+	if (!cert->pub->key) {
+		ret = -ENOMEM;
 		goto error_decode;
+	}
 
 	cert->pub->keylen = ctx->key_size;
 
