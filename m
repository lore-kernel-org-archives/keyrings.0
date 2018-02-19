From: Philipp Hahn <hahn@univention.de>
Date: Mon, 19 Feb 2018 09:39:02 +0000
Subject: [PATCH v2] doc: module-signing.rst: Fix reST formatting
Message-Id: <c60b7f5ecf0315a4ac43f92974a5496316aca79e.1519033055.git.hahn@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Move the _if_ outside the verbatim string.

Make key ring name as a verbatim string.

Signed-off-by: Philipp Hahn <hahn@univention.de>
---
 Documentation/admin-guide/module-signing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 62e389fdcb86..f8b584179cff 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -204,8 +204,8 @@ e.g.::
 	keyctl padd asymmetric "" 0x223c7853 <my_public_key.x509
 
 Note, however, that the kernel will only permit keys to be added to
-``.builtin_trusted_keys _if_`` the new key's X.509 wrapper is validly signed by a key
-that is already resident in the .builtin_trusted_keys at the time the key was added.
+``.builtin_trusted_keys`` **if** the new key's X.509 wrapper is validly signed by a key
+that is already resident in the ``.builtin_trusted_keys`` at the time the key was added.
 
 
 ============
-- 
2.11.0

