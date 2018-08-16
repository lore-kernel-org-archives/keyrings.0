From: David Howells <dhowells@redhat.com>
Date: Thu, 16 Aug 2018 13:05:10 +0000
Subject: [PATCH 1/2] Replace magic for trusting the secondary keyring with #define
Message-Id: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Yannik Sembritzki <yannik@sembritzki.me>

Replace the use of a magic number that indicates that verify_*_signature()
should use the secondary keyring with a symbol.

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---

 certs/system_keyring.c                  |    3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c |    2 +-
 include/linux/verification.h            |    6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 6251d1b27f0c..81728717523d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
@@ -230,7 +231,7 @@ int verify_pkcs7_signature(const void *data, size_t len,
 
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
-	} else if (trusted_keys = (void *)1UL) {
+	} else if (trusted_keys = VERIFY_USE_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 		trusted_keys = secondary_trusted_keys;
 #else
diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index e284d9cb9237..5b2f6a2b5585 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -63,7 +63,7 @@ static int pkcs7_preparse(struct key_preparsed_payload *prep)
 
 	return verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
-				      (void *)1UL, usage,
+				      VERIFY_USE_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
 }
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a10549a6c7cd..cfa4730d607a 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -12,6 +12,12 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+/*
+ * Indicate that both builtin trusted keys and secondary trusted keys
+ * should be used.
+ */
+#define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+
 /*
  * The use to which an asymmetric key is being put.
  */
