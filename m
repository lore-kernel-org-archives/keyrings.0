From: David Howells <dhowells@redhat.com>
Date: Fri, 30 Aug 2019 15:52:26 +0000
Subject: [PATCH] keys: ensure that ->match_free() is called in request_key_and_link()
Message-Id: <156718034654.6899.18350327020509594564.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190822152901.8229-1-ebiggers@kernel.org>
In-Reply-To: <20190822152901.8229-1-ebiggers@kernel.org>
To: torvalds@linux-foundation.org
Cc: Eric Biggers <ebiggers@google.com>, dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If check_cached_key() returns a non-NULL value, we still need to call
key_type::match_free() to undo key_type::match_preparse().

Fixes: 7743c48e54ee ("keys: Cache result of request_key*() temporarily in task_struct")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/request_key.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 7325f382dbf4..957b9e3e1492 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -595,7 +595,7 @@ struct key *request_key_and_link(struct key_type *type,
 
 	key = check_cached_key(&ctx);
 	if (key)
-		return key;
+		goto error_free;
 
 	/* search all the process keyrings for a key */
 	rcu_read_lock();
