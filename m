From: Kairui Song <kasong@redhat.com>
Date: Mon, 21 Jan 2019 09:59:28 +0000
Subject: [PATCH v5 1/2] integrity, KEYS: add a reference to platform keyring
Message-Id: <20190121095929.26915-2-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190121095929.26915-1-kasong@redhat.com>
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
introduced a .platform keyring for storing preboot keys, used for
verifying kernel images' signature. Currently only IMA-appraisal is able
to use the keyring to verify kernel images that have their signature
stored in xattr.

This patch exposes the .platform keyring, making it
accessible for verifying PE signed kernel images as well.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 9 +++++++++
 security/integrity/digsig.c   | 3 +++
 3 files changed, 21 insertions(+)

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
index 359c2f936004..df766ef8f03c 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,14 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern void __init set_platform_trusted_keys(struct key* keyring);
+
+#else
+
+static inline void set_platform_trusted_keys(struct key* keyring) { };
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..e19c2eb72c51 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -87,6 +87,9 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		pr_info("Can't allocate %s keyring (%d)\n",
 			keyring_name[id], err);
 		keyring[id] = NULL;
+	} else {
+		if (id = INTEGRITY_KEYRING_PLATFORM)
+			set_platform_trusted_keys(keyring[id]);
 	}
 
 	return err;
-- 
2.20.1
