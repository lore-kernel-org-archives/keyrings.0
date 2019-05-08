From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:46 +0000
Subject: [PATCH, RFC 26/62] keys/mktme: Move the MKTME payload into a cache aligned structure
Message-Id: <20190508144422.13171-27-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

In preparation for programming the key into the hardware, move
the key payload into a cache aligned structure. This alignment
is a requirement of the MKTME hardware.

Use the slab allocator to have this structure readily available.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 39 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 14bc4e600978..a7ca32865a1c 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 
 static DEFINE_SPINLOCK(mktme_lock);
+struct kmem_cache *mktme_prog_cache;	/* Hardware programming cache */
 
 /* 1:1 Mapping between Userspace Keys (struct key) and Hardware KeyIDs */
 struct mktme_mapping {
@@ -97,6 +98,27 @@ struct mktme_payload {
 	u8		tweak_key[MKTME_AES_XTS_SIZE];
 };
 
+/* Copy the payload to the HW programming structure and program this KeyID */
+static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
+{
+	struct mktme_key_program *kprog = NULL;
+	int ret;
+
+	kprog = kmem_cache_zalloc(mktme_prog_cache, GFP_ATOMIC);
+	if (!kprog)
+		return -ENOMEM;
+
+	/* Hardware programming requires cached aligned struct */
+	kprog->keyid = keyid;
+	kprog->keyid_ctrl = payload->keyid_ctrl;
+	memcpy(kprog->key_field_1, payload->data_key, MKTME_AES_XTS_SIZE);
+	memcpy(kprog->key_field_2, payload->tweak_key, MKTME_AES_XTS_SIZE);
+
+	ret = MKTME_PROG_SUCCESS;	/* Future programming call */
+	kmem_cache_free(mktme_prog_cache, kprog);
+	return ret;
+}
+
 /* Key Service Method called when a Userspace Key is garbage collected. */
 static void mktme_destroy_key(struct key *key)
 {
@@ -106,6 +128,7 @@ static void mktme_destroy_key(struct key *key)
 /* Key Service Method to create a new key. Payload is preparsed. */
 int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 {
+	struct mktme_payload *payload = prep->payload.data[0];
 	unsigned long flags;
 	int keyid;
 
@@ -114,7 +137,14 @@ int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 	spin_unlock_irqrestore(&mktme_lock, flags);
 	if (!keyid)
 		return -ENOKEY;
-	return 0;
+
+	if (!mktme_program_keyid(keyid, payload))
+		return MKTME_PROG_SUCCESS;
+
+	spin_lock_irqsave(&mktme_lock, flags);
+	mktme_release_keyid(keyid);
+	spin_unlock_irqrestore(&mktme_lock, flags);
+	return -ENOKEY;
 }
 
 /* Make sure arguments are correct for the TYPE of key requested */
@@ -275,10 +305,15 @@ static int __init init_mktme(void)
 	if (mktme_map_alloc())
 		return -ENOMEM;
 
+	/* Used to program the hardware key tables */
+	mktme_prog_cache = KMEM_CACHE(mktme_key_program, SLAB_PANIC);
+	if (!mktme_prog_cache)
+		goto free_map;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
-
+free_map:
 	kvfree(mktme_map);
 
 	return -ENOMEM;
-- 
2.20.1
