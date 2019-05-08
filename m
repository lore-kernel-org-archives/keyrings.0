From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:14 +0000
Subject: [PATCH, RFC 54/62] x86/mm: Disable MKTME on incompatible platform configurations
Message-Id: <20190508144422.13171-55-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Icelake Server requires additional check to make sure that MKTME usage
is safe on Linux.

Kernel needs a way to access encrypted memory. There can be different
approaches to this: create a temporary mapping to access the page (using
kmap() interface), modify kernel's direct mapping on allocation of
encrypted page.

In order to minimize runtime overhead, the Linux MKTME implementation
uses multiple direct mappings, one per-KeyID. Kernel uses the direct
mapping that is relevant for the page at the moment.

Icelake Server in some configurations doesn't allow a page to be mapped
with multiple KeyIDs at the same time. Even if only one of KeyIDs is
actively used. It conflicts with the Linux MKTME implementation.

OS can check if it's safe to map the same with multiple KeyIDs by
examining bit 8 of MSR 0x6F. If the bit is set we cannot safely use
MKTME on Linux.

The user can disable the Directory Mode in BIOS setup to get the
platform into Linux-compatible mode.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h |  2 ++
 arch/x86/kernel/cpu/intel.c         | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..6a633af144aa 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -53,6 +53,8 @@
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_X		0x6A
+#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
 
 /* "Small Core" Processors (Atom) */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f402a74c00a1..3fc318f699d3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -531,6 +532,16 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
+#define MSR_ICX_MKTME_STATUS		0x6F
+#define MKTME_ALIASES_FORBIDDEN(x)	(x & BIT(8))
+
+/* Need to check MSR_ICX_MKTME_STATUS for these CPUs */
+static const struct x86_cpu_id mktme_status_msr_ids[] = {
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ICELAKE_X		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ICELAKE_XEON_D	},
+	{}
+};
+
 /* Values for mktme_status (SW only construct) */
 #define MKTME_ENABLED			0
 #define MKTME_DISABLED			1
@@ -564,6 +575,17 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		return;
 	}
 
+	/* Icelake Server quirk: do not enable MKTME if aliases are forbidden */
+	if (x86_match_cpu(mktme_status_msr_ids)) {
+		u64 mktme_status;
+		rdmsrl(MSR_ICX_MKTME_STATUS, mktme_status);
+
+		if (MKTME_ALIASES_FORBIDDEN(mktme_status)) {
+			pr_err_once("x86/tme: Directory Mode is enabled in BIOS\n");
+			mktme_status = MKTME_DISABLED;
+		}
+	}
+
 	if (mktme_status != MKTME_UNINITIALIZED)
 		goto detect_keyid_bits;
 
-- 
2.20.1
