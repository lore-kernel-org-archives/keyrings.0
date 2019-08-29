From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:41 +0000
Subject: [PATCH 12/13] tests/search: test searching with a mismatched type
Message-Id: <20190829203542.4410-19-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This should fail because the actually found key has a type mismatch.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/search/valid/runtest.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/keyctl/search/valid/runtest.sh b/tests/keyctl/search/valid/runtest.sh
index d60ea61..a9912ee 100644
--- a/tests/keyctl/search/valid/runtest.sh
+++ b/tests/keyctl/search/valid/runtest.sh
@@ -32,6 +32,11 @@ expect_error ENOKEY
 marker "SEARCH SESSION"
 search_for_key --expect=$keyid @s user lizard
 
+# search the session keyring for the key using the wrong type
+marker "SEARCH SESSION USING WRONG TYPE"
+search_for_key --fail @s keyring lizard $keyring2id
+expect_error ENOKEY
+
 # search the session keyring for the key and attach to second keyring
 marker "SEARCH SESSION AND ATTACH"
 search_for_key --expect=$keyid @s user lizard $keyring2id
-- 
2.21.0
