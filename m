From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 28 Feb 2018 16:52:28 +0000
Subject: [RFC PATCH 3/5] KEYS: Provide missing asym kpp subops for new key type ops
Message-Id: <20180228165230.18729-4-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-1-tudor.ambarus@microchip.com>
To: dhowells@redhat.com, keyrings@vger.kernel.org

Includes kpp_query, kpp_gen_pubkey and kpp_compute_ss.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 77 ++++++++++++++++++++++++++++++++
 include/keys/asymmetric-subtype.h        | 12 +++++
 2 files changed, 89 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 3cd4315..cdc0974e 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -578,6 +578,80 @@ static int asymmetric_key_verify_signature(struct kernel_pkey_params *params,
 	return verify_signature(params->key, &sig);
 }
 
+int query_asym_kpp_key(const struct kernel_kpp_params *params,
+		       struct kernel_kpp_query *res)
+{
+	const struct asymmetric_key_subtype *subtype;
+	struct key *key = params->key;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return -EINVAL;
+
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype || !key->payload.data[0])
+		return -EINVAL;
+
+	if (!subtype->kpp_query)
+		return -ENOTSUPP;
+
+	ret = subtype->kpp_query(params, res);
+
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+int asymmetric_key_kpp_gen_pubkey(struct kernel_kpp_params *params, void *out)
+{
+	const struct asymmetric_key_subtype *subtype;
+	struct key *key = params->key;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return -EINVAL;
+
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype || !key->payload.data[0])
+		return -EINVAL;
+
+	if (!subtype->kpp_gen_pubkey)
+		return -ENOTSUPP;
+
+	ret = subtype->kpp_gen_pubkey(params, out);
+
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+int asymmetric_key_kpp_compute_ss(struct kernel_kpp_params *params,
+				  const void *in, void *out)
+{
+	const struct asymmetric_key_subtype *subtype;
+	struct key *key = params->key;
+	int ret;
+
+	pr_devel("=>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return -EINVAL;
+
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype || !key->payload.data[0])
+		return -EINVAL;
+
+	if (!subtype->kpp_compute_ss)
+		return -ENOTSUPP;
+
+	ret = subtype->kpp_compute_ss(params, in, out);
+
+	pr_devel("<=%s() = %d\n", __func__, ret);
+	return ret;
+}
+
 struct key_type key_type_asymmetric = {
 	.name			= "asymmetric",
 	.preparse		= asymmetric_key_preparse,
@@ -591,6 +665,9 @@ struct key_type key_type_asymmetric = {
 	.asym_query		= query_asymmetric_key,
 	.asym_eds_op		= asymmetric_key_eds_op,
 	.asym_verify_signature	= asymmetric_key_verify_signature,
+	.asym_kpp_query		= query_asym_kpp_key,
+	.asym_kpp_gen_pubkey	= asymmetric_key_kpp_gen_pubkey,
+	.asym_kpp_compute_ss	= asymmetric_key_kpp_compute_ss,
 };
 EXPORT_SYMBOL_GPL(key_type_asymmetric);
 
diff --git a/include/keys/asymmetric-subtype.h b/include/keys/asymmetric-subtype.h
index bd12733..5f9bece 100644
--- a/include/keys/asymmetric-subtype.h
+++ b/include/keys/asymmetric-subtype.h
@@ -20,6 +20,8 @@
 struct kernel_pkey_query;
 struct kernel_pkey_params;
 struct public_key_signature;
+struct kernel_kpp_query;
+struct kernel_kpp_params;
 
 /*
  * Keys of this type declare a subtype that indicates the handlers and
@@ -46,6 +48,16 @@ struct asymmetric_key_subtype {
 	/* Verify the signature on a key of this subtype (optional) */
 	int (*verify_signature)(const struct key *key,
 				const struct public_key_signature *sig);
+
+	int (*kpp_query)(const struct kernel_kpp_params *params,
+			 struct kernel_kpp_query *res);
+
+	/* Generate public key */
+	int (*kpp_gen_pubkey)(struct kernel_kpp_params *params, void *out);
+
+	/* Compute shared secret */
+	int (*kpp_compute_ss)(struct kernel_kpp_params *params,
+			      const void *in, void *out);
 };
 
 /**
-- 
2.9.4

