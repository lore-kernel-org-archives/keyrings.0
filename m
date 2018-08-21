From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Aug 2018 15:58:17 +0000
Subject: [PATCH 13/23] TPMLIB: Rename store8() and storebytes()
Message-Id: <153486709741.13066.7109350297231028843.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

Rename store8() and storebytes() so that the names are the same length as for
store16() and store32() and their parameters line up, making blocks of them
easier to read.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/tpm/tpm-library.c |   28 ++++++++++++++--------------
 drivers/char/tpm/tpm-library.h |   14 +++++++-------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm-library.c b/drivers/char/tpm/tpm-library.c
index 1c64282d1d0d..1eea483cf36b 100644
--- a/drivers/char/tpm/tpm-library.c
+++ b/drivers/char/tpm/tpm-library.c
@@ -427,7 +427,7 @@ static int tpm_create_osap(struct tpm_chip *chip,
 	store32(tb, TPM_ORD_OSAP);
 	store16(tb, keytype);
 	store32(tb, keyhandle);
-	storebytes(tb, ononce.data, TPM_NONCE_SIZE);
+	store_s(tb, ononce.data, TPM_NONCE_SIZE);
 
 	ret = tpm_send_dump(chip, tb->data, MAX_BUF_SIZE,
 			    "creating OSAP session");
@@ -579,15 +579,15 @@ int tpm_seal(struct tpm_chip *chip,
 	store32(tb, TPM_SEAL_SIZE + pcrinfosize + rawlen);
 	store32(tb, TPM_ORD_SEAL);
 	store32(tb, keyhandle);
-	storebytes(tb, td->encauth, SHA1_DIGEST_SIZE);
+	store_s(tb, td->encauth, SHA1_DIGEST_SIZE);
 	store32(tb, pcrinfosize);
-	storebytes(tb, pcrinfo, pcrinfosize);
+	store_s(tb, pcrinfo, pcrinfosize);
 	store32(tb, rawlen);
-	storebytes(tb, rawdata, rawlen);
+	store_s(tb, rawdata, rawlen);
 	store32(tb, sess.handle);
-	storebytes(tb, td->ononce.data, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, td->pubauth, SHA1_DIGEST_SIZE);
+	store_s(tb, td->ononce.data, TPM_NONCE_SIZE);
+	store_8(tb, cont);
+	store_s(tb, td->pubauth, SHA1_DIGEST_SIZE);
 
 	ret = tpm_send_dump(chip, tb->data, MAX_BUF_SIZE,
 			    "sealing data");
@@ -688,15 +688,15 @@ int tpm_unseal(struct tpm_chip *chip, struct tpm_buf *tb,
 	store32(tb, TPM_UNSEAL_SIZE + enclen);
 	store32(tb, TPM_ORD_UNSEAL);
 	store32(tb, keyhandle);
-	storebytes(tb, encdata, enclen);
+	store_s(tb, encdata, enclen);
 	store32(tb, authhandle1);
-	storebytes(tb, ononce.data, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata1, SHA1_DIGEST_SIZE);
+	store_s(tb, ononce.data, TPM_NONCE_SIZE);
+	store_8(tb, cont);
+	store_s(tb, authdata1, SHA1_DIGEST_SIZE);
 	store32(tb, authhandle2);
-	storebytes(tb, ononce.data, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata2, SHA1_DIGEST_SIZE);
+	store_s(tb, ononce.data, TPM_NONCE_SIZE);
+	store_8(tb, cont);
+	store_s(tb, authdata2, SHA1_DIGEST_SIZE);
 
 	ret = tpm_send_dump(chip, tb->data, MAX_BUF_SIZE,
 			    "unsealing data");
diff --git a/drivers/char/tpm/tpm-library.h b/drivers/char/tpm/tpm-library.h
index ceb0ea1cd2bb..c1af99dba08d 100644
--- a/drivers/char/tpm/tpm-library.h
+++ b/drivers/char/tpm/tpm-library.h
@@ -29,25 +29,25 @@ struct tpm_osapsess {
 	struct tpm_even_nonce enonce;
 };
 
-static inline void store8(struct tpm_buf *buf, const unsigned char value)
+static inline void store_8(struct tpm_buf *buf, unsigned char value)
 {
 	buf->data[buf->len++] = value;
 }
 
-static inline void store16(struct tpm_buf *buf, const uint16_t value)
+static inline void store16(struct tpm_buf *buf, uint16_t value)
 {
-	*(uint16_t *) & buf->data[buf->len] = htons(value);
+	*(uint16_t *)&buf->data[buf->len] = htons(value);
 	buf->len += sizeof value;
 }
 
-static inline void store32(struct tpm_buf *buf, const uint32_t value)
+static inline void store32(struct tpm_buf *buf, uint32_t value)
 {
-	*(uint32_t *) & buf->data[buf->len] = htonl(value);
+	*(uint32_t *)&buf->data[buf->len] = htonl(value);
 	buf->len += sizeof value;
 }
 
-static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
-			      const int len)
+static inline void store_s(struct tpm_buf *buf, const unsigned char *in,
+			   int len)
 {
 	memcpy(buf->data + buf->len, in, len);
 	buf->len += len;
