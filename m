From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:41 +0000
Subject: [PATCHv2 27/59] keys/mktme: Destroy MKTME keys
Message-Id: <20190731150813.26289-28-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Destroy is a method invoked by the kernel key service when a
userspace key is being removed. (invalidate, revoke, timeout).

During destroy, MKTME wil returned the hardware KeyID to the pool
of available keyids.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index beca852db01a..10fcdbf5a08f 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -50,6 +50,23 @@ int mktme_reserve_keyid(struct key *key)
 	return 0;
 }
 
+static void mktme_release_keyid(int keyid)
+{
+	 mktme_map[keyid].state = KEYID_AVAILABLE;
+	 mktme_available_keyids++;
+}
+
+int mktme_keyid_from_key(struct key *key)
+{
+	int i;
+
+	for (i = 1; i <= mktme_nr_keyids(); i++) {
+		if (mktme_map[i].key = key)
+			return i;
+	}
+	return 0;
+}
+
 enum mktme_opt_id {
 	OPT_ERROR,
 	OPT_TYPE,
@@ -62,6 +79,17 @@ static const match_table_t mktme_token = {
 	{OPT_ERROR, NULL}
 };
 
+/* Key Service Method called when a Userspace Key is garbage collected. */
+static void mktme_destroy_key(struct key *key)
+{
+	int keyid = mktme_keyid_from_key(key);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mktme_lock, flags);
+	mktme_release_keyid(keyid);
+	spin_unlock_irqrestore(&mktme_lock, flags);
+}
+
 /* Key Service Method to create a new key. Payload is preparsed. */
 int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 {
@@ -198,6 +226,7 @@ struct key_type key_type_mktme = {
 	.free_preparse	= mktme_free_preparsed_payload,
 	.instantiate	= mktme_instantiate_key,
 	.describe	= user_describe,
+	.destroy	= mktme_destroy_key,
 };
 
 static int __init init_mktme(void)
-- 
2.21.0
