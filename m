From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:45 +0000
Subject: [PATCHv2 31/59] keys/mktme: Set up a percpu_ref_count for MKTME keys
Message-Id: <20190731150813.26289-32-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

The MKTME key service needs to keep usage counts on the encryption
keys in order to know when it is safe to free a key for reuse.

percpu_ref_count applies well here because the key service will
take the initial reference and typically hold that reference while
the intermediary references are get/put. The intermediaries in this
case will be encrypted VMA's,

Align the percpu_ref_init and percpu_ref_kill with the key service
instantiate and destroy methods respectively.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 3c641f3ee794..18cb57be5193 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -8,6 +8,7 @@
 #include <linux/key-type.h>
 #include <linux/mm.h>
 #include <linux/parser.h>
+#include <linux/percpu-refcount.h>
 #include <linux/string.h>
 #include <asm/intel_pconfig.h>
 #include <keys/mktme-type.h>
@@ -71,6 +72,26 @@ int mktme_keyid_from_key(struct key *key)
 	return 0;
 }
 
+struct percpu_ref *encrypt_count;
+void mktme_percpu_ref_release(struct percpu_ref *ref)
+{
+	unsigned long flags;
+	int keyid;
+
+	for (keyid = 1; keyid <= mktme_nr_keyids(); keyid++) {
+		if (&encrypt_count[keyid] = ref)
+			break;
+	}
+	if (&encrypt_count[keyid] != ref) {
+		pr_debug("%s: invalid ref counter\n", __func__);
+		return;
+	}
+	percpu_ref_exit(ref);
+	spin_lock_irqsave(&mktme_lock, flags);
+	mktme_release_keyid(keyid);
+	spin_unlock_irqrestore(&mktme_lock, flags);
+}
+
 enum mktme_opt_id {
 	OPT_ERROR,
 	OPT_TYPE,
@@ -199,8 +220,10 @@ static void mktme_destroy_key(struct key *key)
 	unsigned long flags;
 
 	spin_lock_irqsave(&mktme_lock, flags);
-	mktme_release_keyid(keyid);
+	mktme_map[keyid].key = NULL;
+	mktme_map[keyid].state = KEYID_REF_KILLED;
 	spin_unlock_irqrestore(&mktme_lock, flags);
+	percpu_ref_kill(&encrypt_count[keyid]);
 }
 
 /* Key Service Method to create a new key. Payload is preparsed. */
@@ -216,9 +239,15 @@ int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 	if (!keyid)
 		return -ENOKEY;
 
+	if (percpu_ref_init(&encrypt_count[keyid], mktme_percpu_ref_release,
+			    0, GFP_KERNEL))
+		goto err_out;
+
 	if (!mktme_program_keyid(keyid, *payload))
 		return MKTME_PROG_SUCCESS;
 
+	percpu_ref_exit(&encrypt_count[keyid]);
+err_out:
 	spin_lock_irqsave(&mktme_lock, flags);
 	mktme_release_keyid(keyid);
 	spin_unlock_irqrestore(&mktme_lock, flags);
@@ -405,10 +434,18 @@ static int __init init_mktme(void)
 	/* Initialize first programming targets */
 	mktme_update_pconfig_targets();
 
+	/* Reference counters to protect in use KeyIDs */
+	encrypt_count = kvcalloc(mktme_nr_keyids() + 1, sizeof(encrypt_count[0]),
+				 GFP_KERNEL);
+	if (!encrypt_count)
+		goto free_targets;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
 
+	kvfree(encrypt_count);
+free_targets:
 	free_cpumask_var(mktme_leadcpus);
 	bitmap_free(mktme_target_map);
 free_cache:
-- 
2.21.0
