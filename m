From: Alison Schofield <alison.schofield@intel.com>
Date: Tue, 04 Dec 2018 07:39:55 +0000
Subject: [RFC v2 08/13] mm: Use reference counting for encrypted VMAs
Message-Id: <985ba614d49986fdfc0397434fd1dd9eb5646c6f.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

The MKTME (Multi-Key Total Memory Encryption) Key Service needs
a reference count on encrypted VMAs. This reference count is used
to determine when a hardware encryption keyid is in use, which in
turn, tells the key service what operations can be safely performed
with this keyid.

The approach is:
1) Increment/decrement the reference count during encrypt_mprotect()
system call for initial or updated encryption on a VMA.

2) Piggy back on the new vm_area_dup/free() helpers. If the VMAs being
duplicated, or freed are encrypted, adjust the reference count.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/mktme.c | 2 ++
 kernel/fork.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index facf08f9cb74..55d34beb9b81 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -145,10 +145,12 @@ void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
 	if (oldkeyid = newkeyid)
 		return;
 
+	vma_put_encrypt_ref(vma);
 	newprot = pgprot_val(vma->vm_page_prot);
 	newprot &= ~mktme_keyid_mask;
 	newprot |= (unsigned long)newkeyid << mktme_keyid_shift;
 	vma->vm_page_prot = __pgprot(newprot);
+	vma_get_encrypt_ref(vma);
 
 	/*
 	 * The VMA doesn't have any inherited pages.
diff --git a/kernel/fork.c b/kernel/fork.c
index 07cddff89c7b..d12d27b50966 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -341,12 +341,14 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	if (new) {
 		*new = *orig;
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_get_encrypt_ref(new);
 	}
 	return new;
 }
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	vma_put_encrypt_ref(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-- 
2.14.1
