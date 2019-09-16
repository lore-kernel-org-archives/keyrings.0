From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 16 Sep 2019 10:46:23 +0000
Subject: [Patch v6 3/4] KEYS: trusted: Create trusted keys subsystem
Message-Id: <1568630064-14887-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
To: jarkko.sakkinen@linux.intel.com, dhowells@redhat.com, peterhuewe@gmx.de
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, jsnitsel@redhat.com, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>

Move existing code to trusted keys subsystem. Also, rename files with
"tpm" as suffix which provides the underlying implementation.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 crypto/asymmetric_keys/asym_tpm.c                        | 2 +-
 include/Kbuild                                           | 1 -
 include/keys/{trusted.h => trusted_tpm.h}                | 7 +++++--
 security/keys/Makefile                                   | 2 +-
 security/keys/trusted-keys/Makefile                      | 7 +++++++
 security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} | 2 +-
 6 files changed, 15 insertions(+), 6 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (96%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (99%)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index a2b2a61..d16d893 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -13,7 +13,7 @@
 #include <crypto/sha.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 #include <crypto/asym_tpm_subtype.h>
 #include <crypto/public_key.h>
 
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d4..a5801c0 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -65,7 +65,6 @@ header-test-			+= keys/asymmetric-subtype.h
 header-test-			+= keys/asymmetric-type.h
 header-test-			+= keys/big_key-type.h
 header-test-			+= keys/request_key_auth-type.h
-header-test-			+= keys/trusted.h
 header-test-			+= kvm/arm_arch_timer.h
 header-test-			+= kvm/arm_pmu.h
 header-test-$(CONFIG_ARM)	+= kvm/arm_psci.h
diff --git a/include/keys/trusted.h b/include/keys/trusted_tpm.h
similarity index 96%
rename from include/keys/trusted.h
rename to include/keys/trusted_tpm.h
index 29e3e9b..7b9d7b4 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted_tpm.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TRUSTED_KEY_H
-#define __TRUSTED_KEY_H
+#ifndef __TRUSTED_TPM_H
+#define __TRUSTED_TPM_H
+
+#include <keys/trusted-type.h>
+#include <linux/tpm_command.h>
 
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE			1024
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef540..074f275 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -28,5 +28,5 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 # Key types
 #
 obj-$(CONFIG_BIG_KEYS) += big_key.o
-obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+obj-$(CONFIG_TRUSTED_KEYS) += trusted-keys/
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
new file mode 100644
index 0000000..1a24680
--- /dev/null
+++ b/security/keys/trusted-keys/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for trusted keys
+#
+
+obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+trusted-y += trusted_tpm1.o
diff --git a/security/keys/trusted.c b/security/keys/trusted-keys/trusted_tpm1.c
similarity index 99%
rename from security/keys/trusted.c
rename to security/keys/trusted-keys/trusted_tpm1.c
index 7071011..e3155fd 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -27,7 +27,7 @@
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
-- 
2.7.4
