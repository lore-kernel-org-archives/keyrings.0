From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:09 +0000
Subject: [PATCH, RFC 49/62] mm, x86: export several MKTME variables
Message-Id: <20190508144422.13171-50-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Kai Huang <kai.huang@linux.intel.com>

KVM needs those variables to get/set memory encryption mask.

Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/mktme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index df70651816a1..12f4266cf7ea 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -7,13 +7,16 @@
 
 /* Mask to extract KeyID from physical address. */
 phys_addr_t mktme_keyid_mask;
+EXPORT_SYMBOL_GPL(mktme_keyid_mask);
 /*
  * Number of KeyIDs available for MKTME.
  * Excludes KeyID-0 which used by TME. MKTME KeyIDs start from 1.
  */
 int mktme_nr_keyids;
+EXPORT_SYMBOL_GPL(mktme_nr_keyids);
 /* Shift of KeyID within physical address. */
 int mktme_keyid_shift;
+EXPORT_SYMBOL_GPL(mktme_keyid_shift);
 
 DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
 EXPORT_SYMBOL_GPL(mktme_enabled_key);
-- 
2.20.1
