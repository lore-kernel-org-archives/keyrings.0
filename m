From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:33 +0000
Subject: [PATCH, RFC 13/62] x86/mm: Add hooks to allocate and free encrypted pages
Message-Id: <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Hook up into page allocator to allocate and free encrypted page
properly.

The hardware/CPU does not enforce coherency between mappings of the same
physical page with different KeyIDs or encryption keys.
We are responsible for cache management.

Flush cache on allocating encrypted page and on returning the page to
the free pool.

prep_encrypted_page() also takes care about zeroing the page. We have to
do this after KeyID is set for the page.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 17 +++++++++++++
 arch/x86/mm/mktme.c          | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index b5afa31b4526..6e604126f0bc 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -40,6 +40,23 @@ static inline int vma_keyid(struct vm_area_struct *vma)
 	return __vma_keyid(vma);
 }
 
+#define prep_encrypted_page prep_encrypted_page
+void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero);
+static inline void prep_encrypted_page(struct page *page, int order,
+		int keyid, bool zero)
+{
+	if (keyid)
+		__prep_encrypted_page(page, order, keyid, zero);
+}
+
+#define HAVE_ARCH_FREE_PAGE
+void free_encrypted_page(struct page *page, int order);
+static inline void arch_free_page(struct page *page, int order)
+{
+	if (page_keyid(page))
+		free_encrypted_page(page, order);
+}
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index d4a1a9e9b1c0..43489c098e60 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/mktme.h>
 
 /* Mask to extract KeyID from physical address. */
@@ -37,3 +38,51 @@ int __vma_keyid(struct vm_area_struct *vma)
 	pgprotval_t prot = pgprot_val(vma->vm_page_prot);
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
+
+/* Prepare page to be used for encryption. Called from page allocator. */
+void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
+{
+	int i;
+
+	/*
+	 * The hardware/CPU does not enforce coherency between mappings
+	 * of the same physical page with different KeyIDs or
+	 * encryption keys. We are responsible for cache management.
+	 */
+	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		/* All pages coming out of the allocator should have KeyID 0 */
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
+		lookup_page_ext(page)->keyid = keyid;
+
+		/* Clear the page after the KeyID is set. */
+		if (zero)
+			clear_highpage(page);
+
+		page++;
+	}
+}
+
+/*
+ * Handles freeing of encrypted page.
+ * Called from page allocator on freeing encrypted page.
+ */
+void free_encrypted_page(struct page *page, int order)
+{
+	int i;
+
+	/*
+	 * The hardware/CPU does not enforce coherency between mappings
+	 * of the same physical page with different KeyIDs or
+	 * encryption keys. We are responsible for cache management.
+	 */
+	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		/* Check if the page has reasonable KeyID */
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);
+		lookup_page_ext(page)->keyid = 0;
+		page++;
+	}
+}
-- 
2.20.1
