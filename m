From: Kairui Song <kasong@redhat.com>
Date: Wed, 16 Jan 2019 10:16:53 +0000
Subject: [PATCH v3 1/2] integrity, KEYS: add a reference to platform keyring
Message-Id: <20190116101654.7288-2-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190116101654.7288-1-kasong@redhat.com>
In-Reply-To: <20190116101654.7288-1-kasong@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

Currently when loading new kernel via kexec_file_load syscall, it is able
to verify the signed PE bzimage against .builtin_trusted_keys or
.secondary_trusted_keys. But the image could be signed with third part
keys which will be provided by platform or firmware as EFI variable (eg.
stored in MokListRT EFI variable), and the keys won't be available in
keyrings mentioned above.

After commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
a .platform keyring is introduced to store the keys provided by platform
or firmware, this keyring is intended to be used for verifying kernel
images being loaded by kexec_file_load syscall. And with a few following
up commits, keys provided by firmware is being loaded into this keyring,
and IMA-appraisal is able to use the keyring to verify kernel images.
IMA is the currently the only user of that keyring.

This patch exposes the .platform, and makes it useable for other
components. For example, kexec_file_load could use this .platform
keyring to verify the kernel image's image.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 5 +++++
 security/integrity/digsig.c   | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 81728717523d..4690ef9cda8a 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+static struct key *platform_trusted_keys;
+#endif
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
@@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+void __init set_platform_trusted_keys(struct key *keyring) {
+	platform_trusted_keys = keyring;
+}
+#endif
+
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 359c2f936004..9e1b7849b6aa 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern void __init set_platform_trusted_keys(struct key* keyring);
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..bfabc2a8111d 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		keyring[id] = NULL;
 	}
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	if (id = INTEGRITY_KEYRING_PLATFORM) {
+		set_platform_trusted_keys(keyring[id]);
+	}
+#endif
+
 	return err;
 }
 
-- 
2.20.1
