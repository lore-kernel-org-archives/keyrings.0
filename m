From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 10 Feb 2019 18:10:11 +0000
Subject: [PATCH] MAINTAINERS: use tab instead of spaces
Message-Id: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linuxibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
with this commit.

The issue was detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mimi, please pick up this patch. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf4965d6d5de..31950caabcaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8405,7 +8405,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linuxibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.17.1
