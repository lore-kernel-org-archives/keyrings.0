From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 10 Sep 2019 14:32:16 +0000
Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
Message-Id: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, open list <linux-kernel@vger.kernel.org>

Add Jarkko Sakkinen as co-maintainer of KEYS/KEYRINGS and add
git://git.infradead.org/users/jjs/linux-tpmdd.git as the GIT repository
for KEYS-TRUSTED.

Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 108ea925a5d9..aa7cedd671d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8937,6 +8937,7 @@ M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
+T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
@@ -8945,6 +8946,7 @@ F:	security/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
-- 
2.20.1
