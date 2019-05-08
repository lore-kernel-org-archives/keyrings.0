From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:36 +0000
Subject: [PATCH, RFC 16/62] x86/mm: Allow to disable MKTME after enumeration
Message-Id: <20190508144422.13171-17-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
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
index 6e604126f0bc..454d6d7c791d 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -18,6 +18,8 @@ static inline bool mktme_enabled(void)
 	return static_branch_unlikely(&mktme_enabled_key);
 }
 
+void mktme_disable(void);
+
 extern struct page_ext_operations page_mktme_ops;
 
 #define page_keyid page_keyid
@@ -68,6 +70,9 @@ static inline bool mktme_enabled(void)
 {
 	return false;
 }
+
+static inline void mktme_disable(void) {}
+
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4c9fadb57a13..f402a74c00a1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -618,10 +618,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * We must not allow onlining secondary CPUs with non-matching
 		 * configuration.
 		 */
-		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
-		mktme_keyid_mask = 0;
-		mktme_keyid_shift = 0;
-		mktme_nr_keyids = 0;
+		mktme_disable();
 	}
 #endif
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 43489c098e60..9221c894e8e9 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -15,6 +15,16 @@ int mktme_keyid_shift;
 DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
 EXPORT_SYMBOL_GPL(mktme_enabled_key);
 
+void mktme_disable(void)
+{
+	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	mktme_keyid_mask = 0;
+	mktme_keyid_shift = 0;
+	mktme_nr_keyids = 0;
+	if (mktme_enabled())
+		static_branch_disable(&mktme_enabled_key);
+}
+
 static bool need_page_mktme(void)
 {
 	/* Make sure keyid doesn't collide with extended page flags */
-- 
2.20.1
