From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Date: Fri, 22 Mar 2019 06:27:38 +0000
Subject: [PATCH] X.509: Add messages for obsolete OIDs
Message-Id: <20190322062738.19852-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>

We found that the db in Acer machine has self signed certificates
(CN=3DDisablePW or CN=ABO) that they used obsolete OID 1.3.14.3.2.29
sha1WithRSASignature and 2.5.29.1 subjectKeyIdentifier. Kernel
emits -65 error code when loading those certificates to platform
keyring:

[    1.484388] integrity: Loading X.509 certificate: UEFI:MokListRT
[    1.485557] integrity: Problem loading X.509 certificate -65
[    1.486100] Error adding keys to platform keyring UEFI:MokListRT

Because the -65 error code is not enough for appeasing user when
loading a outdated certificate. This patch add messages against
1.3.14.3.2.29 and 2.5.29.1 OIDs.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1129471
Cc: David Howells <dhowells@redhat.com>=20
Cc: Herbert Xu <herbert@gondor.apana.org.au>=20
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 7 +++++++
 include/linux/oid_registry.h              | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_=
keys/x509_cert_parser.c
index 991f4d735a4e..bbd22d5c5b5d 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -192,6 +192,8 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	pr_debug("PubKey Algo: %u\n", ctx->last_oid);
=20
 	switch (ctx->last_oid) {
+	case OID_sha1WithRSASignature:
+		pr_info("1.3.14.3.2.29 sha1WithRSASignature is obsolete.\n");
 	case OID_md2WithRSAEncryption:
 	case OID_md3WithRSAEncryption:
 	default:
@@ -464,6 +466,11 @@ int x509_process_extension(void *context, size_t hdrle=
n,
 		return 0;
 	}
=20
+	if (ctx->last_oid =3D OID_subjectKeyIdentifier_obsolete) {
+		pr_info("2.5.29.1 subjectKeyIdentifier OID is obsolete.\n");
+		return -ENOPKG;
+	}
+
 	return 0;
 }
=20
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index d2fa9ca42e9a..0641d5aa2251 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -62,6 +62,7 @@ enum OID {
=20
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_sha1,			/* 1.3.14.3.2.26 */
+	OID_sha1WithRSASignature,	/* 1.3.14.3.2.29 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
@@ -83,6 +84,7 @@ enum OID {
 	OID_generationalQualifier,	/* 2.5.4.44 */
=20
 	/* Certificate extension IDs */
+	OID_subjectKeyIdentifier_obsolete,	/* 2.5.29.1 */
 	OID_subjectKeyIdentifier,	/* 2.5.29.14 */
 	OID_keyUsage,			/* 2.5.29.15 */
 	OID_subjectAltName,		/* 2.5.29.17 */
--=20
2.16.4
