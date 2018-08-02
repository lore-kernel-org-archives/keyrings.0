From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 02 Aug 2018 18:31:10 +0000
Subject: [RFCv3 02/13] KEYS: asym_tpm: add skeleton for asym_tpm
Message-Id: <20180802183121.22909-3-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This patch adds the basic skeleton for the asym_tpm asymmetric key
subtype.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/Kconfig    | 11 +++++
 crypto/asymmetric_keys/Makefile   |  1 +
 crypto/asymmetric_keys/asym_tpm.c | 94 +++++++++++++++++++++++++++++++++++++++
 include/crypto/asym_tpm_subtype.h | 16 +++++++
 4 files changed, 122 insertions(+)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 include/crypto/asym_tpm_subtype.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 66a7dad7ed3d..b75555c7d8ae 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -21,6 +21,17 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM_KEY_SUBTYPE
+	tristate "Asymmetric TPM backed private key subtype"
+	depends on TCG_TPM
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
+	select CRYPTO_HASH_INFO
+	help
+	  This option provides support for TPM backed private key type handling.
+	  Operations such as sign, verify, encrypt, decrypt are performed by
+	  the TPM after the private key is loaded.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index c38424f55b08..73fbe650ff1d 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE) += asym_tpm.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
new file mode 100644
index 000000000000..f98335068a3b
--- /dev/null
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "ASYM-TPM: "fmt
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/scatterlist.h>
+#include <linux/tpm.h>
+#include <keys/asymmetric-subtype.h>
+#include <crypto/asym_tpm_subtype.h>
+
+/*
+ * Provide a part of a description of the key for /proc/keys.
+ */
+static void asym_tpm_describe(const struct key *asymmetric_key,
+			      struct seq_file *m)
+{
+	struct tpm_key *tk = asymmetric_key->payload.data[asym_crypto];
+
+	pr_info("%s: tk: %p\n", __func__, tk);
+
+	if (!tk)
+		return;
+
+	seq_printf(m, "TPM1.2/Blob");
+}
+
+static void asym_tpm_destroy(void *payload0, void *payload3)
+{
+	struct tpm_key *tk = payload0;
+
+	pr_info("%s: %p\n", __func__, tk);
+
+	if (!tk)
+		return;
+
+	kfree(tk->blob);
+	tk->blob_len = 0;
+
+	kfree(tk);
+}
+
+/* Given the blob, parse it and load it into the TPM */
+struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
+{
+	int r;
+	struct tpm_key *tk;
+
+	r = tpm_is_tpm2(NULL);
+	if (r < 0)
+		goto error;
+
+	/* We don't support TPM2 yet */
+	if (r > 0) {
+		r = -ENODEV;
+		goto error;
+	}
+
+	r = -ENOMEM;
+	tk = kzalloc(sizeof(struct tpm_key), GFP_KERNEL);
+	if (!tk)
+		goto error;
+
+	tk->blob = kmemdup(blob, blob_len, GFP_KERNEL);
+	if (!tk->blob)
+		goto error_memdup;
+
+	tk->blob_len = blob_len;
+
+	return tk;
+
+error_memdup:
+	kfree(tk);
+error:
+	return ERR_PTR(r);
+}
+EXPORT_SYMBOL_GPL(tpm_key_create);
+
+/*
+ * TPM-based asymmetric key subtype
+ */
+struct asymmetric_key_subtype asym_tpm_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "asym_tpm",
+	.name_len		= sizeof("asym_tpm") - 1,
+	.describe		= asym_tpm_describe,
+	.destroy		= asym_tpm_destroy,
+};
+EXPORT_SYMBOL_GPL(asym_tpm_subtype);
+
+MODULE_DESCRIPTION("TPM based asymmetric key subtype");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
new file mode 100644
index 000000000000..03550b850998
--- /dev/null
+++ b/include/crypto/asym_tpm_subtype.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_ASYM_TPM_SUBTYPE_H
+#define _LINUX_ASYM_TPM_SUBTYPE_H
+
+#include <linux/keyctl.h>
+
+struct tpm_key {
+	void *blob;
+	u32 blob_len;
+};
+
+struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len);
+
+extern struct asymmetric_key_subtype asym_tpm_subtype;
+
+#endif /* _LINUX_ASYM_TPM_SUBTYPE_H */
-- 
2.16.1

