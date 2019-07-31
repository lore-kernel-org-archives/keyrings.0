From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:39 +0000
Subject: [PATCHv2 25/59] keys/mktme: Preparse the MKTME key payload
Message-Id: <20190731150813.26289-26-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

It is a requirement of the Kernel Keys subsystem to provide a
preparse method that validates payloads before key instantiate
methods are called.

Verify that userspace provides valid MKTME options and prepare
the payload for use at key instantiate time.

Create a method to free the preparsed payload. The Kernel Key
subsystem will that to clean up after the key is instantiated.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/keys/mktme-type.h  |  31 +++++++++
 security/keys/mktme_keys.c | 134 +++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 include/keys/mktme-type.h

diff --git a/include/keys/mktme-type.h b/include/keys/mktme-type.h
new file mode 100644
index 000000000000..9dad92f17179
--- /dev/null
+++ b/include/keys/mktme-type.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Key service for Multi-KEY Total Memory Encryption */
+
+#ifndef _KEYS_MKTME_TYPE_H
+#define _KEYS_MKTME_TYPE_H
+
+#include <linux/key.h>
+
+enum mktme_alg {
+	MKTME_ALG_AES_XTS_128,
+};
+
+const char *const mktme_alg_names[] = {
+	[MKTME_ALG_AES_XTS_128]	= "aes-xts-128",
+};
+
+enum mktme_type {
+	MKTME_TYPE_ERROR = -1,
+	MKTME_TYPE_CPU,
+	MKTME_TYPE_NO_ENCRYPT,
+};
+
+const char *const mktme_type_names[] = {
+	[MKTME_TYPE_CPU]	= "cpu",
+	[MKTME_TYPE_NO_ENCRYPT]	= "no-encrypt",
+};
+
+extern struct key_type key_type_mktme;
+
+#endif /* _KEYS_MKTME_TYPE_H */
diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index d262e0f348e4..fe119a155235 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -6,6 +6,10 @@
 #include <linux/key.h>
 #include <linux/key-type.h>
 #include <linux/mm.h>
+#include <linux/parser.h>
+#include <linux/string.h>
+#include <asm/intel_pconfig.h>
+#include <keys/mktme-type.h>
 #include <keys/user-type.h>
 
 #include "internal.h"
@@ -27,8 +31,138 @@ struct mktme_mapping {
 
 static struct mktme_mapping *mktme_map;
 
+enum mktme_opt_id {
+	OPT_ERROR,
+	OPT_TYPE,
+	OPT_ALGORITHM,
+};
+
+static const match_table_t mktme_token = {
+	{OPT_TYPE, "type=%s"},
+	{OPT_ALGORITHM, "algorithm=%s"},
+	{OPT_ERROR, NULL}
+};
+
+/* Make sure arguments are correct for the TYPE of key requested */
+static int mktme_check_options(u32 *payload, unsigned long token_mask,
+			       enum mktme_type type, enum mktme_alg alg)
+{
+	if (!token_mask)
+		return -EINVAL;
+
+	switch (type) {
+	case MKTME_TYPE_CPU:
+		if (test_bit(OPT_ALGORITHM, &token_mask))
+			*payload |= (1 << alg) << 8;
+		else
+			return -EINVAL;
+
+		*payload |= MKTME_KEYID_SET_KEY_RANDOM;
+		break;
+
+	case MKTME_TYPE_NO_ENCRYPT:
+		*payload |= MKTME_KEYID_NO_ENCRYPT;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Parse the options and store the key programming data in the payload. */
+static int mktme_get_options(char *options, u32 *payload)
+{
+	enum mktme_alg alg = MKTME_ALG_AES_XTS_128;
+	enum mktme_type type = MKTME_TYPE_ERROR;
+	substring_t args[MAX_OPT_ARGS];
+	unsigned long token_mask = 0;
+	char *p = options;
+	int token;
+
+	while ((p = strsep(&options, " \t"))) {
+		if (*p = '\0' || *p = ' ' || *p = '\t')
+			continue;
+		token = match_token(p, mktme_token, args);
+		if (token = OPT_ERROR)
+			return -EINVAL;
+		if (test_and_set_bit(token, &token_mask))
+			return -EINVAL;
+
+		switch (token) {
+		case OPT_TYPE:
+			type = match_string(mktme_type_names,
+					    ARRAY_SIZE(mktme_type_names),
+					    args[0].from);
+			if (type < 0)
+				return -EINVAL;
+			break;
+
+		case OPT_ALGORITHM:
+			/* Algorithm must be generally supported */
+			alg = match_string(mktme_alg_names,
+					   ARRAY_SIZE(mktme_alg_names),
+					   args[0].from);
+			if (alg < 0)
+				return -EINVAL;
+
+			/* Algorithm must be activated on this platform */
+			if (!(mktme_algs & (1 << alg)))
+				return -EINVAL;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+	return mktme_check_options(payload, token_mask, type, alg);
+}
+
+void mktme_free_preparsed_payload(struct key_preparsed_payload *prep)
+{
+	kzfree(prep->payload.data[0]);
+}
+
+/*
+ * Key Service Method to preparse a payload before a key is created.
+ * Check permissions and the options. Load the proposed key field
+ * data into the payload for use by the instantiate method.
+ */
+int mktme_preparse_payload(struct key_preparsed_payload *prep)
+{
+	size_t datalen = prep->datalen;
+	u32 *mktme_payload;
+	char *options;
+	int ret;
+
+	if (datalen <= 0 || datalen > 1024 || !prep->data)
+		return -EINVAL;
+
+	options = kmemdup_nul(prep->data, datalen, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	mktme_payload = kzalloc(sizeof(*mktme_payload), GFP_KERNEL);
+	if (!mktme_payload) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = mktme_get_options(options, mktme_payload);
+	if (ret < 0) {
+		kzfree(mktme_payload);
+		goto out;
+	}
+	prep->quotalen = sizeof(mktme_payload);
+	prep->payload.data[0] = mktme_payload;
+out:
+	kzfree(options);
+	return ret;
+}
+
 struct key_type key_type_mktme = {
 	.name		= "mktme",
+	.preparse	= mktme_preparse_payload,
+	.free_preparse	= mktme_free_preparsed_payload,
 	.describe	= user_describe,
 };
 
-- 
2.21.0
