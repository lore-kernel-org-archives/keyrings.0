From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Sep 2018 12:18:34 +0000
Subject: [PATCH 1/2] Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"
Message-Id: <153779151491.28003.1935104275920340501.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
In-Reply-To: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

This changes UAPI, breaking iwd and libell:

  ell/key.c: In function 'kernel_dh_compute':
  ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
    struct keyctl_dh_params params = { .private = private,
                                        ^~~~~~~
                                        dh_private

This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Stephan Mueller <smueller@chronox.de>
cc: James Morris <jmorris@namei.org>
cc: "Serge E. Hallyn" <serge@hallyn.com>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: <stable@vger.kernel.org>
---

 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 910cc4334b21..7b8c9e19bad1 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 dh_private;
+	__s32 private;
 	__s32 prime;
 	__s32 base;
 };
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 3b602a1e27fa..711e89d8c415 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -300,7 +300,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;
