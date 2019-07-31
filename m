From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:17 +0000
Subject: [PATCHv2 03/59] mm/ksm: Do not merge pages with different KeyIDs
Message-Id: <20190731150813.26289-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KSM compares plain text.  It might try to merge two pages that have the
same plain text but different ciphertext and possibly different
encryption keys.  When the kernel encrypted the page, it promised that
it would keep it encrypted with _that_ key.  That makes it impossible to
merge two pages encrypted with different keys.

Never merge encrypted pages with different KeyIDs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h |  7 +++++++
 mm/ksm.c           | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5bfd3dd121c1..af1a56ff6764 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1644,6 +1644,13 @@ static inline int vma_keyid(struct vm_area_struct *vma)
 }
 #endif
 
+#ifndef page_keyid
+static inline int page_keyid(struct page *page)
+{
+	return 0;
+}
+#endif
+
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc4346411e4..7d4ef634f38e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1228,6 +1228,23 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	if (!PageAnon(page))
 		goto out;
 
+	/*
+	 * KeyID indicates what key to use to encrypt and decrypt page's
+	 * content.
+	 *
+	 * KSM compares plain text instead (transparently to KSM code).
+	 *
+	 * But we still need to make sure that pages with identical plain
+	 * text will not be merged together if they are encrypted with
+	 * different keys.
+	 *
+	 * To make it work kernel only allows merging pages with the same KeyID.
+	 * The approach guarantees that the merged page can be read by all
+	 * users.
+	 */
+	if (kpage && page_keyid(page) != page_keyid(kpage))
+		goto out;
+
 	/*
 	 * We need the page lock to read a stable PageSwapCache in
 	 * write_protect_page().  We use trylock_page() instead of
-- 
2.21.0
