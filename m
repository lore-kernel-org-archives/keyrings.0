From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:50:11 +0000
Subject: [PATCH 23/23] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <149692981183.11452.6166169090897805425.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

The initial Diffie-Hellman computation made direct use of the MPI
library because the crypto module did not support DH at the time. Now
that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
duplicate code and leverage possible hardware acceleration.

This fixes an issue whereby the input to the KDF computation would
include additional uninitialized memory when the result of the
Diffie-Hellman computation was shorter than the input prime number.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/Kconfig |    2 
 security/keys/dh.c    |  272 +++++++++++++++++++++++++++++++------------------
 2 files changed, 171 insertions(+), 103 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 00b7431a8aeb..a7a23b5541f8 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -93,9 +93,9 @@ config ENCRYPTED_KEYS
 config KEY_DH_OPERATIONS
        bool "Diffie-Hellman operations on retained keys"
        depends on KEYS
-       select MPILIB
        select CRYPTO
        select CRYPTO_HASH
+       select CRYPTO_DH
        help
 	 This option provides support for calculating Diffie-Hellman
 	 public keys and shared secrets using values stored as keys
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 63ac87d430db..4755d4b4f945 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -8,34 +8,17 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/mpi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/scatterlist.h>
 #include <linux/crypto.h>
 #include <crypto/hash.h>
+#include <crypto/kpp.h>
+#include <crypto/dh.h>
 #include <keys/user-type.h>
 #include "internal.h"
 
-/*
- * Public key or shared secret generation function [RFC2631 sec 2.1.1]
- *
- * ya = g^xa mod p;
- * or
- * ZZ = yb^xa mod p;
- *
- * where xa is the local private key, ya is the local public key, g is
- * the generator, p is the prime, yb is the remote public key, and ZZ
- * is the shared secret.
- *
- * Both are the same calculation, so g or yb are the "base" and ya or
- * ZZ are the "result".
- */
-static int do_dh(MPI result, MPI base, MPI xa, MPI p)
-{
-	return mpi_powm(result, base, xa, p);
-}
-
-static ssize_t mpi_from_key(key_serial_t keyid, size_t maxlen, MPI *mpi)
+static ssize_t dh_data_from_key(key_serial_t keyid, void **data)
 {
 	struct key *key;
 	key_ref_t key_ref;
@@ -56,19 +39,17 @@ static ssize_t mpi_from_key(key_serial_t keyid, size_t maxlen, MPI *mpi)
 		status = key_validate(key);
 		if (status = 0) {
 			const struct user_key_payload *payload;
+			uint8_t *duplicate;
 
 			payload = user_key_payload_locked(key);
 
-			if (maxlen = 0) {
-				*mpi = NULL;
+			duplicate = kmemdup(payload->data, payload->datalen,
+					    GFP_KERNEL);
+			if (duplicate) {
+				*data = duplicate;
 				ret = payload->datalen;
-			} else if (payload->datalen <= maxlen) {
-				*mpi = mpi_read_raw_data(payload->data,
-							 payload->datalen);
-				if (*mpi)
-					ret = payload->datalen;
 			} else {
-				ret = -EINVAL;
+				ret = -ENOMEM;
 			}
 		}
 		up_read(&key->sem);
@@ -79,6 +60,29 @@ static ssize_t mpi_from_key(key_serial_t keyid, size_t maxlen, MPI *mpi)
 	return ret;
 }
 
+static void dh_free_data(struct dh *dh)
+{
+	kzfree(dh->key);
+	kzfree(dh->p);
+	kzfree(dh->g);
+}
+
+struct dh_completion {
+	struct completion completion;
+	int err;
+};
+
+static void dh_crypto_done(struct crypto_async_request *req, int err)
+{
+	struct dh_completion *compl = req->data;
+
+	if (err = -EINPROGRESS)
+		return;
+
+	compl->err = err;
+	complete(&compl->completion);
+}
+
 struct kdf_sdesc {
 	struct shash_desc shash;
 	char ctx[];
@@ -140,7 +144,7 @@ static void kdf_dealloc(struct kdf_sdesc *sdesc)
  * 5.8.1.2).
  */
 static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
-		   u8 *dst, unsigned int dlen)
+		   u8 *dst, unsigned int dlen, unsigned int zlen)
 {
 	struct shash_desc *desc = &sdesc->shash;
 	unsigned int h = crypto_shash_digestsize(desc->tfm);
@@ -157,6 +161,22 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		if (err)
 			goto err;
 
+		if (zlen && h) {
+			u8 tmpbuffer[h];
+			size_t chunk = min_t(size_t, zlen, h);
+			memset(tmpbuffer, 0, chunk);
+
+			do {
+				err = crypto_shash_update(desc, tmpbuffer,
+							  chunk);
+				if (err)
+					goto err;
+
+				zlen -= chunk;
+				chunk = min_t(size_t, zlen, h);
+			} while (zlen);
+		}
+
 		if (src && slen) {
 			err = crypto_shash_update(desc, src, slen);
 			if (err)
@@ -192,7 +212,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 
 static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
 				 char __user *buffer, size_t buflen,
-				 uint8_t *kbuf, size_t kbuflen)
+				 uint8_t *kbuf, size_t kbuflen, size_t lzero)
 {
 	uint8_t *outbuf = NULL;
 	int ret;
@@ -203,7 +223,7 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
 		goto err;
 	}
 
-	ret = kdf_ctr(sdesc, kbuf, kbuflen, outbuf, buflen);
+	ret = kdf_ctr(sdesc, kbuf, kbuflen, outbuf, buflen, lzero);
 	if (ret)
 		goto err;
 
@@ -221,21 +241,26 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 			 struct keyctl_kdf_params *kdfcopy)
 {
 	long ret;
-	MPI base, private, prime, result;
-	unsigned nbytes;
+	ssize_t dlen;
+	int secretlen;
+	int outlen;
 	struct keyctl_dh_params pcopy;
-	uint8_t *kbuf;
-	ssize_t keylen;
-	size_t resultlen;
+	struct dh dh_inputs;
+	struct scatterlist outsg;
+	struct dh_completion compl;
+	struct crypto_kpp *tfm;
+	struct kpp_request *req;
+	uint8_t *secret;
+	uint8_t *outbuf;
 	struct kdf_sdesc *sdesc = NULL;
 
 	if (!params || (!buffer && buflen)) {
 		ret = -EINVAL;
-		goto out;
+		goto out1;
 	}
 	if (copy_from_user(&pcopy, params, sizeof(pcopy)) != 0) {
 		ret = -EFAULT;
-		goto out;
+		goto out1;
 	}
 
 	if (kdfcopy) {
@@ -244,104 +269,147 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 		if (buflen > KEYCTL_KDF_MAX_OUTPUT_LEN ||
 		    kdfcopy->otherinfolen > KEYCTL_KDF_MAX_OI_LEN) {
 			ret = -EMSGSIZE;
-			goto out;
+			goto out1;
 		}
 
 		/* get KDF name string */
 		hashname = strndup_user(kdfcopy->hashname, CRYPTO_MAX_ALG_NAME);
 		if (IS_ERR(hashname)) {
 			ret = PTR_ERR(hashname);
-			goto out;
+			goto out1;
 		}
 
 		/* allocate KDF from the kernel crypto API */
 		ret = kdf_alloc(&sdesc, hashname);
 		kfree(hashname);
 		if (ret)
-			goto out;
+			goto out1;
 	}
 
-	/*
-	 * If the caller requests postprocessing with a KDF, allow an
-	 * arbitrary output buffer size since the KDF ensures proper truncation.
-	 */
-	keylen = mpi_from_key(pcopy.prime, kdfcopy ? SIZE_MAX : buflen, &prime);
-	if (keylen < 0 || !prime) {
-		/* buflen = 0 may be used to query the required buffer size,
-		 * which is the prime key length.
-		 */
-		ret = keylen;
-		goto out;
+	memset(&dh_inputs, 0, sizeof(dh_inputs));
+
+	dlen = dh_data_from_key(pcopy.prime, &dh_inputs.p);
+	if (dlen < 0) {
+		ret = dlen;
+		goto out1;
 	}
+	dh_inputs.p_size = dlen;
 
-	/* The result is never longer than the prime */
-	resultlen = keylen;
+	dlen = dh_data_from_key(pcopy.base, &dh_inputs.g);
+	if (dlen < 0) {
+		ret = dlen;
+		goto out2;
+	}
+	dh_inputs.g_size = dlen;
 
-	keylen = mpi_from_key(pcopy.base, SIZE_MAX, &base);
-	if (keylen < 0 || !base) {
-		ret = keylen;
-		goto error1;
+	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	if (dlen < 0) {
+		ret = dlen;
+		goto out2;
 	}
+	dh_inputs.key_size = dlen;
 
-	keylen = mpi_from_key(pcopy.private, SIZE_MAX, &private);
-	if (keylen < 0 || !private) {
-		ret = keylen;
-		goto error2;
+	secretlen = crypto_dh_key_len(&dh_inputs);
+	secret = kmalloc(secretlen, GFP_KERNEL);
+	if (!secret) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+	ret = crypto_dh_encode_key(secret, secretlen, &dh_inputs);
+	if (ret)
+		goto out3;
+
+	tfm = crypto_alloc_kpp("dh", CRYPTO_ALG_TYPE_KPP, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out3;
+	}
+
+	ret = crypto_kpp_set_secret(tfm, secret, secretlen);
+	if (ret)
+		goto out4;
+
+	outlen = crypto_kpp_maxsize(tfm);
+
+	if (!kdfcopy) {
+		/*
+		 * When not using a KDF, buflen 0 is used to read the
+		 * required buffer length
+		 */
+		if (buflen = 0) {
+			ret = outlen;
+			goto out4;
+		} else if (outlen > buflen) {
+			ret = -EOVERFLOW;
+			goto out4;
+		}
 	}
 
-	result = mpi_alloc(0);
-	if (!result) {
+	outbuf = kzalloc(kdfcopy ? (outlen + kdfcopy->otherinfolen) : outlen,
+			 GFP_KERNEL);
+	if (!outbuf) {
 		ret = -ENOMEM;
-		goto error3;
+		goto out4;
 	}
 
-	/* allocate space for DH shared secret and SP800-56A otherinfo */
-	kbuf = kmalloc(kdfcopy ? (resultlen + kdfcopy->otherinfolen) : resultlen,
-		       GFP_KERNEL);
-	if (!kbuf) {
+	sg_init_one(&outsg, outbuf, outlen);
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
 		ret = -ENOMEM;
-		goto error4;
+		goto out5;
 	}
 
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, &outsg, outlen);
+	init_completion(&compl.completion);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				 CRYPTO_TFM_REQ_MAY_SLEEP,
+				 dh_crypto_done, &compl);
+
 	/*
-	 * Concatenate SP800-56A otherinfo past DH shared secret -- the
-	 * input to the KDF is (DH shared secret || otherinfo)
+	 * For DH, generate_public_key and generate_shared_secret are
+	 * the same calculation
 	 */
-	if (kdfcopy &&
-	    copy_from_user(kbuf + resultlen, kdfcopy->otherinfo,
-			   kdfcopy->otherinfolen) != 0) {
-		ret = -EFAULT;
-		goto error5;
+	ret = crypto_kpp_generate_public_key(req);
+	if (ret = -EINPROGRESS) {
+		wait_for_completion(&compl.completion);
+		ret = compl.err;
+		if (ret)
+			goto out6;
 	}
 
-	ret = do_dh(result, base, private, prime);
-	if (ret)
-		goto error5;
-
-	ret = mpi_read_buffer(result, kbuf, resultlen, &nbytes, NULL);
-	if (ret != 0)
-		goto error5;
-
 	if (kdfcopy) {
-		ret = keyctl_dh_compute_kdf(sdesc, buffer, buflen, kbuf,
-					    resultlen + kdfcopy->otherinfolen);
-	} else {
-		ret = nbytes;
-		if (copy_to_user(buffer, kbuf, nbytes) != 0)
+		/*
+		 * Concatenate SP800-56A otherinfo past DH shared secret -- the
+		 * input to the KDF is (DH shared secret || otherinfo)
+		 */
+		if (copy_from_user(outbuf + req->dst_len, kdfcopy->otherinfo,
+				   kdfcopy->otherinfolen) != 0) {
 			ret = -EFAULT;
+			goto out6;
+		}
+
+		ret = keyctl_dh_compute_kdf(sdesc, buffer, buflen, outbuf,
+					    req->dst_len + kdfcopy->otherinfolen,
+					    outlen - req->dst_len);
+	} else if (copy_to_user(buffer, outbuf, req->dst_len) = 0) {
+		ret = req->dst_len;
+	} else {
+		ret = -EFAULT;
 	}
 
-error5:
-	kzfree(kbuf);
-error4:
-	mpi_free(result);
-error3:
-	mpi_free(private);
-error2:
-	mpi_free(base);
-error1:
-	mpi_free(prime);
-out:
+out6:
+	kpp_request_free(req);
+out5:
+	kzfree(outbuf);
+out4:
+	crypto_free_kpp(tfm);
+out3:
+	kzfree(secret);
+out2:
+	dh_free_data(&dh_inputs);
+out1:
 	kdf_dealloc(sdesc);
 	return ret;
 }

