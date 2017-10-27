From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 27 Oct 2017 03:12:07 +0000
Subject: [PATCH] MAINTAINERS: remove David Safford as maintainer for encrypted+trusted keys
Message-Id: <20171027031207.6193-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Emails to David's listed email address bounce, and in the commit log
there's no activity from him within the last 5 years.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d85c08956875..f0b69d1c2041 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7626,7 +7626,6 @@ F:	kernel/kexec*
 
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-M:	David Safford <safford@us.ibm.com>
 L:	linux-security-module@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
@@ -7635,7 +7634,6 @@ F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
-M:	David Safford <safford@us.ibm.com>
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 L:	linux-security-module@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.14.3

