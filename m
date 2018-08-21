From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Aug 2018 15:57:56 +0000
Subject: [PATCH 10/23] TPMLIB: Better format calls to TSS_*hmac*()
Message-Id: <153486707690.13066.12378140282590781364.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

Better format calls to TSS_rawhmac(), TSS_authhmac() and TSS_checkhmac*().
Each of these calls takes a varargs list of pairs of datasize and data values.
Put each pair on its own line so that things are more obvious.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/tpm/tpm-library.c |   86 ++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/char/tpm/tpm-library.c b/drivers/char/tpm/tpm-library.c
index e4cfc1f090e1..41fe4247a4c8 100644
--- a/drivers/char/tpm/tpm-library.c
+++ b/drivers/char/tpm/tpm-library.c
@@ -153,9 +153,12 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 	if (!ret)
 		ret = crypto_shash_final(&sdesc->shash, paramdigest);
 	if (!ret)
-		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
-				  paramdigest, TPM_NONCE_SIZE, h1,
-				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
+		ret = TSS_rawhmac(digest, key, keylen,
+				  SHA1_DIGEST_SIZE, paramdigest,
+				  TPM_NONCE_SIZE, h1,
+				  TPM_NONCE_SIZE, h2,
+				  1, &c,
+				  0, 0);
 out:
 	kfree(sdesc);
 	return ret;
@@ -229,9 +232,12 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	if (ret < 0)
 		goto out;
 
-	ret = TSS_rawhmac(testhmac, key, keylen, SHA1_DIGEST_SIZE, paramdigest,
-			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
-			  1, continueflag, 0, 0);
+	ret = TSS_rawhmac(testhmac, key, keylen,
+			  SHA1_DIGEST_SIZE, paramdigest,
+			  TPM_NONCE_SIZE, enonce,
+			  TPM_NONCE_SIZE, ononce,
+			  1, continueflag,
+			  0, 0);
 	if (ret < 0)
 		goto out;
 
@@ -322,18 +328,24 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	if (ret < 0)
 		goto out;
 
-	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
-			  paramdigest, TPM_NONCE_SIZE, enonce1,
-			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
+	ret = TSS_rawhmac(testhmac1, key1, keylen1,
+			  SHA1_DIGEST_SIZE, paramdigest,
+			  TPM_NONCE_SIZE, enonce1,
+			  TPM_NONCE_SIZE, ononce,
+			  1, continueflag1,
+			  0, 0);
 	if (ret < 0)
 		goto out;
 	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
-			  paramdigest, TPM_NONCE_SIZE, enonce2,
-			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
+	ret = TSS_rawhmac(testhmac2, key2, keylen2,
+			  SHA1_DIGEST_SIZE, paramdigest,
+			  TPM_NONCE_SIZE, enonce2,
+			  TPM_NONCE_SIZE, ononce,
+			  1, continueflag2,
+			  0, 0);
 	if (ret < 0)
 		goto out;
 	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
@@ -395,8 +407,10 @@ static int tpm_create_osap(struct tpm_chip *chip,
 	       TPM_NONCE_SIZE);
 	memcpy(enonce, &(tb->data[TPM_DATA_OFFSET + sizeof(uint32_t) +
 				  TPM_NONCE_SIZE]), TPM_NONCE_SIZE);
-	return TSS_rawhmac(s->secret, key, SHA1_DIGEST_SIZE, TPM_NONCE_SIZE,
-			   enonce, TPM_NONCE_SIZE, ononce, 0, 0);
+	return TSS_rawhmac(s->secret, key, SHA1_DIGEST_SIZE,
+			   TPM_NONCE_SIZE, enonce,
+			   TPM_NONCE_SIZE, ononce,
+			   0, 0);
 }
 
 /*
@@ -488,18 +502,23 @@ int tpm_seal(struct tpm_chip *chip, struct tpm_buf *tb, uint16_t keytype,
 		/* no pcr info specified */
 		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
 				   sess.enonce, td->nonceodd, cont,
-				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
-				   td->encauth, sizeof(uint32_t), &pcrsize,
-				   sizeof(uint32_t), &datsize, datalen, data, 0,
-				   0);
+				   sizeof(uint32_t), &ordinal,
+				   SHA1_DIGEST_SIZE, td->encauth,
+				   sizeof(uint32_t), &pcrsize,
+				   sizeof(uint32_t), &datsize,
+				   datalen, data,
+				   0, 0);
 	} else {
 		/* pcr info specified */
 		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
 				   sess.enonce, td->nonceodd, cont,
-				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
-				   td->encauth, sizeof(uint32_t), &pcrsize,
-				   pcrinfosize, pcrinfo, sizeof(uint32_t),
-				   &datsize, datalen, data, 0, 0);
+				   sizeof(uint32_t), &ordinal,
+				   SHA1_DIGEST_SIZE, td->encauth,
+				   sizeof(uint32_t), &pcrsize,
+				   pcrinfosize, pcrinfo,
+				   sizeof(uint32_t), &datsize,
+				   datalen, data,
+				   0, 0);
 	}
 	if (ret < 0)
 		goto out;
@@ -533,9 +552,10 @@ int tpm_seal(struct tpm_chip *chip, struct tpm_buf *tb, uint16_t keytype,
 	    sizeof(uint32_t) + encdatasize;
 
 	/* check the HMAC in the response */
-	ret = TSS_checkhmac1(tb->data, ordinal, td->nonceodd, sess.secret,
-			     SHA1_DIGEST_SIZE, storedsize, TPM_DATA_OFFSET, 0,
-			     0);
+	ret = TSS_checkhmac1(tb->data, ordinal, td->nonceodd,
+			     sess.secret, SHA1_DIGEST_SIZE,
+			     storedsize, TPM_DATA_OFFSET,
+			     0, 0);
 
 	/* copy the returned blob to caller */
 	if (!ret) {
@@ -589,13 +609,17 @@ int tpm_unseal(struct tpm_chip *chip, struct tpm_buf *tb,
 		return ret;
 	}
 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
-			   enonce1, nonceodd, cont, sizeof(uint32_t),
-			   &ordinal, bloblen, blob, 0, 0);
+			   enonce1, nonceodd, cont,
+			   sizeof(uint32_t), &ordinal,
+			   bloblen, blob,
+			   0, 0);
 	if (ret < 0)
 		return ret;
 	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
-			   enonce2, nonceodd, cont, sizeof(uint32_t),
-			   &ordinal, bloblen, blob, 0, 0);
+			   enonce2, nonceodd, cont,
+			   sizeof(uint32_t), &ordinal,
+			   bloblen, blob,
+			   0, 0);
 	if (ret < 0)
 		return ret;
 
@@ -627,8 +651,8 @@ int tpm_unseal(struct tpm_chip *chip, struct tpm_buf *tb,
 			     keyauth, SHA1_DIGEST_SIZE,
 			     blobauth, SHA1_DIGEST_SIZE,
 			     sizeof(uint32_t), TPM_DATA_OFFSET,
-			     *datalen, TPM_DATA_OFFSET + sizeof(uint32_t), 0,
-			     0);
+			     *datalen, TPM_DATA_OFFSET + sizeof(uint32_t),
+			     0, 0);
 	if (ret < 0) {
 		pr_info("TSS_checkhmac2 failed (%d)\n", ret);
 		return ret;
