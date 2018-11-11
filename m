From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 11 Nov 2018 14:29:53 +0000
Subject: [PATCH] integrity: support new struct public_key_signature encoding field
Message-Id: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>

On systems with IMA-appraisal enabled with a policy requiring file
signatures, the "good" signature values are stored on the filesystem as
extended attributes (security.ima).  Signature verification failure
would normally be limited to just a particular file (eg. executable),
but during boot signature verification failure could result in a system
hang.

Defining and requiring a new public_key_signature field requires all
callers of asymmetric signature verification to be updated to reflect
the change.  This patch updates the integrity asymmetric_verify()
caller.

Fixes: 82f94f24475c ("KEYS: Provide software public key query function [ver #2]")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Denis Kenzior <denkenz@gmail.com>
---
 security/integrity/digsig_asymmetric.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6dc075144508..d775e03fbbcc 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -106,6 +106,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 
 	pks.pkey_algo = "rsa";
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
+	pks.encoding = "pkcs1";
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
-- 
2.7.5
