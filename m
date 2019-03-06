From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Wed, 06 Mar 2019 18:57:23 +0000
Subject: [PATCH] security: keys: Kconfig: pedantic cleanup
Message-Id: <1551898643-23397-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 security/keys/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 6462e66..6594149 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -90,14 +90,14 @@ config ENCRYPTED_KEYS
 	  If you are unsure as to whether this is required, answer N.
 
 config KEY_DH_OPERATIONS
-       bool "Diffie-Hellman operations on retained keys"
-       depends on KEYS
-       select CRYPTO
-       select CRYPTO_HASH
-       select CRYPTO_DH
-       help
-	 This option provides support for calculating Diffie-Hellman
-	 public keys and shared secrets using values stored as keys
-	 in the kernel.
-
-	 If you are unsure as to whether this is required, answer N.
+	bool "Diffie-Hellman operations on retained keys"
+	depends on KEYS
+	select CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_DH
+	help
+	  This option provides support for calculating Diffie-Hellman
+	  public keys and shared secrets using values stored as keys
+	  in the kernel.
+
+	  If you are unsure as to whether this is required, answer N.
-- 
1.9.1
