From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 20:57:41 +0000
Subject: [PATCH v2 2/3] KEYS: don't revoke uninstantiated key in request_key_auth_new()
Message-Id: <20170921205742.144596-3-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921205742.144596-1-ebiggers3@gmail.com>
In-Reply-To: <20170921205742.144596-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If key_instantiate_and_link() were to fail (which fortunately isn't
possible currently), the call to key_revoke(authkey) would crash with a
NULL pointer dereference in request_key_auth_revoke() because the key
has not yet been instantiated.

Fix this by removing the call to key_revoke().  key_put() is sufficient,
as it's not possible for an uninstantiated authkey to have been used for
anything yet.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key_auth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 8f12645945ca..2df92b619a38 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -220,7 +220,6 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	return authkey;
 
 error_put_authkey:
-	key_revoke(authkey);
 	key_put(authkey);
 error_free_rka:
 	free_request_key_auth(rka);
-- 
2.14.1.821.g8fa685d3b7-goog

