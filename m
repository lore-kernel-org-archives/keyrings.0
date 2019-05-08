From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:42 +0000
Subject: [PATCH, RFC 22/62] x86/pconfig: Set a valid encryption algorithm for all MKTME commands
Message-Id: <20190508144422.13171-23-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

The Intel MKTME architecture specification requires a valid encryption
algorithm for all command types.

For commands that actually perform encryption, SET_KEY_DIRECT and
SET_KEY_RANDOM, the user specifies the algorithm when requesting the
key through the MKTME Key Service.

For CLEAR_KEY and NO_ENCRYPT commands, a valid encryption algorithm is
also required by the MKTME hardware. However, it does not make sense to
ask userspace to specify one. Define the CLEAR_KEY and NO_ENCRYPT type
commands to always include a valid encryption algorithm.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/intel_pconfig.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
index 3cb002b1d0f9..15705699a14e 100644
--- a/arch/x86/include/asm/intel_pconfig.h
+++ b/arch/x86/include/asm/intel_pconfig.h
@@ -21,14 +21,20 @@ enum pconfig_leaf {
 
 /* Defines and structure for MKTME_KEY_PROGRAM of PCONFIG instruction */
 
+/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
+#define MKTME_AES_XTS_128	(1 << 8)
+#define MKTME_ANY_VALID_ALG	(1 << 8)
+
 /* mktme_key_program::keyid_ctrl COMMAND, bits [7:0] */
 #define MKTME_KEYID_SET_KEY_DIRECT	0
 #define MKTME_KEYID_SET_KEY_RANDOM	1
-#define MKTME_KEYID_CLEAR_KEY		2
-#define MKTME_KEYID_NO_ENCRYPT		3
 
-/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
-#define MKTME_AES_XTS_128	(1 << 8)
+/*
+ * CLEAR_KEY and NO_ENCRYPT require the COMMAND in bits [7:0]
+ * and any valid encryption algorithm, ENC_ALG, in bits [23:8]
+ */
+#define MKTME_KEYID_CLEAR_KEY  (2 | MKTME_ANY_VALID_ALG)
+#define MKTME_KEYID_NO_ENCRYPT (3 | MKTME_ANY_VALID_ALG)
 
 /* Return codes from the PCONFIG MKTME_KEY_PROGRAM */
 #define MKTME_PROG_SUCCESS	0
-- 
2.20.1
