From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:43 +0000
Subject: [PATCH, RFC 23/62] keys/mktme: Introduce a Kernel Key Service for MKTME
Message-Id: <20190508144422.13171-24-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

MKTME (Multi-Key Total Memory Encryption) is a technology that allows
transparent memory encryption in upcoming Intel platforms. MKTME will
support multiple encryption domains, each having their own key.

The MKTME key service will manage the hardware encryption keys. It
will map Userspace Keys to Hardware KeyIDs and program the hardware
with the user requested encryption options.

Here the mapping structure and associated helpers are introduced,
as well as the key service initialization and registration.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/Makefile     |  1 +
 security/keys/mktme_keys.c | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 security/keys/mktme_keys.c

diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef54064f60..28799be801a9 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 obj-$(CONFIG_BIG_KEYS) += big_key.o
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
+obj-$(CONFIG_X86_INTEL_MKTME) += mktme_keys.o
diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
new file mode 100644
index 000000000000..b5e8289f041b
--- /dev/null
+++ b/security/keys/mktme_keys.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-3.0
+
+/* Documentation/x86/mktme_keys.rst */
+
+#include <linux/init.h>
+#include <linux/key.h>
+#include <linux/key-type.h>
+#include <linux/mm.h>
+#include <keys/user-type.h>
+
+#include "internal.h"
+
+/* 1:1 Mapping between Userspace Keys (struct key) and Hardware KeyIDs */
+struct mktme_mapping {
+	unsigned int	mapped_keyids;
+	struct key	*key[];
+};
+
+struct mktme_mapping *mktme_map;
+
+static inline long mktme_map_size(void)
+{
+	long size = 0;
+
+	size += sizeof(*mktme_map);
+	size += sizeof(mktme_map->key[0]) * (mktme_nr_keyids + 1);
+	return size;
+}
+
+int mktme_map_alloc(void)
+{
+	mktme_map = kvzalloc(mktme_map_size(), GFP_KERNEL);
+	if (!mktme_map)
+		return -ENOMEM;
+	return 0;
+}
+
+int mktme_reserve_keyid(struct key *key)
+{
+	int i;
+
+	if (mktme_map->mapped_keyids = mktme_nr_keyids)
+		return 0;
+
+	for (i = 1; i <= mktme_nr_keyids; i++) {
+		if (mktme_map->key[i] = 0) {
+			mktme_map->key[i] = key;
+			mktme_map->mapped_keyids++;
+			return i;
+		}
+	}
+	return 0;
+}
+
+void mktme_release_keyid(int keyid)
+{
+	mktme_map->key[keyid] = 0;
+	mktme_map->mapped_keyids--;
+}
+
+int mktme_keyid_from_key(struct key *key)
+{
+	int i;
+
+	for (i = 1; i <= mktme_nr_keyids; i++) {
+		if (mktme_map->key[i] = key)
+			return i;
+	}
+	return 0;
+}
+
+struct key_type key_type_mktme = {
+	.name		= "mktme",
+	.describe	= user_describe,
+};
+
+static int __init init_mktme(void)
+{
+	int ret;
+
+	/* Verify keys are present */
+	if (mktme_nr_keyids < 1)
+		return 0;
+
+	/* Mapping of Userspace Keys to Hardware KeyIDs */
+	if (mktme_map_alloc())
+		return -ENOMEM;
+
+	ret = register_key_type(&key_type_mktme);
+	if (!ret)
+		return ret;			/* SUCCESS */
+
+	kvfree(mktme_map);
+
+	return -ENOMEM;
+}
+
+late_initcall(init_mktme);
-- 
2.20.1
