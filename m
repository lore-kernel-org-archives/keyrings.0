From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 29 May 2017 13:26:22 +0000
Subject: [PATCH v2] X.509: Fix error code in x509_cert_parse()
Message-Id: <20170529132622.6tapug7i7aqmvnqz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <4045.1495558143@warthog.procyon.org.uk>
In-Reply-To: <4045.1495558143@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2:  Style change

Sorry for the delay, I'm been out of office.

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index c80765b211cf..dd03fead1ca3 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -102,6 +102,7 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 		}
 	}
 
+	ret = -ENOMEM;
 	cert->pub->key = kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
 	if (!cert->pub->key)
 		goto error_decode;
