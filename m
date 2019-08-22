From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 22 Aug 2019 15:29:01 +0000
Subject: [PATCH] keys: ensure that ->match_free() is called in request_key_and_link()
Message-Id: <20190822152901.8229-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If check_cached_key() returns a non-NULL value, we still need to call
key_type::match_free() to undo key_type::match_preparse().

Fixes: 7743c48e54ee ("keys: Cache result of request_key*() temporarily in task_struct")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 46c5187ce03f..6d628a5a8d10 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -589,7 +589,7 @@ struct key *request_key_and_link(struct key_type *type,
 
 	key = check_cached_key(&ctx);
 	if (key)
-		return key;
+		goto error_free;
 
 	/* search all the process keyrings for a key */
 	rcu_read_lock();
-- 
2.22.1
