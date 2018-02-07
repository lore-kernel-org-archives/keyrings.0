From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 07 Feb 2018 01:10:09 +0000
Subject: [PATCH 6/9] PKCS#7: remove unnecessary check for NULL sinfo->sig->hash_algo
Message-Id: <20180207011012.5928-7-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-1-ebiggers3@gmail.com>
In-Reply-To: <20180207011012.5928-1-ebiggers3@gmail.com>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

The PKCS#7 parser is guaranteed to set ->sig->hash_algo for every
SignerInfo, since pkcs7_sig_note_digest_algo() is a mandatory action in
the PKCS#7 ASN.1 grammar, and it returns an error code if an
unrecognized DigestAlgorithmIdentifier is given rather than leaving the
algorithm as NULL.  Therefore, remove the unnecessary NULL check.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 97c77f66b20d..a9e03f5c52e7 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -33,9 +33,6 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 
 	kenter(",%u,%s", sinfo->index, sinfo->sig->hash_algo);
 
-	if (!sinfo->sig->hash_algo)
-		return -ENOPKG;
-
 	/* Allocate the hashing algorithm we're going to need and find out how
 	 * big the hash operational data will be.
 	 */
-- 
2.16.0.rc1.238.g530d649a79-goog

