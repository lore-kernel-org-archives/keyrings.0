From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 28 Feb 2018 16:52:29 +0000
Subject: [RFC PATCH 4/5] KEYS: add asymmetric kpp subtype
Message-Id: <20180228165230.18729-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-1-tudor.ambarus@microchip.com>
To: dhowells@redhat.com, keyrings@vger.kernel.org

Includes generation of public key and computation of shared secret.
This mostly involves offloading the calls to the crypto layer.

The crypto tfm was allocated and the private key was set when parsing
the private key. This permits us to use a single tfm whatever the
number of operation calls.

The private key, the corresponding public key, the pair's public key
and the shared secret are the same as those in crypto/testmgr.h:

    # echo -n 020028000200200024d121ebe5cf2d83f6621b6e43843aa38be086c32019da92505303e1c0eab882 \
        | xxd -r -p | keyctl padd asymmetric private @s
    # keyctl kpp_query 266205365
    max_sized
    kpp_gen_pubkey=y
    kpp_compute_ss=y
    # keyctl kpp_gen_pubkey 266205365 | xxd -p
    1a7feb5200bd3c317db670c186a6c7c43bc55f6c6f583cf5b66382773324
    a15f6aca436ff77eff023708cc405e7afd6a6a026e4187683877faa94443
    2def09df
    # echo -n ccb4da74b1473fea6c709e382dc7aab729b2470319abdd34bda82c93e1a474d96463f770202fa4e69f4a38ccc02c492fb132bbaf2261dacb6fdba9aafc7781f3 | xxd -r -p > /tmp/bpub
    # keyctl kpp_compute_ss 266205365 0 /tmp/bpub | xxd -p
    ea176f7e6e5726388bfb41ebbac86da5a872d1ffc9473daa58439f340f8c
    f3c9

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/asymmetric_keys/Kconfig    |   7 ++
 crypto/asymmetric_keys/Makefile   |   1 +
 crypto/asymmetric_keys/asym_kpp.c | 142 ++++++++++++++++++++++++++++++++++++++
 include/crypto/asym_kpp_subtype.h |  12 ++++
 4 files changed, 162 insertions(+)
 create mode 100644 crypto/asymmetric_keys/asym_kpp.c
 create mode 100644 include/crypto/asym_kpp_subtype.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 66a7dad..1884570 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -21,6 +21,13 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_KPP_SUBTYPE
+	tristate "Asymmetric Key Protocol Primitives (KPP) subtype"
+	select CRYPTO_ECDH
+	help
+	  This option provides support for KPP handling.
+	  ENOPKG will be reported if the requisite algorithm is unavailable.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index a67ad83..d884cf1 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_KPP_SUBTYPE) += asym_kpp.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/asym_kpp.c b/crypto/asymmetric_keys/asym_kpp.c
new file mode 100644
index 0000000..77e085f
--- /dev/null
+++ b/crypto/asymmetric_keys/asym_kpp.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "ASYM-KPP: "fmt
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/scatterlist.h>
+#include <keys/asymmetric-subtype.h>
+#include <crypto/asym_kpp_subtype.h>
+#include <crypto/kpp.h>
+
+/*
+ * Provide a part of a description of the key for /proc/keys.
+ */
+static void asym_kpp_describe(const struct key *asymmetric_key,
+			      struct seq_file *m)
+{
+	struct asym_kpp_ctx *ctx = asymmetric_key->payload.data[asym_crypto];
+
+	if (ctx)
+		seq_printf(m, "%s", ctx->alg_name);
+}
+
+static void free_kpp_ctx(struct asym_kpp_ctx *ctx)
+{
+	if (ctx) {
+		if (ctx->tfm)
+			crypto_free_kpp(ctx->tfm);
+		kfree(ctx);
+	}
+}
+
+static void asym_kpp_destroy(void *payload0, void *payload3)
+{
+	free_kpp_ctx(payload0);
+}
+
+/*
+ * Query information about a key.
+ */
+static int software_kpp_query(const struct kernel_kpp_params *params,
+			      struct kernel_kpp_query *res)
+{
+	struct asym_kpp_ctx *ctx = params->key->payload.data[asym_crypto];
+
+	res->max_size = crypto_kpp_maxsize(ctx->tfm);
+	res->supported_ops = KEYCTL_KPP_GEN_PUBKEY | KEYCTL_KPP_COMPUTE_SS;
+
+	pr_devel("<=%s() = %d\n", __func__, 0);
+	return 0;
+}
+
+/*
+ * Generate public key.
+ */
+static int software_kpp_gen_pubkey(struct kernel_kpp_params *params, void *out)
+{
+	struct crypto_wait cwait;
+	const struct asym_kpp_ctx *ctx = params->key->payload.data[asym_crypto];
+	struct kpp_request *req;
+	struct scatterlist out_sg;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	req = kpp_request_alloc(ctx->tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	kpp_request_set_input(req, NULL, 0);
+	sg_init_one(&out_sg, out, params->out_len);
+	kpp_request_set_output(req, &out_sg, params->out_len);
+	crypto_init_wait(&cwait);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				 CRYPTO_TFM_REQ_MAY_SLEEP,
+				 crypto_req_done, &cwait);
+
+	ret = crypto_wait_req(crypto_kpp_generate_public_key(req), &cwait);
+	if (ret = 0)
+		ret = req->dst_len;
+
+	kpp_request_free(req);
+
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Compute shared secret.
+ */
+static int software_kpp_compute_ss(struct kernel_kpp_params *params,
+				   const void *in, void *out)
+{
+	struct crypto_wait cwait;
+	const struct asym_kpp_ctx *ctx = params->key->payload.data[asym_crypto];
+	struct kpp_request *req;
+	struct scatterlist in_sg, out_sg;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	req = kpp_request_alloc(ctx->tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	sg_init_one(&in_sg, in, params->in_len);
+	kpp_request_set_input(req, &in_sg, params->in_len);
+	sg_init_one(&out_sg, out, params->out_len);
+	kpp_request_set_output(req, &out_sg, params->out_len);
+	crypto_init_wait(&cwait);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				 CRYPTO_TFM_REQ_MAY_SLEEP,
+				 crypto_req_done, &cwait);
+
+	ret = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &cwait);
+	if (ret = 0)
+		ret = req->dst_len;
+
+	kpp_request_free(req);
+
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * KPP algorithm asymmetric key subtype
+ */
+struct asymmetric_key_subtype asym_kpp_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "asym_kpp",
+	.name_len		= sizeof("asym_kpp") - 1,
+	.describe		= asym_kpp_describe,
+	.destroy		= asym_kpp_destroy,
+	.kpp_query		= software_kpp_query,
+	.kpp_gen_pubkey		= software_kpp_gen_pubkey,
+	.kpp_compute_ss		= software_kpp_compute_ss,
+};
+EXPORT_SYMBOL_GPL(asym_kpp_subtype);
+
+MODULE_DESCRIPTION("In-software asymmetric KPP subtype");
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/crypto/asym_kpp_subtype.h b/include/crypto/asym_kpp_subtype.h
new file mode 100644
index 0000000..abb7569
--- /dev/null
+++ b/include/crypto/asym_kpp_subtype.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_ASYM_KPP_SUBTYPE_H
+#define _LINUX_ASYM_KPP_SUBTYPE_H
+
+#include <linux/keyctl.h>
+
+struct asym_kpp_ctx {
+	struct crypto_kpp *tfm;
+	const char *alg_name;
+};
+
+#endif /* _LINUX_ASYM_KPP_SUBTYPE_H */
-- 
2.9.4

