From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 17:57:44 +0000
Subject: [PATCH 2/3] keys: export find_keyring_by_name()
Message-Id: <20180228175521.10287-2-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>

This patch exports the function find_keyring_by_name()
to be used by other subsystems.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 include/linux/key.h      | 2 ++
 security/keys/internal.h | 2 --
 security/keys/keyring.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e58ee10f6e58..c8d332d4103c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -346,6 +346,8 @@ static inline key_serial_t key_serial(const struct key *key)
 
 extern void key_set_timeout(struct key *, unsigned);
 
+extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
+
 /*
  * The permissions required on a key that we're looking up.
  */
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9f8208dc0e55..8aa8d347a1ab 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -141,8 +141,6 @@ extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
 extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
 
-extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
-
 extern int install_user_keyrings(void);
 extern int install_thread_keyring_to_cred(struct cred *);
 extern int install_process_keyring_to_cred(struct cred *);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d0bccebbd3b5..0fd230534685 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1159,6 +1159,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	read_unlock(&keyring_name_lock);
 	return keyring;
 }
+EXPORT_SYMBOL(find_keyring_by_name);
 
 static int keyring_detect_cycle_iterator(const void *object,
 					 void *iterator_data)
-- 
2.13.6

