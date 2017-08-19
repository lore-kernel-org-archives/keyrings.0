From: Josh Holland <anowlcalledjosh@gmail.com>
Date: Sat, 19 Aug 2017 15:21:06 +0000
Subject: [PATCH 2/2] docs: Fix paths in security/keys
Message-Id: <20170819152106.20432-3-anowlcalledjosh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Several paths in the security/keys documentation were incorrect.

Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
---
 Documentation/security/keys/core.rst              | 4 ++--
 Documentation/security/keys/request-key.rst       | 2 +-
 Documentation/security/keys/trusted-encrypted.rst | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 7c39c595c..396c7cc4f 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -443,7 +443,7 @@ The main syscalls are:
      /sbin/request-key will be invoked in an attempt to obtain a key. The
      callout_info string will be passed as an argument to the program.
 
-     See also Documentation/security/keys-request-key.txt.
+     See also Documentation/security/keys/request-key.rst.
 
 
 The keyctl syscall functions are:
@@ -973,7 +973,7 @@ payload contents" for more information.
     If successful, the key will have been attached to the default keyring for
     implicitly obtained request-key keys, as set by KEYCTL_SET_REQKEY_KEYRING.
 
-    See also Documentation/security/keys-request-key.txt.
+    See also Documentation/security/keys/request-key.rst.
 
 
  *  To search for a key, passing auxiliary data to the upcaller, call::
diff --git a/Documentation/security/keys/request-key.rst b/Documentation/security/keys/request-key.rst
index aba327841..b2d16abaa 100644
--- a/Documentation/security/keys/request-key.rst
+++ b/Documentation/security/keys/request-key.rst
@@ -3,7 +3,7 @@ Key Request Service
 ========= 
 The key request service is part of the key retention service (refer to
-Documentation/security/keys.txt).  This document explains more fully how
+Documentation/security/core.rst).  This document explains more fully how
 the requesting algorithm works.
 
 The process starts by either the kernel requesting a service by calling
diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 7b503831b..3bb24e09a 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -172,4 +172,4 @@ Other uses for trusted and encrypted keys, such as for disk and file encryption
 are anticipated.  In particular the new format 'ecryptfs' has been defined in
 in order to use encrypted keys to mount an eCryptfs filesystem.  More details
 about the usage can be found in the file
-``Documentation/security/keys-ecryptfs.txt``.
+``Documentation/security/keys/ecryptfs.rst``.
-- 
2.14.1

