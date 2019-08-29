From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:35:42 +0000
Subject: [PATCH 13/13] tests/search: test a found key without search permissions
Message-Id: <20190829203542.4410-20-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

These stanzas were essentially duplicates of the previous blocks.
Instead, test removing the search permission from the target key and
that EACCES is returned when this happens.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/search/valid/runtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/keyctl/search/valid/runtest.sh b/tests/keyctl/search/valid/runtest.sh
index a9912ee..e597170 100644
--- a/tests/keyctl/search/valid/runtest.sh
+++ b/tests/keyctl/search/valid/runtest.sh
@@ -135,14 +135,14 @@ set_key_perm $keyring2id 0x3f0000
 search_for_key --expect=$keyid2 $keyringid user lizard
 
 # removing search permission on the second key should hide the key
-marker "SEARCH WITH NO-SEARCH KEYRING2"
-set_key_perm $keyring2id 0x370000
+marker "SEARCH WITH NO-SEARCH KEY2"
+set_key_perm $keyid2 0x370000
 search_for_key --fail $keyringid user lizard
-expect_error ENOKEY
+expect_error EACCES
 
 # putting search permission on the second key back again should make it
 # available again
-set_key_perm $keyring2id 0x3f0000
+set_key_perm $keyid2 0x3f0000
 search_for_key --expect=$keyid2 $keyringid user lizard
 
 # revoking the key should make the key unavailable
-- 
2.21.0
