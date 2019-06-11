From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 11 Jun 2019 06:28:17 +0000
Subject: [PATCH v11 13/13] ima: Allow template= option for appraise rules as well
Message-Id: <20190611062817.18412-14-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

It's useful being able to specify a different IMA template on appraise
policy rules, so allow it.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6463ab8921ea..1ac1ef458f2e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1110,7 +1110,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		case Opt_template:
 			ima_log_string(ab, "template", args[0].from);
-			if (entry->action != MEASURE) {
+			if (entry->action != MEASURE &&
+			    entry->action != APPRAISE) {
 				result = -EINVAL;
 				break;
 			}
