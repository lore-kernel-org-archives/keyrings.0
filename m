From: Robert Holmes <robeholmes@gmail.com>
Date: Wed, 24 Apr 2019 14:33:51 +0000
Subject: [PATCH v2] KEYS: Make use of platform keyring for module signature verify
Message-Id: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jeyu@kernel.org, linux-kernel@vger.kernel.org
Cc: Robert Holmes <robeholmes@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, stable@vger.kernel.org

This patch completes commit 278311e417be ("kexec, KEYS: Make use of
platform keyring for signature verify") which, while adding the
platform keyring for bzImage verification, neglected to also add
this keyring for module verification.

As such, kernel modules signed with keys from the MokList variable
were not successfully verified.

Signed-off-by: Robert Holmes <robeholmes@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: stable@vger.kernel.org
---
 kernel/module_signing.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 6b9a926fd86b..cf94220e9154 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -49,6 +49,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;
+	int ret;
 
 	pr_devel("=>%s(,%zu)\n", __func__, modlen);
 
@@ -82,8 +83,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret = -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	}
+	return ret;
 }
-- 
2.21.0
