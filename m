From: David Howells <dhowells@redhat.com>
Date: Wed, 05 Sep 2018 21:56:10 +0000
Subject: [PATCH 17/22] KEYS: asym_tpm: Add loadkey2 and flushspecific
Message-Id: <153618457002.7946.741829373041553399.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This commit adds TPM_LoadKey2 and TPM_FlushSpecific operations.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---

 crypto/asymmetric_keys/asym_tpm.c |   94 +++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 8edca3c4c193..6a2d33014ecc 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -7,11 +7,105 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/tpm.h>
+#include <linux/tpm_command.h>
 #include <crypto/akcipher.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
+#include <keys/trusted.h>
 #include <crypto/asym_tpm_subtype.h>
 
+#define TPM_ORD_FLUSHSPECIFIC	186
+#define TPM_ORD_LOADKEY2	65
+#define TPM_LOADKEY2_SIZE		59
+#define TPM_FLUSHSPECIFIC_SIZE		18
+
+#define TPM_RT_KEY                      0x00000001
+
+/*
+ * Load a TPM key from the blob provided by userspace
+ */
+static int tpm_loadkey2(struct tpm_buf *tb,
+			uint32_t keyhandle, unsigned char *keyauth,
+			const unsigned char *keyblob, int keybloblen,
+			uint32_t *newhandle)
+{
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+	unsigned char authdata[SHA1_DIGEST_SIZE];
+	uint32_t authhandle = 0;
+	unsigned char cont = 0;
+	uint32_t ordinal;
+	int ret;
+
+	ordinal = htonl(TPM_ORD_LOADKEY2);
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
+			   keybloblen, keyblob, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* build the request buffer */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
+	store32(tb, TPM_LOADKEY2_SIZE + keybloblen);
+	store32(tb, TPM_ORD_LOADKEY2);
+	store32(tb, keyhandle);
+	storebytes(tb, keyblob, keybloblen);
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
+	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd, keyauth,
+			     SHA1_DIGEST_SIZE, 0, 0);
+	if (ret < 0) {
+		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
+		return ret;
+	}
+
+	*newhandle = LOAD32(tb->data, TPM_DATA_OFFSET);
+	return 0;
+}
+
+/*
+ * Execute the FlushSpecific TPM command
+ */
+static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
+{
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_COMMAND);
+	store32(tb, TPM_FLUSHSPECIFIC_SIZE);
+	store32(tb, TPM_ORD_FLUSHSPECIFIC);
+	store32(tb, handle);
+	store32(tb, TPM_RT_KEY);
+
+	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+}
+
 /*
  * Maximum buffer size for the BER/DER encoded public key.  The public key
  * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
