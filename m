From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 18 Nov 2019 22:38:15 +0000
Subject: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
Message-Id: <20191118223818.3353-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
In-Reply-To: <20191118223818.3353-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Measure asymmetric keys used for verifying file signatures,
certificates, etc.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

The IMA hook is defined in a new file namely ima_asymmetric_keys.c
which is built only if CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is enabled.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: James Morris <jamorris@linux.microsoft.com>
---
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima_asymmetric_keys.c | 51 ++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..207a0a9eb72c 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..f6884641a622
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_asymmetric_keys.c
+ *       Defines an IMA hook to measure asymmetric keys on key
+ *       create or update.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	/* Only asymmetric keys are handled by this hook. */
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	/* Get the public_key of the given asymmetric key to measure. */
+	pk = key->payload.data[asym_crypto];
+
+	/*
+	 * keyring->description points to the name of the keyring
+	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
+	 * which the given key is linked to.
+	 *
+	 * The name of the keyring is passed in the "eventname"
+	 * parameter to process_buffer_measurement() and is set
+	 * in the "eventname" field in ima_event_data for
+	 * the key measurement IMA event.
+	 */
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description, KEY_CHECK, 0);
+}
-- 
2.17.1
