From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 07 Sep 2018 21:10:12 +0000
Subject: [PATCH 4.9 41/63] Replace magic for trusting the secondary keyring with #define
Message-Id: <20180907211015.234722958@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180907211012.965501324@linuxfoundation.org>
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
To: linux-security-module@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yannik Sembritzki <yannik@sembritzki.me>

commit 817aef260037f33ee0f44c17fe341323d3aebd6d upstream.

Replace the use of a magic number that indicates that verify_*_signature()
should use the secondary keyring with a symbol.

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 certs/system_keyring.c                  |    3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c |    2 +-
 include/linux/verification.h            |    6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
@@ -207,7 +208,7 @@ int verify_pkcs7_signature(const void *d
 
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
-	} else if (trusted_keys = (void *)1UL) {
+	} else if (trusted_keys = VERIFY_USE_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 		trusted_keys = secondary_trusted_keys;
 #else
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -62,7 +62,7 @@ static int pkcs7_preparse(struct key_pre
 
 	return verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
-				      (void *)1UL, usage,
+				      VERIFY_USE_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
 }
 
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -13,6 +13,12 @@
 #define _LINUX_VERIFICATION_H
 
 /*
+ * Indicate that both builtin trusted keys and secondary trusted keys
+ * should be used.
+ */
+#define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+
+/*
  * The use to which an asymmetric key is being put.
  */
 enum key_being_used_for {
