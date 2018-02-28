From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 28 Feb 2018 16:52:27 +0000
Subject: [RFC PATCH 2/5] KEYS: Provide keyctls to drive the new key type ops for kpp
Message-Id: <20180228165230.18729-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-1-tudor.ambarus@microchip.com>
To: dhowells@redhat.com, keyrings@vger.kernel.org

Provide three keyctl functions that permit userspace to make use of the new
key type ops for accessing and driving asymmetric kpp keys.

(*) Query an asymmetric kpp key.

        long keyctl(KEYCTL_KPP_QUERY,
                    key_serial_t key, struct keyctl_kpp_query *res);

    Get information about an asymmetric kpp key. The information is
    returned in the keyctl_kpp_query struct:

        __u32           supported_ops;

    A bit mask of flags indicating which ops are supported. This
    is constructed from a bitwise-OR of:

        KEYCTL_SUPPORTS_{GEN_PUBKEY, COMPUTE_SS}

        __u32           max_size;

    The maximum size in bytes of the key.

    __spare must be set to 0.  This is intended for future use to hand
    over one or more passphrases needed to unlock a key.

    If successful, 0 is returned.  If the key is not an asymmetric kpp key,
    EOPNOTSUPP is returned.

(*) Generate the public key or compute the shared secret using an
    asymmetric kpp key.

        long keyctl(KEYCTL_KPP_GEN_PUBKEY,
                    const struct keyctl_kpp_params *params,
                    void *out);

        long keyctl(KEYCTL_KPP_GEN_PUBKEY,
                    const struct keyctl_kpp_params *params,
                    const void *in, void *out);

    The parameter block pointed by params contains a number of integer
    values:
        __s32           key_id;
        __u32           in_len;
        __u32           out_len;

    For a given operation, the in and out buffers are used as follows:

        Operation ID            in,in_len            out,out_len
        ============ ==========  ============
        KEYCTL_KPP_GEN_PUBKEY   -                    Corresponding public key
        KEYCTL_KPP_COMPUTE_SS   Pair's public key    Shared Secret

    The __spare space in the parameter block must be set to 0.  This is
    intended, amongst other things, to allow the passing of passphrases
    required to unlock a key.

    If successful, the public key generation and the shared secret computation
    will return the amount of data written into the output buffer.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 Documentation/security/keys/core.rst |  59 ++++++++++
 include/uapi/linux/keyctl.h          |  16 +++
 security/keys/Makefile               |   1 +
 security/keys/compat.c               |  10 ++
 security/keys/internal.h             |  28 +++++
 security/keys/keyctl.c               |  13 +++
 security/keys/keyctl_kpp.c           | 205 +++++++++++++++++++++++++++++++++++
 7 files changed, 332 insertions(+)
 create mode 100644 security/keys/keyctl_kpp.c

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 9b69a1f..31b9501 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -994,6 +994,65 @@ The keyctl syscall functions are:
      If successful, encrypt, decrypt and sign all return the amount of data
      written into the output buffer.  Verification returns 0 on success.
 
+  *  Query an asymmetric kpp key::
+
+       long keyctl(KEYCTL_KPP_QUERY,
+                   key_serial_t key, struct keyctl_kpp_query *res);
+
+     Get information about an asymmetric kpp key. The information is
+     returned in the keyctl_kpp_query struct::
+
+       struct keyctl_kpp_query {
+               __u32           supported_ops;  /* Which ops are supported */
+               __u32           max_size;       /* Maximum size of the output buffer in bytes */
+               __u32           __spare[10];
+       };
+
+     ``__u32   supported_ops;`` is a bit mask of flags indicating which ops are
+     supported.  This is constructed from a bitwise-OR of::
+
+        KEYCTL_SUPPORTS_{GEN_PUBKEY, COMPUTE_SS}
+
+     ``__spare`` must be set to 0.  This is intended for future use to hand
+     over one or more passphrases needed to unlock a key.
+
+     If successful, 0 is returned.  If the key is not an asymmetric kpp key,
+     EOPNOTSUPP is returned.
+
+  *  Generate the public key or compute the shared secret using an asymmetric
+     kpp key::
+
+       long keyctl(KEYCTL_KPP_GEN_PUBKEY,
+                   const struct keyctl_kpp_params *params,
+                   void *out);
+
+       long keyctl(KEYCTL_KPP_GEN_PUBKEY,
+                   const struct keyctl_kpp_params *params,
+                   const void *in, void *out);
+
+     The parameter block pointed by params contains a number of integer
+     values::
+            __s32           key_id;
+            __u32           in_len;
+            __u32           out_len;
+
+     ``key_id`` is the key tp be used and ``in_len`` and ``out_len`` are the
+     lengths in bytes of the input and output buffers.
+
+     For a given operation, the in and out buffers are used as follows::
+
+       Operation ID            in,in_len            out,out_len
+       ============ ==========  ============
+       KEYCTL_KPP_GEN_PUBKEY   -                    Corresponding public key
+       KEYCTL_KPP_COMPUTE_SS   Pair's public key    Shared Secret
+
+     The __spare space in the parameter block must be set to 0.  This is
+     intended, amongst other things, to allow the passing of passphrases
+     required to unlock a key.
+
+     If successful, the public key generation and the shared secret computation
+     will return the amount of data written into the output buffer.
+
 
 Kernel Services
 =======diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 98b79f8..dcee74c 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -67,6 +67,9 @@
 #define KEYCTL_PKEY_DECRYPT		26	/* Decrypt a blob using a public key */
 #define KEYCTL_PKEY_SIGN		27	/* Create a public key signature */
 #define KEYCTL_PKEY_VERIFY		28	/* Verify a public key signature */
+#define KEYCTL_KPP_QUERY		30	/* Query KPP parameters */
+#define KEYCTL_KPP_GEN_PUBKEY		31	/* Generate public key */
+#define KEYCTL_KPP_COMPUTE_SS		32	/* Compute shared secret */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -110,4 +113,17 @@ struct keyctl_pkey_params {
 #define KEYCTL_SUPPORTS_GEN_PUBKEY	0x0f
 #define KEYCTL_SUPPORTS_COMPUTE_SS	0x10
 
+struct keyctl_kpp_query {
+	__u32           supported_ops;  /* Which ops are supported */
+	__u32           max_size;	/* Maximum size of the output buffer in bytes */
+	__u32		__spare[10];
+};
+
+struct keyctl_kpp_params {
+	__s32		key_id;		/* Serial no. of private key to use */
+	__u32		in_len;		/* Input data size */
+	__u32		out_len;	/* Output buffer size */
+	__u32           __spare[7];
+};
+
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef540..eb05d3c 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SYSCTL) += sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
 obj-$(CONFIG_KEY_DH_OPERATIONS) += dh.o
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
+obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_kpp.o
 
 #
 # Key types
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 9482df6..0909715 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -159,6 +159,16 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 		return keyctl_pkey_verify(compat_ptr(arg2), compat_ptr(arg3),
 					  compat_ptr(arg4), compat_ptr(arg5));
 
+	case KEYCTL_KPP_QUERY:
+		return keyctl_kpp_query(arg2, compat_ptr(arg5));
+
+	case KEYCTL_KPP_GEN_PUBKEY:
+		return keyctl_kpp_gen_pubkey(compat_ptr(arg2), compat_ptr(arg5);
+
+	case KEYCTL_KPP_COMPUTE_SS:
+		return keyctl_kpp_compute_ss(compat_ptr(arg2), compat_ptr(arg4),
+					     compat_ptr(arg5));
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 74cb0ff..bacfda5 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -311,6 +311,14 @@ extern long keyctl_pkey_e_d_s(int,
 			      const struct keyctl_pkey_params __user *,
 			      const char __user *,
 			      const void __user *, void __user *);
+
+extern long keyctl_kpp_query(key_serial_t, struct keyctl_kpp_query __user *);
+
+extern long keyctl_kpp_gen_pubkey(const struct keyctl_kpp_params __user *,
+				  void __user *);
+
+extern long keyctl_kpp_compute_ss(const struct keyctl_kpp_params __user *,
+				  const void __user *, void __user *);
 #else
 static inline long keyctl_pkey_query(key_serial_t id,
 				     const char __user *_info,
@@ -335,6 +343,26 @@ static inline long keyctl_pkey_e_d_s(int op,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline long keyctl_kpp_query(key_serial_t id,
+				    struct keyctl_kpp_query __user *_res);
+{
+	return -EOPNOTSUPP;
+}
+
+static inline long keyctl_kpp_gen_pubkey(
+				const struct keyctl_kpp_params __user *params,
+				void __user *_out);
+{
+	return -EOPNOTSUPP;
+}
+
+static inline long keyctl_kpp_compute_ss(
+				const struct keyctl_kpp_params __user *params,
+				const void __user *in, void __user *_out);
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 614b147bc..a9a47e6 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1775,6 +1775,19 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			(const void __user *)arg4,
 			(const void __user *)arg5);
 
+	case KEYCTL_KPP_QUERY:
+		return keyctl_kpp_query((key_serial_t)arg2,
+					(struct keyctl_kpp_query *)arg5);
+	case KEYCTL_KPP_GEN_PUBKEY:
+		return keyctl_kpp_gen_pubkey(
+			(const struct keyctl_kpp_params __user *)arg2,
+			(void __user *)arg5);
+	case KEYCTL_KPP_COMPUTE_SS:
+		return keyctl_kpp_compute_ss(
+			(const struct keyctl_kpp_params __user *)arg2,
+			(const void __user *)arg4,
+			(void __user *)arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyctl_kpp.c b/security/keys/keyctl_kpp.c
new file mode 100644
index 0000000..8b4f77a
--- /dev/null
+++ b/security/keys/keyctl_kpp.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/key.h>
+#include <linux/keyctl.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include "internal.h"
+
+enum kernel_kpp_operation {
+	kernel_kpp_gen_pubkey,
+	kernel_kpp_compute_ss,
+};
+
+static void keyctl_kpp_params_free(struct kernel_kpp_params *params)
+{
+	key_put(params->key);
+}
+
+/*
+ * Interpret parameters.  Callers must always call the free function
+ * on params, even if an error is returned.
+ */
+static int keyctl_kpp_params_get(key_serial_t id,
+				 struct kernel_kpp_params *params)
+{
+	key_ref_t key_ref;
+
+	key_ref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
+	params->key = key_ref_to_ptr(key_ref);
+
+	if (!params->key->type->asym_kpp_query)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * Get parameters from userspace.  Callers must always call the free function
+ * on params, even if an error is returned.
+ */
+static int keyctl_kpp_params_get_2(
+				const struct keyctl_kpp_params __user *_params,
+				int operation,
+				struct kernel_kpp_params *params)
+{
+	struct keyctl_kpp_params uparams;
+	struct kernel_kpp_query res;
+	int ret;
+
+	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
+		return -EFAULT;
+
+	ret = keyctl_kpp_params_get(uparams.key_id, params);
+	if (ret < 0)
+		return ret;
+
+	ret = params->key->type->asym_kpp_query(params, &res);
+	if (ret < 0)
+		return ret;
+
+	switch (operation) {
+	case kernel_kpp_gen_pubkey:
+		if (uparams.out_len > res.max_size)
+			return -EINVAL;
+		break;
+	case kernel_kpp_compute_ss:
+		if (uparams.in_len  > res.max_size ||
+		    uparams.out_len > res.max_size)
+			return -EINVAL;
+		params->in_len  = uparams.in_len;
+		break;
+	default:
+		return -EINVAL;
+	}
+	params->out_len = uparams.out_len;
+
+	return 0;
+}
+
+/*
+ * Query information about an asymmetric key.
+ */
+long keyctl_kpp_query(key_serial_t id, struct keyctl_kpp_query __user *_res)
+{
+	struct kernel_kpp_params params;
+	struct kernel_kpp_query res;
+	long ret;
+
+	memset(&params, 0, sizeof(params));
+
+	ret = keyctl_kpp_params_get(id, &params);
+	if (ret < 0)
+		goto free_params;
+
+	ret = params.key->type->asym_kpp_query(&params, &res);
+	if (ret < 0)
+		goto free_params;
+
+	if (copy_to_user(_res, &res, sizeof(res)) ||
+	    clear_user(_res->__spare, sizeof(_res->__spare)))
+		ret = -EFAULT;
+
+free_params:
+	keyctl_kpp_params_free(&params);
+	return ret;
+}
+
+/*
+ * Generate public key.
+ *
+ * If successful, the amount of data written into the output buffer is
+ * returned.
+ */
+long keyctl_kpp_gen_pubkey(const struct keyctl_kpp_params __user *_params,
+			   void __user *_out)
+{
+	struct kernel_kpp_params params;
+	void *out;
+	long ret;
+
+	memset(&params, 0, sizeof(params));
+
+	ret = keyctl_kpp_params_get_2(_params, kernel_kpp_gen_pubkey, &params);
+	if (ret < 0)
+		goto free_params;
+
+	if (!params.key->type->asym_kpp_gen_pubkey) {
+		ret = -EOPNOTSUPP;
+		goto free_params;
+	}
+
+	out = kmalloc(params.out_len, GFP_KERNEL);
+	if (!out) {
+		ret = -ENOMEM;
+		goto free_params;
+	}
+
+	ret = params.key->type->asym_kpp_gen_pubkey(&params, out);
+	if (ret < 0)
+		goto free_all;
+
+	if (copy_to_user(_out, out, ret) != 0)
+		ret = -EFAULT;
+
+free_all:
+	kfree(out);
+free_params:
+	keyctl_kpp_params_free(&params);
+	return ret;
+}
+
+/*
+ * Compute shared secret.
+ *
+ * If successful, the amount of data written into the output buffer is
+ * returned.
+ */
+long keyctl_kpp_compute_ss(const struct keyctl_kpp_params __user *_params,
+			   const void __user *_in,
+			   void __user *_out)
+{
+	struct kernel_kpp_params params;
+	void *in, *out;
+	long ret;
+
+	memset(&params, 0, sizeof(params));
+
+	ret = keyctl_kpp_params_get_2(_params, kernel_kpp_compute_ss, &params);
+	if (ret < 0)
+		goto free_params;
+
+	if (!params.key->type->asym_kpp_compute_ss) {
+		ret = -EOPNOTSUPP;
+		goto free_params;
+	}
+
+	in = memdup_user(_in, params.in_len);
+	if (IS_ERR(in)) {
+		ret = PTR_ERR(in);
+		goto free_params;
+	}
+
+	out = kmalloc(params.out_len, GFP_KERNEL);
+	if (!out) {
+		ret = -ENOMEM;
+		goto free_in;
+	}
+
+	ret = params.key->type->asym_kpp_compute_ss(&params, in, out);
+	if (ret < 0)
+		goto free_all;
+
+	if (copy_to_user(_out, out, ret) != 0)
+		ret = -EFAULT;
+
+free_all:
+	kfree(out);
+free_in:
+	kfree(in);
+free_params:
+	keyctl_kpp_params_free(&params);
+	return ret;
+}
-- 
2.9.4

