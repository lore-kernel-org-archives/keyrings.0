From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 20:30:25 +0000
Subject: [PATCH 2/2] KEYS: trusted: Use common error handling code in tpm_unseal()
Message-Id: <3470e9c8-f7d8-247c-9e69-5301f71c3982@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
In-Reply-To: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, James Morris <james.l.morris@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 21:15:53 +0100

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Replace two calls of the macro "pr_info" by goto statements.

* Adjust two condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/keys/trusted.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index fd06d0c5323b..a295eaae40ba 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -591,15 +591,12 @@ static int tpm_unseal(struct tpm_buf *tb,
 
 	/* sessions for unsealing key and data */
 	ret = oiap(tb, &authhandle1, enonce1);
-	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		goto report_failure;
+
 	ret = oiap(tb, &authhandle2, enonce2);
-	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		goto report_failure;
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
 	keyhndl = htonl(SRKHANDLE);
@@ -654,6 +651,10 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 	memcpy(data, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t), *datalen);
 	return 0;
+
+report_failure:
+	pr_info("trusted_key: oiap failed (%d)\n", ret);
+	return ret;
 }
 
 /*
-- 
2.15.0

