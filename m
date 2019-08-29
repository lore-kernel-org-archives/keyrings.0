From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:11 +0000
Subject: [PATCH v2 03/13] tests: remove some trailing whitespace
Message-Id: <20190829204322.8015-4-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/dh_compute/bad-args/runtest.sh |  2 +-
 tests/keyctl/pupdate/userupdate/runtest.sh  | 10 +++++-----
 tests/keyctl/unlink/all/runtest.sh          |  2 +-
 tests/keyctl/unlink/valid/runtest.sh        |  4 ++--
 tests/keyctl/update/userupdate/runtest.sh   | 14 +++++++-------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/keyctl/dh_compute/bad-args/runtest.sh b/tests/keyctl/dh_compute/bad-args/runtest.sh
index d9f7792..ef05592 100644
--- a/tests/keyctl/dh_compute/bad-args/runtest.sh
+++ b/tests/keyctl/dh_compute/bad-args/runtest.sh
@@ -70,7 +70,7 @@ then
     expect_error EOPNOTSUPP
 else
     expect_error ENOKEY
-fi    
+fi
 dh_compute --fail $privateid $primeid @s
 expect_error EOPNOTSUPP
 
diff --git a/tests/keyctl/pupdate/userupdate/runtest.sh b/tests/keyctl/pupdate/userupdate/runtest.sh
index 30aba54..81db4f9 100644
--- a/tests/keyctl/pupdate/userupdate/runtest.sh
+++ b/tests/keyctl/pupdate/userupdate/runtest.sh
@@ -10,25 +10,25 @@ result=PASS
 echo "++++ BEGINNING TEST" >$OUTPUTFILE
 
 # check that we can add a user key to the session keyring
-marker "ADD USER KEY" 
+marker "ADD USER KEY"
 create_key --new=keyid user wibble stuff @s
 
 # read back what we put in it
-marker "PRINT PAYLOAD" 
+marker "PRINT PAYLOAD"
 print_key $keyid
 expect_payload payload "stuff"
 
 # check that we can update a user key
-marker "PUPDATE USER KEY" 
+marker "PUPDATE USER KEY"
 echo -n "lizard" | pupdate_key $keyid
 
 # read back what we changed it to
-marker "PRINT UPDATED PAYLOAD" 
+marker "PRINT UPDATED PAYLOAD"
 print_key $keyid
 expect_payload payload "lizard"
 
 # remove the key we added
-marker "UNLINK KEY" 
+marker "UNLINK KEY"
 unlink_key $keyid @s
 
 echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
diff --git a/tests/keyctl/unlink/all/runtest.sh b/tests/keyctl/unlink/all/runtest.sh
index 3f12a42..9215a0e 100644
--- a/tests/keyctl/unlink/all/runtest.sh
+++ b/tests/keyctl/unlink/all/runtest.sh
@@ -34,7 +34,7 @@ then
     unlink_key $keyid
     expect_unlink_count n_unlinked 0
 
-    # check that the keyring is now empty 
+    # check that the keyring is now empty
     marker "LIST KEYRING"
     list_keyring $keyringid
     expect_keyring_rlist rlist empty
diff --git a/tests/keyctl/unlink/valid/runtest.sh b/tests/keyctl/unlink/valid/runtest.sh
index 8cfbe47..c5a15df 100644
--- a/tests/keyctl/unlink/valid/runtest.sh
+++ b/tests/keyctl/unlink/valid/runtest.sh
@@ -31,7 +31,7 @@ marker "CHECK NO UNLINK KEY FROM KEYRING"
 unlink_key --fail $keyid $keyringid
 expect_error ENOKEY
 
-# check that the keyring is now empty 
+# check that the keyring is now empty
 marker "LIST KEYRING"
 list_keyring $keyringid
 expect_keyring_rlist rlist empty
@@ -80,7 +80,7 @@ done
 
 keyctl show
 
-# check that it's now empty 
+# check that it's now empty
 marker "LIST KEYRING"
 list_keyring $keyringid
 expect_keyring_rlist rlist empty
diff --git a/tests/keyctl/update/userupdate/runtest.sh b/tests/keyctl/update/userupdate/runtest.sh
index e7df452..320f9ce 100644
--- a/tests/keyctl/update/userupdate/runtest.sh
+++ b/tests/keyctl/update/userupdate/runtest.sh
@@ -10,34 +10,34 @@ result=PASS
 echo "++++ BEGINNING TEST" >$OUTPUTFILE
 
 # check that we can add a user key to the session keyring
-marker "ADD USER KEY" 
+marker "ADD USER KEY"
 create_key --new=keyid user wibble stuff @s
 
 # read back what we put in it
-marker "PRINT PAYLOAD" 
+marker "PRINT PAYLOAD"
 print_key $keyid
 expect_payload payload "stuff"
 
 # check that we can update a user key
-marker "UPDATE USER KEY" 
+marker "UPDATE USER KEY"
 update_key $keyid "lizard"
 
 # read back what we changed it to
-marker "PRINT UPDATED PAYLOAD" 
+marker "PRINT UPDATED PAYLOAD"
 print_key $keyid
 expect_payload payload "lizard"
 
 # check that we can update a user key with hex-encoded data
-marker "UPDATE USER KEY HEX" 
+marker "UPDATE USER KEY HEX"
 update_key -x $keyid "  6c 697a  6172 64  78  "
 
 # read back what we changed it to
-marker "PRINT UPDATED PAYLOAD" 
+marker "PRINT UPDATED PAYLOAD"
 print_key $keyid
 expect_payload payload "lizardx"
 
 # remove the key we added
-marker "UNLINK KEY" 
+marker "UNLINK KEY"
 unlink_key $keyid @s
 
 echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
-- 
2.21.0
