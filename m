From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:04 +0000
Subject: [PATCH 14/23] KEYS: user_defined: sanitize key payloads
Message-Id: <149692974429.11452.9095858900312530276.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Zero the payloads of user and logon keys before freeing them.  This
prevents sensitive key material from being kept around in the slab
caches after a key is released.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/user_defined.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 26605134f17a..3d8c68eba516 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -86,10 +86,18 @@ EXPORT_SYMBOL_GPL(user_preparse);
  */
 void user_free_preparse(struct key_preparsed_payload *prep)
 {
-	kfree(prep->payload.data[0]);
+	kzfree(prep->payload.data[0]);
 }
 EXPORT_SYMBOL_GPL(user_free_preparse);
 
+static void user_free_payload_rcu(struct rcu_head *head)
+{
+	struct user_key_payload *payload;
+
+	payload = container_of(head, struct user_key_payload, rcu);
+	kzfree(payload);
+}
+
 /*
  * update a user defined key
  * - the key's semaphore is write-locked
@@ -112,7 +120,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 	prep->payload.data[0] = NULL;
 
 	if (zap)
-		kfree_rcu(zap, rcu);
+		call_rcu(&zap->rcu, user_free_payload_rcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(user_update);
@@ -130,7 +138,7 @@ void user_revoke(struct key *key)
 
 	if (upayload) {
 		rcu_assign_keypointer(key, NULL);
-		kfree_rcu(upayload, rcu);
+		call_rcu(&upayload->rcu, user_free_payload_rcu);
 	}
 }
 
@@ -143,7 +151,7 @@ void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data[0];
 
-	kfree(upayload);
+	kzfree(upayload);
 }
 
 EXPORT_SYMBOL_GPL(user_destroy);

