From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 04 Mar 2020 16:03:59 +0000
Subject: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Sumit Garg <sumit.garg@linaro.org>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
to trusted-keys/trusted_tpm1.c in security/keys/.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: security/keys/trusted.c
  warning: no file matches F: include/keys/trusted.h

Rectify the KEYS-TRUSTED entry in MAINTAINERS now.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Sumit, please ack.
Jarkko, please pick this patch.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c755e03ddee..cf389058ca76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9276,8 +9276,8 @@ L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
-F:	security/keys/trusted.c
-F:	include/keys/trusted.h
+F:	include/keys/trusted_tpm.h
+F:	security/keys/trusted-keys/trusted_tpm1.c
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-- 
2.17.1
