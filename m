From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:29 +0000
Subject: [PATCHv2 15/59] x86/mm: Map zero pages into encrypted mappings correctly
Message-Id: <20190731150813.26289-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Zero pages are never encrypted. Keep KeyID-0 for them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..f0dd80a920a9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -820,6 +820,19 @@ static inline unsigned long pmd_index(unsigned long address)
  */
 #define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
 
+#define mk_zero_pte mk_zero_pte
+static inline pte_t mk_zero_pte(unsigned long addr, pgprot_t prot)
+{
+	extern unsigned long zero_pfn;
+	pte_t entry;
+
+	prot.pgprot &= ~mktme_keyid_mask();
+	entry = pfn_pte(zero_pfn, prot);
+	entry = pte_mkspecial(entry);
+
+	return entry;
+}
+
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
  *
@@ -1153,6 +1166,12 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 
 #define mk_pmd(page, pgprot)   pfn_pmd(page_to_pfn(page), (pgprot))
 
+#define mk_zero_pmd(zero_page, prot)					\
+({									\
+	prot.pgprot &= ~mktme_keyid_mask();				\
+	pmd_mkhuge(mk_pmd(zero_page, prot));				\
+})
+
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp,
-- 
2.21.0
