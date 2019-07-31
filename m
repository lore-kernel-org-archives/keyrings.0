From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:50 +0000
Subject: [PATCHv2 36/59] keys/mktme: Require ACPI HMAT to register the MKTME Key Service
Message-Id: <20190731150813.26289-37-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
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
index 2d90cc83e5ce..6265b62801e9 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -2,6 +2,7 @@
 
 /* Documentation/x86/mktme/ */
 
+#include <linux/acpi.h>
 #include <linux/cred.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -445,6 +446,12 @@ static int __init init_mktme(void)
 
 	mktme_available_keyids = mktme_nr_keyids();
 
+	/* Require an ACPI HMAT to identify MKTME safe topologies */
+	if (!acpi_hmat_present()) {
+		pr_warn("MKTME: Registration failed. ACPI HMAT not present.\n");
+		return -EINVAL;
+	}
+
 	/* Mapping of Userspace Keys to Hardware KeyIDs */
 	mktme_map = kvzalloc((sizeof(*mktme_map) * (mktme_nr_keyids() + 1)),
 			     GFP_KERNEL);
-- 
2.21.0
