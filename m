From: Andrea Parri <andrea.parri@amarulasolutions.com>
Date: Mon, 07 May 2018 15:40:55 +0000
Subject: [PATCH] certificate handling: Update references to the documentation
Message-Id: <1525707655-3542-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, keyrings@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>

Commit 94e980cc45f2b2 ("Documentation/module-signing.txt: convert to
ReST markup") converted the .txt doc. to ReST markup, but it did not
update the references to the doc. (including in MAINTAINERS).

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 MAINTAINERS   | 2 +-
 certs/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb2559af..803d4b4ff5f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3347,7 +3347,7 @@ M:	David Howells <dhowells@redhat.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	keyrings@vger.kernel.org
 S:	Maintained
-F:	Documentation/module-signing.txt
+F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
 F:	scripts/extract-cert.c
diff --git a/certs/Kconfig b/certs/Kconfig
index 5f7663df6e8e3..c94e93d8bccf0 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -13,7 +13,7 @@ config MODULE_SIG_KEY
 
          If this option is unchanged from its default "certs/signing_key.pem",
          then the kernel will automatically generate the private key and
-         certificate as described in Documentation/module-signing.txt
+         certificate as described in Documentation/admin-guide/module-signing.rst
 
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
-- 
2.7.4

