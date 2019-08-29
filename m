From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:15 +0000
Subject: [PATCH v2 07/13] tests/timeout: test actions on an expired keyring as well
Message-Id: <20190829204322.8015-8-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/timeout/valid/runtest.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/keyctl/timeout/valid/runtest.sh b/tests/keyctl/timeout/valid/runtest.sh
index ce27b68..ee20179 100644
--- a/tests/keyctl/timeout/valid/runtest.sh
+++ b/tests/keyctl/timeout/valid/runtest.sh
@@ -100,6 +100,21 @@ marker "CHECK NO VALIDATE KEYRING"
 describe_key --fail $keyringid
 expect_error EKEYEXPIRED
 
+# validating the new keyring's name and type should also fail
+marker "CHECK NO SET KEYRING TIMEOUT"
+timeout_key --fail $keyringid 20
+expect_error EKEYEXPIRED
+
+# validating the new keyring's name and type should also fail
+marker "CHECK NO INVALIDATE KEYRING"
+invalidate_key --fail $keyringid
+expect_error EKEYEXPIRED
+
+# validating the new keyring's name and type should also fail
+marker "CHECK NO REVOKE KEYRING"
+revoke_key --fail $keyringid
+expect_error EKEYEXPIRED
+
 # remove the keyring we added
 marker "UNLINK KEYRING"
 unlink_key $keyringid @s
-- 
2.21.0
