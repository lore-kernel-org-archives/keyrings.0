From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:15 +0000
Subject: [PATCH, RFC 55/62] x86/mm: Disable MKTME if not all system memory supports encryption
Message-Id: <20190508144422.13171-56-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

UEFI memory attribute EFI_MEMORY_CPU_CRYPTO indicates whether the memory
region supports encryption.

Kernel doesn't handle situation when only part of the system memory
supports encryption.

Disable MKTME if not all system memory supports encryption.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/mktme.c        | 29 +++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c | 25 +++++++++++++------------
 include/linux/efi.h        |  1 +
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 12f4266cf7ea..60b479686ea5 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,6 +1,7 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/rmap.h>
+#include <linux/efi.h>
 #include <asm/mktme.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -33,9 +34,37 @@ void mktme_disable(void)
 
 static bool need_page_mktme(void)
 {
+	int nid;
+
 	/* Make sure keyid doesn't collide with extended page flags */
 	BUILD_BUG_ON(__NR_PAGE_EXT_FLAGS > 16);
 
+	for_each_node_state(nid, N_MEMORY) {
+		const efi_memory_desc_t *md;
+		unsigned long node_start, node_end;
+
+		node_start = node_start_pfn(nid) << PAGE_SHIFT;
+		node_end = node_end_pfn(nid) << PAGE_SHIFT;
+
+		for_each_efi_memory_desc(md) {
+			u64 efi_start = md->phys_addr;
+			u64 efi_end = md->phys_addr + PAGE_SIZE * md->num_pages;
+
+			if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+				continue;
+			if (efi_start > node_end)
+				continue;
+			if (efi_end  < node_start)
+				continue;
+
+			printk("Memory range %#llx-%#llx: doesn't support encryption\n",
+					efi_start, efi_end);
+			printk("Disable MKTME\n");
+			mktme_disable();
+			break;
+		}
+	}
+
 	return !!mktme_nr_keyids;
 }
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..239b2edc78d3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -848,25 +848,26 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
-		     EFI_MEMORY_NV |
+		     EFI_MEMORY_NV | EFI_MEMORY_CPU_CRYPTO |
 		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
-			 attr & EFI_MEMORY_NV      ? "NV"  : "",
-			 attr & EFI_MEMORY_XP      ? "XP"  : "",
-			 attr & EFI_MEMORY_RP      ? "RP"  : "",
-			 attr & EFI_MEMORY_WP      ? "WP"  : "",
-			 attr & EFI_MEMORY_RO      ? "RO"  : "",
-			 attr & EFI_MEMORY_UCE     ? "UCE" : "",
-			 attr & EFI_MEMORY_WB      ? "WB"  : "",
-			 attr & EFI_MEMORY_WT      ? "WT"  : "",
-			 attr & EFI_MEMORY_WC      ? "WC"  : "",
-			 attr & EFI_MEMORY_UC      ? "UC"  : "");
+			 attr & EFI_MEMORY_NV         ? "NV"  : "",
+			 attr & EFI_MEMORY_CPU_CRYPTO ? "CR"  : "",
+			 attr & EFI_MEMORY_XP         ? "XP"  : "",
+			 attr & EFI_MEMORY_RP         ? "RP"  : "",
+			 attr & EFI_MEMORY_WP         ? "WP"  : "",
+			 attr & EFI_MEMORY_RO         ? "RO"  : "",
+			 attr & EFI_MEMORY_UCE        ? "UCE" : "",
+			 attr & EFI_MEMORY_WB         ? "WB"  : "",
+			 attr & EFI_MEMORY_WT         ? "WT"  : "",
+			 attr & EFI_MEMORY_WC         ? "WC"  : "",
+			 attr & EFI_MEMORY_UC         ? "UC"  : "");
 	return buf;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6ebc2098cfe1..4b2d0b1a75dc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -112,6 +112,7 @@ typedef	struct {
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
+#define EFI_MEMORY_CPU_CRYPTO 	((u64)0x0000000000080000ULL)	/* memory encryption supported */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
-- 
2.20.1
