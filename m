From: Baruch Siach <baruch@tkos.co.il>
Date: Thu, 07 Mar 2019 18:57:17 +0000
Subject: [PATCH v2] MAINTAINERS: fix typo in Mimi Zohar's address
Message-Id: <bfe5434476b9e70445e6c416c31d88b85078d186.1551985037.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E . McKenney" <paulmck@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>

Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Hi Linus,

Paul suggested that I send this to you directly since otherwise it would
miss v5.1 after missing v5.0. I hope you are fine with that.

baruch

v2: add Paul's review tag
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae76b5853ffe..3456651e5c72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8494,7 +8494,7 @@ F:	security/keys/encrypted-keys/
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
 M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.20.1
