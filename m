From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:38 +0000
Subject: [PATCH 9/9] tests/reading: remove revokation test
Message-Id: <20190829203542.4410-16-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This is already tested in the revokation test script.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/reading/valid/runtest.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/keyctl/reading/valid/runtest.sh b/tests/keyctl/reading/valid/runtest.sh
index c5a4e3f..a3ac773 100644
--- a/tests/keyctl/reading/valid/runtest.sh
+++ b/tests/keyctl/reading/valid/runtest.sh
@@ -80,12 +80,6 @@ set_key_perm $keyid 0x370000
 print_key $keyid
 expect_payload payload "gizzard"
 
-# revoke the key
-marker "REVOKE KEY"
-revoke_key $keyid
-print_key --fail $keyid
-expect_error EKEYREVOKED
-
 # remove the keyring we added
 marker "UNLINK KEYRING"
 unlink_key $keyringid @s
-- 
2.21.0
