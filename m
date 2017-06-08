From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:18 +0000
Subject: [PATCH 16/23] KEYS: trusted: sanitize all key material
Message-Id: <149692975873.11452.4299102306056105423.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As the previous patch did for encrypted-keys, zero sensitive any
potentially sensitive data related to the "trusted" key type before it
is freed.  Notably, we were not zeroing the tpm_buf structures in which
the actual key is stored for TPM seal and unseal, nor were we zeroing
the trusted_key_payload in certain error paths.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/trusted.c |   50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 2ae31c5a87de..435e86e13879 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -70,7 +70,7 @@ static int TSS_sha1(const unsigned char *data, unsigned int datalen,
 	}
 
 	ret = crypto_shash_digest(&sdesc->shash, data, datalen, digest);
-	kfree(sdesc);
+	kzfree(sdesc);
 	return ret;
 }
 
@@ -114,7 +114,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
 	if (!ret)
 		ret = crypto_shash_final(&sdesc->shash, digest);
 out:
-	kfree(sdesc);
+	kzfree(sdesc);
 	return ret;
 }
 
@@ -165,7 +165,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 				  paramdigest, TPM_NONCE_SIZE, h1,
 				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
 out:
-	kfree(sdesc);
+	kzfree(sdesc);
 	return ret;
 }
 
@@ -246,7 +246,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
-	kfree(sdesc);
+	kzfree(sdesc);
 	return ret;
 }
 
@@ -347,7 +347,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
-	kfree(sdesc);
+	kzfree(sdesc);
 	return ret;
 }
 
@@ -564,7 +564,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 		*bloblen = storedsize;
 	}
 out:
-	kfree(td);
+	kzfree(td);
 	return ret;
 }
 
@@ -678,7 +678,7 @@ static int key_seal(struct trusted_key_payload *p,
 	if (ret < 0)
 		pr_info("trusted_key: srkseal failed (%d)\n", ret);
 
-	kfree(tb);
+	kzfree(tb);
 	return ret;
 }
 
@@ -703,7 +703,7 @@ static int key_unseal(struct trusted_key_payload *p,
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
 
-	kfree(tb);
+	kzfree(tb);
 	return ret;
 }
 
@@ -1037,12 +1037,12 @@ static int trusted_instantiate(struct key *key,
 	if (!ret && options->pcrlock)
 		ret = pcrlock(options->pcrlock);
 out:
-	kfree(datablob);
-	kfree(options);
+	kzfree(datablob);
+	kzfree(options);
 	if (!ret)
 		rcu_assign_keypointer(key, payload);
 	else
-		kfree(payload);
+		kzfree(payload);
 	return ret;
 }
 
@@ -1051,8 +1051,7 @@ static void trusted_rcu_free(struct rcu_head *rcu)
 	struct trusted_key_payload *p;
 
 	p = container_of(rcu, struct trusted_key_payload, rcu);
-	memset(p->key, 0, p->key_len);
-	kfree(p);
+	kzfree(p);
 }
 
 /*
@@ -1094,13 +1093,13 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	ret = datablob_parse(datablob, new_p, new_o);
 	if (ret != Opt_update) {
 		ret = -EINVAL;
-		kfree(new_p);
+		kzfree(new_p);
 		goto out;
 	}
 
 	if (!new_o->keyhandle) {
 		ret = -EINVAL;
-		kfree(new_p);
+		kzfree(new_p);
 		goto out;
 	}
 
@@ -1114,22 +1113,22 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	ret = key_seal(new_p, new_o);
 	if (ret < 0) {
 		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kfree(new_p);
+		kzfree(new_p);
 		goto out;
 	}
 	if (new_o->pcrlock) {
 		ret = pcrlock(new_o->pcrlock);
 		if (ret < 0) {
 			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kfree(new_p);
+			kzfree(new_p);
 			goto out;
 		}
 	}
 	rcu_assign_keypointer(key, new_p);
 	call_rcu(&p->rcu, trusted_rcu_free);
 out:
-	kfree(datablob);
-	kfree(new_o);
+	kzfree(datablob);
+	kzfree(new_o);
 	return ret;
 }
 
@@ -1158,24 +1157,19 @@ static long trusted_read(const struct key *key, char __user *buffer,
 	for (i = 0; i < p->blob_len; i++)
 		bufp = hex_byte_pack(bufp, p->blob[i]);
 	if ((copy_to_user(buffer, ascii_buf, 2 * p->blob_len)) != 0) {
-		kfree(ascii_buf);
+		kzfree(ascii_buf);
 		return -EFAULT;
 	}
-	kfree(ascii_buf);
+	kzfree(ascii_buf);
 	return 2 * p->blob_len;
 }
 
 /*
- * trusted_destroy - before freeing the key, clear the decrypted data
+ * trusted_destroy - clear and free the key's payload
  */
 static void trusted_destroy(struct key *key)
 {
-	struct trusted_key_payload *p = key->payload.data[0];
-
-	if (!p)
-		return;
-	memset(p->key, 0, p->key_len);
-	kfree(key->payload.data[0]);
+	kzfree(key->payload.data[0]);
 }
 
 struct key_type key_type_trusted = {

