From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:28 +0000
Subject: [PATCH, RFC 08/62] x86/mm: Introduce variables to store number, shift and mask of KeyIDs
Message-Id: <20190508144422.13171-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

mktme_nr_keyids holds the number of KeyIDs available for MKTME,
excluding KeyID zero which used by TME. MKTME KeyIDs start from 1.

mktme_keyid_shift holds the shift of KeyID within physical address.

mktme_keyid_mask holds the mask to extract KeyID from physical address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 16 ++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 16 ++++++++++++----
 arch/x86/mm/Makefile         |  2 ++
 arch/x86/mm/mktme.c          | 11 +++++++++++
 4 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/mktme.h
 create mode 100644 arch/x86/mm/mktme.c

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
new file mode 100644
index 000000000000..df31876ec48c
--- /dev/null
+++ b/arch/x86/include/asm/mktme.h
@@ -0,0 +1,16 @@
+#ifndef	_ASM_X86_MKTME_H
+#define	_ASM_X86_MKTME_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_X86_INTEL_MKTME
+extern phys_addr_t mktme_keyid_mask;
+extern int mktme_nr_keyids;
+extern int mktme_keyid_shift;
+#else
+#define mktme_keyid_mask	((phys_addr_t)0)
+#define mktme_nr_keyids		0
+#define mktme_keyid_shift	0
+#endif
+
+#endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 5dfecc9c2253..e271264e238a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -591,6 +591,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
 
 #ifdef CONFIG_X86_INTEL_MKTME
 	if (mktme_status = MKTME_ENABLED && nr_keyids) {
+		mktme_nr_keyids = nr_keyids;
+		mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
+
 		/*
 		 * Mask out bits claimed from KeyID from physical address mask.
 		 *
@@ -598,17 +601,22 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * and number of bits claimed for KeyID is 6, bits 51:46 of
 		 * physical address is unusable.
 		 */
-		phys_addr_t keyid_mask;
-
-		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
-		physical_mask &= ~keyid_mask;
+		mktme_keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, mktme_keyid_shift);
+		physical_mask &= ~mktme_keyid_mask;
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
+		mktme_keyid_mask = 0;
+		mktme_keyid_shift = 0;
+		mktme_nr_keyids = 0;
 	}
 #endif
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..4ebee899c363 100644
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
index 000000000000..91a415612519
--- /dev/null
+++ b/arch/x86/mm/mktme.c
@@ -0,0 +1,11 @@
+#include <asm/mktme.h>
+
+/* Mask to extract KeyID from physical address. */
+phys_addr_t mktme_keyid_mask;
+/*
+ * Number of KeyIDs available for MKTME.
+ * Excludes KeyID-0 which used by TME. MKTME KeyIDs start from 1.
+ */
+int mktme_nr_keyids;
+/* Shift of KeyID within physical address. */
+int mktme_keyid_shift;
-- 
2.20.1
