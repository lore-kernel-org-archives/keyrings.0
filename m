From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 01:19:10 +0000
Subject: [PATCH v3 9/9] KEYS: Call the IMA hook to measure key when a new key is created or an existing key i
Message-Id: <20191031011910.2574-10-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

key_create_or_update function needs to call the IMA hook to measure
the key when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update
function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h | 7 +++++++
 security/keys/key.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..f085f1c6ef34 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -24,6 +24,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  unsigned long flags, bool create);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -91,6 +94,10 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 unsigned long flags,
+						 bool create) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..7c39054d8da6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the ima module know about the created key. */
+	ima_post_key_create_or_update(keyring, key, flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+	if (!IS_ERR(key_ref)) {
+		/* let the ima module know about the updated key. */
+		ima_post_key_create_or_update(keyring, key, flags, false);
+	}
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1
