From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Dec 2019 00:06:07 +0000
Subject: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <1575936367.31378.52.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

We have a need in the TPM trusted keys to return the ASN.1 form of the
TPM key blob so it can be operated on by tools outside of the kernel.
To do that, we have to be able to read and write the key format.  The
current ASN.1 decoder does fine for reading, but we need pieces of an
ASN.1 encoder to return the key blob.

The current implementation only encodes the ASN.1 bits we actually need.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: updated API to use indefinite length, and made symbol exports gpl
---
 include/linux/asn1_encoder.h |  21 ++++
 lib/Makefile                 |   2 +-
 lib/asn1_encoder.c           | 258 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
new file mode 100644
index 000000000000..9cfb8035dc46
--- /dev/null
+++ b/include/linux/asn1_encoder.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_ASN1_ENCODER_H
+#define _LINUX_ASN1_ENCODER_H
+
+#include <linux/types.h>
+#include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
+
+#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
+void asn1_encode_integer(unsigned char **_data, s64 integer, int len);
+void asn1_encode_oid(unsigned char **_data, u32 oid[], int oid_len);
+void asn1_encode_tag(unsigned char **data, u32 tag,
+		     const unsigned char *string, int len);
+void asn1_encode_octet_string(unsigned char **data, const unsigned char *string,
+			      u32 len);
+void asn1_encode_sequence(unsigned char **data, const unsigned char *seq,
+			  int len);
+void asn1_encode_boolean(unsigned char **data, bool val);
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index c2f0e2a4e4e8..515b35f92c3c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -233,7 +233,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 
-obj-$(CONFIG_ASN1) += asn1_decoder.o
+obj-$(CONFIG_ASN1) += asn1_decoder.o asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
new file mode 100644
index 000000000000..768cabf8bf76
--- /dev/null
+++ b/lib/asn1_encoder.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple encoder primitives for ASN.1 BER/DER/CER
+ *
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/asn1_encoder.h>
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+/**
+ * asn1_encode_integer - encode positive integer to ASN.1
+ * @_data: pointer to the pointer to the data
+ * @integer: integer to be encoded
+ * @len: length of buffer
+ *
+ * This is a simplified encoder: it only currently does
+ * positive integers, but it should be simple enough to add the 
+ * negative case if a use comes along.
+ */
+void asn1_encode_integer(unsigned char **_data, s64 integer, int len)
+{
+	unsigned char *data = *_data, *d = &data[2];
+	int i;
+	bool found = false;
+
+	if (WARN(integer < 0,
+		 "BUG: asn1_encode_integer only supports positive integers"))
+		return;
+
+	if (WARN(len < 3,
+		 "BUG: buffer for integers must have at least 3 bytes"))
+		return;
+
+	len =- 2;
+
+	data[0] = _tag(UNIV, PRIM, INT);
+	if (integer = 0) {
+		*d++ = 0;
+		goto out;
+	}
+	for (i = sizeof(integer); i > 0 ; i--) {
+		int byte = integer >> (8*(i-1));
+
+		if (!found && byte = 0)
+			continue;
+		found = true;
+		if (byte & 0x80) {
+			/*
+			 * no check needed here, we already know we
+			 * have len >= 1
+			 */
+			*d++ = 0;
+			len--;
+		}
+		if (WARN(len = 0,
+			 "BUG buffer too short in asn1_encode_integer"))
+			return;
+		*d++ = byte;
+		len--;
+	}
+ out:
+	data[1] = d - data - 2;
+	*_data = d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_integer);
+
+/* calculate the base 128 digit values setting the top bit of the first octet */
+static void asn1_encode_oid_digit(unsigned char **_data, u32 oid)
+{
+	int start = 7 + 7 + 7 + 7;
+	unsigned char *data = *_data;
+
+	/* quick case */
+	if (oid = 0) {
+		*data++ = 0x80;
+		goto out;
+	}
+
+	while (oid >> start = 0)
+		start -= 7;
+
+	while (start > 0) {
+		u8 byte;
+
+		byte = oid >> start;
+		oid = oid - (byte << start);
+		start -= 7;
+		byte |= 0x80;
+		*data++ = byte;
+	}
+	*data++ = oid;
+
+ out:
+	*_data = data;
+}
+
+/**
+ * asn1_encode_oid - encode an oid to ASN.1
+ * @_data: position to begin encoding at
+ * @oid: array of oids
+ * @oid_len: length of oid array
+ *
+ * this encodes an OID up to ASN.1 when presented as an array of OID values
+ */
+void asn1_encode_oid(unsigned char **_data, u32 oid[], int oid_len)
+{
+	unsigned char *data = *_data;
+	unsigned char *d = data + 2;
+	int i;
+
+	if (WARN(oid_len < 2, "OID must have at least two elements"))
+		return;
+	if (WARN(oid_len > 32, "OID is too large"))
+		return;
+
+	data[0] = _tag(UNIV, PRIM, OID);
+	*d++ = oid[0] * 40 + oid[1];
+	for (i = 2; i < oid_len; i++)
+		asn1_encode_oid_digit(&d, oid[i]);
+	data[1] = d - data - 2;
+	*_data = d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_oid);
+
+static void asn1_encode_length(unsigned char **data, int len)
+{
+	if (len < 0) {
+		*((*data)++) = ASN1_INDEFINITE_LENGTH;
+		return;
+	}
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		return;
+	}
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		return;
+	}
+	if (len <= 0xffff) {
+		*((*data)++) = 0x82;
+		*((*data)++) = (len >> 8) & 0xff;
+		*((*data)++) = len & 0xff;
+		return;
+	}
+
+	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
+		return;
+
+	*((*data)++) = 0x83;
+	*((*data)++) = (len >> 16) & 0xff;
+	*((*data)++) = (len >> 8) & 0xff;
+	*((*data)++) = len & 0xff;
+}
+
+/**
+ * asn1_encode_tag - add a tag for optional or explicit value
+ * @data: pointer to place tag at
+ * @tag: tag to be placed
+ * @string: the data to be tagged
+ * @len: the length of the data to be tagged
+ *
+ * Note this currently only handles short form tags < 31.  To encode
+ * in place pass a NULL @string and -1 for @len; all this will do is
+ * add an indefinite length tag and update the data pointer to the
+ * place where the tag contents should be placed.  After the data is
+ * placed, repeat the prior statement but now with the known length.
+ * In order to avoid having to keep both before and after pointers,
+ * the repeat expects to be called with @data pointing to where the
+ * first encode placed it.
+ */
+void asn1_encode_tag(unsigned char **data, u32 tag,
+		     const unsigned char *string, int len)
+{
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return;
+
+	if (!string && WARN(len > 127,
+			    "BUG: recode tag is too big (>127)"))
+		return;
+
+	if (!string && len > 0)
+		/* we're recoding, so move back to the start of the tag */
+		*data -= 2;
+
+	*((*data)++) = _tagn(CONT, CONS, tag);
+	asn1_encode_length(data, len);
+	if (!string)
+		return;
+	memcpy(*data, string, len);
+	*data += len;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_tag);
+
+/**
+ * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
+ * @data: pointer to encode at
+ * @string: string to be encoded
+ * @len: length of string
+ *
+ * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
+ */
+void asn1_encode_octet_string(unsigned char **data, const unsigned char *string,
+			      u32 len)
+{
+	*((*data)++) = _tag(UNIV, PRIM, OTS);
+	asn1_encode_length(data, len);
+	memcpy(*data, string, len);
+	*data += len;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_octet_string);
+
+/**
+ * asn1_encode_sequence - wrap a byte stream in an ASN.1 SEQUENCE
+ * @data: pointer to encode at
+ * @seq: data to be encoded as a sequence
+ * @len: length of the data to be encoded as a sequence
+ *
+ * Fill in a sequence.  To encode in place, pass NULL for @seq and -1
+ * for @len; then call again once the length is known (still with NULL
+ * for @seq). In order to avoid having to keep both before and after
+ * pointers, the repeat expects to be called with @data pointing to
+ * where the first encode placed it.
+ */
+void asn1_encode_sequence(unsigned char **data, const unsigned char *seq,
+			  int len)
+{
+	if (!seq && WARN(len > 127,
+			 "BUG: recode sequence is too big (>127)"))
+		return;
+	if (!seq && len > 0)
+		/* we're recoding, so move back to the start of the sequence */
+		*data -= 2;
+		
+	*((*data)++) = _tag(UNIV, CONS, SEQ);
+	asn1_encode_length(data, len);
+	if (!seq)
+		return;
+	memcpy(*data, seq, len);
+	*data += len;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_sequence);
+
+/**
+ * asn1_encode_boolean - encode a boolean value to ASN.1
+ * @data: pointer to encode at
+ * @val: the boolean true/false value
+ */
+void asn1_encode_boolean(unsigned char **data, bool val)
+{
+	*((*data)++) = _tag(UNIV, PRIM, BOOL);
+	asn1_encode_length(data, 1);
+	*((*data)++) = val ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_boolean);
-- 
2.16.4
