From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 28 Nov 2017 18:59:38 +0000
Subject: [PATCH v2] X.509: fix comparisons of ->pkey_algo
Message-Id: <20171128185938.57246-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

->pkey_algo used to be an enum, but was changed to a string by commit
4e8ae72a75aa ("X.509: Make algo identifiers text instead of enum").  But
two comparisons were not updated.  Fix them to use strcmp().

This bug broke signature verification in certain configurations,
depending on whether the string constants were deduplicated or not.

Fixes: 4e8ae72a75aa ("X.509: Make algo identifiers text instead of enum")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: use != 0 in comparisons

 crypto/asymmetric_keys/pkcs7_verify.c    | 2 +-
 crypto/asymmetric_keys/x509_public_key.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 2d93d9eccb4d..986033e64a83 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -150,7 +150,7 @@ static int pkcs7_find_key(struct pkcs7_message *pkcs7,
 		pr_devel("Sig %u: Found cert serial match X.509[%u]\n",
 			 sinfo->index, certix);
 
-		if (x509->pub->pkey_algo != sinfo->sig->pkey_algo) {
+		if (strcmp(x509->pub->pkey_algo, sinfo->sig->pkey_algo) != 0) {
 			pr_warn("Sig %u: X.509 algo and PKCS#7 sig algo don't match\n",
 				sinfo->index);
 			continue;
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index c9013582c026..3d6f124a8b34 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -135,7 +135,7 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 	}
 
 	ret = -EKEYREJECTED;
-	if (cert->pub->pkey_algo != cert->sig->pkey_algo)
+	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
 		goto out;
 
 	ret = public_key_verify_signature(cert->pub, cert->sig);
-- 
2.15.0.417.g466bffb3ac-goog

