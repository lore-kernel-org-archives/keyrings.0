From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 12 Jun 2018 15:55:33 +0000
Subject: [RFCv2 12/13] KEYS: asym_tpm: Implement tpm_sign
Message-Id: <20180612155534.4873-13-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 88 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 571fb98e1af9..8789df029313 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -20,9 +20,11 @@
 #define TPM_ORD_FLUSHSPECIFIC	186
 #define TPM_ORD_LOADKEY2	65
 #define TPM_ORD_UNBIND		30
+#define TPM_ORD_SIGN		60
 #define TPM_LOADKEY2_SIZE		59
 #define TPM_FLUSHSPECIFIC_SIZE		18
 #define TPM_UNBIND_SIZE			63
+#define TPM_SIGN_SIZE			63
 
 #define TPM_RT_KEY                      0x00000001
 
@@ -189,6 +191,92 @@ static int tpm_unbind(struct tpm_buf *tb,
 	return datalen;
 }
 
+/*
+ * Sign a blob provided by userspace (that has had the hash function applied)
+ * using a specific key handle.  The handle is assumed to have been previously
+ * loaded by e.g. LoadKey2.
+ *
+ * Note that the key signature scheme of the used key should be set to
+ * TPM_SS_RSASSAPKCS1v15_DER.  This allows the hashed input to be of any size
+ * up to key_length_in_bytes - 11 and not be limited to size 20 like the
+ * TPM_SS_RSASSAPKCS1v15_SHA1 signature scheme.
+ */
+static int tpm_sign(struct tpm_buf *tb,
+		    uint32_t keyhandle, unsigned char *keyauth,
+		    const unsigned char *blob, uint32_t bloblen,
+		    void *out, uint32_t outlen)
+{
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+	unsigned char authdata[SHA1_DIGEST_SIZE];
+	uint32_t authhandle = 0;
+	unsigned char cont = 0;
+	uint32_t ordinal;
+	uint32_t datalen;
+	int ret;
+
+	ordinal = htonl(TPM_ORD_SIGN);
+	datalen = htonl(bloblen);
+
+	/* session for loading the key */
+	ret = oiap(tb, &authhandle, enonce);
+	if (ret < 0) {
+		pr_info("oiap failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* generate odd nonce */
+	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
+	if (ret < 0) {
+		pr_info("tpm_get_random failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* calculate authorization HMAC value */
+	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
+			   nonceodd, cont, sizeof(uint32_t), &ordinal,
+			   sizeof(uint32_t), &datalen,
+			   bloblen, blob, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* build the request buffer */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
+	store32(tb, TPM_SIGN_SIZE + bloblen);
+	store32(tb, TPM_ORD_SIGN);
+	store32(tb, keyhandle);
+	store32(tb, bloblen);
+	storebytes(tb, blob, bloblen);
+	store32(tb, authhandle);
+	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
+	store8(tb, cont);
+	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0) {
+		pr_info("authhmac failed (%d)\n", ret);
+		return ret;
+	}
+
+	datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
+	pr_info("datalen: %u, outlen: %u\n", datalen, outlen);
+
+	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd,
+			     keyauth, SHA1_DIGEST_SIZE,
+			     sizeof(uint32_t), TPM_DATA_OFFSET,
+			     datalen, TPM_DATA_OFFSET + sizeof(uint32_t),
+			     0, 0);
+	if (ret < 0) {
+		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
+		return ret;
+	}
+
+	memcpy(out, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t),
+	       min(datalen, outlen));
+
+	return datalen;
+}
 /*
  * Maximum buffer size for the BER/DER encoded public key.  The public key
  * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
-- 
2.16.1

