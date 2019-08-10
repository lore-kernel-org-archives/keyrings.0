From: "Yihao Wu" <yihao.wyh@alibaba-inc.com>
Date: Sat, 10 Aug 2019 18:29:00 +0000
Subject: [PATCH] KEYS: pass expiry from X.509 cert to key structure
Message-Id: <ebc38740-53b8-0008-9697-c4d39e98a958@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Expiry time is not utilized by X.509 cert yet. This patch reads expiry
from X.509 cert into key_preparsed_payload. Then it is passed to key
structure when the key is being instantiated.

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index d964cc82b69c..6315da3b21c3 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -227,6 +227,7 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
     prep->payload.data[asym_auth] = cert->sig;
     prep->description = desc;
     prep->quotalen = 100;
+    prep->expiry = cert->valid_to;
 
     /* We've finished with the certificate */
     cert->pub = NULL;
-- 
2.21.0
