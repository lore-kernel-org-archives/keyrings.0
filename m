From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:35 +0000
Subject: [PATCH, RFC 15/62] x86/mm: Rename CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING
Message-Id: <20190508144422.13171-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Rename the option to CONFIG_MEMORY_PHYSICAL_PADDING. It will be used
not only for KASLR.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig    | 2 +-
 arch/x86/mm/kaslr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..62cfb381fee3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2201,7 +2201,7 @@ config RANDOMIZE_MEMORY
 
 	   If unsure, say Y.
 
-config RANDOMIZE_MEMORY_PHYSICAL_PADDING
+config MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
 	depends on RANDOMIZE_MEMORY
 	default "0xa" if MEMORY_HOTPLUG
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index d669c5e797e0..2228cc7d6b42 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -103,7 +103,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		CONFIG_MEMORY_PHYSICAL_PADDING;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.20.1
