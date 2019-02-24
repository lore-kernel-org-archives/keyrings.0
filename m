From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:08:19 +0000
Subject: [PATCH v5 01/10] KEYS: report to keyctl only actually supported key ops
Message-Id: <20190224060828.2527-2-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Because with the introduction of EC-RDSA and change in workings of RSA
in regard to sign/verify, akcipher may have not all callbacks defined,
report to keyctl only actually supported ops determined by the presence
of the akcipher callbacks.

Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/asymmetric_keys/public_key.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index f5d85b47fcc6..c2e4e73fcf06 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -130,11 +130,17 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->max_sig_size = len;
 	info->max_enc_size = len;
 	info->max_dec_size = len;
-	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
-			       KEYCTL_SUPPORTS_VERIFY);
-	if (pkey->key_is_private)
-		info->supported_ops |= (KEYCTL_SUPPORTS_DECRYPT |
-					KEYCTL_SUPPORTS_SIGN);
+	info->supported_ops = 0;
+	if (crypto_akcipher_alg(tfm)->verify)
+		info->supported_ops |= KEYCTL_SUPPORTS_VERIFY;
+	if (crypto_akcipher_alg(tfm)->encrypt)
+		info->supported_ops |= KEYCTL_SUPPORTS_ENCRYPT;
+	if (pkey->key_is_private) {
+		if (crypto_akcipher_alg(tfm)->decrypt)
+			info->supported_ops |= KEYCTL_SUPPORTS_DECRYPT;
+		if (crypto_akcipher_alg(tfm)->sign)
+			info->supported_ops |= KEYCTL_SUPPORTS_SIGN;
+	}
 	ret = 0;
 
 error_free_tfm:
-- 
2.11.0
