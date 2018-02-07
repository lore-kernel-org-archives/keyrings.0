From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 07 Feb 2018 01:10:11 +0000
Subject: [PATCH 8/9] X.509: remove dead code that set ->unsupported_sig
Message-Id: <20180207011012.5928-9-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-1-ebiggers3@gmail.com>
In-Reply-To: <20180207011012.5928-1-ebiggers3@gmail.com>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

The X.509 parser is guaranteed to set cert->sig->pkey_algo and
cert->sig->hash_algo, since x509_note_pkey_algo() is a mandatory action
in the X.509 ASN.1 grammar, and it returns an error code if an
unrecognized AlgorithmIdentifier is given rather than leaving the
algorithms as NULL.

Therefore, remove the dead code which handled these algorithm strings
being NULL.

Note that cert->unsupported_sig can still be set if the hash algorithm
cannot be allocated from the crypto API.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 514007932ec9..1a7c63003bc6 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -34,15 +34,6 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	pr_devel("=>%s()\n", __func__);
 
-	if (!sig->pkey_algo)
-		cert->unsupported_sig = true;
-
-	/* We check the hash if we can - even if we can't then verify it */
-	if (!sig->hash_algo) {
-		cert->unsupported_sig = true;
-		return 0;
-	}
-
 	sig->s = kmemdup(cert->raw_sig, cert->raw_sig_size, GFP_KERNEL);
 	if (!sig->s)
 		return -ENOMEM;
-- 
2.16.0.rc1.238.g530d649a79-goog

