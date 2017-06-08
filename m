From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:11 +0000
Subject: [PATCH 15/23] KEYS: encrypted: sanitize all key material
Message-Id: <149692975135.11452.9791971822965563991.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

For keys of type "encrypted", consistently zero sensitive key material
before freeing it.  This was already being done for the decrypted
payloads of encrypted keys, but not for the master key and the keys
derived from the master key.

Out of an abundance of caution and because it is trivial to do so, also
zero buffers containing the key payload in encrypted form, although
depending on how the encrypted-keys feature is used such information
does not necessarily need to be kept secret.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |   31 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 5c98c2fe03f0..bb6324d1ccec 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -375,7 +375,7 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
 	ret = calc_hash(hash_tfm, derived_key, derived_buf, derived_buf_len);
-	kfree(derived_buf);
+	kzfree(derived_buf);
 	return ret;
 }
 
@@ -507,6 +507,7 @@ static int datablob_hmac_append(struct encrypted_key_payload *epayload,
 	if (!ret)
 		dump_hmac(NULL, digest, HASH_SIZE);
 out:
+	memzero_explicit(derived_key, sizeof(derived_key));
 	return ret;
 }
 
@@ -545,6 +546,7 @@ static int datablob_hmac_verify(struct encrypted_key_payload *epayload,
 		dump_hmac("calc", digest, HASH_SIZE);
 	}
 out:
+	memzero_explicit(derived_key, sizeof(derived_key));
 	return ret;
 }
 
@@ -701,6 +703,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
 out:
 	up_read(&mkey->sem);
 	key_put(mkey);
+	memzero_explicit(derived_key, sizeof(derived_key));
 	return ret;
 }
 
@@ -807,13 +810,13 @@ static int encrypted_instantiate(struct key *key,
 	ret = encrypted_init(epayload, key->description, format, master_desc,
 			     decrypted_datalen, hex_encoded_iv);
 	if (ret < 0) {
-		kfree(epayload);
+		kzfree(epayload);
 		goto out;
 	}
 
 	rcu_assign_keypointer(key, epayload);
 out:
-	kfree(datablob);
+	kzfree(datablob);
 	return ret;
 }
 
@@ -822,8 +825,7 @@ static void encrypted_rcu_free(struct rcu_head *rcu)
 	struct encrypted_key_payload *epayload;
 
 	epayload = container_of(rcu, struct encrypted_key_payload, rcu);
-	memset(epayload->decrypted_data, 0, epayload->decrypted_datalen);
-	kfree(epayload);
+	kzfree(epayload);
 }
 
 /*
@@ -881,7 +883,7 @@ static int encrypted_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, new_epayload);
 	call_rcu(&epayload->rcu, encrypted_rcu_free);
 out:
-	kfree(buf);
+	kzfree(buf);
 	return ret;
 }
 
@@ -939,33 +941,26 @@ static long encrypted_read(const struct key *key, char __user *buffer,
 
 	up_read(&mkey->sem);
 	key_put(mkey);
+	memzero_explicit(derived_key, sizeof(derived_key));
 
 	if (copy_to_user(buffer, ascii_buf, asciiblob_len) != 0)
 		ret = -EFAULT;
-	kfree(ascii_buf);
+	kzfree(ascii_buf);
 
 	return asciiblob_len;
 out:
 	up_read(&mkey->sem);
 	key_put(mkey);
+	memzero_explicit(derived_key, sizeof(derived_key));
 	return ret;
 }
 
 /*
- * encrypted_destroy - before freeing the key, clear the decrypted data
- *
- * Before freeing the key, clear the memory containing the decrypted
- * key data.
+ * encrypted_destroy - clear and free the key's payload
  */
 static void encrypted_destroy(struct key *key)
 {
-	struct encrypted_key_payload *epayload = key->payload.data[0];
-
-	if (!epayload)
-		return;
-
-	memzero_explicit(epayload->decrypted_data, epayload->decrypted_datalen);
-	kfree(key->payload.data[0]);
+	kzfree(key->payload.data[0]);
 }
 
 struct key_type key_type_encrypted = {

