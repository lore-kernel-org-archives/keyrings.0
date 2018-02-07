From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 07 Feb 2018 01:10:07 +0000
Subject: [PATCH 4/9] X.509: fix BUG_ON() when hash algorithm is unsupported
Message-Id: <20180207011012.5928-5-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-1-ebiggers3@gmail.com>
In-Reply-To: <20180207011012.5928-1-ebiggers3@gmail.com>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>, Paolo Valente <paolo.valente@linaro.org>, stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The X.509 parser mishandles the case where the certificate's signature's
hash algorithm is not available in the crypto API.  In this case,
x509_get_sig_params() doesn't allocate the cert->sig->digest buffer;
this part seems to be intentional.  However,
public_key_verify_signature() is still called via
x509_check_for_self_signed(), which triggers the 'BUG_ON(!sig->digest)'.

Fix this by making public_key_verify_signature() return -ENOPKG if the
hash buffer has not been allocated.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled:

    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Reported-by: Paolo Valente <paolo.valente@linaro.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/public_key.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index de996586762a..e929fe1e4106 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -79,9 +79,11 @@ int public_key_verify_signature(const struct public_key *pkey,
 
 	BUG_ON(!pkey);
 	BUG_ON(!sig);
-	BUG_ON(!sig->digest);
 	BUG_ON(!sig->s);
 
+	if (!sig->digest)
+		return -ENOPKG;
+
 	alg_name = sig->pkey_algo;
 	if (strcmp(sig->pkey_algo, "rsa") = 0) {
 		/* The data wangled by the RSA algorithm is typically padded
-- 
2.16.0.rc1.238.g530d649a79-goog

