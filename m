From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 03 Nov 2018 02:10:49 +0000
Subject: [PATCH] KEYS: reuse keyring_index_key::desc_len in lookup_user_key()
Message-Id: <20181103021049.11395-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When lookup_user_key() checks whether the key is possessed, it should
use the key's existing index_key including the 'desc_len' field, rather
than recomputing the 'desc_len'.  This shouldn't cause any observable
behavior change; this way is just simpler and faster.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/process_keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index d5b25e535d3a5..3bea09e7176d7 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -688,9 +688,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 0);
 
 		/* check to see if we possess the key */
-		ctx.index_key.type		= key->type;
-		ctx.index_key.description	= key->description;
-		ctx.index_key.desc_len		= strlen(key->description);
+		ctx.index_key			= key->index_key;
 		ctx.match_data.raw_data		= key;
 		kdebug("check possessed");
 		skey_ref = search_process_keyrings(&ctx);
-- 
2.19.1
