From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 13 Jun 2017 21:50:06 +0000
Subject: [PATCH keyutils v2 2/6] TEST: Add keyctl xpadd tests
Message-Id: <20170613215010.14390-3-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

---
 tests/keyctl/xpadd/bad-args/runtest.sh | 86 ++++++++++++++++++++++++++++++++++
 tests/keyctl/xpadd/noargs/runtest.sh   | 31 ++++++++++++
 tests/keyctl/xpadd/useradd/runtest.sh  | 68 +++++++++++++++++++++++++++
 tests/toolbox.inc.sh                   | 29 ++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 tests/keyctl/xpadd/bad-args/runtest.sh
 create mode 100644 tests/keyctl/xpadd/noargs/runtest.sh
 create mode 100644 tests/keyctl/xpadd/useradd/runtest.sh

diff --git a/tests/keyctl/xpadd/bad-args/runtest.sh b/tests/keyctl/xpadd/bad-args/runtest.sh
new file mode 100644
index 0000000..d321fd6
--- /dev/null
+++ b/tests/keyctl/xpadd/bad-args/runtest.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+
+. ../../../prepare.inc.sh
+. ../../../toolbox.inc.sh
+
+
+# ---- do the actual testing ----
+
+result=PASS
+echo "++++ BEGINNING TEST" >$OUTPUTFILE
+
+# check that non-hexadecimal input fails correctly
+marker "CHECK NON-HEXADECIMAL INPUT"
+xpcreate_key --failarg nothex user wibble @p
+
+# check that odd-length hexadecimal input fails correctly
+marker "CHECK ODD-LENGTH HEXADECIMAL INPUT"
+xpcreate_key --failarg "00 01 2 03" user wibble @p
+
+# check that non-hexadecimal trailing input fails correctly
+marker "CHECK TRAILING INPUT"
+xpcreate_key --failarg 0123. user wibble @p
+
+# check that an empty key type fails correctly
+marker "CHECK EMPTY KEY TYPE"
+xpcreate_key --fail 0f1e2c3d "" wibble @p
+expect_error EINVAL
+
+# check that an unsupported key type fails correctly
+marker "CHECK UNSUPPORTED KEY TYPE"
+xpcreate_key --fail 0f1e2c3d lizardsgizzards wibble @p
+expect_error ENODEV
+
+# check that an invalid key type fails correctly
+marker "CHECK INVALID KEY TYPE"
+xpcreate_key --fail 0f1e2c3d .user wibble @p
+expect_error EPERM
+
+# check that an maximum length invalid key type fails correctly
+marker "CHECK MAXLEN KEY TYPE"
+xpcreate_key --fail 0f1e2c3d $maxtype wibble @p
+expect_error ENODEV
+
+# check that an overlong key type fails correctly
+marker "CHECK OVERLONG KEY TYPE"
+xpcreate_key --fail 0f1e2c3d a$maxtype wibble @p
+expect_error EINVAL
+
+# check that creation of a keyring with non-empty payload fails correctly
+marker "CHECK ADD KEYRING WITH PAYLOAD"
+xpcreate_key --fail 0f1e2c3d keyring wibble @p
+expect_error EINVAL
+
+# check that an max length key description works correctly
+if [ $PAGE_SIZE -lt $maxsquota ]
+then
+    marker "CHECK MAXLEN DESC"
+    xpcreate_key 0f1e2c3d user $maxdesc @p
+    expect_keyid keyid
+else
+    marker "CHECK MAXLEN DESC FAILS WITH EDQUOT"
+    xpcreate_key --fail 0f1e2c3d user $maxdesc @p
+    expect_error EDQUOT
+fi
+
+# This doesn't work on MIPS earler than 3.19 because of a kernel bug
+kver=`uname -r`
+kmch=`uname -m`
+if kernel_at_or_later_than 3.19 ||
+	[ "$kmch" != "mips" -a "$kmch" != "mips64" ]
+then
+	# check that an overlong key description fails correctly (>4095 inc NUL)
+	marker "CHECK OVERLONG DESC"
+	xpcreate_key --fail 0f1e2c3d user a$maxdesc @p
+	expect_error EINVAL
+fi
+
+# check that a bad key ID fails correctly
+marker "CHECK BAD KEY ID"
+xpcreate_key --fail 0f1e2c3d user wibble 0
+expect_error EINVAL
+
+echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
+
+# --- then report the results in the database ---
+toolbox_report_result $TEST $result
diff --git a/tests/keyctl/xpadd/noargs/runtest.sh b/tests/keyctl/xpadd/noargs/runtest.sh
new file mode 100644
index 0000000..cde2f8f
--- /dev/null
+++ b/tests/keyctl/xpadd/noargs/runtest.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+. ../../../prepare.inc.sh
+. ../../../toolbox.inc.sh
+
+
+# ---- do the actual testing ----
+
+result=PASS
+echo "++++ BEGINNING TEST" >$OUTPUTFILE
+
+# check that no arguments fails correctly
+marker "ADD NO ARGS"
+expect_args_error keyctl xpadd
+
+# check that one argument fails correctly
+marker "ADD ONE ARG"
+expect_args_error keyctl xpadd user
+
+# check that two arguments fail correctly
+marker "ADD TWO ARGS"
+expect_args_error keyctl xpadd user wibble
+
+# check that four arguments fail correctly
+marker "ADD FOUR ARGS"
+expect_args_error keyctl xpadd user wibble @s x
+
+echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
+
+# --- then report the results in the database ---
+toolbox_report_result $TEST $result
diff --git a/tests/keyctl/xpadd/useradd/runtest.sh b/tests/keyctl/xpadd/useradd/runtest.sh
new file mode 100644
index 0000000..b89c23a
--- /dev/null
+++ b/tests/keyctl/xpadd/useradd/runtest.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+
+. ../../../prepare.inc.sh
+. ../../../toolbox.inc.sh
+
+
+# ---- do the actual testing ----
+
+result=PASS
+echo "++++ BEGINNING TEST" >$OUTPUTFILE
+
+# check that we can add a user key to the session keyring
+marker "ADD USER KEY"
+xpcreate_key 61626364 user wibble @s
+expect_keyid keyid
+
+# read back what we put in it
+marker "PRINT PAYLOAD"
+print_key $keyid
+expect_payload payload "abcd"
+
+# check that we can update a user key
+marker "UPDATE USER KEY"
+xpcreate_key 65666768 user wibble @s
+
+# check we get the same key ID back
+expect_keyid keyid2
+
+if [ "x$keyid" != "x$keyid2" ]
+then
+    failed
+fi
+
+# read back what we changed it to
+marker "PRINT UPDATED PAYLOAD"
+print_key $keyid
+expect_payload payload "efgh"
+
+# remove the key we added
+marker "UNLINK KEY"
+unlink_key $keyid @s
+
+# add bytes with whitespace
+marker "ADD KEY BYTES WITH WHITESPACE"
+xpcreate_key "41 42 43 44 45 46 47 48" user wibble @s
+expect_keyid wsid
+
+# read back what we put in it
+marker "PRINT WHITESPACE PAYLOAD"
+print_key $wsid
+expect_payload payload "ABCDEFGH"
+
+# add multiline key with "keyctl read"-style whitespace
+marker "ADD HEX MULTILINE KEY"
+line="58585858 58585858 58585858 58585858 58585858 58585858 58585858 58585858\n"
+xpcreate_key "$line$line" user wibble @s
+expect_keyid multilineid
+
+# read back what we put in it
+marker "PRINT MULTILINE PAYLOAD"
+print_key $multilineid
+multitext="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
+expect_payload payload $multitext
+
+echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
+
+# --- then report the results in the database ---
+toolbox_report_result $TEST $result
diff --git a/tests/toolbox.inc.sh b/tests/toolbox.inc.sh
index 602218c..5173c18 100644
--- a/tests/toolbox.inc.sh
+++ b/tests/toolbox.inc.sh
@@ -345,6 +345,35 @@ function pcreate_key ()
 
 ###############################################################################
 #
+# create a key and attach it to the new keyring, piping in hex data
+#
+###############################################################################
+function xpcreate_key ()
+{
+    my_exitval=0
+    if [ "x$1" = "x--fail" ]
+    then
+	my_exitval=1
+	shift
+    elif [ "x$1" = "x--failarg" ]
+    then
+	my_exitval=2
+	shift
+    fi
+
+    data="$1"
+    shift
+
+    echo echo -n -e $data \| keyctl xpadd "$@" >>$OUTPUTFILE
+    echo -n -e $data | keyctl xpadd "$@" >>$OUTPUTFILE 2>&1
+    if [ $? != $my_exitval ]
+    then
+	failed
+    fi
+}
+
+###############################################################################
+#
 # create a key and attach it to the new keyring, piping in the data
 #
 ###############################################################################
-- 
2.13.1

