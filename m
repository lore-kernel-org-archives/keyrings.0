From: David Howells <dhowells@redhat.com>
Date: Tue, 30 Apr 2019 15:06:43 +0000
Subject: [PATCH 01/11] keys: Invalidate used request_key authentication keys [ver #2]
Message-Id: <155663680358.31331.10328156725789843466.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
In-Reply-To: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
To: ebiederm@xmission.com
Cc: keyrings@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dwalsh@redhat.com, vgoyal@redhat.com

Invalidate used request_key authentication keys rather than revoking them
so that they get cleaned up immediately rather than potentially hanging
around.  There doesn't seem any need to keep the revoked keys around.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/key.c         |    4 ++--
 security/keys/request_key.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 696f1c092c50..d705b950ce2a 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -459,7 +459,7 @@ static int __key_instantiate_and_link(struct key *key,
 
 			/* disable the authorisation key */
 			if (authkey)
-				key_revoke(authkey);
+				key_invalidate(authkey);
 
 			if (prep->expiry != TIME64_MAX) {
 				key->expiry = prep->expiry;
@@ -607,7 +607,7 @@ int key_reject_and_link(struct key *key,
 
 		/* disable the authorisation key */
 		if (authkey)
-			key_revoke(authkey);
+			key_invalidate(authkey);
 	}
 
 	mutex_unlock(&key_construction_mutex);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 75d87f9e0f49..a7b698394257 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -222,7 +222,7 @@ static int construct_key(struct key *key, const void *callout_info,
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
 	WARN_ON(ret < 0 &&
-		!test_bit(KEY_FLAG_REVOKED, &authkey->flags));
+		!test_bit(KEY_FLAG_INVALIDATED, &authkey->flags));
 
 	key_put(authkey);
 	kleave(" = %d", ret);
