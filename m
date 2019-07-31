From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:28 +0000
Subject: [PATCHv2 14/59] x86/mm: Add hooks to allocate and free encrypted pages
Message-Id: <20190731150813.26289-15-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
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

The patch relies on page_address() to return virtual address of the page
mapping with the current KeyID. It will be implemented later in the
patchset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 17 ++++++++
 arch/x86/mm/mktme.c          | 83 ++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 52b115b30a42..a61b45fca4b1 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -43,6 +43,23 @@ static inline int vma_keyid(struct vm_area_struct *vma)
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
 #define mktme_keyid_mask()	((phys_addr_t)0)
 #define mktme_nr_keyids()	0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index d02867212e33..8015e7822c9b 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/mktme.h>
 
 /* Mask to extract KeyID from physical address. */
@@ -55,3 +56,85 @@ int __vma_keyid(struct vm_area_struct *vma)
 	pgprotval_t prot = pgprot_val(vma->vm_page_prot);
 	return (prot & mktme_keyid_mask()) >> mktme_keyid_shift();
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
+	 *
+	 * Flush cache lines with KeyID-0. page_address() returns virtual
+	 * address of the page mapping with the current (zero) KeyID.
+	 */
+	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		/* All pages coming out of the allocator should have KeyID 0 */
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
+
+		/*
+		 * Change KeyID. From now on page_address() will return address
+		 * of the page mapping with the new KeyID.
+		 *
+		 * We don't need barrier() before the KeyID change because
+		 * clflush_cache_range() above stops compiler from reordring
+		 * past the point with mb().
+		 *
+		 * And we don't need a barrier() after the assignment because
+		 * any future reference of KeyID (i.e. from page_address())
+		 * will create address dependency and compiler is not allow to
+		 * mess with this.
+		 */
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
+	 *
+	 * Flush cache lines with non-0 KeyID. page_address() returns virtual
+	 * address of the page mapping with the current (non-zero) KeyID.
+	 */
+	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		/* Check if the page has reasonable KeyID */
+		WARN_ON_ONCE(!lookup_page_ext(page)->keyid);
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids());
+
+		/*
+		 * Switch the page back to zero KeyID.
+		 *
+		 * We don't need barrier() before the KeyID change because
+		 * clflush_cache_range() above stops compiler from reordring
+		 * past the point with mb().
+		 *
+		 * And we don't need a barrier() after the assignment because
+		 * any future reference of KeyID (i.e. from page_address())
+		 * will create address dependency and compiler is not allow to
+		 * mess with this.
+		 */
+		lookup_page_ext(page)->keyid = 0;
+		page++;
+	}
+}
-- 
2.21.0
