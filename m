From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 13:19:59 +0000
Subject: [PATCH 09/10] keys: Reuse keyring_index_key::desc_len in lookup_user_key() [ver #3]
Message-Id: <156095039896.9363.4535558628030573762.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, ebiggers@kernel.org
Cc: Eric Biggers <ebiggers@google.com>, James Morris <jamorris@linux.microsoft.com>, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When lookup_user_key() checks whether the key is possessed, it should
use the key's existing index_key including the 'desc_len' field, rather
than recomputing the 'desc_len'.  This doesn't change the behavior; this
way is just simpler and faster.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---

 security/keys/process_keys.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index ba5d3172cafe..39aaa21462bf 100644
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
