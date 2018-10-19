From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Fri, 19 Oct 2018 22:13:45 +0000
Subject: [RESEND][PATCH] KEYS: Handle missing Authority Key Identifier x509 extension
Message-Id: <20181019221345.24618-1-andrew.zaborowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180505060152.21571-1-andrew.zaborowski@intel.com>
In-Reply-To: <20180505060152.21571-1-andrew.zaborowski@intel.com>
To: keyrings@vger.kernel.org

If the certificate is self-signed and the Key Identifier is not present
in the Authority Key Identifier extension (RFC5280 4.2.1.1), fill in the
sig->auth_ids values with the certificate's own key IDs since they must
be the same.  A note in 4.2.1.1 makes the AKID keyIdentifier optional
in self-signed certificates as an exception.

There are root certificates in use where this is the case.  This would
affect the checks in the restrict functions in
crypto/asymmetric_keys/restrict.c.  As a consequence the restrict
functions would behave differently depending on whether the (optional)
AKID was found or not.

The asymmetric_key_generate_id return value is not checked because it's
already succeeded once at this point.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index b6cabac4b6..1424f20703 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -130,6 +130,25 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 	if (ret < 0)
 		goto error_decode;
 
+	if (cert->self_signed) {
+		if (!cert->sig->auth_ids[0]) {
+			/* Duplicate cert->id */
+			kid = asymmetric_key_generate_id(cert->raw_serial,
+							 cert->raw_serial_size,
+							 cert->raw_issuer,
+							 cert->raw_issuer_size);
+			cert->sig->auth_ids[0] = kid;
+		}
+
+		if (!cert->sig->auth_ids[1] && cert->skid) {
+			/* Duplicate cert->skid */
+			kid = asymmetric_key_generate_id(cert->raw_skid,
+							 cert->raw_skid_size,
+							 "", 0);
+			cert->sig->auth_ids[1] = kid;
+		}
+	}
+
 	kfree(ctx);
 	return cert;
 
-- 
2.14.1
