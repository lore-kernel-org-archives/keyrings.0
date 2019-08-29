From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:13 +0000
Subject: [PATCH v2 05/13] tests: fix typos in test comments
Message-Id: <20190829204322.8015-6-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/add/bad-args/runtest.sh        | 2 +-
 tests/keyctl/link/recursion/runtest.sh      | 2 +-
 tests/keyctl/newring/bad-args/runtest.sh    | 2 +-
 tests/keyctl/padd/bad-args/runtest.sh       | 2 +-
 tests/keyctl/requesting/bad-args/runtest.sh | 2 +-
 tests/keyctl/requesting/piped/runtest.sh    | 4 ++--
 tests/keyctl/requesting/valid/runtest.sh    | 4 ++--
 tests/keyctl/search/bad-args/runtest.sh     | 2 +-
 tests/keyctl/session/bad-args/runtest.sh    | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/keyctl/add/bad-args/runtest.sh b/tests/keyctl/add/bad-args/runtest.sh
index 270ee0a..69121b2 100644
--- a/tests/keyctl/add/bad-args/runtest.sh
+++ b/tests/keyctl/add/bad-args/runtest.sh
@@ -51,7 +51,7 @@ else
     expect_error EDQUOT
 fi
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
diff --git a/tests/keyctl/link/recursion/runtest.sh b/tests/keyctl/link/recursion/runtest.sh
index 65abd9c..d258c83 100644
--- a/tests/keyctl/link/recursion/runtest.sh
+++ b/tests/keyctl/link/recursion/runtest.sh
@@ -79,7 +79,7 @@ marker "RECURSE 7"
 link_key --fail $keyringid $keyring7id
 expect_error EDEADLK
 
-# create an eigth keyring in the seventh
+# create an eighth keyring in the seventh
 marker "CREATE KEYRING 8"
 create_keyring --new=keyring8id "eighth" @s
 set_key_perm $keyring8id 0x3f3f0000
diff --git a/tests/keyctl/newring/bad-args/runtest.sh b/tests/keyctl/newring/bad-args/runtest.sh
index 734b44e..f35c4c6 100644
--- a/tests/keyctl/newring/bad-args/runtest.sh
+++ b/tests/keyctl/newring/bad-args/runtest.sh
@@ -21,7 +21,7 @@ else
     expect_error EDQUOT
 fi
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
diff --git a/tests/keyctl/padd/bad-args/runtest.sh b/tests/keyctl/padd/bad-args/runtest.sh
index 291584e..c59393c 100644
--- a/tests/keyctl/padd/bad-args/runtest.sh
+++ b/tests/keyctl/padd/bad-args/runtest.sh
@@ -51,7 +51,7 @@ else
     expect_error EDQUOT
 fi
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
diff --git a/tests/keyctl/requesting/bad-args/runtest.sh b/tests/keyctl/requesting/bad-args/runtest.sh
index 83c114f..cf822e2 100644
--- a/tests/keyctl/requesting/bad-args/runtest.sh
+++ b/tests/keyctl/requesting/bad-args/runtest.sh
@@ -90,7 +90,7 @@ marker "CHECK MAXLEN DESC"
 request_key --fail user $maxdesc
 expect_error ENOKEY
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
diff --git a/tests/keyctl/requesting/piped/runtest.sh b/tests/keyctl/requesting/piped/runtest.sh
index 010af33..1496d06 100644
--- a/tests/keyctl/requesting/piped/runtest.sh
+++ b/tests/keyctl/requesting/piped/runtest.sh
@@ -49,7 +49,7 @@ marker "CHECK ATTACHMENT TO SESSION KEYRING"
 list_keyring @s
 expect_keyring_rlist rlist $keyid
 
-# rerequesting should pick up that key again
+# re-requesting should pick up that key again
 marker "REDO PIPED CALL OUT REQUEST KEY TO SESSION"
 prequest_key_callout --old=$keyid gizzard user debug:lizard
 
@@ -76,7 +76,7 @@ marker "CHECK ATTACHMENT TO SESSION"
 list_keyring @s
 expect_keyring_rlist rlist $keyid
 
-# rerequesting should pick up that key again
+# re-requesting should pick up that key again
 marker "REDO PIPED CALL OUT REQUEST KEY TO KEYRING"
 prequest_key_callout --old=$keyid gizzard user debug:lizard $keyringid
 
diff --git a/tests/keyctl/requesting/valid/runtest.sh b/tests/keyctl/requesting/valid/runtest.sh
index 824b700..06834c2 100644
--- a/tests/keyctl/requesting/valid/runtest.sh
+++ b/tests/keyctl/requesting/valid/runtest.sh
@@ -49,7 +49,7 @@ marker "CHECK ATTACHMENT TO SESSION KEYRING"
 list_keyring @s
 expect_keyring_rlist rlist $keyid
 
-# rerequesting should pick up that key again
+# re-requesting should pick up that key again
 marker "REDO CALL OUT REQUEST KEY TO SESSION"
 request_key_callout --old=$keyid user debug:lizard gizzard
 
@@ -77,7 +77,7 @@ marker "CHECK ATTACHMENT TO SESSION"
 list_keyring @s
 expect_keyring_rlist rlist $keyid
 
-# rerequesting should pick up that key again
+# re-requesting should pick up that key again
 marker "REDO CALL OUT REQUEST KEY TO KEYRING"
 request_key_callout --old=$keyid user debug:lizard gizzard $keyringid
 
diff --git a/tests/keyctl/search/bad-args/runtest.sh b/tests/keyctl/search/bad-args/runtest.sh
index 2128790..8650ae5 100644
--- a/tests/keyctl/search/bad-args/runtest.sh
+++ b/tests/keyctl/search/bad-args/runtest.sh
@@ -45,7 +45,7 @@ expect_error ENOKEY
 search_for_key --fail @s user $maxdesc @p
 expect_error ENOKEY
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
diff --git a/tests/keyctl/session/bad-args/runtest.sh b/tests/keyctl/session/bad-args/runtest.sh
index 8bae0d4..45a9984 100644
--- a/tests/keyctl/session/bad-args/runtest.sh
+++ b/tests/keyctl/session/bad-args/runtest.sh
@@ -14,7 +14,7 @@ marker "SESSION WITH EMPTY KEYRING NAME"
 new_session --fail ""
 expect_error EINVAL
 
-# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+# This doesn't work on MIPS earlier than 3.19 because of a kernel bug
 kver=`uname -r`
 kmch=`uname -m`
 if kernel_at_or_later_than 3.19 ||
-- 
2.21.0
