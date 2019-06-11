From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 11 Jun 2019 06:28:10 +0000
Subject: [PATCH v11 06/13] ima: Use designated initializers for struct ima_event_data
Message-Id: <20190611062817.18412-7-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Designated initializers allow specifying only the members of the struct
that need initialization. Non-mentioned members are initialized to zero.

This makes the code a bit clearer (particularly in ima_add_boot_aggregate)
and also allows adding a new member to the struct without having to update
all struct initializations.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_api.c  | 13 +++++++++----
 security/integrity/ima/ima_init.c |  4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 78eb11c7ac07..c0cf4bcfc82f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -139,8 +139,10 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 {
 	struct ima_template_entry *entry;
 	struct inode *inode = file_inode(file);
-	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
-					    cause};
+	struct ima_event_data event_data = { .iint = iint,
+					     .file = file,
+					     .filename = filename,
+					     .violation = cause };
 	int violation = 1;
 	int result;
 
@@ -294,8 +296,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	int result = -ENOMEM;
 	struct inode *inode = file_inode(file);
 	struct ima_template_entry *entry;
-	struct ima_event_data event_data = {iint, file, filename, xattr_value,
-					    xattr_len, NULL};
+	struct ima_event_data event_data = { .iint = iint,
+					     .file = file,
+					     .filename = filename,
+					     .xattr_value = xattr_value,
+					     .xattr_len = xattr_len };
 	int violation = 0;
 
 	if (iint->measured_pcrs & (0x1 << pcr))
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 993d0f1915ff..368ef658a1cd 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -49,8 +49,8 @@ static int __init ima_add_boot_aggregate(void)
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry;
 	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
-	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
-					    NULL, 0, NULL};
+	struct ima_event_data event_data = { .iint = iint,
+					     .filename = boot_aggregate_name };
 	int result = -ENOMEM;
 	int violation = 0;
 	struct {
