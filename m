From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:18 +0000
Subject: [PATCH v2 10/13] tests/reading: fix test comment
Message-Id: <20190829204322.8015-11-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This comment was copied from another test. This one actually fails
because search permissions were also removed.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/reading/valid/runtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/keyctl/reading/valid/runtest.sh b/tests/keyctl/reading/valid/runtest.sh
index a40ccaf..2fb88b9 100644
--- a/tests/keyctl/reading/valid/runtest.sh
+++ b/tests/keyctl/reading/valid/runtest.sh
@@ -57,7 +57,7 @@ print_key $keyid
 expect_payload payload "gizzard"
 
 # remove search permission from the key as well
-# - we should still have read permission because it's searchable in our
+# - we do not have read permission because it's no longer searchable in our
 #   keyrings
 marker "REMOVE SEARCH PERM"
 set_key_perm $keyid 0x350000
-- 
2.21.0
