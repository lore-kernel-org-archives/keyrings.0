From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 07 Sep 2018 22:36:27 +0000
Subject: [RFC 05/12] x86/mm: Add a helper function to set keyid bits in encrypted VMA's
Message-Id: <efec45aae8dab3f4db8a79d001ec65137748cdb1.1536356108.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1536356108.git.alison.schofield@intel.com>
In-Reply-To: <cover.1536356108.git.alison.schofield@intel.com>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: Kai Huang <kai.huang@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, Dave Hansen <dave.hansen@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-mm@kvack.org

Store the memory encryption keyid in the upper bits of vm_page_prot
that match position of keyid, bits 51:46, in a PTE.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/mktme.h |  3 +++
 arch/x86/mm/mktme.c          | 15 +++++++++++++++
 include/linux/mm.h           |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index f6acd551457f..b707f800b68f 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -13,6 +13,9 @@ extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
 
+/* Set the encryption keyid bits in a VMA */
+extern void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid);
+
 /* Manage mappings between hardware keyids and userspace keys */
 extern int mktme_map_alloc(void);
 extern void mktme_map_free(void);
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 5246d8323359..5ee7f37e9cd0 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -63,6 +63,21 @@ int vma_keyid(struct vm_area_struct *vma)
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
 
+/* Set the encryption keyid bits in a VMA */
+void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid)
+{
+	int oldkeyid = vma_keyid(vma);
+	pgprotval_t newprot;
+
+	if (newkeyid = oldkeyid)
+		return;
+
+	newprot = pgprot_val(vma->vm_page_prot);
+	newprot &= ~mktme_keyid_mask;
+	newprot |= (unsigned long)newkeyid << mktme_keyid_shift;
+	vma->vm_page_prot = __pgprot(newprot);
+}
+
 /*
  * struct mktme_mapping and the mktme_map_* functions manage the mapping
  * of userspace keys to hardware keyids in MKTME. They are used by the
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a4ce26aa0b65..ac85c0805761 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2799,5 +2799,9 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+#ifndef CONFIG_X86_INTEL_MKTME
+static inline void mprotect_set_encrypt(struct vm_area_struct *vma,
+					int newkeyid) {}
+#endif /* CONFIG_X86_INTEL_MKTME */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.14.1
