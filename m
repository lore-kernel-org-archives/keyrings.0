From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:23 +0000
Subject: [PATCHv2 09/59] x86/mm: Store bitmask of the encryption algorithms supported by MKTME
Message-Id: <20190731150813.26289-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Store bitmask of the supported encryption algorithms in 'mktme_algs'.
This will be used by key management service.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 2 ++
 arch/x86/kernel/cpu/intel.c  | 6 +++++-
 arch/x86/mm/mktme.c          | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index b9ba2ea5b600..42a3b1b44669 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -10,6 +10,8 @@ extern int __mktme_keyid_shift;
 extern int mktme_keyid_shift(void);
 extern int __mktme_nr_keyids;
 extern int mktme_nr_keyids(void);
+extern unsigned int mktme_algs;
+
 #else
 #define mktme_keyid_mask()	((phys_addr_t)0)
 #define mktme_nr_keyids()	0
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 7ba44825be42..991bdcb2a55a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -553,6 +553,8 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
+#define TME_ACTIVATE_CRYPTO_KNOWN_ALGS	TME_ACTIVATE_CRYPTO_AES_XTS_128
+
 /* Values for mktme_status (SW only construct) */
 #define MKTME_ENABLED			0
 #define MKTME_DISABLED			1
@@ -596,7 +598,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
 
 	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_KNOWN_ALGS)) {
 		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
 				tme_crypto_algs);
 		mktme_status = MKTME_DISABLED;
@@ -631,6 +633,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		__mktme_keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, mktme_keyid_shift());
 		physical_mask &= ~mktme_keyid_mask();
 
+		tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+		mktme_algs = tme_crypto_algs & TME_ACTIVATE_CRYPTO_KNOWN_ALGS;
 	} else {
 		/*
 		 * Reset __PHYSICAL_MASK.
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 0f48ef2720cc..755afc6935b5 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -25,3 +25,5 @@ int mktme_nr_keyids(void)
 {
 	return __mktme_nr_keyids;
 }
+
+unsigned int mktme_algs;
-- 
2.21.0
