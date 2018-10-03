From: Michael Olbrich <m.olbrich@pengutronix.de>
Date: Wed, 03 Oct 2018 09:59:38 +0000
Subject: [PATCH] build: use SOURCE_DATE_EPOCH if available to make the build reproducible
Message-Id: <20181003095938.12014-1-m.olbrich@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The build date is included into the binary. As a result, the binaries
change with the build date.
Use SOURCE_DATE_EPOCH[1] if defined. This allows packages to make the build
reproducible by setting SOURCE_DATE_EPOCH to a fixed value.

[1] https://reproducible-builds.org/specs/source-date-epoch/

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 96b5df716e4c..bcb4b0704117 100644
--- a/Makefile
+++ b/Makefile
@@ -104,7 +104,7 @@ all: keyctl request-key key.dns_resolver
 ###############################################################################
 #RPATH = -Wl,-rpath,$(LIBDIR)
 
-VCPPFLAGS	:= -DPKGBUILD="\"$(shell date -u +%F)\""
+VCPPFLAGS	:= -DPKGBUILD="\"$(shell date $(if $(SOURCE_DATE_EPOCH),--date @$(SOURCE_DATE_EPOCH)) -u +%F)\""
 VCPPFLAGS	+= -DPKGVERSION="\"keyutils-$(VERSION)\""
 VCPPFLAGS	+= -DAPIVERSION="\"libkeyutils-$(APIVERSION)\""
 
-- 
2.19.0
