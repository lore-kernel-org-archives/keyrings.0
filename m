From: David Howells <dhowells@redhat.com>
Date: Tue, 13 Nov 2018 16:31:03 +0000
Subject: Re: [PATCH v3] keyutils: Add pkg-config file for keyutils library
Message-Id: <1195.1542126663@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> >> +prefix=@prefix@
> >> +exec_prefix=@exec_prefix@
> > 
> > Is there any point to these two lines?  You added a 'PREFIX' variable to the
> > Makefile, but it's not used for anything.
> 
> Actually I'm not sure. Most .pc config files have them and do not use
> them looks like.

According to:

	https://people.freedesktop.org/~dbn/pkg-config-guide.html

the variables aren't really used other than for expanding macros in the
keyword definitions.

Revised patch attached, if you could look it over.

David
---
From: Dave Jiang <dave.jiang@intel.com>

keyutils: Add pkg-config file for keyutils library

This is needed so that other projects can add a dependency on libkeyutils
via PKG_CHECK_MODULES([KEYUTILS], [libkeyutils]).  This enabling makes
'make install' do the right thing, and of course individual distros will
need to add enabling to their associated packages (rpm, deb, etc.) so the
package manager installs do the right thing.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
diff --git a/Makefile b/Makefile
index 96b5df7..33a451e 100644
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
 
+PKGCONFIG 	:= libkeyutils.pc
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
@@ -217,7 +239,7 @@ test:
 ###############################################################################
 clean:
 	$(MAKE) -C tests clean
-	$(RM) libkeyutils*
+	$(RM) libkeyutils.so* libkeyutils.a
 	$(RM) keyctl request-key key.dns_resolver
 	$(RM) *.o *.os *~
 	$(RM) debugfiles.list debugsources.list
diff --git a/keyutils.spec b/keyutils.spec
index 544fe7c..155779b 100644
--- a/keyutils.spec
+++ b/keyutils.spec
@@ -96,6 +96,7 @@ make \
 %{_libdir}/libkeyutils.so
 %{_includedir}/*
 %{_mandir}/man3/*
+%{_libdir}/pkgconfig/libkeyutils.pc
 
 %changelog
 * Wed May 9 2018 David Howells <dhowells@redhat.com> - 1.5.11-1
diff --git a/libkeyutils.pc.in b/libkeyutils.pc.in
new file mode 100644
index 0000000..4c06267
--- /dev/null
+++ b/libkeyutils.pc.in
@@ -0,0 +1,8 @@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: libkeyutils
+Description: keyutils library
+Version: @VERSION@
+Cflags: -I${includedir}
+Libs: -L${libdir} -lkeyutils
