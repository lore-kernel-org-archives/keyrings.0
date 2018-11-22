From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 22 Nov 2018 15:45:09 +0000
Subject: [PATCH] scripts: use pkg-config to locate libcrypto
Message-Id: <3861016.XCek94Sdvs@devpool21>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

Otherwise build fails if the headers are not in the default location. While at
it also ask pkg-config for the libs, with fallback to the existing value.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Cc: stable@vger.kernel.org
---
 scripts/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index ece52ff20171..a303f478a65b 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -8,6 +8,8 @@
 # conmakehash:   Create chartable
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
+PKG_CONFIG?= pkg-config
+
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
 hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
@@ -23,8 +25,9 @@ hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTLDLIBS_sign-file = -lcrypto
-HOSTLDLIBS_extract-cert = -lcrypto
+HOSTLDLIBS_sign-file = $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || -lcrypto)
+HOSTCFLAGS_extract-cert.o = $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_extract-cert = $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || -lcrypto)
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
-- 
2.19.1


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source
