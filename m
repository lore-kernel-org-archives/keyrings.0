From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:55 +0000
Subject: [PATCH, RFC 35/62] keys/mktme: Require ACPI HMAT to register the MKTME Key Service
Message-Id: <20190508144422.13171-36-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

The ACPI HMAT will be used by the MKTME key service to identify
topologies that support the safe programming of encryption keys.
Those decisions will happen at key creation time and during
hotplug events.

To enable this, we at least need to have the ACPI HMAT present
at init time. If it's not present, do not register the type.

If the HMAT is not present, failure looks like this:
[ ] MKTME: Registration failed. ACPI HMAT not present.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index bcd68850048f..f5fc6cccc81b 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -2,6 +2,7 @@
 
 /* Documentation/x86/mktme_keys.rst */
 
+#include <linux/acpi.h>
 #include <linux/cred.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -490,6 +491,12 @@ static int __init init_mktme(void)
 	if (mktme_nr_keyids < 1)
 		return 0;
 
+	/* Require an ACPI HMAT to identify MKTME safe topologies */
+	if (!acpi_hmat_present()) {
+		pr_warn("MKTME: Registration failed. ACPI HMAT not present.\n");
+		return -EINVAL;
+	}
+
 	/* Mapping of Userspace Keys to Hardware KeyIDs */
 	if (mktme_map_alloc())
 		return -ENOMEM;
-- 
2.20.1
