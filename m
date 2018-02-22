From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Feb 2018 16:20:41 +0000
Subject: [PATCH 2/6] PKCS#7: fix certificate blacklisting
Message-Id: <151931644086.27713.11709941422438272479.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If there is a blacklisted certificate in a SignerInfo's certificate
chain, then pkcs7_verify_sig_chain() sets sinfo->blacklisted and returns
0.  But, pkcs7_verify() fails to handle this case appropriately, as it
actually continues on to the line 'actual_ret = 0;', indicating that the
SignerInfo has passed verification.  Consequently, PKCS#7 signature
verification ignores the certificate blacklist.

Fix this by not considering blacklisted SignerInfos to have passed
verification.

Also fix the function comment with regards to when 0 is returned.

Fixes: 03bb79315ddc ("PKCS#7: Handle blacklisted certificates")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/pkcs7_verify.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 2f6a768b91d7..97c77f66b20d 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -366,8 +366,7 @@ static int pkcs7_verify_one(struct pkcs7_message *pkcs7,
  *
  *  (*) -EBADMSG if some part of the message was invalid, or:
  *
- *  (*) 0 if no signature chains were found to be blacklisted or to contain
- *	unsupported crypto, or:
+ *  (*) 0 if a signature chain passed verification, or:
  *
  *  (*) -EKEYREJECTED if a blacklisted key was encountered, or:
  *
@@ -423,8 +422,11 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
 		ret = pkcs7_verify_one(pkcs7, sinfo);
-		if (sinfo->blacklisted && actual_ret = -ENOPKG)
-			actual_ret = -EKEYREJECTED;
+		if (sinfo->blacklisted) {
+			if (actual_ret = -ENOPKG)
+				actual_ret = -EKEYREJECTED;
+			continue;
+		}
 		if (ret < 0) {
 			if (ret = -ENOPKG) {
 				sinfo->unsupported_crypto = true;

