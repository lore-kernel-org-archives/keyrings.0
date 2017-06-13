From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 13 Jun 2017 06:09:25 +0000
Subject: [PATCH] KEYS: remove CONFIG_KEYS_COMPAT
Message-Id: <20170613060925.17121-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
security/keys/ directory is only compiled if KEYS is enabled, so in
practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
unnecessary KEYS_COMPAT and just use COMPAT directly.

(Also remove an outdated comment from compat.c.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/Kconfig    | 4 ----
 security/keys/Makefile   | 2 +-
 security/keys/compat.c   | 5 -----
 security/keys/internal.h | 4 ++--
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index a7a23b5541f8..f5d96996baa6 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -20,10 +20,6 @@ config KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
-config KEYS_COMPAT
-	def_bool y
-	depends on COMPAT && KEYS
-
 config PERSISTENT_KEYRINGS
 	bool "Enable register of persistent per-UID keyrings"
 	depends on KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 57dff0c15809..6d31eca7c602 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -16,7 +16,7 @@ obj-y := \
 	request_key_auth.o \
 	user_defined.o
 compat-obj-$(CONFIG_KEY_DH_OPERATIONS) += compat_dh.o
-obj-$(CONFIG_KEYS_COMPAT) += compat.o $(compat-obj-y)
+obj-$(CONFIG_COMPAT) += compat.o $(compat-obj-y)
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSCTL) += sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
diff --git a/security/keys/compat.c b/security/keys/compat.c
index e87c89c0177c..d7445946b701 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -50,11 +50,6 @@ static long compat_keyctl_instantiate_key_iov(
 
 /*
  * The key control system call, 32-bit compatibility version for 64-bit archs
- *
- * This should only be called if the 64-bit arch uses weird pointers in 32-bit
- * mode or doesn't guarantee that the top 32-bits of the argument registers on
- * taking a 32-bit syscall are zero.  If you can, you should call sys_keyctl()
- * directly.
  */
 COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 		       u32, arg2, u32, arg3, u32, arg4, u32, arg5)
diff --git a/security/keys/internal.h b/security/keys/internal.h
index c0f8682eba69..0cc7333408d0 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -271,7 +271,7 @@ extern long keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
 			      size_t, struct keyctl_kdf_params __user *);
 extern long __keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
 				size_t, struct keyctl_kdf_params *);
-#ifdef CONFIG_KEYS_COMPAT
+#ifdef CONFIG_COMPAT
 extern long compat_keyctl_dh_compute(struct keyctl_dh_params __user *params,
 				char __user *buffer, size_t buflen,
 				struct compat_keyctl_kdf_params __user *kdf);
@@ -286,7 +286,7 @@ static inline long keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	return -EOPNOTSUPP;
 }
 
-#ifdef CONFIG_KEYS_COMPAT
+#ifdef CONFIG_COMPAT
 static inline long compat_keyctl_dh_compute(
 				struct keyctl_dh_params __user *params,
 				char __user *buffer, size_t buflen,
-- 
2.13.1

