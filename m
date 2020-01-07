From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Jan 2020 20:30:30 +0000
Subject: [PATCH] ima: make ASYMMETRIC_PUBLIC_KEY_SUBTYPE 'bool'
Message-Id: <20200107203041.843060-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

The asymmetric key subtype is only used by the key subsystem that cannot
itself be a loadable module, so when ASYMMETRIC_PUBLIC_KEY_SUBTYPE is set
to =m, it just does not get used. It also produces a compile-time warning:

WARNING: modpost: missing MODULE_LICENSE() in security/integrity/ima/ima_asymmetric_keys.o

Make this a 'bool' symbol to avoid both problems.

Fixes: 88e70da170e8 ("IMA: Define an IMA hook to measure keys")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/asymmetric_keys/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1f1f004dc757..f2846293e4d5 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -11,7 +11,7 @@ menuconfig ASYMMETRIC_KEY_TYPE
 if ASYMMETRIC_KEY_TYPE
 
 config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	tristate "Asymmetric public-key crypto algorithm subtype"
+	bool "Asymmetric public-key crypto algorithm subtype"
 	select MPILIB
 	select CRYPTO_HASH_INFO
 	select CRYPTO_AKCIPHER
-- 
2.20.0
