From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Fri, 04 Aug 2017 22:03:29 +0000
Subject: [PATCH v4 6/7] ima: Store measurement after appraisal
Message-Id: <20170804220330.30026-7-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
In-Reply-To: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

When module-style signatures appended at the end of files are supported for
IMA appraisal, the code will fallback to the xattr signature if the
appended one fails to verify.

The problem is that we don't know whether we need to fallback to the xattr
signature until the appraise step, and by then the measure step was already
completed and would need to be done again in case the template includes the
signature.

To avoid this problem, do the appraisal first so that the correct signature
is stored by the template in the measure step.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..0b4845e7248d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -244,12 +244,12 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, pcr);
 	if (action & IMA_APPRAISE_SUBMASK)
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
+	if (action & IMA_MEASURE)
+		ima_store_measurement(iint, file, pathname,
+				      xattr_value, xattr_len, pcr);
 	if (action & IMA_AUDIT)
 		ima_audit_measurement(iint, pathname);
 
-- 
2.13.0

