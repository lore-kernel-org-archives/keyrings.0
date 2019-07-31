From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:40 +0000
Subject: [PATCHv2 26/59] keys/mktme: Instantiate MKTME keys
Message-Id: <20190731150813.26289-27-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Instantiate is a Kernel Key Service method invoked when a key is
added (add_key, request_key) by the user.

During instantiation, MKTME allocates an available hardware KeyID
and maps it to the Userspace Key.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index fe119a155235..beca852db01a 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -14,6 +14,7 @@
 
 #include "internal.h"
 
+static DEFINE_SPINLOCK(mktme_lock);
 static unsigned int mktme_available_keyids;  /* Free Hardware KeyIDs */
 
 enum mktme_keyid_state {
@@ -31,6 +32,24 @@ struct mktme_mapping {
 
 static struct mktme_mapping *mktme_map;
 
+int mktme_reserve_keyid(struct key *key)
+{
+	int i;
+
+	if (!mktme_available_keyids)
+		return 0;
+
+	for (i = 1; i <= mktme_nr_keyids(); i++) {
+		if (mktme_map[i].state = KEYID_AVAILABLE) {
+			mktme_map[i].state = KEYID_ASSIGNED;
+			mktme_map[i].key = key;
+			mktme_available_keyids--;
+			return i;
+		}
+	}
+	return 0;
+}
+
 enum mktme_opt_id {
 	OPT_ERROR,
 	OPT_TYPE,
@@ -43,6 +62,20 @@ static const match_table_t mktme_token = {
 	{OPT_ERROR, NULL}
 };
 
+/* Key Service Method to create a new key. Payload is preparsed. */
+int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
+{
+	unsigned long flags;
+	int keyid;
+
+	spin_lock_irqsave(&mktme_lock, flags);
+	keyid = mktme_reserve_keyid(key);
+	spin_unlock_irqrestore(&mktme_lock, flags);
+	if (!keyid)
+		return -ENOKEY;
+	return 0;
+}
+
 /* Make sure arguments are correct for the TYPE of key requested */
 static int mktme_check_options(u32 *payload, unsigned long token_mask,
 			       enum mktme_type type, enum mktme_alg alg)
@@ -163,6 +196,7 @@ struct key_type key_type_mktme = {
 	.name		= "mktme",
 	.preparse	= mktme_preparse_payload,
 	.free_preparse	= mktme_free_preparsed_payload,
+	.instantiate	= mktme_instantiate_key,
 	.describe	= user_describe,
 };
 
-- 
2.21.0
