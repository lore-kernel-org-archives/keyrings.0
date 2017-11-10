From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 20:28:16 +0000
Subject: [PATCH 0/2] security/keys/trusted: Fine-tuning for two function implementations
Message-Id: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, James Morris <james.l.morris@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 21:21:12 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code in trusted_update()
  Use common error handling code in tpm_unseal()

 security/keys/trusted.c | 61 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

-- 
2.15.0

