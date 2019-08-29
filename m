From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:10 +0000
Subject: [PATCH v2 02/13] tests: fix some typos in marker lines
Message-Id: <20190829204322.8015-3-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 tests/keyctl/clear/valid/runtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/keyctl/clear/valid/runtest.sh b/tests/keyctl/clear/valid/runtest.sh
index bdefa46..e162bdd 100644
--- a/tests/keyctl/clear/valid/runtest.sh
+++ b/tests/keyctl/clear/valid/runtest.sh
@@ -75,7 +75,7 @@ then
 fi
 
 # clear the keyring
-marker "CLEAR KEYRING WITH ONE"
+marker "CLEAR KEYRING WITH MANY"
 clear_keyring $keyringid
 
 # check that it's now empty yet again
-- 
2.21.0
