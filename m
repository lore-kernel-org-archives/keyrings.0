From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Feb 2018 16:20:47 +0000
Subject: [PATCH 3/6] PKCS#7: fix direct verification of SignerInfo signature
Message-Id: <151931644754.27713.14995018428445770576.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If none of the certificates in a SignerInfo's certificate chain match a
trusted key, nor is the last certificate signed by a trusted key, then
pkcs7_validate_trust_one() tries to check whether the SignerInfo's
signature was made directly by a trusted key.  But, it actually fails to
set the 'sig' variable correctly, so it actually verifies the last
signature seen.  That will only be the SignerInfo's signature if the
certificate chain is empty; otherwise it will actually be the last
certificate's signature.

This is not by itself a security problem, since verifying any of the
certificates in the chain should be sufficient to verify the SignerInfo.
Still, it's not working as intended so it should be fixed.

Fix it by setting 'sig' correctly for the direct verification case.

Fixes: 757932e6da6d ("PKCS#7: Handle PKCS#7 messages that contain no X.509 certs")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/pkcs7_trust.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 1f4e25f10049..598906b1e28d 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -106,6 +106,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 		pr_devel("sinfo %u: Direct signer is key %x\n",
 			 sinfo->index, key_serial(key));
 		x509 = NULL;
+		sig = sinfo->sig;
 		goto matched;
 	}
 	if (PTR_ERR(key) != -ENOKEY)

