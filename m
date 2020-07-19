From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 19 Jul 2020 18:07:34 +0000
Subject: [PATCH] crypto: asymmetric_keys: fix some comments in pkcs7_parser.h
Message-Id: <20200719180734.11812-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

Drop the doubled word "the" in a comment.
Change "THis" to "This".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
---
 crypto/asymmetric_keys/pkcs7_parser.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-next-20200717.orig/crypto/asymmetric_keys/pkcs7_parser.h
+++ linux-next-20200717/crypto/asymmetric_keys/pkcs7_parser.h
@@ -41,10 +41,9 @@ struct pkcs7_signed_info {
 	 *
 	 * This contains the generated digest of _either_ the Content Data or
 	 * the Authenticated Attributes [RFC2315 9.3].  If the latter, one of
-	 * the attributes contains the digest of the the Content Data within
-	 * it.
+	 * the attributes contains the digest of the Content Data within it.
 	 *
-	 * THis also contains the issuing cert serial number and issuer's name
+	 * This also contains the issuing cert serial number and issuer's name
 	 * [PKCS#7 or CMS ver 1] or issuing cert's SKID [CMS ver 3].
 	 */
 	struct public_key_signature *sig;
