From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 21 Nov 2019 03:20:31 +0000
Subject: [PATCH v2] security: Fix Kconfig indentation
Message-Id: <1574306432-27096-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Micah Morton <mortonm@chromium.org>, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 security/apparmor/Kconfig      | 22 +++++++++++-----------
 security/integrity/Kconfig     | 36 ++++++++++++++++++------------------
 security/integrity/ima/Kconfig | 12 ++++++------
 security/keys/Kconfig          | 22 +++++++++++-----------
 security/safesetid/Kconfig     | 24 ++++++++++++------------
 5 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index a422a349f926..81d85acff580 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -28,17 +28,17 @@ config SECURITY_APPARMOR_HASH
 	  is available to userspace via the apparmor filesystem.
 
 config SECURITY_APPARMOR_HASH_DEFAULT
-       bool "Enable policy hash introspection by default"
-       depends on SECURITY_APPARMOR_HASH
-       default y
-       help
-         This option selects whether sha1 hashing of loaded policy
-	 is enabled by default. The generation of sha1 hashes for
-	 loaded policy provide system administrators a quick way
-	 to verify that policy in the kernel matches what is expected,
-	 however it can slow down policy load on some devices. In
-	 these cases policy hashing can be disabled by default and
-	 enabled only if needed.
+	bool "Enable policy hash introspection by default"
+	depends on SECURITY_APPARMOR_HASH
+	default y
+	help
+	  This option selects whether sha1 hashing of loaded policy
+	  is enabled by default. The generation of sha1 hashes for
+	  loaded policy provide system administrators a quick way
+	  to verify that policy in the kernel matches what is expected,
+	  however it can slow down policy load on some devices. In
+	  these cases policy hashing can be disabled by default and
+	  enabled only if needed.
 
 config SECURITY_APPARMOR_DEBUG
 	bool "Build AppArmor with debug code"
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..41d565f9c2c3 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -34,10 +34,10 @@ config INTEGRITY_ASYMMETRIC_KEYS
 	bool "Enable asymmetric keys support"
 	depends on INTEGRITY_SIGNATURE
 	default n
-        select ASYMMETRIC_KEY_TYPE
-        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-        select CRYPTO_RSA
-        select X509_CERTIFICATE_PARSER
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO_RSA
+	select X509_CERTIFICATE_PARSER
 	help
 	  This option enables digital signature verification using
 	  asymmetric keys.
@@ -53,24 +53,24 @@ config INTEGRITY_TRUSTED_KEYRING
 	   keyring.
 
 config INTEGRITY_PLATFORM_KEYRING
-        bool "Provide keyring for platform/firmware trusted keys"
-        depends on INTEGRITY_ASYMMETRIC_KEYS
-        depends on SYSTEM_BLACKLIST_KEYRING
-        help
-         Provide a separate, distinct keyring for platform trusted keys, which
-         the kernel automatically populates during initialization from values
-         provided by the platform for verifying the kexec'ed kerned image
-         and, possibly, the initramfs signature.
+	bool "Provide keyring for platform/firmware trusted keys"
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	help
+	  Provide a separate, distinct keyring for platform trusted keys, which
+	  the kernel automatically populates during initialization from values
+	  provided by the platform for verifying the kexec'ed kerned image
+	  and, possibly, the initramfs signature.
 
 config LOAD_UEFI_KEYS
-       depends on INTEGRITY_PLATFORM_KEYRING
-       depends on EFI
-       def_bool y
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on EFI
+	def_bool y
 
 config LOAD_IPL_KEYS
-       depends on INTEGRITY_PLATFORM_KEYRING
-       depends on S390
-       def_bool y
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on S390
+	def_bool y
 
 config LOAD_PPC_KEYS
 	bool "Enable loading of platform and blacklisted keys for POWER"
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 838476d780e5..ec9259bd8115 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -159,13 +159,13 @@ config IMA_APPRAISE
 	  If unsure, say N.
 
 config IMA_ARCH_POLICY
-        bool "Enable loading an IMA architecture specific policy"
-        depends on (KEXEC_SIG && IMA) || IMA_APPRAISE \
+	bool "Enable loading an IMA architecture specific policy"
+	depends on (KEXEC_SIG && IMA) || IMA_APPRAISE \
 		   && INTEGRITY_ASYMMETRIC_KEYS
-        default n
-        help
-          This option enables loading an IMA architecture specific policy
-          based on run time secure boot flags.
+	default n
+	help
+	  This option enables loading an IMA architecture specific policy
+	  based on run time secure boot flags.
 
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 20791a556b58..7d7fc251b38a 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -109,17 +109,17 @@ config ENCRYPTED_KEYS
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
 
 config KEY_NOTIFICATIONS
 	bool "Provide key/keyring change notifications"
diff --git a/security/safesetid/Kconfig b/security/safesetid/Kconfig
index 18b5fb90417b..ab1a2c69b0b8 100644
--- a/security/safesetid/Kconfig
+++ b/security/safesetid/Kconfig
@@ -1,15 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SECURITY_SAFESETID
-        bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilities"
-        depends on SECURITY
-        select SECURITYFS
-        default n
-        help
-          SafeSetID is an LSM module that gates the setid family of syscalls to
-          restrict UID/GID transitions from a given UID/GID to only those
-          approved by a system-wide whitelist. These restrictions also prohibit
-          the given UIDs/GIDs from obtaining auxiliary privileges associated
-          with CAP_SET{U/G}ID, such as allowing a user to set up user namespace
-          UID mappings.
+	bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilities"
+	depends on SECURITY
+	select SECURITYFS
+	default n
+	help
+	  SafeSetID is an LSM module that gates the setid family of syscalls to
+	  restrict UID/GID transitions from a given UID/GID to only those
+	  approved by a system-wide whitelist. These restrictions also prohibit
+	  the given UIDs/GIDs from obtaining auxiliary privileges associated
+	  with CAP_SET{U/G}ID, such as allowing a user to set up user namespace
+	  UID mappings.
 
-          If you are unsure how to answer this question, answer N.
+	  If you are unsure how to answer this question, answer N.
-- 
2.7.4
