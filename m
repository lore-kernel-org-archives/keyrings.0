From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:47:49 +0000
Subject: [PATCH 04/23] X.509: Fix error code in x509_cert_parse()
Message-Id: <149692966935.11452.18193643051594786260.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/x509_cert_parser.c |    1 +
 1 file changed, 1 insertion(+)

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

