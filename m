From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:28 +0000
Subject: [PATCH 4/9] tests/revoke: test key revokation in the revoke tests
Message-Id: <20190829203542.4410-6-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/revoke/valid/runtest.sh  | 20 ++++++++++++++++++++
 tests/keyctl/timeout/valid/runtest.sh | 17 -----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/tests/keyctl/revoke/valid/runtest.sh b/tests/keyctl/revoke/valid/runtest.sh
index 55bbbdf..fc2b928 100644
--- a/tests/keyctl/revoke/valid/runtest.sh
+++ b/tests/keyctl/revoke/valid/runtest.sh
@@ -47,6 +47,16 @@ marker "CHECK NO READ PAYLOAD"
 print_key --fail $keyid
 expect_error EKEYREVOKED
 
+# invalidating the new keyring should also fail
+marker "CHECK NO SET KEY TIMEOUT"
+timeout_key --fail $keyid 20
+expect_error EKEYREVOKED
+
+# invalidating the new keyring should also fail
+marker "CHECK NO INVALIDATE KEY"
+invalidate_key --fail $keyid
+expect_error EKEYREVOKED
+
 # remove the key we added
 marker "UNLINK KEY"
 unlink_key $keyid $keyringid
@@ -65,6 +75,16 @@ marker "CHECK NO VALIDATE KEYRING"
 describe_key --fail $keyringid
 expect_error EKEYREVOKED
 
+# invalidating the new keyring should also fail
+marker "CHECK NO SET KEYRING TIMEOUT"
+timeout_key --fail $keyringid 20
+expect_error EKEYREVOKED
+
+# invalidating the new keyring should also fail
+marker "CHECK NO INVALIDATE KEYRING"
+invalidate_key --fail $keyringid
+expect_error EKEYREVOKED
+
 # remove the keyring we added
 marker "UNLINK KEYRING"
 unlink_key $keyringid @s
diff --git a/tests/keyctl/timeout/valid/runtest.sh b/tests/keyctl/timeout/valid/runtest.sh
index 4d772bb..01dc48f 100644
--- a/tests/keyctl/timeout/valid/runtest.sh
+++ b/tests/keyctl/timeout/valid/runtest.sh
@@ -80,23 +80,6 @@ marker "ADD KEY"
 create_key user lizard gizzard $keyringid
 expect_keyid keyid
 
-# set a silly timeout on the key
-marker "SET BIG TIMEOUT"
-timeout_key $keyid 10000000
-
-# revoke the key
-marker "REVOKE KEY"
-revoke_key $keyid
-
-# check we can no longer set the key's timeout
-marker "CHECK NO SET KEY TIMEOUT"
-timeout_key --fail $keyid 20
-expect_error EKEYREVOKED
-
-# remove the key we added
-marker "UNLINK KEY"
-unlink_key $keyid $keyringid
-
 # revoke the keyring
 marker "TIMEOUT KEYRING"
 timeout_key $keyringid 1
-- 
2.21.0
