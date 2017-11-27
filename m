From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 27 Nov 2017 07:19:54 +0000
Subject: [PATCH] X.509: use crypto_shash_digest()
Message-Id: <20171127071954.26273-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

Use crypto_shash_digest() instead of crypto_shash_init() followed by
crypto_shash_finup().  (For simplicity only; they are equivalent.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 9db20abe78a0..3b39c0659155 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -79,11 +79,7 @@ int x509_get_sig_params(struct x509_certificate *cert)
 	desc->tfm = tfm;
 	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
 
-	ret = crypto_shash_init(desc);
-	if (ret < 0)
-		goto error_2;
-	might_sleep();
-	ret = crypto_shash_finup(desc, cert->tbs, cert->tbs_size, sig->digest);
+	ret = crypto_shash_digest(desc, cert->tbs, cert->tbs_size, sig->digest);
 	if (ret < 0)
 		goto error_2;
 
-- 
2.15.0

