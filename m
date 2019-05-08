From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:29 +0000
Subject: [PATCH, RFC 09/62] x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
Message-Id: <20190508144422.13171-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

An encrypted VMA will have KeyID stored in vma->vm_page_prot. This way
we don't need to do anything special to setup encrypted page table
entries and don't need to reserve space for KeyID in a VMA.

This patch changes _PAGE_CHG_MASK to include KeyID bits. Otherwise they
are going to be stripped from vm_page_prot on the first pgprot_modify().

Define PTE_PFN_MASK_MAX similar to PTE_PFN_MASK but based on
__PHYSICAL_MASK_SHIFT. This way we include whole range of bits
architecturally available for PFN without referencing physical_mask and
mktme_keyid_mask variables.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index d6ff0bbdb394..7d6f68431538 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -117,12 +117,25 @@
 				 _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * Set of bits not changed in pte_modify.  The pte's
- * protection key is treated like _PAGE_RW, for
- * instance, and is *not* included in this mask since
- * pte_modify() does modify it.
+ * Set of bits not changed in pte_modify.
+ *
+ * The pte's protection key is treated like _PAGE_RW, for instance, and is
+ * *not* included in this mask since pte_modify() does modify it.
+ *
+ * They include the physical address and the memory encryption keyID.
+ * The paddr and the keyID never occupy the same bits at the same time.
+ * But, a given bit might be used for the keyID on one system and used for
+ * the physical address on another. As an optimization, we manage them in
+ * one unit here since their combination always occupies the same hardware
+ * bits. PTE_PFN_MASK_MAX stores combined mask.
+ *
+ * Cast PAGE_MASK to a signed type so that it is sign-extended if
+ * virtual addresses are 32-bits but physical addresses are larger
+ * (ie, 32-bit PAE).
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
+#define PTE_PFN_MASK_MAX \
+	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
 			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
-- 
2.20.1
