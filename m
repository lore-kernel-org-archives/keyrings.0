From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 27 Feb 2020 10:25:45 +0000
Subject: [PATCH] KEYS: reaching the keys quotas correctly when instanttiating
Message-Id: <1582799145-16073-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com

I wrote a regression test[1]to test commit a08bf91ce28ed
("KEYS: allow reaching the keys quotas exactly"), but it
failed even I used lastest kernel. It looks like the previous
patch doesn't remove "=" when we instantiate the key.

[1]http://lists.linux.it/pipermail/ltp/2020-February/015331.html

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 718bf7217420..e959b3c96b48 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -382,7 +382,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
 		spin_lock(&key->user->lock);
 
 		if (delta > 0 &&
-		    (key->user->qnbytes + delta >= maxbytes ||
+		    (key->user->qnbytes + delta > maxbytes ||
 		     key->user->qnbytes + delta < key->user->qnbytes)) {
 			ret = -EDQUOT;
 		}
-- 
2.18.0
