From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:08:07 +0000
Subject: [PATCHv2 53/59] x86: Introduce CONFIG_X86_INTEL_MKTME
Message-Id: <20190731150813.26289-54-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add new config option to enabled/disable Multi-Key Total Memory
Encryption support.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f2cc88fe8ada..d8551b612f3b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1550,6 +1550,25 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	  If set to N, then the encryption of system memory can be
 	  activated with the mem_encrypt=on command line option.
 
+config X86_INTEL_MKTME
+	bool "Intel Multi-Key Total Memory Encryption"
+	depends on X86_64 && CPU_SUP_INTEL && !KASAN
+	select X86_MEM_ENCRYPT_COMMON
+	select PAGE_EXTENSION
+	select KEYS
+	select ACPI_HMAT
+	---help---
+	  Say yes to enable support for Multi-Key Total Memory Encryption.
+	  This requires an Intel processor that has support of the feature.
+
+	  Multikey Total Memory Encryption (MKTME) is a technology that allows
+	  transparent memory encryption in upcoming Intel platforms.
+
+	  MKTME is built on top of TME. TME allows encryption of the entirety
+	  of system memory using a single key. MKTME allows having multiple
+	  encryption domains, each having own key -- different memory pages can
+	  be encrypted with different keys.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
@@ -2220,7 +2239,7 @@ config RANDOMIZE_MEMORY
 
 config MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
-	depends on RANDOMIZE_MEMORY
+	depends on RANDOMIZE_MEMORY || X86_INTEL_MKTME
 	default "0xa" if MEMORY_HOTPLUG
 	default "0x0"
 	range 0x1 0x40 if MEMORY_HOTPLUG
-- 
2.21.0
