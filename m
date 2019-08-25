From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 25 Aug 2019 17:00:15 +0000
Subject: [RESEND][PATCH v2-resend] MAINTAINERS: fix style in KEYS-TRUSTED entry
Message-Id: <20190825170015.3199-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry.

In fact, ./scripts/checkpatch.pl -f MAINTAINERS complains:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #8581: FILE: MAINTAINERS:8581:
  +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The issue was detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/patchwork/patch/1040412/
  - Joe Perches clarified that this is a style defect.

v2: applies cleanly to v5.1-rc4 and next-20190412

v2-resend: applies cleanly to v5.3-rc5 and next-20190823

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43604d6ab96c..6cb9a4927da8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8937,7 +8937,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.17.1
