Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702367;
	b=e4aoQdaoAdCTSDtUoM8TPb9rkhq7eG5lN8Dx+usKHc6O+/FZed4qvc7bcVsLdfgxuptN
	 yiq02Xzy5ph9KNIXuZ5D7MQ3nFOGpttphwyaPZ6H2nXId6WdijLPNYSsb9jZjcbDfRDvJ
	 06qSqvkxcpd+5RorgLQ5jZ8y1lcWZjHJK/e8jAlhj8AD+yolRG/3UYuQ7HCoVQMs222gI
	 KJF2nb0dHeALL0b6hNC0+RdxsHTpa95hkVJ/u5sCWOuJSmz2GMboHb23kfQi4cEy0mhNJ
	 BSV0g6pNJTm0g8XYJM0cCUPrwtQ3gOp0Se5xVehgVji+kMViFWaQtYhKNXZvya3pO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702367;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qy534Nh6u8nxp1iATIjUdHcOokDpVqgScyiiSAKQSJQ=;
	b=yU4Jr6yGXOa9xChzDcoG9z030HCNSgxhVuCXBV8tEb/tuoXA6ft9eWZCyOb5/UfgqhWi
	 XAkZfo1DApSCKyLUIhMkMcgEuAbZ1YolKMMCXVAWIYfFpRcs8MNKQVgW59Ti61q4MCSHF
	 KBHGy4kzxnh+8MCiYbaqNog0eDRNvoLbeiCg4fqLulSiRqZ5TO2wOhHJvc/zGf5hy3Bdt
	 wDXExixlnjK0Fj/2DdGWuhAJcShOJ/qO6Ug+nwumSd2DceeaRNZRZ7nudUFNPUs7RhRpI
	 PTgKEQxBfRfauVF3nu53k30qSr5MmwUmgCU3/NdV85kxVn37sC06IdUg2/4V1UbblBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1EKHhkn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82866606A327;
	Thu, 26 Nov 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1EKHhkn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB51F000C0;
	Thu, 26 Nov 2026 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702367;
	bh=qy534Nh6u8nxp1iATIjUdHcOokDpVqgScyiiSAKQSJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R1EKHhkndglncBLR/7yV5f146vyG/P45cf3/X7a2hERebjS5aA7rBCMqUePpyCX/T
	 r+nQuln6ImSCU1SJGMS2xCuuTmLVc50Km5RQDv4i1wJwKPKelIRB/ORFVK3mPpFGDm
	 DlJX4VpCzWA23XGqaq0CfAmZIrcZCKjYj2O9SbrLzo1U52X3AVXJwglJQ4gAfiiACd
	 0req1YfJ1TN/brW+VopAkoI0W8sT6yher1v+zvO1JaWz0/uRyLA4vCIzt4G/6UvQQA
	 mD2G4RuTVX4AYgJnY5ae4HZCWbCCMvL0DoWmTyKFMEvlyo/GWZ4kitC24C4ZfDKCNB
	 eWCR9YY7zd4sA==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:20 +0100
Subject: [PATCH v7 02/14] nvme-keyring: add 'dhchap' key type
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-2-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=7718;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=mruuFQ6Nv7hQzDnYvL7H0xG1+BGTRwzkr6zy0ykps/4=;
 b=EKnNRGouqsKII5oIZB2GUkn/1mx4Jhwg2zWQ7/C0g6agSjNCVBHT8QF+uIk8OFxmESowb7FF2
 XQ3S6oPmbD0BxL9gQ2wCAZbj6qTxgsikM+fio9F5aZa/i1L4gQ9qreq
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
Keys are stored with a 'user-type' compatible payload, such
that one can use 'user_read()' to access the raw contents
and the 'read()' callback to get the base64-encoded key
data in the DH-HMAC-CHAP secret representation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/Kconfig   |   1 +
 drivers/nvme/common/keyring.c | 209 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index f1639db65fd38abde01832a7404cbc48cf49a93e..24c893c71d86527c1cdf3adace2151f2894afbb6 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -3,6 +3,7 @@
 config NVME_KEYRING
        tristate
        select KEYS
+       select CRC32
 
 config NVME_AUTH
 	tristate
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 87cb51e1f5a7f330af4705f4058f661d15f5984a..de8dab10fa1059d8bfc2351edd7bb68ee52207a5 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/module.h>
+#include <linux/crc32.h>
+#include <linux/base64.h>
+#include <linux/unaligned.h>
 #include <linux/seq_file.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -253,6 +256,205 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
 
+static void nvme_dhchap_psk_describe(const struct key *key, struct seq_file *m)
+{
+	seq_puts(m, key->description);
+	seq_printf(m, ": %u", key->datalen);
+}
+
+/**
+ * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
+ * @prep: preparsed payload of the key data
+ *
+ * Decode the DH-HMAC-CHAP key data passed in @prep and
+ * store the resulting binary data. The binary data includes
+ * space for the CRC, the version, and the hmac identifier,
+ * but the data length is just the key data without the CRC.
+ * This allows the user to read the key data via the
+ * 'user_read()' function. The additional 'version' ahd 'hmac'
+ * data is used in the ->read() callback to generate the
+ * base64 encoded key.
+ */
+static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
+{
+	struct user_key_payload *upayload;
+	size_t datalen = prep->datalen;
+	int ret = -EINVAL, offset = 0;
+	char *p;
+	u32 crc;
+	u8 version, hmac;
+
+	if (!prep->data || prep->datalen < 10) {
+		pr_debug("%s: Invalid key data", __func__);
+		goto out_err;
+	}
+	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
+		   &version, &hmac, &offset) != 2 || offset != 10) {
+		pr_debug("%s: invalid key header\n", __func__);
+		goto out_err;
+	}
+
+	if (version != 1 || hmac > 3) {
+		pr_debug("%s: invalid key version\n", __func__);
+		goto out_err;
+	}
+
+	/* skip header and final ':' character */
+	if (offset > prep->datalen) {
+		pr_debug("%s: invalid key data\n", __func__);
+		goto out_err;
+	}
+	datalen = prep->datalen - offset;
+	p = memchr(prep->data + offset, ':', datalen);
+	if (p) {
+		datalen = (p - (char *)prep->data);
+		datalen -= offset;
+	}
+
+	/*
+	 * payload is < key | version | hmac >
+	 * base64 decode will always return less data
+	 * than the encoded data, so allocating the size
+	 * of the encoded data will be large enough.
+	 */
+	upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	if (!upayload) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	/* decode the data */
+	prep->payload.data[0] = upayload;
+	ret = base64_decode(prep->data + offset, datalen, upayload->data,
+			    true, BASE64_STD);
+	if (ret < 0) {
+		pr_debug("%s: Failed to decode key\n", __func__);
+		ret = -EINVAL;
+		goto out_free;
+	}
+	if (ret != 36 && ret != 52 && ret != 68) {
+		pr_debug("%s: invalid decoded key size '%d'\n",
+			 __func__, ret);
+		ret = -EINVAL;
+		goto out_free;
+	}
+	ret -= 4;
+	crc = ~crc32(~0, upayload->data, ret);
+	if (get_unaligned_le32(upayload->data + ret) != crc) {
+		/* CRC mismatch */
+		pr_debug("%s: CRC mismatch for key\n", __func__);
+		ret = -EKEYREJECTED;
+		goto out_free;
+	}
+	/* append version and hmac to the payload */
+	upayload->data[ret + 4] = version;
+	upayload->data[ret + 5] = hmac;
+	upayload->datalen = ret;
+	prep->quotalen = ret + 6;
+	return 0;
+out_free:
+	kfree_sensitive(upayload);
+out_err:
+	prep->payload.data[0] = NULL;
+	prep->quotalen = 0;
+	return ret;
+}
+
+/**
+ * nvme_dhchap_encoded_key_size - Size of the base64-encoded key
+ * @size: size of the encoded key
+ *
+ * Returns the expected size of the key after base64 decoding
+ * include 4 bytes of CRC.
+ */
+static inline int nvme_dhchap_encoded_key_size(int size)
+{
+	int keylen = -EINVAL;
+
+	switch (size) {
+	case 32:
+		keylen = 48;
+		break;
+	case 48:
+		keylen = 72;
+		break;
+	case 64:
+		keylen = 92;
+		break;
+	default:
+		break;
+	}
+	return keylen;
+}
+
+/**
+ * nvme_dhchap_psk_read - read callback for dhchap key types
+ * @key: key to read from
+ * @buffer: buffer for the key contents
+ * @buflen: length of @buffer
+ *
+ * Formats the DH-HMAC-CHAP key in base64-encoded form as
+ * defined in the NVM Express TCP Transport Specification Rev 1.1,
+ * Section 3.6.1.5 'PSK Interchange Format'. The payload of @key
+ * is assumed to be of 'struct user_key_payload', with the data
+ * consisting of the key data of length 'upayload->datalen', followed
+ * by four bytes of CRC, one byte version, and one byte hmac fields.
+ */
+static long nvme_dhchap_psk_read(const struct key *key,
+				 char *buffer, size_t buflen)
+{
+	const struct user_key_payload *upayload;
+	size_t datalen, keylen;
+	u8 version, hmac;
+	long ret;
+
+	upayload = user_key_payload_locked(key);
+	/*
+	 * Expected output string length:
+	 * strlen("DHHC-") +
+	 * version (= 1) +
+	 * ':' (= 1) +
+	 * hmac (= 2) +
+	 * ':' (= 1) +
+	 * encoded base64 key length +
+	 * ':' (= 1)
+	 */
+	ret = nvme_dhchap_encoded_key_size(upayload->datalen);
+	if (ret < 0)
+		return ret;
+	keylen = ret + 11;
+	if (!buffer || !buflen)
+		return keylen;
+	else if (buflen < keylen)
+		return -EINVAL;
+
+	memset(buffer, 0, buflen);
+	version = upayload->data[upayload->datalen + 4];
+	hmac = upayload->data[upayload->datalen + 5];
+	ret = sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
+	if (ret < 0)
+		return -ENOKEY;
+	/* Include the trailing CRC */
+	datalen = upayload->datalen + 4;
+	ret += base64_encode(upayload->data, datalen, buffer + ret,
+			     true, BASE64_STD);
+	buffer[ret] = ':';
+	ret++;
+	return ret;
+}
+
+static struct key_type nvme_dhchap_psk_key_type = {
+	.name           = "dhchap",
+	.flags          = KEY_TYPE_NET_DOMAIN,
+	.preparse       = nvme_dhchap_psk_preparse,
+	.free_preparse  = user_free_preparse,
+	.instantiate    = generic_key_instantiate,
+	.revoke         = user_revoke,
+	.destroy        = user_destroy,
+	.describe       = nvme_dhchap_psk_describe,
+	.read           = nvme_dhchap_psk_read,
+};
+
 static int __init nvme_keyring_init(void)
 {
 	int err;
@@ -271,11 +473,18 @@ static int __init nvme_keyring_init(void)
 		key_put(nvme_keyring);
 		return err;
 	}
+	err = register_key_type(&nvme_dhchap_psk_key_type);
+	if (err) {
+		unregister_key_type(&nvme_tls_psk_key_type);
+		key_put(nvme_keyring);
+		return err;
+	}
 	return 0;
 }
 
 static void __exit nvme_keyring_exit(void)
 {
+	unregister_key_type(&nvme_dhchap_psk_key_type);
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);

-- 
2.51.0

