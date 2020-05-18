From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:27:02 +0000
Subject: [PATCH 15/17] include: crypto: add asym_tpm2_subtype definition
Message-Id: <20200518172704.29608-16-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, James Prestwood <prestwoj@gmail.com>

This defines the structure of a TPM2 key in the kernel.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/crypto/asym_tpm2_subtype.h | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/crypto/asym_tpm2_subtype.h

diff --git a/include/crypto/asym_tpm2_subtype.h b/include/crypto/asym_tpm2_subtype.h
new file mode 100644
index 000000000000..dea80b2e6e66
--- /dev/null
+++ b/include/crypto/asym_tpm2_subtype.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ASYM_TPM2_SUBTYPE_H
+#define _LINUX_ASYM_TPM2_SUBTYPE_H
+
+#include <linux/keyctl.h>
+
+struct tpm2_parse_context {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+};
+
+struct tpm2_key {
+	struct tpm_chip *chip;
+	u32 parent;
+
+	u8 *blob;
+	u32 bloblen;
+
+	/* pointer into 'blob' where public key begins */
+	const u8 *pub;
+	u32 pub_len;
+
+};
+
+struct tpm2_key *tpm2_key_create(struct tpm2_parse_context *ctx);
+
+extern struct asymmetric_key_subtype asym_tpm2_subtype;
+
+#endif /* _LINUX_ASYM_TPM2_SUBTYPE_H */
-- 
2.21.1
