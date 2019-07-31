From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:22 +0000
Subject: [PATCHv2 08/59] x86/mm: Introduce helpers to read number, shift and mask of KeyIDs
Message-Id: <20190731150813.26289-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

mktme_nr_keyids() returns the number of KeyIDs available for MKTME,
excluding KeyID zero which used by TME. MKTME KeyIDs start from 1.

mktme_keyid_shift() returns the shift of KeyID within physical address.

mktme_keyid_mask() returns the mask to extract KeyID from physical address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 15 ++++++++++++---
 arch/x86/mm/Makefile         |  2 ++
 arch/x86/mm/mktme.c          | 27 +++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/mktme.h
 create mode 100644 arch/x86/mm/mktme.c

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
new file mode 100644
index 000000000000..b9ba2ea5b600
--- /dev/null
+++ b/arch/x86/include/asm/mktme.h
@@ -0,0 +1,19 @@
+#ifndef	_ASM_X86_MKTME_H
+#define	_ASM_X86_MKTME_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_X86_INTEL_MKTME
+extern phys_addr_t __mktme_keyid_mask;
+extern phys_addr_t mktme_keyid_mask(void);
+extern int __mktme_keyid_shift;
+extern int mktme_keyid_shift(void);
+extern int __mktme_nr_keyids;
+extern int mktme_nr_keyids(void);
+#else
+#define mktme_keyid_mask()	((phys_addr_t)0)
+#define mktme_nr_keyids()	0
+#define mktme_keyid_shift()	0
+#endif
+
+#endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f03eee666761..7ba44825be42 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -618,6 +618,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
 
 #ifdef CONFIG_X86_INTEL_MKTME
 	if (mktme_status = MKTME_ENABLED && nr_keyids) {
+		__mktme_nr_keyids = nr_keyids;
+		__mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
+
 		/*
 		 * Mask out bits claimed from KeyID from physical address mask.
 		 *
@@ -625,17 +628,23 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * and number of bits claimed for KeyID is 6, bits 51:46 of
 		 * physical address is unusable.
 		 */
-		phys_addr_t keyid_mask;
+		__mktme_keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, mktme_keyid_shift());
+		physical_mask &= ~mktme_keyid_mask();
 
-		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
-		physical_mask &= ~keyid_mask;
 	} else {
 		/*
 		 * Reset __PHYSICAL_MASK.
 		 * Maybe needed if there's inconsistent configuation
 		 * between CPUs.
+		 *
+		 * FIXME: broken for hotplug.
+		 * We must not allow onlining secondary CPUs with non-matching
+		 * configuration.
 		 */
 		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+		__mktme_keyid_mask = 0;
+		__mktme_keyid_shift = 0;
+		__mktme_nr_keyids = 0;
 	}
 #endif
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..600d18691876 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
new file mode 100644
index 000000000000..0f48ef2720cc
--- /dev/null
+++ b/arch/x86/mm/mktme.c
@@ -0,0 +1,27 @@
+#include <asm/mktme.h>
+
+/* Mask to extract KeyID from physical address. */
+phys_addr_t __mktme_keyid_mask;
+phys_addr_t mktme_keyid_mask(void)
+{
+	return __mktme_keyid_mask;
+}
+EXPORT_SYMBOL_GPL(mktme_keyid_mask);
+
+/* Shift of KeyID within physical address. */
+int __mktme_keyid_shift;
+int mktme_keyid_shift(void)
+{
+	return __mktme_keyid_shift;
+}
+EXPORT_SYMBOL_GPL(mktme_keyid_shift);
+
+/*
+ * Number of KeyIDs available for MKTME.
+ * Excludes KeyID-0 which used by TME. MKTME KeyIDs start from 1.
+ */
+int __mktme_nr_keyids;
+int mktme_nr_keyids(void)
+{
+	return __mktme_nr_keyids;
+}
-- 
2.21.0
