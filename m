From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:08:24 +0000
Subject: [PATCH v5 06/10] crypto: Kconfig - create Public-key cryptography section
Message-Id: <20190224060828.2527-7-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Group RSA, DH, and ECDH into Public-key cryptography config section.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/Kconfig | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index bbab6bf33519..370cbdca87a7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -113,29 +113,6 @@ config CRYPTO_ACOMP
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 
-config CRYPTO_RSA
-	tristate "RSA algorithm"
-	select CRYPTO_AKCIPHER
-	select CRYPTO_MANAGER
-	select MPILIB
-	select ASN1
-	help
-	  Generic implementation of the RSA public key algorithm.
-
-config CRYPTO_DH
-	tristate "Diffie-Hellman algorithm"
-	select CRYPTO_KPP
-	select MPILIB
-	help
-	  Generic implementation of the Diffie-Hellman algorithm.
-
-config CRYPTO_ECDH
-	tristate "ECDH algorithm"
-	select CRYPTO_KPP
-	select CRYPTO_RNG_DEFAULT
-	help
-	  Generic implementation of the ECDH algorithm
-
 config CRYPTO_MANAGER
 	tristate "Cryptographic algorithm manager"
 	select CRYPTO_MANAGER2
@@ -253,6 +230,31 @@ config CRYPTO_GLUE_HELPER_X86
 config CRYPTO_ENGINE
 	tristate
 
+comment "Public-key cryptography"
+
+config CRYPTO_RSA
+	tristate "RSA algorithm"
+	select CRYPTO_AKCIPHER
+	select CRYPTO_MANAGER
+	select MPILIB
+	select ASN1
+	help
+	  Generic implementation of the RSA public key algorithm.
+
+config CRYPTO_DH
+	tristate "Diffie-Hellman algorithm"
+	select CRYPTO_KPP
+	select MPILIB
+	help
+	  Generic implementation of the Diffie-Hellman algorithm.
+
+config CRYPTO_ECDH
+	tristate "ECDH algorithm"
+	select CRYPTO_KPP
+	select CRYPTO_RNG_DEFAULT
+	help
+	  Generic implementation of the ECDH algorithm
+
 comment "Authenticated Encryption with Associated Data"
 
 config CRYPTO_CCM
-- 
2.11.0
