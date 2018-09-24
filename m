From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 24 Sep 2018 09:47:23 +0000
Subject: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"
Message-Id: <20180924094723.487697-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

This changes UAPI, breaking iwd and libell:

  ell/key.c: In function 'kernel_dh_compute':
  ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
    struct keyctl_dh_params params = { .private = private,
                                        ^~~~~~~
                                        dh_private

This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.

Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org>
---
 include/uapi/linux/keyctl.h | 2 +-
 security/keys/dh.c          | 2 +-
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
-- 
2.19.0
