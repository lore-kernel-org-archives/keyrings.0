From: Philipp Hahn <hahn@univention.de>
Date: Mon, 19 Feb 2018 09:39:01 +0000
Subject: [PATCH v2] doc: Rename .system_keyring to .builtin_trusted_keys
Message-Id: <56bc730ca40df297dd2f5b9fc8e100b96a1121dc.1519033055.git.hahn@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Commit d3bfe84129f65e0af2450743ebdab33d161d01c9 changed the name but did
not update the documentation.

Fixes: d3bfe84129f65e0af2450743ebdab33d161d01c9
Signed-off-by: Philipp Hahn <hahn@univention.de>
---
 Documentation/admin-guide/module-signing.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 27e59498b487..62e389fdcb86 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -180,11 +180,11 @@ Public keys in the kernel
 ============ 
 The kernel contains a ring of public keys that can be viewed by root.  They're
-in a keyring called ".system_keyring" that can be seen by::
+in a keyring called ".builtin_trusted_keys" that can be seen by::
 
 	[root@deneb ~]# cat /proc/keys
 	...
-	223c7853 I------     1 perm 1f030000     0     0 keyring   .system_keyring: 1
+	223c7853 I------     1 perm 1f030000     0     0 keyring   .builtin_trusted_keys: 1
 	302d2d52 I------     1 perm 1f010000     0     0 asymmetri Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []
 	...
 
@@ -197,15 +197,15 @@ add those in also (e.g. from the UEFI key database).
 
 Finally, it is possible to add additional public keys by doing::
 
-	keyctl padd asymmetric "" [.system_keyring-ID] <[key-file]
+	keyctl padd asymmetric "" [.builtin_trusted_keys-ID] <[key-file]
 
 e.g.::
 
 	keyctl padd asymmetric "" 0x223c7853 <my_public_key.x509
 
 Note, however, that the kernel will only permit keys to be added to
-``.system_keyring _if_`` the new key's X.509 wrapper is validly signed by a key
-that is already resident in the .system_keyring at the time the key was added.
+``.builtin_trusted_keys _if_`` the new key's X.509 wrapper is validly signed by a key
+that is already resident in the .builtin_trusted_keys at the time the key was added.
 
 
 ============
-- 
2.11.0

