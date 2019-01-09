From: Kairui Song <kasong@redhat.com>
Date: Wed, 09 Jan 2019 16:48:23 +0000
Subject: [RFC PATCH 1/2] integrity, KEYS: add a reference to platform keyring
Message-Id: <20190109164824.19708-2-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190109164824.19708-1-kasong@redhat.com>
In-Reply-To: <20190109164824.19708-1-kasong@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

Currently kexec_file_load will verify the kernel image being loaded
against .builtin_trusted_keys or .secondary_trusted_keys, but the
image could be signed with third part keys which will be provided by
platform or firmware and the keys won't be available in keyrings mentioned
above.

After commit ea93102f3224 ('integrity: Define a trusted platform keyring')
a .platform keyring is introduced to store the keys provided by platform
or firmware. And with a few following commits, now keys required to verify
the image is being imported to .platform keyring, but currently, only
IMA-appraisal could use the keyring and verify the image.

This patch exposes the .platform and makes other components, like
kexec_file_load, could use this .platform keyring to verify the
kernel image.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 3 +++
 include/keys/system_keyring.h | 5 +++++
 security/integrity/digsig.c   | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 81728717523d..a61b95390b80 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+struct key *platform_trusted_keys;
+#endif
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 359c2f936004..9eaf01d01036 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern struct key *platform_trusted_keys;
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..26206240388d 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -89,6 +89,10 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		keyring[id] = NULL;
 	}
 
+	if (id = INTEGRITY_KEYRING_PLATFORM) {
+		platform_trusted_keys = keyring[id];
+	}
+
 	return err;
 }
 
-- 
2.20.1
