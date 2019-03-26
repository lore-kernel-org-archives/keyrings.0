From: Vitaly Chikunov <vt@altlinux.org>
Date: Tue, 26 Mar 2019 12:58:36 +0000
Subject: [PATCH v8 04/10] KEYS: do not kmemdup digest in {public,tpm}_key_verify_signature
Message-Id: <20190326125842.24110-5-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326125842.24110-1-vt@altlinux.org>
In-Reply-To: <20190326125842.24110-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Treat (struct public_key_signature)'s digest same as its signature (s).
Since digest should be already in the kmalloc'd memory do not kmemdup
digest value before calling {public,tpm}_key_verify_signature.

Patch is split from the previous as suggested by Herbert Xu.

Suggested-by: David Howells <dhowells@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/asymmetric_keys/asym_tpm.c   | 10 +---------
 crypto/asymmetric_keys/public_key.c |  9 +--------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 4e5b6fb57a94..402fc34ca044 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -748,7 +748,6 @@ static int tpm_key_verify_signature(const struct key *key,
 	char alg_name[CRYPTO_MAX_ALG_NAME];
 	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
 	uint32_t der_pub_key_len;
-	void *digest;
 	int ret;
 
 	pr_devel("=>%s()\n", __func__);
@@ -780,14 +779,9 @@ static int tpm_key_verify_signature(const struct key *key,
 	if (!req)
 		goto error_free_tfm;
 
-	ret = -ENOMEM;
-	digest = kmemdup(sig->digest, sig->digest_size, GFP_KERNEL);
-	if (!digest)
-		goto error_free_req;
-
 	sg_init_table(src_sg, 2);
 	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
-	sg_set_buf(&src_sg[1], digest, sig->digest_size);
+	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
 	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
 				   sig->digest_size);
 	crypto_init_wait(&cwait);
@@ -796,8 +790,6 @@ static int tpm_key_verify_signature(const struct key *key,
 				      crypto_req_done, &cwait);
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
 
-	kfree(digest);
-error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
 	crypto_free_akcipher(tfm);
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 0c069fe8a59c..33093b7bcc47 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -229,7 +229,6 @@ int public_key_verify_signature(const struct public_key *pkey,
 	struct akcipher_request *req;
 	struct scatterlist src_sg[2];
 	char alg_name[CRYPTO_MAX_ALG_NAME];
-	void *digest;
 	int ret;
 
 	pr_devel("=>%s()\n", __func__);
@@ -262,14 +261,9 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_req;
 
-	ret = -ENOMEM;
-	digest = kmemdup(sig->digest, sig->digest_size, GFP_KERNEL);
-	if (!digest)
-		goto error_free_req;
-
 	sg_init_table(src_sg, 2);
 	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
-	sg_set_buf(&src_sg[1], digest, sig->digest_size);
+	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
 	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
 				   sig->digest_size);
 	crypto_init_wait(&cwait);
@@ -278,7 +272,6 @@ int public_key_verify_signature(const struct public_key *pkey,
 				      crypto_req_done, &cwait);
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
 
-	kfree(digest);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
-- 
2.11.0
