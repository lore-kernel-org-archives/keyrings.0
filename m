From: Kairui Song <kasong@redhat.com>
Date: Fri, 18 Jan 2019 09:17:33 +0000
Subject: [PATCH v4 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <20190118091733.29940-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118091733.29940-1-kasong@redhat.com>
In-Reply-To: <20190118091733.29940-1-kasong@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

This patch let kexec_file_load makes use of .platform keyring as fall
back if it failed to verify a PE signed image against secondary or
builtin keyring, make it possible to verify kernel image signed with
preboot keys as well.

This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
should verify the signature using platform keyring. Also, decrease
the error message log level when verification failed with -ENOKEY,
so that if called tried multiple time with different keyring it
won't generate extra noises.

Signed-off-by: Kairui Song <kasong@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 13 ++++++++++++-
 include/linux/verification.h      |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7d97e432cbbc..2c007abd3d40 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -534,9 +534,16 @@ static int bzImage64_cleanup(void *loader_data)
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len,
-				       VERIFY_USE_SECONDARY_KEYRING,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	int ret;
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret = -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
 }
 #endif
 
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4690ef9cda8a..7085c286f4bd 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -240,11 +240,22 @@ int verify_pkcs7_signature(const void *data, size_t len,
 #else
 		trusted_keys = builtin_trusted_keys;
 #endif
+	} else if (trusted_keys = VERIFY_USE_PLATFORM_KEYRING) {
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+		trusted_keys = platform_trusted_keys;
+#else
+		trusted_keys = NULL;
+#endif
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("PKCS#7 platform keyring is not available\n");
+			goto error;
+		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
 		if (ret = -ENOKEY)
-			pr_err("PKCS#7 signature not signed with a trusted key\n");
+			pr_devel("PKCS#7 signature not signed with a trusted key\n");
 		goto error;
 	}
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cfa4730d607a..018fb5f13d44 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -17,6 +17,7 @@
  * should be used.
  */
 #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+#define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
 
 /*
  * The use to which an asymmetric key is being put.
-- 
2.20.1
