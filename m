From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:08:21 +0000
Subject: [PATCH v5 03/10] crypto: rsa - unimplement sign/verify for raw RSA backends
Message-Id: <20190224060828.2527-4-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Aymen Sghaier <aymen.sghaier@nxp.com>

In preparation for new akcipher verify call remove sign/verify callbacks
from RSA backends and make PKCS1 driver call encrypt/decrypt instead.

This also complies with the well-known idea that raw RSA should never be
used for sign/verify. It only should be used with proper padding scheme
such as PKCS1 driver provides.

Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: qat-linux@intel.com
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Gary Hook <gary.hook@amd.com>
Cc: Horia Geant=C4=83 <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/rsa-pkcs1pad.c                         |   4 +-
 crypto/rsa.c                                  | 109 ----------------------=
----
 drivers/crypto/caam/caampkc.c                 |   2 -
 drivers/crypto/ccp/ccp-crypto-rsa.c           |   2 -
 drivers/crypto/qat/qat_common/qat_asym_algs.c |   2 -
 5 files changed, 2 insertions(+), 117 deletions(-)

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index 0a6680ca8cb6..94382fa2c6ac 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -429,7 +429,7 @@ static int pkcs1pad_sign(struct akcipher_request *req)
 	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx->in_sg,
 				   req->dst, ctx->key_size - 1, req->dst_len);
=20
-	err =3D crypto_akcipher_sign(&req_ctx->child_req);
+	err =3D crypto_akcipher_decrypt(&req_ctx->child_req);
 	if (err !=3D -EINPROGRESS && err !=3D -EBUSY)
 		return pkcs1pad_encrypt_sign_complete(req, err);
=20
@@ -551,7 +551,7 @@ static int pkcs1pad_verify(struct akcipher_request *req)
 				   req_ctx->out_sg, req->src_len,
 				   ctx->key_size);
=20
-	err =3D crypto_akcipher_verify(&req_ctx->child_req);
+	err =3D crypto_akcipher_encrypt(&req_ctx->child_req);
 	if (err !=3D -EINPROGRESS && err !=3D -EBUSY)
 		return pkcs1pad_verify_complete(req, err);
=20
diff --git a/crypto/rsa.c b/crypto/rsa.c
index 4167980c243d..5d427c1100d6 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -50,34 +50,6 @@ static int _rsa_dec(const struct rsa_mpi_key *key, MPI m=
, MPI c)
 	return mpi_powm(m, c, key->d, key->n);
 }
=20
-/*
- * RSASP1 function [RFC3447 sec 5.2.1]
- * s =3D m^d mod n
- */
-static int _rsa_sign(const struct rsa_mpi_key *key, MPI s, MPI m)
-{
-	/* (1) Validate 0 <=3D m < n */
-	if (mpi_cmp_ui(m, 0) < 0 || mpi_cmp(m, key->n) >=3D 0)
-		return -EINVAL;
-
-	/* (2) s =3D m^d mod n */
-	return mpi_powm(s, m, key->d, key->n);
-}
-
-/*
- * RSAVP1 function [RFC3447 sec 5.2.2]
- * m =3D s^e mod n;
- */
-static int _rsa_verify(const struct rsa_mpi_key *key, MPI m, MPI s)
-{
-	/* (1) Validate 0 <=3D s < n */
-	if (mpi_cmp_ui(s, 0) < 0 || mpi_cmp(s, key->n) >=3D 0)
-		return -EINVAL;
-
-	/* (2) m =3D s^e mod n */
-	return mpi_powm(m, s, key->e, key->n);
-}
-
 static inline struct rsa_mpi_key *rsa_get_key(struct crypto_akcipher *tfm)
 {
 	return akcipher_tfm_ctx(tfm);
@@ -160,85 +132,6 @@ static int rsa_dec(struct akcipher_request *req)
 	return ret;
 }
=20
-static int rsa_sign(struct akcipher_request *req)
-{
-	struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
-	const struct rsa_mpi_key *pkey =3D rsa_get_key(tfm);
-	MPI m, s =3D mpi_alloc(0);
-	int ret =3D 0;
-	int sign;
-
-	if (!s)
-		return -ENOMEM;
-
-	if (unlikely(!pkey->n || !pkey->d)) {
-		ret =3D -EINVAL;
-		goto err_free_s;
-	}
-
-	ret =3D -ENOMEM;
-	m =3D mpi_read_raw_from_sgl(req->src, req->src_len);
-	if (!m)
-		goto err_free_s;
-
-	ret =3D _rsa_sign(pkey, s, m);
-	if (ret)
-		goto err_free_m;
-
-	ret =3D mpi_write_to_sgl(s, req->dst, req->dst_len, &sign);
-	if (ret)
-		goto err_free_m;
-
-	if (sign < 0)
-		ret =3D -EBADMSG;
-
-err_free_m:
-	mpi_free(m);
-err_free_s:
-	mpi_free(s);
-	return ret;
-}
-
-static int rsa_verify(struct akcipher_request *req)
-{
-	struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
-	const struct rsa_mpi_key *pkey =3D rsa_get_key(tfm);
-	MPI s, m =3D mpi_alloc(0);
-	int ret =3D 0;
-	int sign;
-
-	if (!m)
-		return -ENOMEM;
-
-	if (unlikely(!pkey->n || !pkey->e)) {
-		ret =3D -EINVAL;
-		goto err_free_m;
-	}
-
-	s =3D mpi_read_raw_from_sgl(req->src, req->src_len);
-	if (!s) {
-		ret =3D -ENOMEM;
-		goto err_free_m;
-	}
-
-	ret =3D _rsa_verify(pkey, m, s);
-	if (ret)
-		goto err_free_s;
-
-	ret =3D mpi_write_to_sgl(m, req->dst, req->dst_len, &sign);
-	if (ret)
-		goto err_free_s;
-
-	if (sign < 0)
-		ret =3D -EBADMSG;
-
-err_free_s:
-	mpi_free(s);
-err_free_m:
-	mpi_free(m);
-	return ret;
-}
-
 static void rsa_free_mpi_key(struct rsa_mpi_key *key)
 {
 	mpi_free(key->d);
@@ -353,8 +246,6 @@ static void rsa_exit_tfm(struct crypto_akcipher *tfm)
 static struct akcipher_alg rsa =3D {
 	.encrypt =3D rsa_enc,
 	.decrypt =3D rsa_dec,
-	.sign =3D rsa_sign,
-	.verify =3D rsa_verify,
 	.set_priv_key =3D rsa_set_priv_key,
 	.set_pub_key =3D rsa_set_pub_key,
 	.max_size =3D rsa_max_size,
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 77ab28a2811a..d7e1fc5bacc5 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -994,8 +994,6 @@ static void caam_rsa_exit_tfm(struct crypto_akcipher *t=
fm)
 static struct akcipher_alg caam_rsa =3D {
 	.encrypt =3D caam_rsa_enc,
 	.decrypt =3D caam_rsa_dec,
-	.sign =3D caam_rsa_dec,
-	.verify =3D caam_rsa_enc,
 	.set_pub_key =3D caam_rsa_set_pub_key,
 	.set_priv_key =3D caam_rsa_set_priv_key,
 	.max_size =3D caam_rsa_max_size,
diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-c=
rypto-rsa.c
index 05850dfd7940..71e40680c880 100644
--- a/drivers/crypto/ccp/ccp-crypto-rsa.c
+++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
@@ -214,8 +214,6 @@ static void ccp_rsa_exit_tfm(struct crypto_akcipher *tf=
m)
 static struct akcipher_alg ccp_rsa_defaults =3D {
 	.encrypt =3D ccp_rsa_encrypt,
 	.decrypt =3D ccp_rsa_decrypt,
-	.sign =3D ccp_rsa_decrypt,
-	.verify =3D ccp_rsa_encrypt,
 	.set_pub_key =3D ccp_rsa_setpubkey,
 	.set_priv_key =3D ccp_rsa_setprivkey,
 	.max_size =3D ccp_rsa_maxsize,
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto=
/qat/qat_common/qat_asym_algs.c
index 320e7854b4ee..c05d03565e96 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -1300,8 +1300,6 @@ static void qat_rsa_exit_tfm(struct crypto_akcipher *=
tfm)
 static struct akcipher_alg rsa =3D {
 	.encrypt =3D qat_rsa_enc,
 	.decrypt =3D qat_rsa_dec,
-	.sign =3D qat_rsa_dec,
-	.verify =3D qat_rsa_enc,
 	.set_pub_key =3D qat_rsa_setpubkey,
 	.set_priv_key =3D qat_rsa_setprivkey,
 	.max_size =3D qat_rsa_max_size,
--=20
2.11.0
