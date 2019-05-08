From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:32 +0000
Subject: [PATCH, RFC 12/62] x86/mm: Add a helper to retrieve KeyID for a VMA
Message-Id: <20190508144422.13171-13-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

We store KeyID in upper bits for vm_page_prot that match position of
KeyID in PTE. vma_keyid() extracts KeyID from vm_page_prot.

With KeyID in vm_page_prot we don't need to modify any page table helper
to propagate the KeyID to page table entires.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 12 ++++++++++++
 arch/x86/mm/mktme.c          |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 51f831b94179..b5afa31b4526 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -5,6 +5,8 @@
 #include <linux/page_ext.h>
 #include <linux/jump_label.h>
 
+struct vm_area_struct;
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
@@ -28,6 +30,16 @@ static inline int page_keyid(const struct page *page)
 }
 
 
+#define vma_keyid vma_keyid
+int __vma_keyid(struct vm_area_struct *vma);
+static inline int vma_keyid(struct vm_area_struct *vma)
+{
+	if (!mktme_enabled())
+		return 0;
+
+	return __vma_keyid(vma);
+}
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 9dc256e3654b..d4a1a9e9b1c0 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,3 +1,4 @@
+#include <linux/mm.h>
 #include <asm/mktme.h>
 
 /* Mask to extract KeyID from physical address. */
@@ -30,3 +31,9 @@ struct page_ext_operations page_mktme_ops = {
 	.need = need_page_mktme,
 	.init = init_page_mktme,
 };
+
+int __vma_keyid(struct vm_area_struct *vma)
+{
+	pgprotval_t prot = pgprot_val(vma->vm_page_prot);
+	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
+}
-- 
2.20.1
