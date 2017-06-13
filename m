From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 13 Jun 2017 21:50:08 +0000
Subject: [PATCH keyutils v2 4/6] TEST: Add KDF leading zero test
Message-Id: <20170613215010.14390-5-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

---
 tests/keyctl/dh_compute/valid/runtest.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/keyctl/dh_compute/valid/runtest.sh b/tests/keyctl/dh_compute/valid/runtest.sh
index 6498eef..e0daba9 100644
--- a/tests/keyctl/dh_compute/valid/runtest.sh
+++ b/tests/keyctl/dh_compute/valid/runtest.sh
@@ -171,6 +171,12 @@ marker "COMPUTE DERIVED KEY FROM DH SHARED SECRET (SHA-256)"
 echo -e -n $otherinfo | dh_compute_kdf_oi $privateid $primeid $xaid 16 "sha256"
 expect_multiline payload "$derived"
 
+xpcreate_key 01 user dh:leadingzero @s
+expect_keyid lzid
+
+marker "COMPUTE DERIVED KEY WITH LEADING ZEROS"
+echo -e -n $otherinfo | dh_compute_kdf_oi $privateid $primeid $lzid 16 "sha256"
+expect_payload payload "0066207b cdab1d64 bbf489b3 d6a0dadc"
 
 # SHA-224
 
-- 
2.13.1

