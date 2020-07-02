From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Date: Thu, 02 Jul 2020 08:57:22 +0000
Subject: [PATCH 3/4] Check that keyutils.h has valid C++ syntax at build time
Message-Id: <20200702085723.7026-4-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200702085723.7026-1-cvubrugier@fastmail.fm>
In-Reply-To: <20200702085723.7026-1-cvubrugier@fastmail.fm>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, =?utf-8?q?Stephan_M=C3=BCller?= <smueller@chronox.de>, Christophe Vu-Brugier <cvubrugier@fastmail.fm>

Signed-off-by: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
---
 Makefile | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6f79446..949ad7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,6 @@
 CPPFLAGS	:= -I.
 CFLAGS		:= -g -Wall -Werror
+CXXFLAGS	:= -g -Wall -Werror
 INSTALL		:= install
 DESTDIR		: SPECFILE	:= keyutils.spec
@@ -99,7 +100,7 @@ endif
 # Normal build rule
 #
 ###############################################################################
-all: keyctl request-key key.dns_resolver
+all: keyctl request-key key.dns_resolver cxx
 
 ###############################################################################
 #
@@ -163,6 +164,18 @@ key.dns_resolver: key.dns_resolver.o dns.afsdb.o $(LIB_DEPENDENCY)
 key.dns_resolver.o: key.dns_resolver.c key.dns.h
 dns.afsdb.o: dns.afsdb.c key.dns.h
 
+###############################################################################
+#
+# Check that the header file has valid C++ syntax
+#
+###############################################################################
+cxx.stamp: keyutils.h Makefile
+	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -x c++-header -fsyntax-only $<
+	touch $@
+
+cxx: cxx.stamp
+.PHONY: cxx
+
 ###############################################################################
 #
 # Install everything
@@ -244,6 +257,7 @@ clean:
 	$(RM) keyctl request-key key.dns_resolver
 	$(RM) *.o *.os *~
 	$(RM) debugfiles.list debugsources.list
+	$(RM) cxx.stamp
 
 distclean: clean
 	$(RM) -r rpmbuild $(TARBALL)
-- 
2.27.0
