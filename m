From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 27 Nov 2017 07:20:05 +0000
Subject: [PATCH] pkcs7: use crypto_shash_digest()
Message-Id: <20171127072005.26333-1-ebiggers3@gmail.com>
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
 crypto/asymmetric_keys/pkcs7_verify.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 063d6745c741..1647313872aa 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -59,11 +59,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	/* Digest the message [RFC2315 9.3] */
-	ret = crypto_shash_init(desc);
-	if (ret < 0)
-		goto error;
-	ret = crypto_shash_finup(desc, pkcs7->data, pkcs7->data_len,
-				 sig->digest);
+	ret = crypto_shash_digest(desc, pkcs7->data, pkcs7->data_len,
+				  sig->digest);
 	if (ret < 0)
 		goto error;
 	pr_devel("MsgDigest = [%*ph]\n", 8, sig->digest);
-- 
2.15.0

