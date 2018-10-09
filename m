From: David Howells <dhowells@redhat.com>
Date: Tue, 09 Oct 2018 16:47:31 +0000
Subject: [PATCH 06/22] KEYS: Allow the public_key struct to hold a private key [ver #2]
Message-Id: <153910365097.12141.17819540114453509322.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
To: jmorris@namei.org
Cc: Marcel Holtmann <marcel@holtmann.org>Marcel Holtmann <marcel@holtmann.org>, Denis Kenzior <denkenz@gmail.com>Denis Kenzior <denkenz@gmail.com>, dhowells@redhat.comdenkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Put a flag in the public_key struct to indicate if the structure is holding
a private key.  The private key must be held ASN.1 encoded in the format
specified in RFC 3447 A.1.2.  This is the form required by crypto/rsa.c.

The software encryption subtype's verification and query functions then
need to select the appropriate crypto function to set the key.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Denis Kenzior <denkenz@gmail.com>
Tested-by: Denis Kenzior <denkenz@gmail.com>
---

 crypto/asymmetric_keys/public_key.c |   14 ++++++++++++--
 include/crypto/public_key.h         |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 761bfab352dc..f2dc27897319 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -115,7 +115,12 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	ret = crypto_akcipher_set_pub_key(tfm, pkey->key, pkey->keylen);
+	if (pkey->key_is_private)
+		ret = crypto_akcipher_set_priv_key(tfm,
+						   pkey->key, pkey->keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(tfm,
+						  pkey->key, pkey->keylen);
 	if (ret < 0)
 		goto error_free_tfm;
 
@@ -170,7 +175,12 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (!req)
 		goto error_free_tfm;
 
-	ret = crypto_akcipher_set_pub_key(tfm, pkey->key, pkey->keylen);
+	if (pkey->key_is_private)
+		ret = crypto_akcipher_set_priv_key(tfm,
+						   pkey->key, pkey->keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(tfm,
+						  pkey->key, pkey->keylen);
 	if (ret)
 		goto error_free_req;
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 3a1047a0195c..be626eac9113 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -25,6 +25,7 @@
 struct public_key {
 	void *key;
 	u32 keylen;
+	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
 };
