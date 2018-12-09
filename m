From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 09 Dec 2018 20:36:30 +0000
Subject: [PATCH 2/5] keys: remove needless modular infrastructure from ecryptfs_format
Message-Id: <1544387793-32309-3-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

Even though the support can be modular, only one file needs to use
all the macros like MODULE_AUTHOR, MODULE_LICENSE etc.  Only the one
responsible for registering/removal with module_init/module_exit
needs to declare these.  In this case, that file is "encrypted.c"
and it already has the MODULE_LICENSE that we are removing here.

Since the file does EXPORT_SYMBOL, we add export.h - and build tests
show that module.h (which includes everything) was hiding an implicit
use of string.h - so that is added as well.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 security/keys/encrypted-keys/ecryptfs_format.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 6daa3b6ff9ed..efac03047919 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -15,7 +15,8 @@
  * the Free Software Foundation, version 2 of the License.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/string.h>
 #include "ecryptfs_format.h"
 
 u8 *ecryptfs_get_auth_tok_key(struct ecryptfs_auth_tok *auth_tok)
@@ -77,5 +78,3 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	return 0;
 }
 EXPORT_SYMBOL(ecryptfs_fill_auth_tok);
-
-MODULE_LICENSE("GPL");
-- 
2.7.4
