From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:47:26 +0000
Subject: [PATCH 01/23] security/keys: add CONFIG_KEYS_COMPAT to Kconfig
Message-Id: <149692964657.11452.547823032024351272.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Bilal Amarni <bilal.amarni@gmail.com>

CONFIG_KEYS_COMPAT is defined in arch-specific Kconfigs and is missing for
several 64-bit architectures : mips, parisc, tile.

At the moment and for those architectures, calling in 32-bit userspace the
keyctl syscall would return an ENOSYS error.

This patch moves the CONFIG_KEYS_COMPAT option to security/keys/Kconfig, to
make sure the compatibility wrapper is registered by default for any 64-bit
architecture as long as it is configured with CONFIG_COMPAT.

[DH: Modified to remove arm64 compat enablement also as requested by Eric
 Biggers]

Signed-off-by: Bilal Amarni <bilal.amarni@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
cc: Eric Biggers <ebiggers3@gmail.com>
---

 arch/arm64/Kconfig    |    4 ----
 arch/powerpc/Kconfig  |    5 -----
 arch/s390/Kconfig     |    3 ---
 arch/sparc/Kconfig    |    3 ---
 arch/x86/Kconfig      |    4 ----
 security/keys/Kconfig |    4 ++++
 6 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec69bca..b2024db225a9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1084,10 +1084,6 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
-config KEYS_COMPAT
-	def_bool y
-	depends on COMPAT && KEYS
-
 endmenu
 
 menu "Power management options"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f9972f61..83d2e0f43c26 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1215,11 +1215,6 @@ source "arch/powerpc/Kconfig.debug"
 
 source "security/Kconfig"
 
-config KEYS_COMPAT
-	bool
-	depends on COMPAT && KEYS
-	default y
-
 source "crypto/Kconfig"
 
 config PPC_LIB_RHEAP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e161fafb495b..6967addc6a89 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -363,9 +363,6 @@ config COMPAT
 config SYSVIPC_COMPAT
 	def_bool y if COMPAT && SYSVIPC
 
-config KEYS_COMPAT
-	def_bool y if COMPAT && KEYS
-
 config SMP
 	def_bool y
 	prompt "Symmetric multi-processing support"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b558c9e29de3..5639c9fe5b55 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -577,9 +577,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-config KEYS_COMPAT
-	def_bool y if COMPAT && KEYS
-
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4ccfacc7232a..0efb4c9497bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2776,10 +2776,6 @@ config COMPAT_FOR_U64_ALIGNMENT
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on SYSVIPC
-
-config KEYS_COMPAT
-	def_bool y
-	depends on KEYS
 endif
 
 endmenu
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 6fd95f76bfae..00b7431a8aeb 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -20,6 +20,10 @@ config KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 config PERSISTENT_KEYRINGS
 	bool "Enable register of persistent per-UID keyrings"
 	depends on KEYS

