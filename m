From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:37 +0000
Subject: [PATCH 09/13] test/instantiating: test bad arguments for `keyctl reject`
Message-Id: <20190829203542.4410-15-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 .../keyctl/instantiating/bad-args/runtest.sh  | 14 ++++++++++++
 tests/toolbox.inc.sh                          | 22 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tests/keyctl/instantiating/bad-args/runtest.sh b/tests/keyctl/instantiating/bad-args/runtest.sh
index d611fb9..21bbf10 100644
--- a/tests/keyctl/instantiating/bad-args/runtest.sh
+++ b/tests/keyctl/instantiating/bad-args/runtest.sh
@@ -17,6 +17,8 @@ pinstantiate_key --fail a 0 @p
 expect_error EPERM
 negate_key --fail 0 10 @p
 expect_error EPERM
+reject_key --fail 0 10 rejected @p
+expect_error EPERM
 
 # create a non-keyring
 marker "CREATE KEY"
@@ -28,9 +30,19 @@ instantiate_key --fail $keyid a @p
 expect_error EPERM
 pinstantiate_key --fail a $keyid @p
 expect_error EPERM
+reject_key --fail $keyid 10 rejected @p
+expect_error EPERM
 negate_key --fail $keyid 10 @p
 expect_error EPERM
 
+# check reject key timeout must be a number
+marker "CHECK REJECT TIMEOUT"
+expect_args_error keyctl reject $keyid aa rejected @p
+
+# check reject key timeout must be a number
+marker "CHECK REJECT ERRORS"
+expect_args_error keyctl reject $keyid 10 notanerror @p
+
 # check negative key timeout must be a number
 marker "CHECK NEGATE TIMEOUT"
 expect_args_error keyctl negate $keyid aa @p
@@ -45,6 +57,8 @@ instantiate_key --fail $keyid a @p
 expect_error EPERM
 pinstantiate_key --fail a $keyid @p
 expect_error EPERM
+reject_key --fail $keyid 10 rejected @p
+expect_error EPERM
 negate_key --fail $keyid 10 @p
 expect_error EPERM
 
diff --git a/tests/toolbox.inc.sh b/tests/toolbox.inc.sh
index 9c819e5..b8c27c2 100644
--- a/tests/toolbox.inc.sh
+++ b/tests/toolbox.inc.sh
@@ -1626,6 +1626,28 @@ function pinstantiate_key ()
     fi
 }
 
+###############################################################################
+#
+# reject a key
+#
+###############################################################################
+function reject_key ()
+{
+    my_exitval=0
+    if [ "x$1" = "x--fail" ]
+    then
+	my_exitval=1
+	shift
+    fi
+
+    echo keyctl reject "$@" >>$OUTPUTFILE
+    keyctl reject "$@" >>$OUTPUTFILE 2>&1
+    if [ $? != $my_exitval ]
+    then
+	failed
+    fi
+}
+
 ###############################################################################
 #
 # negate a key
-- 
2.21.0
