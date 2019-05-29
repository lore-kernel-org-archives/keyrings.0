From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 29 May 2019 21:01:32 +0000
Subject: [PATCH RESEND] KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails
Message-Id: <20190529210132.120114-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

No error code was being set on this error path.

Fixes: ad4b1eb5fb33 ("KEYS: asym_tpm: Implement encryption operation [ver #2]")
Fixes: c08fed737126 ("KEYS: Implement encrypt, decrypt and sign for software asymmetric key [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/asym_tpm.c   | 1 +
 crypto/asymmetric_keys/public_key.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 76d2ce3a1b5b1..5154e280ada22 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -486,6 +486,7 @@ static int tpm_key_encrypt(struct tpm_key *tk,
 	if (ret < 0)
 		goto error_free_tfm;
 
+	ret = -ENOMEM;
 	req = akcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
 		goto error_free_tfm;
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 364b9df9d631f..d7f43d4ea925a 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -184,6 +184,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
+	ret = -ENOMEM;
 	req = akcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
 		goto error_free_tfm;
-- 
2.22.0.rc1.257.g3120a18244-goog
