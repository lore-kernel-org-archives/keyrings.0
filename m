From: Jelle van der Waa <jelle@vdwaa.nl>
Date: Fri, 07 Jun 2019 10:01:56 +0000
Subject: [PATCH] Make keyutils reproducible
Message-Id: <20190607100156.19477-1-jelle@vdwaa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Adhere to the SOURCE_DATE_EPOCH standard and use it's date when set
otherwise fall back to the default behaviour.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 33a451e..9066d5d 100644
--- a/Makefile
+++ b/Makefile
@@ -108,7 +108,7 @@ all: keyctl request-key key.dns_resolver
 ###############################################################################
 #RPATH = -Wl,-rpath,$(LIBDIR)
 
-VCPPFLAGS	:= -DPKGBUILD="\"$(shell date -u +%F)\""
+VCPPFLAGS	:= -DPKGBUILD="\"$(date --utc --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%F)\""
 VCPPFLAGS	+= -DPKGVERSION="\"keyutils-$(VERSION)\""
 VCPPFLAGS	+= -DAPIVERSION="\"libkeyutils-$(APIVERSION)\""
 
-- 
2.21.0
