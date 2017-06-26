From: Artem Savkov <asavkov@redhat.com>
Date: Mon, 26 Jun 2017 12:35:21 +0000
Subject: [PATCH keyutils] tests/bz1031154: skip if selinux is disabled
Message-Id: <1498480521-16489-1-git-send-email-asavkov@redhat.com>
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
 tests/bugzillas/bz1031154/runtest.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/bugzillas/bz1031154/runtest.sh b/tests/bugzillas/bz1031154/runtest.sh
index aee8a28..e1721c0 100644
--- a/tests/bugzillas/bz1031154/runtest.sh
+++ b/tests/bugzillas/bz1031154/runtest.sh
@@ -20,6 +20,11 @@ then
     exit 0
 fi
 
+if ! grep -q selinuxfs /proc/mounts; then
+    toolbox_skip_test $TEST "SKIPPING TEST DUE TO DISABLED SELINUX"
+    exit 0
+fi
+
 require_command getenforce
 require_command setenforce
 require_command runcon
-- 
2.7.5

