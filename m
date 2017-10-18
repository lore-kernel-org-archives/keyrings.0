From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 00:53:15 +0000
Subject: [PATCH v5 02/18] ima: Remove some superfluous parentheses
Message-Id: <20171018005331.2688-3-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, James Morris <james.l.morris@oracle.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

Superfluous parentheses just add clutter to the code, making it harder to
read and to understand.

In order to avoid churn and minimize conflicts with other patches from the
community, this patch only removes superfluous parentheses from lines that
are modified by other patches in this series.

Confirmed that the patch is correct by comparing the object files from
before and after the patch. They are identical.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c     | 11 +++++------
 security/integrity/ima/ima_template_lib.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ec7dfa02c051..bce0b36778bd 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -229,9 +229,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
-		if ((status = INTEGRITY_NOLABEL)
-		    || (status = INTEGRITY_NOXATTRS))
+	if (status != INTEGRITY_PASS && status != INTEGRITY_UNKNOWN) {
+		if (status = INTEGRITY_NOLABEL || status = INTEGRITY_NOXATTRS)
 			cause = "missing-HMAC";
 		else if (status = INTEGRITY_FAIL)
 			cause = "invalid-HMAC";
@@ -293,10 +292,10 @@ int ima_appraise_measurement(enum ima_hooks func,
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
-		} else if ((inode->i_size = 0) &&
+		} else if (inode->i_size = 0 &&
 			   (iint->flags & IMA_NEW_FILE) &&
-			   (xattr_value &&
-			    xattr_value->type = EVM_IMA_XATTR_DIGSIG)) {
+			   xattr_value &&
+			   xattr_value->type = EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
 		}
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 28af43f63572..8bebcbb61162 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -383,7 +383,7 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	int xattr_len = event_data->xattr_len;
 	int rc = 0;
 
-	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
+	if (!xattr_value || xattr_value->type != EVM_IMA_XATTR_DIGSIG)
 		goto out;
 
 	rc = ima_write_template_field_data(xattr_value, xattr_len, fmt,

