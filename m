From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:08:04 +0000
Subject: [PATCHv2 50/59] x86/mm: Use common code for DMA memory encryption
Message-Id: <20190731150813.26289-51-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Replace sme_ code with x86 memory encryption common code such that
Intel MKTME can be supported underneath generic DMA code.
dma_to_phys() & phys_to_dma() results will be runtime modified by
memory encryption code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mem_encrypt.h | 29 +++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_common.c   |  2 +-
 include/linux/dma-direct.h         |  4 ++--
 include/linux/mem_encrypt.h        | 23 ++++++++++-------------
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..62a1493f389c 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,8 +52,19 @@ bool sev_active(void);
 
 #define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
 
+/*
+ * The __sme_set() and __sme_clr() macros are useful for adding or removing
+ * the encryption mask from a value (e.g. when dealing with pagetable
+ * entries).
+ */
+#define __sme_set(x)		((x) | sme_me_mask)
+#define __sme_clr(x)		((x) & ~sme_me_mask)
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
+#define __sme_set(x)		(x)
+#define __sme_clr(x)		(x)
+
 #define sme_me_mask	0ULL
 
 static inline void __init sme_early_encrypt(resource_size_t paddr,
@@ -94,4 +105,22 @@ extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypte
 
 #endif	/* __ASSEMBLY__ */
 
+#ifdef CONFIG_X86_MEM_ENCRYPT_COMMON
+
+extern dma_addr_t __mem_encrypt_dma_set(dma_addr_t daddr, phys_addr_t paddr);
+extern phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr);
+
+#else
+static inline dma_addr_t __mem_encrypt_dma_set(dma_addr_t daddr, phys_addr_t paddr)
+{
+	return daddr;
+}
+
+static inline phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr)
+{
+	return paddr;
+}
+#endif /* CONFIG_X86_MEM_ENCRYPT_COMMON */
+
+
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index c11d70151735..588d6ea45624 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -1,6 +1,6 @@
 #include <linux/mm.h>
-#include <linux/mem_encrypt.h>
 #include <linux/dma-mapping.h>
+#include <asm/mem_encrypt.h>
 #include <asm/mktme.h>
 
 /*
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..6ce96b06c440 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -49,12 +49,12 @@ static inline bool force_dma_unencrypted(struct device *dev)
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __sme_set(__phys_to_dma(dev, paddr));
+	return __mem_encrypt_dma_set(__phys_to_dma(dev, paddr), paddr);
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	return __sme_clr(__dma_to_phys(dev, daddr));
+	return __mem_encrypt_dma_clear(__dma_to_phys(dev, daddr));
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 470bd53a89df..88724aa7c065 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -23,6 +23,16 @@
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 
+static inline dma_addr_t __mem_encrypt_dma_set(dma_addr_t daddr, phys_addr_t paddr)
+{
+	return daddr;
+}
+
+static inline phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr)
+{
+	return paddr;
+}
+
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 static inline bool mem_encrypt_active(void)
@@ -35,19 +45,6 @@ static inline u64 sme_get_me_mask(void)
 	return sme_me_mask;
 }
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-/*
- * The __sme_set() and __sme_clr() macros are useful for adding or removing
- * the encryption mask from a value (e.g. when dealing with pagetable
- * entries).
- */
-#define __sme_set(x)		((x) | sme_me_mask)
-#define __sme_clr(x)		((x) & ~sme_me_mask)
-#else
-#define __sme_set(x)		(x)
-#define __sme_clr(x)		(x)
-#endif
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
-- 
2.21.0
