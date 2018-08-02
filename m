From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 02 Aug 2018 18:31:12 +0000
Subject: [RFCv3 04/13] KEYS: asym_tpm: extract key size & public key
Message-Id: <20180802183121.22909-5-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The parsed BER/DER blob obtained from user space contains a TPM_Key
structure.  This structure has some information about the key as well as
the public key portion.

This patch extracts this information for future use.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 114 ++++++++++++++++++++++++++++++++++++++
 include/crypto/asym_tpm_subtype.h |   3 +
 2 files changed, 117 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index f98335068a3b..4f070706628c 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/tpm.h>
+#include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
 #include <crypto/asym_tpm_subtype.h>
 
@@ -41,6 +42,112 @@ static void asym_tpm_destroy(void *payload0, void *payload3)
 	kfree(tk);
 }
 
+/*
+ * Parse enough information out of TPM_KEY structure:
+ * TPM_STRUCT_VER -> 4 bytes
+ * TPM_KEY_USAGE -> 2 bytes
+ * TPM_KEY_FLAGS -> 4 bytes
+ * TPM_AUTH_DATA_USAGE -> 1 byte
+ * TPM_KEY_PARMS -> variable
+ * UINT32 PCRInfoSize -> 4 bytes
+ * BYTE* -> PCRInfoSize bytes
+ * TPM_STORE_PUBKEY
+ * UINT32 encDataSize;
+ * BYTE* -> encDataSize;
+ *
+ * TPM_KEY_PARMS:
+ * TPM_ALGORITHM_ID -> 4 bytes
+ * TPM_ENC_SCHEME -> 2 bytes
+ * TPM_SIG_SCHEME -> 2 bytes
+ * UINT32 parmSize -> 4 bytes
+ * BYTE* -> variable
+ */
+static int extract_key_parameters(struct tpm_key *tk)
+{
+	const void *cur = tk->blob;
+	uint32_t len = tk->blob_len;
+	const void *pub_key;
+	uint32_t sz;
+	uint32_t key_len;
+
+	if (len < 11)
+		return -EBADMSG;
+
+	/* Ensure this is a legacy key */
+	if (get_unaligned_be16(cur + 4) != 0x0015)
+		return -EBADMSG;
+
+	/* Skip to TPM_KEY_PARMS */
+	cur += 11;
+	len -= 11;
+
+	if (len < 12)
+		return -EBADMSG;
+
+	/* Make sure this is an RSA key */
+	if (get_unaligned_be32(cur) != 0x00000001)
+		return -EBADMSG;
+
+	/* Make sure this is TPM_ES_RSAESPKCSv15 encoding scheme */
+	if (get_unaligned_be16(cur + 4) != 0x0002)
+		return -EBADMSG;
+
+	/* Make sure this is TPM_SS_RSASSAPKCS1v15_DER signature scheme */
+	if (get_unaligned_be16(cur + 6) != 0x0003)
+		return -EBADMSG;
+
+	sz = get_unaligned_be32(cur + 8);
+	if (len < sz + 12)
+		return -EBADMSG;
+
+	/* Move to TPM_RSA_KEY_PARMS */
+	len -= 12;
+	cur += 12;
+
+	/* Grab the RSA key length */
+	key_len = get_unaligned_be32(cur);
+
+	switch (key_len) {
+	case 512:
+	case 1024:
+	case 1536:
+	case 2048:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Move just past TPM_KEY_PARMS */
+	cur += sz;
+	len -= sz;
+
+	if (len < 4)
+		return -EBADMSG;
+
+	sz = get_unaligned_be32(cur);
+	if (len < 4 + sz)
+		return -EBADMSG;
+
+	/* Move to TPM_STORE_PUBKEY */
+	cur += 4 + sz;
+	len -= 4 + sz;
+
+	/* Grab the size of the public key, it should jive with the key size */
+	sz = get_unaligned_be32(cur);
+	if (sz > 256)
+		return -EINVAL;
+
+	pub_key = cur + 4;
+
+	pr_info("Key length: %d\n", key_len);
+	pr_info("Public Key Length: %d\n", sz);
+	tk->key_len = key_len;
+	tk->pub_key = pub_key;
+	tk->pub_key_len = sz;
+
+	return 0;
+}
+
 /* Given the blob, parse it and load it into the TPM */
 struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
 {
@@ -68,8 +175,15 @@ struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
 
 	tk->blob_len = blob_len;
 
+	r = extract_key_parameters(tk);
+	if (r < 0)
+		goto error_extract;
+
 	return tk;
 
+error_extract:
+	kfree(tk->blob);
+	tk->blob_len = 0;
 error_memdup:
 	kfree(tk);
 error:
diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
index 03550b850998..48198c36d6b9 100644
--- a/include/crypto/asym_tpm_subtype.h
+++ b/include/crypto/asym_tpm_subtype.h
@@ -7,6 +7,9 @@
 struct tpm_key {
 	void *blob;
 	u32 blob_len;
+	uint16_t key_len; /* Size in bits of the key */
+	const void *pub_key; /* pointer inside blob to the public key bytes */
+	uint16_t pub_key_len; /* length of the public key */
 };
 
 struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len);
-- 
2.16.1

