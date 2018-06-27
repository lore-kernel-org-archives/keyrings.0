From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 27 Jun 2018 06:15:31 +0000
Subject: [PATCH v2] crypto: DH - add public key verification test
Message-Id: <2573864.V43BhLOfag@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <3594538.6iHA3aaNKK@positron.chronox.de>
In-Reply-To: <3594538.6iHA3aaNKK@positron.chronox.de>
To: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

Hi,

Changes v2:
* addition of a check that mpi_alloc succeeds.

---8<---

According to SP800-56A section 5.6.2.1, the public key to be processed
for the DH operation shall be checked for appropriateness. The check
shall covers the full verification test in case the domain parameter Q
is provided as defined in SP800-56A section 5.6.2.3.1. If Q is not
provided, the partial check according to SP800-56A section 5.6.2.3.2 is
performed.

The full verification test requires the presence of the domain parameter
Q. Thus, the patch adds the support to handle Q. It is permissible to
not provide the Q value as part of the domain parameters. This implies
that the interface is still backwards-compatible where so far only P and
G are to be provided. However, if Q is provided, it is imported.

Without the test, the NIST ACVP testing fails. After adding this check,
the NIST ACVP testing passes. Testing without providing the Q domain
parameter has been performed to verify the interface has not changed.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/dh.c         | 66 ++++++++++++++++++++++++++++++++++++++++++---
 crypto/dh_helper.c  | 15 ++++++++---
 include/crypto/dh.h |  4 +++
 3 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 5659fe7f446d..8f79269db2b7 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -16,14 +16,16 @@
 #include <linux/mpi.h>
 
 struct dh_ctx {
-	MPI p;
-	MPI g;
-	MPI xa;
+	MPI p;	/* Value is guaranteed to be set. */
+	MPI q;	/* Value is optional. */
+	MPI g;	/* Value is guaranteed to be set. */
+	MPI xa;	/* Value is guaranteed to be set. */
 };
 
 static void dh_clear_ctx(struct dh_ctx *ctx)
 {
 	mpi_free(ctx->p);
+	mpi_free(ctx->q);
 	mpi_free(ctx->g);
 	mpi_free(ctx->xa);
 	memset(ctx, 0, sizeof(*ctx));
@@ -60,6 +62,12 @@ static int dh_set_params(struct dh_ctx *ctx, struct dh *params)
 	if (!ctx->p)
 		return -EINVAL;
 
+	if (params->q && params->q_size) {
+		ctx->q = mpi_read_raw_data(params->q, params->q_size);
+		if (!ctx->q)
+			return -EINVAL;
+	}
+
 	ctx->g = mpi_read_raw_data(params->g, params->g_size);
 	if (!ctx->g)
 		return -EINVAL;
@@ -93,6 +101,55 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	return -EINVAL;
 }
 
+/*
+ * SP800-56A public key verification:
+ *
+ * * If Q is provided as part of the domain paramenters, a full validation
+ *   according to SP800-56A section 5.6.2.3.1 is performed.
+ *
+ * * If Q is not provided, a partial validation according to SP800-56A section
+ *   5.6.2.3.2 is performed.
+ */
+static int dh_is_pubkey_valid(struct dh_ctx *ctx, MPI y)
+{
+	if (unlikely(!ctx->p))
+		return -EINVAL;
+
+	/*
+	 * Step 1: Verify that 2 <= y <= p - 2.
+	 *
+	 * The upper limit check is actually y < p instead of y < p - 1
+	 * as the mpi_sub_ui function is yet missing.
+	 */
+	if (mpi_cmp_ui(y, 1) < 1 || mpi_cmp(y, ctx->p) >= 0)
+		return -EINVAL;
+
+	/* Step 2: Verify that 1 = y^q mod p */
+	if (ctx->q) {
+		MPI val = mpi_alloc(0);
+		int ret;
+
+		if (!val)
+			return -ENOMEM;
+
+		ret = mpi_powm(val, y, ctx->q, ctx->p);
+
+		if (ret) {
+			mpi_free(val);
+			return ret;
+		}
+
+		ret = mpi_cmp_ui(val, 1);
+
+		mpi_free(val);
+
+		if (ret != 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int dh_compute_value(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
@@ -115,6 +172,9 @@ static int dh_compute_value(struct kpp_request *req)
 			ret = -EINVAL;
 			goto err_free_val;
 		}
+		ret = dh_is_pubkey_valid(ctx, base);
+		if (ret)
+			goto err_free_val;
 	} else {
 		base = ctx->g;
 	}
diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 24fdb2ecaa85..a7de3d9ce5ac 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -30,7 +30,7 @@ static inline const u8 *dh_unpack_data(void *dst, const void *src, size_t size)
 
 static inline unsigned int dh_data_size(const struct dh *p)
 {
-	return p->key_size + p->p_size + p->g_size;
+	return p->key_size + p->p_size + p->q_size + p->g_size;
 }
 
 unsigned int crypto_dh_key_len(const struct dh *p)
@@ -56,9 +56,11 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
 	ptr = dh_pack_data(ptr, &secret, sizeof(secret));
 	ptr = dh_pack_data(ptr, &params->key_size, sizeof(params->key_size));
 	ptr = dh_pack_data(ptr, &params->p_size, sizeof(params->p_size));
+	ptr = dh_pack_data(ptr, &params->q_size, sizeof(params->q_size));
 	ptr = dh_pack_data(ptr, &params->g_size, sizeof(params->g_size));
 	ptr = dh_pack_data(ptr, params->key, params->key_size);
 	ptr = dh_pack_data(ptr, params->p, params->p_size);
+	ptr = dh_pack_data(ptr, params->q, params->q_size);
 	dh_pack_data(ptr, params->g, params->g_size);
 
 	return 0;
@@ -79,6 +81,7 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 
 	ptr = dh_unpack_data(&params->key_size, ptr, sizeof(params->key_size));
 	ptr = dh_unpack_data(&params->p_size, ptr, sizeof(params->p_size));
+	ptr = dh_unpack_data(&params->q_size, ptr, sizeof(params->q_size));
 	ptr = dh_unpack_data(&params->g_size, ptr, sizeof(params->g_size));
 	if (secret.len != crypto_dh_key_len(params))
 		return -EINVAL;
@@ -88,7 +91,7 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	 * some drivers assume otherwise.
 	 */
 	if (params->key_size > params->p_size ||
-	    params->g_size > params->p_size)
+	    params->g_size > params->p_size || params->q_size > params->p_size)
 		return -EINVAL;
 
 	/* Don't allocate memory. Set pointers to data within
@@ -96,7 +99,9 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	 */
 	params->key = (void *)ptr;
 	params->p = (void *)(ptr + params->key_size);
-	params->g = (void *)(ptr + params->key_size + params->p_size);
+	params->q = (void *)(ptr + params->key_size + params->p_size);
+	params->g = (void *)(ptr + params->key_size + params->p_size +
+			     params->q_size);
 
 	/*
 	 * Don't permit 'p' to be 0.  It's not a prime number, and it's subject
@@ -106,6 +111,10 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	if (memchr_inv(params->p, 0, params->p_size) = NULL)
 		return -EINVAL;
 
+	/* It is permissible to not provide Q. */
+	if (params->q_size = 0)
+		params->q = NULL;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_dh_decode_key);
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index 71e1bb24d79f..7e0dad94cb2b 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -29,17 +29,21 @@
  *
  * @key:	Private DH key
  * @p:		Diffie-Hellman parameter P
+ * @q:		Diffie-Hellman parameter Q
  * @g:		Diffie-Hellman generator G
  * @key_size:	Size of the private DH key
  * @p_size:	Size of DH parameter P
+ * @q_size:	Size of DH parameter Q
  * @g_size:	Size of DH generator G
  */
 struct dh {
 	void *key;
 	void *p;
+	void *q;
 	void *g;
 	unsigned int key_size;
 	unsigned int p_size;
+	unsigned int q_size;
 	unsigned int g_size;
 };
 
-- 
2.17.1




