From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:48:10 +0000
Subject: [PATCH 07/23] KEYS: encrypted: avoid encrypting/decrypting stack buffers
Message-Id: <149692969030.11452.7689983076506041179.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since v4.9, the crypto API cannot (normally) be used to encrypt/decrypt
stack buffers because the stack may be virtually mapped.  Fix this for
the padding buffers in encrypted-keys by using ZERO_PAGE for the
encryption padding and by allocating a temporary heap buffer for the
decryption padding.

Tested with CONFIG_DEBUG_SG=y:
	keyctl new_session
	keyctl add user master "abcdefghijklmnop" @s
	keyid=$(keyctl add encrypted desc "new user:master 25" @s)
	datablob="$(keyctl pipe $keyid)"
	keyctl unlink $keyid
	keyid=$(keyctl add encrypted desc "load $datablob" @s)
	datablob2="$(keyctl pipe $keyid)"
	[ "$datablob" = "$datablob2" ] && echo "Success!"

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 2ab48eab29a1..d14f1a47a130 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -479,12 +479,9 @@ static int derived_key_encrypt(struct encrypted_key_payload *epayload,
 	struct skcipher_request *req;
 	unsigned int encrypted_datalen;
 	u8 iv[AES_BLOCK_SIZE];
-	unsigned int padlen;
-	char pad[16];
 	int ret;
 
 	encrypted_datalen = roundup(epayload->decrypted_datalen, blksize);
-	padlen = encrypted_datalen - epayload->decrypted_datalen;
 
 	req = init_skcipher_req(derived_key, derived_keylen);
 	ret = PTR_ERR(req);
@@ -492,11 +489,10 @@ static int derived_key_encrypt(struct encrypted_key_payload *epayload,
 		goto out;
 	dump_decrypted_data(epayload);
 
-	memset(pad, 0, sizeof pad);
 	sg_init_table(sg_in, 2);
 	sg_set_buf(&sg_in[0], epayload->decrypted_data,
 		   epayload->decrypted_datalen);
-	sg_set_buf(&sg_in[1], pad, padlen);
+	sg_set_page(&sg_in[1], ZERO_PAGE(0), AES_BLOCK_SIZE, 0);
 
 	sg_init_table(sg_out, 1);
 	sg_set_buf(sg_out, epayload->encrypted_data, encrypted_datalen);
@@ -583,9 +579,14 @@ static int derived_key_decrypt(struct encrypted_key_payload *epayload,
 	struct skcipher_request *req;
 	unsigned int encrypted_datalen;
 	u8 iv[AES_BLOCK_SIZE];
-	char pad[16];
+	u8 *pad;
 	int ret;
 
+	/* Throwaway buffer to hold the unused zero padding at the end */
+	pad = kmalloc(AES_BLOCK_SIZE, GFP_KERNEL);
+	if (!pad)
+		return -ENOMEM;
+
 	encrypted_datalen = roundup(epayload->decrypted_datalen, blksize);
 	req = init_skcipher_req(derived_key, derived_keylen);
 	ret = PTR_ERR(req);
@@ -593,13 +594,12 @@ static int derived_key_decrypt(struct encrypted_key_payload *epayload,
 		goto out;
 	dump_encrypted_data(epayload, encrypted_datalen);
 
-	memset(pad, 0, sizeof pad);
 	sg_init_table(sg_in, 1);
 	sg_init_table(sg_out, 2);
 	sg_set_buf(sg_in, epayload->encrypted_data, encrypted_datalen);
 	sg_set_buf(&sg_out[0], epayload->decrypted_data,
 		   epayload->decrypted_datalen);
-	sg_set_buf(&sg_out[1], pad, sizeof pad);
+	sg_set_buf(&sg_out[1], pad, AES_BLOCK_SIZE);
 
 	memcpy(iv, epayload->iv, sizeof(iv));
 	skcipher_request_set_crypt(req, sg_in, sg_out, encrypted_datalen, iv);
@@ -611,6 +611,7 @@ static int derived_key_decrypt(struct encrypted_key_payload *epayload,
 		goto out;
 	dump_decrypted_data(epayload);
 out:
+	kfree(pad);
 	return ret;
 }
 

