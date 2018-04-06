From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 06 Apr 2018 18:58:25 +0000
Subject: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
Message-Id: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since this header is in "include/uapi/linux/", apparently people
want to use it in userspace programs -- even in C++ ones.
However, the header uses a C++ reserved keyword ("private"),
so change that to "dh_private" instead to allow the header file
to be used in C++ userspace.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id1051

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-416.orig/include/uapi/linux/keyctl.h
+++ lnx-416/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	__s32 dh_private;
 	__s32 prime;
 	__s32 base;
 };
--- lnx-416.orig/security/keys/dh.c
+++ lnx-416/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;

