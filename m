From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 20:29:16 +0000
Subject: [PATCH 1/2] KEYS: trusted: Use common error handling code in trusted_update()
Message-Id: <658d88c1-b29b-cf8c-2ce0-8a2755ec9f33@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
In-Reply-To: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, James Morris <james.l.morris@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 20:50:15 +0100

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/keys/trusted.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index bd85315cbfeb..fd06d0c5323b 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1078,30 +1078,18 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	if (!datablob)
 		return -ENOMEM;
 	new_o = trusted_options_alloc();
-	if (!new_o) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!new_o)
+		goto e_nomem;
+
 	new_p = trusted_payload_alloc(key);
-	if (!new_p) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!new_p)
+		goto e_nomem;
 
 	memcpy(datablob, prep->data, datalen);
 	datablob[datalen] = '\0';
 	ret = datablob_parse(datablob, new_p, new_o);
-	if (ret != Opt_update) {
-		ret = -EINVAL;
-		kzfree(new_p);
-		goto out;
-	}
-
-	if (!new_o->keyhandle) {
-		ret = -EINVAL;
-		kzfree(new_p);
-		goto out;
-	}
+	if (ret != Opt_update || !new_o->keyhandle)
+		goto e_inval;
 
 	/* copy old key values, and reseal with new pcrs */
 	new_p->migratable = p->migratable;
@@ -1113,23 +1101,31 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	ret = key_seal(new_p, new_o);
 	if (ret < 0) {
 		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kzfree(new_p);
-		goto out;
+		goto free_payload;
 	}
 	if (new_o->pcrlock) {
 		ret = pcrlock(new_o->pcrlock);
 		if (ret < 0) {
 			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kzfree(new_p);
-			goto out;
+			goto free_payload;
 		}
 	}
 	rcu_assign_keypointer(key, new_p);
 	call_rcu(&p->rcu, trusted_rcu_free);
-out:
+free_data:
 	kzfree(datablob);
 	kzfree(new_o);
 	return ret;
+
+e_nomem:
+	ret = -ENOMEM;
+	goto free_data;
+
+e_inval:
+	ret = -EINVAL;
+free_payload:
+	kzfree(new_p);
+	goto free_data;
 }
 
 /*
-- 
2.15.0

