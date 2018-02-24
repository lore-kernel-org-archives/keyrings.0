From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sat, 24 Feb 2018 16:03:12 +0000
Subject: [PATCH 1/3] X.509: unpack RSA signatureValue field from BIT STRING
Message-Id: <44885af5-b1f5-30cb-5f51-226949cb11a6@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
For RSA signatures this BIT STRING is of so-called primitive subtype, which
contains a u8 prefix indicating a count of unused bits in the encoding.

We have to strip this prefix from signature data, just as we already do for
key data in x509_extract_key_data() function.

This wasn't noticed earlier because this prefix byte is zero for RSA key
sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
prefixes has no bearing on its value.

The signature length, however was incorrect, which is a problem for RSA
implementations that need it to be exactly correct (like AMD CCP).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.509 certificates")
Cc: stable@vger.kernel.org
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ce2df8c9c583..88c26a4538ae 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -249,6 +249,15 @@ int x509_note_signature(void *context, size_t hdrlen,
 		return -EINVAL;
 	}
 
+	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {
+		/* Discard the BIT STRING metadata */
+		if (vlen < 1 || *(const u8 *)value != 0)
+			return -EBADMSG;
+
+		value++;
+		vlen--;
+	}
+
 	ctx->cert->raw_sig = value;
 	ctx->cert->raw_sig_size = vlen;
 	return 0;
