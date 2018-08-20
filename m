From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 20 Aug 2018 21:52:26 +0000
Subject: [PATCH 2/2] public_key: Don't erroneously call akcipher_verify
Message-Id: <20180820215226.20661-3-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The code in software_key_eds_op was already calling the relevant
akcipher_* operation.  So the call to akcipher_verify was an error
(likely due to a copy-paste oversight).

Fixes: 92daec927531 KEYS: Implement encrypt, decrypt and sign for software asymmetric key
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/public_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index f774d34779a5..f5d85b47fcc6 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -206,7 +206,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 		BUG();
 	}
 
-	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+	ret = crypto_wait_req(ret, &cwait);
 	if (ret = 0)
 		ret = req->dst_len;
 
-- 
2.16.1
