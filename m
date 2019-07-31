From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:16 +0000
Subject: [PATCHv2 02/59] mm: Add helpers to setup zero page mappings
Message-Id: <20190731150813.26289-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

When kernel sets up an encrypted page mapping, encryption KeyID is
derived from a VMA. KeyID is going to be part of vma->vm_page_prot and
it will be propagated transparently to page table entry on mk_pte().

But there is an exception: zero page is never encrypted and its mapping
must use KeyID-0, regardless VMA's KeyID.

Introduce helpers that create a page table entry for zero page.

The generic implementation will be overridden by architecture-specific
code that takes care about using correct KeyID.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 fs/dax.c                      | 3 +--
 include/asm-generic/pgtable.h | 8 ++++++++
 mm/huge_memory.c              | 6 ++----
 mm/memory.c                   | 3 +--
 mm/userfaultfd.c              | 3 +--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a237141d8787..6ecc9c560e62 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1445,8 +1445,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
-	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
-	pmd_entry = pmd_mkhuge(pmd_entry);
+	pmd_entry = mk_zero_pmd(zero_page, vmf->vma->vm_page_prot);
 	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
 	spin_unlock(ptl);
 	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..afcfbb4af4b2 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -879,8 +879,16 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 }
 #endif
 
+#ifndef mk_zero_pte
+#define mk_zero_pte(addr, prot) pte_mkspecial(pfn_pte(my_zero_pfn(addr), prot))
+#endif
+
 #ifdef CONFIG_MMU
 
+#ifndef mk_zero_pmd
+#define mk_zero_pmd(zero_page, prot) pmd_mkhuge(mk_pmd(zero_page, prot))
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1334ede667a8..e9a791413730 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -678,8 +678,7 @@ static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 	pmd_t entry;
 	if (!pmd_none(*pmd))
 		return false;
-	entry = mk_pmd(zero_page, vma->vm_page_prot);
-	entry = pmd_mkhuge(entry);
+	entry = mk_zero_pmd(zero_page, vma->vm_page_prot);
 	if (pgtable)
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
@@ -2109,8 +2108,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 
 	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
 		pte_t *pte, entry;
-		entry = pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
-		entry = pte_mkspecial(entry);
+		entry = mk_zero_pte(haddr, vma->vm_page_prot);
 		pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, haddr, pte, entry);
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..81ae8c39f75b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2970,8 +2970,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Use the zero-page for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm)) {
-		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
-						vma->vm_page_prot));
+		entry = mk_zero_pte(vmf->address, vma->vm_page_prot);
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				vmf->address, &vmf->ptl);
 		if (!pte_none(*vmf->pte))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c7ae74ce5ff3..06bf4ea3ee05 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -120,8 +120,7 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	pgoff_t offset, max_off;
 	struct inode *inode;
 
-	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
-					 dst_vma->vm_page_prot));
+	_dst_pte = mk_zero_pte(dst_addr, dst_vma->vm_page_prot);
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
-- 
2.21.0
