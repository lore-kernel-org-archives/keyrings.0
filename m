From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 05 Mar 2020 20:30:13 +0000
Subject: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
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

Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
files in security/keys/trusted-keys/ are identified as part of
KEYS-TRUSTED.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Changes to v1:
  - use a global pattern for matching the whole security/keys/trusted-keys/
    directory.
Changes to v2:
  - name the correct directory in the commit message

Sumit, please ack.
Jarkko, please pick this patch v3.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c755e03ddee..7f11ac752b91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9276,8 +9276,8 @@ L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
-F:	security/keys/trusted.c
-F:	include/keys/trusted.h
+F:	include/keys/trusted_tpm.h
+F:	security/keys/trusted-keys/
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-- 
2.17.1
