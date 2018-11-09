From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 09 Nov 2018 05:59:26 +0000
Subject: [PATCH] KEYS: revert requiring signature "encoding"
Message-Id: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Attempting to verify IMA signatures fail causing the system to hang.

Fixes: commit 82f94f24475c ("KEYS: Provide software public key query
       function [ver #2]")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 crypto/asymmetric_keys/public_key.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index f5d85b47fcc6..f90360122090 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -239,9 +239,17 @@ int public_key_verify_signature(const struct public_key *pkey,
 	BUG_ON(!sig);
 	BUG_ON(!sig->s);
 
-	ret = software_key_determine_akcipher(sig->encoding,
-					      sig->hash_algo,
-					      pkey, alg_name);
+	if (!sig->digest)
+		return -ENOPKG;
+
+	if (!(sig->encoding) && strcmp(pkey->pkey_algo, "rsa") = 0)
+		ret = software_key_determine_akcipher("pkcs1",
+						      sig->hash_algo,
+						      pkey, alg_name);
+	else
+		ret = software_key_determine_akcipher(sig->encoding,
+						      sig->hash_algo,
+						      pkey, alg_name);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.5
