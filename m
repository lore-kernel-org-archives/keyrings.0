From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 11 Nov 2019 19:32:59 +0000
Subject: [PATCH v5 06/10] IMA: Defined an IMA hook to measure keys on key create or update
Message-Id: <20191111193303.12781-7-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Asymmetric keys used for verifying file signatures or certificates
are currently not included in the IMA measurement list.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

The IMA hook is defined in a new file namely ima_asymmetric_keys.c

Note that currently IMA subsystem can be enabled without
enabling KEYS subsystem.

Adding support for measuring asymmetric keys in IMA requires KEYS
subsystem to be enabled. To handle this dependency a new config
namely CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS has been added. Enabling
this config requires the following configs to be enabled:
    CONFIG_IMA, CONFIG_KEYS, CONFIG_ASYMMETRIC_KEY_TYPE, and
    CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE.

The new file ima_asymmetric_keys.c is built only if
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled.

This config is turned off by default.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig               | 14 +++++++
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima_asymmetric_keys.c | 44 ++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 838476d780e5..c6d14884bc19 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,17 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_ASYMMETRIC_KEYS
+	bool "Enable measuring asymmetric keys on key create or update"
+	depends on IMA
+	depends on KEYS
+	depends on ASYMMETRIC_KEY_TYPE
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	default n
+	help
+	   This option enables measuring asymmetric keys when
+	   the key is created or updated. Additionally, IMA policy
+	   needs to be configured to either measure keys linked to
+	   any keyring or only measure keys linked to the keyrings
+	   specified in the IMA policy through the keyrings= option.
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..3e9d0ad68c7b 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..7d6603bfcc06
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,44 @@
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
+	/* Only asymmetric keys are handled */
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	/*
+	 * Get the public_key of the given asymmetric key to measure.
+	 */
+	pk = key->payload.data[asym_crypto];
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description,
+				   KEYRING_CHECK, 0,
+				   keyring->description);
+}
-- 
2.17.1
