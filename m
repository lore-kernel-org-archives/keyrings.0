From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 12 Nov 2018 17:07:35 +0000
Subject: [PATCH v3] keyutils: Add pkg-config file for keyutils library
Message-Id: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This is needed so that other projects can add a dependency on libkeyutils
via PKG_CHECK_MODULES([KEYUTILS], [keyutils]).  This enabling makes 'make
install' do the right thing, and of course individual distros will need to
add enabling to their associated packages (rpm, deb, etc.) so the package
manager installs do the right thing.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3: Move .pc file to lib-devel for rpm spec. (DaveH)

v2: rebased against latest master branch. make rpm checked out ok with the
    correct content in lib rpm.

 Makefile       |   22 ++++++++++++++++++++++
 keyutils.pc.in |   10 ++++++++++
 keyutils.spec  |    1 +
 3 files changed, 33 insertions(+)
 create mode 100644 keyutils.pc.in

diff --git a/Makefile b/Makefile
index 96b5df7..858ad22 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,7 @@ MAN8		:= $(MANDIR)/man8
 INCLUDEDIR	:= /usr/include
 LN		:= ln
 LNS		:= $(LN) -sf
+PREFIX 		:= /usr
 
 ###############################################################################
 #
@@ -78,6 +79,9 @@ endif
 endif
 endif
 
+PKGCONFIG 	:= keyutils.pc
+PKGCONFIG_DIR 	:= pkgconfig
+
 ###############################################################################
 #
 # This is necessary if glibc doesn't know about the key management error codes
@@ -163,6 +167,15 @@ dns.afsdb.o: dns.afsdb.c key.dns.h
 # Install everything
 #
 ###############################################################################
+pkgconfig:
+	sed \
+	-e 's,@VERSION\@,$(VERSION),g' \
+	-e 's,@prefix\@,$(PREFIX),g' \
+	-e 's,@exec_prefix\@,$(PREFIX),g' \
+	-e 's,@libdir\@,$(USRLIBDIR),g' \
+	-e 's,@includedir\@,$(INCLUDEDIR),g' \
+	< $(PKGCONFIG).in > $(PKGCONFIG) || rm $(PKGCONFIG)
+
 install: all
 ifeq ($(NO_ARLIB),0)
 	$(INSTALL) -D -m 0644 $(ARLIB) $(DESTDIR)$(USRLIBDIR)/$(ARLIB)
@@ -172,6 +185,15 @@ ifeq ($(NO_SOLIB),0)
 	$(LNS) $(LIBNAME) $(DESTDIR)$(LIBDIR)/$(SONAME)
 	mkdir -p $(DESTDIR)$(USRLIBDIR)
 	$(LNS) $(LIBDIR)/$(SONAME) $(DESTDIR)$(USRLIBDIR)/$(DEVELLIB)
+	sed \
+	-e 's,@VERSION\@,$(VERSION),g' \
+	-e 's,@prefix\@,$(PREFIX),g' \
+	-e 's,@exec_prefix\@,$(PREFIX),g' \
+	-e 's,@libdir\@,$(USRLIBDIR),g' \
+	-e 's,@includedir\@,$(INCLUDEDIR),g' \
+	< $(PKGCONFIG).in > $(PKGCONFIG) || rm $(PKGCONFIG)
+	$(INSTALL) -D $(PKGCONFIG) $(DESTDIR)$(LIBDIR)/$(PKGCONFIG_DIR)/$(PKGCONFIG)
+	rm $(PKGCONFIG)
 endif
 	$(INSTALL) -D keyctl $(DESTDIR)$(BINDIR)/keyctl
 	$(INSTALL) -D request-key $(DESTDIR)$(SBINDIR)/request-key
diff --git a/keyutils.pc.in b/keyutils.pc.in
new file mode 100644
index 0000000..44fd6e1
--- /dev/null
+++ b/keyutils.pc.in
@@ -0,0 +1,10 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: keyutils
+Description: keyutils library
+Version: @VERSION@
+Cflags: -I${includedir}
+Libs: -L${libdir} -lkeyutils
diff --git a/keyutils.spec b/keyutils.spec
index 544fe7c..c874686 100644
--- a/keyutils.spec
+++ b/keyutils.spec
@@ -96,6 +96,7 @@ make \
 %{_libdir}/libkeyutils.so
 %{_includedir}/*
 %{_mandir}/man3/*
+%{_libdir}/pkgconfig/keyutils.pc
 
 %changelog
 * Wed May 9 2018 David Howells <dhowells@redhat.com> - 1.5.11-1
