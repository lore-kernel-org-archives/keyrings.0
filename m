From: Artem Savkov <asavkov@redhat.com>
Date: Tue, 27 Jun 2017 09:54:19 +0000
Subject: [PATCH keyutils v2] tests/bz1031154: skip if selinux is disabled
Message-Id: <1498557259-23801-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

With selinux disabled the test currently fails trying to setenforce, it
should be skipped instead. Found while trying to run in a container
where selinux always appears disabled.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tests/bugzillas/bz1031154/runtest.sh | 1 +
 tests/toolbox.inc.sh                 | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/bugzillas/bz1031154/runtest.sh b/tests/bugzillas/bz1031154/runtest.sh
index aee8a28..d90afb4 100644
--- a/tests/bugzillas/bz1031154/runtest.sh
+++ b/tests/bugzillas/bz1031154/runtest.sh
@@ -20,6 +20,7 @@ then
     exit 0
 fi
 
+require_selinux
 require_command getenforce
 require_command setenforce
 require_command runcon
diff --git a/tests/toolbox.inc.sh b/tests/toolbox.inc.sh
index 7f19a02..8e4e91d 100644
--- a/tests/toolbox.inc.sh
+++ b/tests/toolbox.inc.sh
@@ -115,6 +115,15 @@ function require_command ()
     fi
 }
 
+function require_selinux ()
+{
+    if ! grep -q selinuxfs /proc/mounts;
+    then
+	toolbox_skip_test $TEST "SKIP DUE TO DISABLED SELINUX"
+	exit 0
+    fi
+}
+
 ###############################################################################
 #
 # extract an error message from the log file and check it
-- 
2.7.5

