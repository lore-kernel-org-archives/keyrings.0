From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:31 +0000
Subject: [PATCH 6/9] tests/instantiating: test the unlinked keyid
Message-Id: <20190829203542.4410-9-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Testing the `0` ID just repeats the "BAD KEY" tests at the beginning of
the file.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/instantiating/bad-args/runtest.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/keyctl/instantiating/bad-args/runtest.sh b/tests/keyctl/instantiating/bad-args/runtest.sh
index 1922282..a585e20 100644
--- a/tests/keyctl/instantiating/bad-args/runtest.sh
+++ b/tests/keyctl/instantiating/bad-args/runtest.sh
@@ -42,11 +42,11 @@ unlink_key --wait $keyid @s
 
 # check that a non-existent key ID fails correctly
 marker "CHECK NON-EXISTENT KEY ID"
-instantiate_key --fail 0 a @p
+instantiate_key --fail $keyid a @p
 expect_error EPERM
-pinstantiate_key --fail a 0 @p
+pinstantiate_key --fail a $keyid @p
 expect_error EPERM
-negate_key --fail 0 10 @p
+negate_key --fail $keyid 10 @p
 expect_error EPERM
 
 echo "++++ FINISHED TEST: $result" >>$OUTPUTFILE
-- 
2.21.0
