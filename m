From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:26:49 +0000
Subject: [PATCH 02/17] tpm-buf: add handling for TPM2B types
Message-Id: <20200518172704.29608-3-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Most complex TPM commands require appending TPM2B buffers to the
command body.  Since TPM2B types are essentially variable size arrays,
it makes it impossible to represent these complex command arguments as
structures and we simply have to build them up using append primitives
like these.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 47 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h     |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 9fa8a9cb0fdf..8c1ed8a14e01 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -8,6 +8,8 @@
 
 #include <linux/module.h>
 
+#include <asm/unaligned.h>
+
 static int __tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data_page = alloc_page(GFP_HIGHUSER);
@@ -46,6 +48,24 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_init);
 
+int tpm_buf_init_2b(struct tpm_buf *buf)
+{
+	struct tpm_header *head;
+	int rc;
+
+	rc = __tpm_buf_init(buf);
+	if (rc)
+		return rc;
+
+	head = (struct tpm_header *) buf->data;
+
+	head->length = cpu_to_be32(sizeof(*head));
+
+	buf->flags = TPM_BUF_2B;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
+
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	kunmap(buf->data_page);
@@ -53,6 +73,13 @@ void tpm_buf_destroy(struct tpm_buf *buf)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 
+static void *tpm_buf_data(struct tpm_buf *buf)
+{
+	if (buf->flags & TPM_BUF_2B)
+		return buf->data + TPM_HEADER_SIZE;
+	return buf->data;
+}
+
 u32 tpm_buf_length(struct tpm_buf *buf)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
@@ -116,3 +143,23 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *) &value2, 4);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
+
+static void tpm_buf_reset_int(struct tpm_buf *buf)
+{
+	struct tpm_header *head;
+
+	head = (struct tpm_header *)buf->data;
+	head->length = cpu_to_be32(sizeof(*head));
+}
+
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
+{
+	u16 len = tpm_buf_length(tpm2b);
+
+	tpm_buf_append_u16(buf, len);
+	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
+	/* clear the buf for reuse */
+	tpm_buf_reset_int(tpm2b);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
+
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 379629704522..dfa03b63d8ee 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -155,6 +155,7 @@ enum tpm_sub_capabilities {
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_2b(struct tpm_buf *buf);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
@@ -162,6 +163,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
 
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
-- 
2.21.1
