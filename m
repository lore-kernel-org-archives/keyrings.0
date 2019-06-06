From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 06 Jun 2019 07:55:37 +0000
Subject: [PATCH v2 RESEND] scripts: use pkg-config to locate libcrypto
Message-Id: <4904761.bSUFNkusSJ@devpool35>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <3861016.XCek94Sdvs@devpool21> <d48cd5083490aa717f59c41960d5a02f93fce841.camel@infradead.org> <2429714.x0fLlpPdDl@devpool21>
In-Reply-To: <2429714.x0fLlpPdDl@devpool21>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

From cca931322233827dc21c7609f21f4042d78f220e Mon Sep 17 00:00:00 2001
From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 22 Nov 2018 16:40:49 +0100
Subject: scripts: use pkg-config to locate libcrypto

Otherwise build fails if the headers are not in the default location. While at
it also ask pkg-config for the libs, with fallback to the existing value.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Cc: stable@vger.kernel.org # 4.19.x
---
 scripts/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Last time I got notice about a build error with 4.19.3, but it works fine for
me on top of both 4.19 and 4.19.48.

diff --git a/scripts/Makefile b/scripts/Makefile
index 9d442ee050bd..bd2a30b43f28 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -8,7 +8,11 @@
 # conmakehash:   Create chartable
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
+PKG_CONFIG?= pkg-config
+
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
+CRYPTO_LIBS = $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || -lcrypto)
+CRYPTO_CFLAGS = $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null)
 
 hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
@@ -23,8 +27,9 @@ hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTLDLIBS_sign-file = -lcrypto
-HOSTLDLIBS_extract-cert = -lcrypto
+HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
+HOSTCFLAGS_extract-cert.o = $(CRYPTO_CFLAGS)
+HOSTLDLIBS_extract-cert = $(CRYPTO_LIBS)
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
-- 
2.21.0
