From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Fri, 16 Nov 2018 20:07:11 +0000
Subject: [PATCH v8 13/14] ima: Write modsig to the measurement list
Message-Id: <20181116200712.14154-14-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Add modsig support to the "sig" template field, allowing the the contents
of the modsig to be included in the measurement list.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h              |  7 +++++++
 security/integrity/ima/ima_modsig.c       | 13 +++++++++++++
 security/integrity/ima/ima_template_lib.c | 15 ++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7f88e4b86156..8e1b1ddbe14f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -315,6 +315,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    int *xattr_len);
 int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
 			const u8 **hash, u8 *len);
+int ima_modsig_serialize_data(struct evm_ima_xattr_data **data, int *data_len);
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr);
 void ima_free_xattr_data(struct evm_ima_xattr_data *hdr);
@@ -339,6 +340,12 @@ static inline int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr,
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_modsig_serialize_data(struct evm_ima_xattr_data **data,
+					    int *data_len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ima_modsig_verify(const unsigned int keyring_id,
 				    struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 584d9d77b2c4..e31ab7dc11db 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -167,6 +167,19 @@ int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
 	return pkcs7_get_digest(modsig->pkcs7_msg, hash, len);
 }
 
+int ima_modsig_serialize_data(struct evm_ima_xattr_data **data, int *data_len)
+{
+	struct modsig_hdr *modsig = (struct modsig_hdr *) *data;
+
+	if (!*data || (*data)->type != IMA_MODSIG)
+		return -EINVAL;
+
+	*data = &modsig->raw_pkcs7;
+	*data_len = modsig->raw_pkcs7_len;
+
+	return 0;
+}
+
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 36d175816894..417cd153ba60 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -411,10 +411,23 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data)
 {
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+	int xattr_len = event_data->xattr_len;
 
 	if (!is_signed(xattr_value))
 		return 0;
 
-	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
+	/*
+	 * The xattr_value for IMA_MODSIG is a runtime structure containing
+	 * pointers. Get its raw data instead.
+	 */
+	if (xattr_value->type = IMA_MODSIG) {
+		int rc;
+
+		rc = ima_modsig_serialize_data(&xattr_value, &xattr_len);
+		if (rc)
+			return rc;
+	}
+
+	return ima_write_template_field_data(xattr_value, xattr_len,
 					     DATA_FMT_HEX, field_data);
 }
