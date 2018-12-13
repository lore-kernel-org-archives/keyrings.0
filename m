From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 13 Dec 2018 02:09:02 +0000
Subject: [PATCH v9 09/14] ima: Export func_tokens
Message-Id: <20181213020907.13601-10-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181213020907.13601-1-bauerman@linux.ibm.com>
In-Reply-To: <20181213020907.13601-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

ima_read_modsig() will need it so that it can show an error message.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_policy.c | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e4f72b30cb28..f0bc2a182cbf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -195,6 +195,8 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+extern const char *const func_tokens[];
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d17a23b5c91d..b7ee342fbe4a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1138,6 +1138,12 @@ void ima_delete_rules(void)
 	}
 }
 
+#define __ima_hook_stringify(str)	(#str),
+
+const char *const func_tokens[] = {
+	__ima_hooks(__ima_hook_stringify)
+};
+
 #ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
@@ -1150,12 +1156,6 @@ static const char *const mask_tokens[] = {
 	"MAY_APPEND"
 };
 
-#define __ima_hook_stringify(str)	(#str),
-
-static const char *const func_tokens[] = {
-	__ima_hooks(__ima_hook_stringify)
-};
-
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
