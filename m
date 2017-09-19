From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 19 Sep 2017 16:51:08 +0000
Subject: [PATCH] KEYS: key refcounting cleanup in keyctl_read_key
Message-Id: <065a1f03-a342-c47c-ea6f-b4cc84f869bb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

key_put is lost if key_permission() returns non-EACCES error

Fixes: 29db919063406 ("Keys: Add LSM hooks for key management [try #3]")
Reported-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 security/keys/keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ab0b337..70efb2d 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -771,7 +771,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	if (ret = 0)
 		goto can_read_key;
 	if (ret != -EACCES)
-		goto error;
+		goto error2;
 
 	/* we can't; see if it's searchable from this process's keyrings
 	 * - we automatically take account of the fact that it may be
-- 
2.7.4

