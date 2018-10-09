From: David Howells <dhowells@redhat.com>
Date: Tue, 09 Oct 2018 16:47:15 +0000
Subject: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type [ver #2]
Message-Id: <153910363539.12141.4210082234235945107.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
To: jmorris@namei.org
Cc: Marcel Holtmann <marcel@holtmann.org>Marcel Holtmann <marcel@holtmann.org>, Denis Kenzior <denkenz@gmail.com>Denis Kenzior <denkenz@gmail.com>, dhowells@redhat.comdenkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Make the X.509 and PKCS7 parsers fill in the signature encoding type field
recently added to the public_key_signature struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Denis Kenzior <denkenz@gmail.com>
Tested-by: Denis Kenzior <denkenz@gmail.com>
---

 crypto/asymmetric_keys/pkcs7_parser.c     |    1 +
 crypto/asymmetric_keys/x509_cert_parser.c |   21 +++++++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 0f134162cef4..f0d56e1a8b7e 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -271,6 +271,7 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 	switch (ctx->last_oid) {
 	case OID_rsaEncryption:
 		ctx->sinfo->sig->pkey_algo = "rsa";
+		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
 	default:
 		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index b6cabac4b62b..991f4d735a4e 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -199,35 +199,32 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 
 	case OID_md4WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "md4";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha1WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha1";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha256WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha256";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha384WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha384";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha512WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha512";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha224WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha224";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 	}
 
+rsa_pkcs1:
+	ctx->cert->sig->pkey_algo = "rsa";
+	ctx->cert->sig->encoding = "pkcs1";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
 }
