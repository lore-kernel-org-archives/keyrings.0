From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:47 +0000
Subject: [PATCHv2 33/59] keys/mktme: Require CAP_SYS_RESOURCE capability for MKTME keys
Message-Id: <20190731150813.26289-34-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

The MKTME key type uses capabilities to restrict the allocation
of keys to privileged users. CAP_SYS_RESOURCE is required, but
the broader capability of CAP_SYS_ADMIN is accepted.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 1e2afcce7d85..2d90cc83e5ce 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -2,6 +2,7 @@
 
 /* Documentation/x86/mktme/ */
 
+#include <linux/cred.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/key.h>
@@ -371,6 +372,9 @@ int mktme_preparse_payload(struct key_preparsed_payload *prep)
 	char *options;
 	int ret;
 
+	if (!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	if (datalen <= 0 || datalen > 1024 || !prep->data)
 		return -EINVAL;
 
-- 
2.21.0
