From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Wed, 07 Jun 2017 17:31:35 +0000
Subject: [PATCH keyutils] TEST: Add KDF leading zero test
Message-Id: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Diffie-Hellman results used as input to a KDF algorithm can have leading
zero bytes, and the current kernel DH implementation truncates leading
zero bytes. This test confirms that the KDF code correctly handles DH
results with leading zeros.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

This applies to the 'next' branch, commit
6eca7565871694091d6cda21fd23e19ad2c77b7a

 tests/keyctl/dh_compute/valid/runtest.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/keyctl/dh_compute/valid/runtest.sh b/tests/keyctl/dh_compute/valid/runtest.sh
index 6498eef..5ad1d14 100644
--- a/tests/keyctl/dh_compute/valid/runtest.sh
+++ b/tests/keyctl/dh_compute/valid/runtest.sh
@@ -171,6 +171,16 @@ marker "COMPUTE DERIVED KEY FROM DH SHARED SECRET (SHA-256)"
 echo -e -n $otherinfo | dh_compute_kdf_oi $privateid $primeid $xaid 16 "sha256"
 expect_multiline payload "$derived"
 
+pcreate_key "-e \x01" user dh:leadingzero @s
+expect_keyid lzid
+
+read -d '' derived2 <<"EOF"
+0066207b cdab1d64 bbf489b3 d6a0dadc
+EOF
+
+marker "COMPUTE DERIVED KEY WITH LEADING ZEROS"
+echo -e -n $otherinfo | dh_compute_kdf_oi $privateid $primeid $lzid 16 "sha256"
+expect_multiline payload "$derived2"
 
 # SHA-224
 
-- 
2.13.1

