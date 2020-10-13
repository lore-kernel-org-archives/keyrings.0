From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 13 Oct 2020 10:46:33 +0000
Subject: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com -> jarkko@kernel.org
Message-Id: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-sgx@vger.kernel.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>

Use korg address as the main communications end point. Update the
corresponding M-entries.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6594f0966716..afe2a20fb85a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9668,7 +9668,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
@@ -9680,7 +9680,7 @@ F:	security/keys/trusted-keys/
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
@@ -17616,7 +17616,7 @@ F:	drivers/platform/x86/toshiba-wmi.c
 
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
-- 
2.25.1
