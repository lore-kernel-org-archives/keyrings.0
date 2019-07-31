From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:57 +0000
Subject: [PATCHv2 43/59] x86/mm: Set KeyIDs in encrypted VMAs for MKTME
Message-Id: <20190731150813.26289-44-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

MKTME architecture requires the KeyID to be placed in PTE bits 51:46.
To create an encrypted VMA, place the KeyID in the upper bits of
vm_page_prot that matches the position of those PTE bits.

When the VMA is assigned a KeyID it is always considered a KeyID
change. The VMA is either going from not encrypted to encrypted,
or from encrypted with any KeyID to encrypted with any other KeyID.
To make the change safely, remove the user pages held by the VMA
and unlink the VMA's anonymous chain.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  4 ++++
 arch/x86/mm/mktme.c          | 26 ++++++++++++++++++++++++++
 include/linux/mm.h           |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index d26ada6b65f7..e8f7f80bb013 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -16,6 +16,10 @@ extern int __mktme_nr_keyids;
 extern int mktme_nr_keyids(void);
 extern unsigned int mktme_algs;
 
+/* Set the encryption keyid bits in a VMA */
+extern void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
+				unsigned long start, unsigned long end);
+
 DECLARE_STATIC_KEY_FALSE(mktme_enabled_key);
 static inline bool mktme_enabled(void)
 {
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index ed13967bb543..05bbf5058ade 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,5 +1,6 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/rmap.h>
 #include <asm/mktme.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -71,6 +72,31 @@ int __vma_keyid(struct vm_area_struct *vma)
 	return (prot & mktme_keyid_mask()) >> mktme_keyid_shift();
 }
 
+/* Set the encryption keyid bits in a VMA */
+void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
+			  unsigned long start, unsigned long end)
+{
+	int oldkeyid = vma_keyid(vma);
+	pgprotval_t newprot;
+
+	/* Unmap pages with old KeyID if there's any. */
+	zap_page_range(vma, start, end - start);
+
+	if (oldkeyid = newkeyid)
+		return;
+
+	newprot = pgprot_val(vma->vm_page_prot);
+	newprot &= ~mktme_keyid_mask();
+	newprot |= (unsigned long)newkeyid << mktme_keyid_shift();
+	vma->vm_page_prot = __pgprot(newprot);
+
+	/*
+	 * The VMA doesn't have any inherited pages.
+	 * Start anon VMA tree from scratch.
+	 */
+	unlink_anon_vmas(vma);
+}
+
 /* Prepare page to be used for encryption. Called from page allocator. */
 void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f9640f388ac..98a6d2bd66a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2905,5 +2905,11 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+#ifndef CONFIG_X86_INTEL_MKTME
+static inline void mprotect_set_encrypt(struct vm_area_struct *vma,
+					int newkeyid,
+					unsigned long start,
+					unsigned long end) {}
+#endif /* CONFIG_X86_INTEL_MKTME */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.21.0
