From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 29 May 2019 21:01:52 +0000
Subject: [PATCH RESEND] KEYS: reuse keyring_index_key::desc_len in lookup_user_key()
Message-Id: <20190529210152.120249-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When lookup_user_key() checks whether the key is possessed, it should
use the key's existing index_key including the 'desc_len' field, rather
than recomputing the 'desc_len'.  This doesn't change the behavior; this
way is just simpler and faster.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/process_keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f05f7125a7d5d..5492677c20b73 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -690,9 +690,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
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
2.22.0.rc1.257.g3120a18244-goog
