From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 28 Feb 2018 16:52:30 +0000
Subject: [RFC PATCH 5/5] KEYS: add KPP ecdh parser
Message-Id: <20180228165230.18729-6-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-1-tudor.ambarus@microchip.com>
To: dhowells@redhat.com, keyrings@vger.kernel.org

The ECDH private keys are expected to be encoded with the ecdh
helpers from kernel.

Use the ecdh helpers to check if the key is valid. If valid,
allocate a tfm and set the private key. There is a one-to-one
binding between the private key and the tfm. The tfm is allocated
once and used as many times as needed.

ECDH keys can be loaded like this:
    # echo -n 020028000200200024d121ebe5cf2d83f6621b6e43843aa38be086c32019da92505303e1c0eab882 \
        | xxd -r -p | keyctl padd asymmetric private @s

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/asymmetric_keys/Kconfig      |   8 +++
 crypto/asymmetric_keys/Makefile     |   5 ++
 crypto/asymmetric_keys/kpp_parser.c | 124 ++++++++++++++++++++++++++++++++++++
 include/crypto/asym_kpp_subtype.h   |   2 +
 4 files changed, 139 insertions(+)
 create mode 100644 crypto/asymmetric_keys/kpp_parser.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1884570..e46a185 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -57,6 +57,14 @@ config PKCS7_MESSAGE_PARSER
 	  This option provides support for parsing PKCS#7 format messages for
 	  signature data and provides the ability to verify the signature.
 
+config KPP_KEY_PARSER
+	tristate "KPP private key parser"
+	depends on ASYMMETRIC_KPP_SUBTYPE
+	help
+	  This option provides support for parsing KPP format blobs for
+	  private key data and provides the ability to instantiate a crypto key
+	  from that data.
+
 config PKCS7_TEST_KEY
 	tristate "PKCS#7 testing key type"
 	depends on SYSTEM_DATA_VERIFICATION
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index d884cf1..e709aee 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -62,6 +62,11 @@ $(obj)/pkcs7-asn1.o: $(obj)/pkcs7-asn1.c $(obj)/pkcs7-asn1.h
 clean-files	+= pkcs7-asn1.c pkcs7-asn1.h
 
 #
+# KPP private key handling
+#
+obj-$(CONFIG_KPP_KEY_PARSER) += kpp_parser.o
+
+#
 # PKCS#7 parser testing key
 #
 obj-$(CONFIG_PKCS7_TEST_KEY) += pkcs7_test_key.o
diff --git a/crypto/asymmetric_keys/kpp_parser.c b/crypto/asymmetric_keys/kpp_parser.c
new file mode 100644
index 0000000..a38da7b
--- /dev/null
+++ b/crypto/asymmetric_keys/kpp_parser.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "KPP-PARSER: "fmt
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/asym_kpp_subtype.h>
+#include <crypto/ecdh.h>
+#include <crypto/kpp.h>
+
+static int decode_kpp_ecdh_key(struct asym_kpp_ctx *ctx,
+			       const void *data, size_t datalen)
+{
+	struct ecdh params;
+	int ret;
+
+	/* check if the key is valid */
+	ret = crypto_ecdh_decode_key(data, datalen, &params);
+	if (ret)
+		return ret;
+
+	ctx->alg_name = "ecdh";
+	return ret;
+}
+
+static int decode_kpp_key(struct asym_kpp_ctx *ctx,
+			  const void *data, size_t datalen)
+{
+	if (decode_kpp_ecdh_key(ctx, data, datalen))
+		return -EBADMSG;
+	return 0;
+}
+
+static int kpp_parser_setkey(struct asym_kpp_ctx *ctx,
+			     const void *data, size_t datalen)
+{
+	struct crypto_kpp *tfm;
+	int ret;
+
+	tfm = crypto_alloc_kpp(ctx->alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = crypto_kpp_set_secret(tfm, data, datalen);
+	if (ret) {
+		crypto_free_kpp(tfm);
+		return ret;
+	}
+
+	ctx->tfm = tfm;
+	return ret;
+}
+
+static struct asym_kpp_ctx *kpp_parse(const void *data, size_t datalen)
+{
+	struct asym_kpp_ctx *ctx;
+	long ret;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = decode_kpp_key(ctx, data, datalen);
+	if (ret)
+		goto free_ctx;
+
+	ret = kpp_parser_setkey(ctx, data, datalen);
+	if (ret)
+		goto free_ctx;
+
+	return ctx;
+
+free_ctx:
+	kfree(ctx);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Attempt to parse a data blob for a key as a KPP private key.
+ */
+static int kpp_key_preparse(struct key_preparsed_payload *prep)
+{
+	struct asym_kpp_ctx *ctx;
+
+	ctx = kpp_parse(prep->data, prep->datalen);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	pr_devel("Algorithm name: %s\n", ctx->alg_name);
+
+	/* We're pinning the module by being linked against it */
+	__module_get(asym_kpp_subtype.owner);
+	prep->payload.data[asym_subtype] = &asym_kpp_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = ctx;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser kpp_key_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "kpp_parser",
+	.parse	= kpp_key_preparse,
+};
+
+static int __init kpp_key_init(void)
+{
+	return register_asymmetric_key_parser(&kpp_key_parser);
+}
+
+static void __exit kpp_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&kpp_key_parser);
+}
+
+module_init(kpp_key_init);
+module_exit(kpp_key_exit);
+
+MODULE_DESCRIPTION("KPP key parser");
+MODULE_LICENSE("GPL v2");
diff --git a/include/crypto/asym_kpp_subtype.h b/include/crypto/asym_kpp_subtype.h
index abb7569..849c411 100644
--- a/include/crypto/asym_kpp_subtype.h
+++ b/include/crypto/asym_kpp_subtype.h
@@ -9,4 +9,6 @@ struct asym_kpp_ctx {
 	const char *alg_name;
 };
 
+extern struct asymmetric_key_subtype asym_kpp_subtype;
+
 #endif /* _LINUX_ASYM_KPP_SUBTYPE_H */
-- 
2.9.4

