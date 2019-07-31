From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:31 +0000
Subject: [PATCHv2 17/59] x86/mm: Allow to disable MKTME after enumeration
Message-Id: <20190731150813.26289-18-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The new helper mktme_disable() allows to disable MKTME even if it's
enumerated successfully. MKTME initialization may fail and this
functionality allows system to boot regardless of the failure.

MKTME needs per-KeyID direct mapping. It requires a lot more virtual
address space which may be a problem in 4-level paging mode. If the
system has more physical memory than we can handle with MKTME the
feature allows to fail MKTME, but boot the system successfully.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  5 +++++
 arch/x86/kernel/cpu/intel.c  |  5 +----
 arch/x86/mm/mktme.c          | 10 ++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index a61b45fca4b1..3fc246acc279 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -22,6 +22,8 @@ static inline bool mktme_enabled(void)
 	return static_branch_unlikely(&mktme_enabled_key);
 }
 
+void mktme_disable(void);
+
 extern struct page_ext_operations page_mktme_ops;
 
 #define page_keyid page_keyid
@@ -71,6 +73,9 @@ static inline bool mktme_enabled(void)
 {
 	return false;
 }
+
+static inline void mktme_disable(void) {}
+
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4c2d70287eb4..9852580340b9 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -650,10 +650,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * We must not allow onlining secondary CPUs with non-matching
 		 * configuration.
 		 */
-		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
-		__mktme_keyid_mask = 0;
-		__mktme_keyid_shift = 0;
-		__mktme_nr_keyids = 0;
+		mktme_disable();
 	}
 #endif
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 8015e7822c9b..1e8d662e5bff 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -33,6 +33,16 @@ unsigned int mktme_algs;
 DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
 EXPORT_SYMBOL_GPL(mktme_enabled_key);
 
+void mktme_disable(void)
+{
+	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	__mktme_keyid_mask = 0;
+	__mktme_keyid_shift = 0;
+	__mktme_nr_keyids = 0;
+	if (mktme_enabled())
+		static_branch_disable(&mktme_enabled_key);
+}
+
 static bool need_page_mktme(void)
 {
 	/* Make sure keyid doesn't collide with extended page flags */
-- 
2.21.0
