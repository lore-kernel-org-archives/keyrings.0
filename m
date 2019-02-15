From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:09:40 +0000
Subject: [RFC PATCH 15/27] keys: Make __key_link_begin() handle lockdep nesting
Message-Id: <155024698079.21651.18304462489603588280.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Make __key_link_begin() handle lockdep nesting for the implementation of
key_move() where we have to lock two keyrings.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/internal.h    |    2 +-
 security/keys/key.c         |    6 +++---
 security/keys/keyring.c     |    6 +++---
 security/keys/request_key.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9f2a6ce67d15..40846657aebd 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -95,7 +95,7 @@ extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
 extern int key_get_type_from_user(char *, const char __user *, unsigned);
 
-extern int __key_link_begin(struct key *keyring,
+extern int __key_link_begin(struct key *keyring, unsigned int lock_nesting,
 			    const struct keyring_index_key *index_key,
 			    struct assoc_array_edit **_edit);
 extern int __key_link_check_live_key(struct key *keyring, struct key *key);
diff --git a/security/keys/key.c b/security/keys/key.c
index 2c60d6bcf8a3..63513ffcf2e8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -518,7 +518,7 @@ int key_instantiate_and_link(struct key *key,
 	}
 
 	if (keyring) {
-		ret = __key_link_begin(keyring, &key->index_key, &edit);
+		ret = __key_link_begin(keyring, 0, &key->index_key, &edit);
 		if (ret < 0)
 			goto error;
 
@@ -586,7 +586,7 @@ int key_reject_and_link(struct key *key,
 		if (keyring->restrict_link)
 			return -EPERM;
 
-		link_ret = __key_link_begin(keyring, &key->index_key, &edit);
+		link_ret = __key_link_begin(keyring, 0, &key->index_key, &edit);
 	}
 
 	mutex_lock(&key_construction_mutex);
@@ -866,7 +866,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	index_key.desc_len = strlen(index_key.description);
 	key_set_index_key(&index_key);
 
-	ret = __key_link_begin(keyring, &index_key, &edit);
+	ret = __key_link_begin(keyring, 0, &index_key, &edit);
 	if (ret < 0) {
 		key_ref = ERR_PTR(ret);
 		goto error_free_prep;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 431094c6cd74..1334ed97e530 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1227,7 +1227,7 @@ static int keyring_detect_cycle(struct key *A, struct key *B)
 /*
  * Preallocate memory so that a key can be linked into to a keyring.
  */
-int __key_link_begin(struct key *keyring,
+int __key_link_begin(struct key *keyring, unsigned int lock_nesting,
 		     const struct keyring_index_key *index_key,
 		     struct assoc_array_edit **_edit)
 	__acquires(&keyring->sem)
@@ -1244,7 +1244,7 @@ int __key_link_begin(struct key *keyring,
 	if (keyring->type != &key_type_keyring)
 		return -ENOTDIR;
 
-	down_write(&keyring->sem);
+	down_write_nested(&keyring->sem, lock_nesting);
 
 	ret = -EKEYREVOKED;
 	if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
@@ -1393,7 +1393,7 @@ int key_link(struct key *keyring, struct key *key)
 	key_check(keyring);
 	key_check(key);
 
-	ret = __key_link_begin(keyring, &key->index_key, &edit);
+	ret = __key_link_begin(keyring, 0, &key->index_key, &edit);
 	if (ret = 0) {
 		kdebug("begun {%d,%d}", keyring->serial, refcount_read(&keyring->usage));
 		ret = __key_link_check_restriction(keyring, key);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 078767564283..ab1f6de9e623 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -375,7 +375,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	if (dest_keyring) {
-		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
+		ret = __key_link_begin(dest_keyring, 0, &ctx->index_key, &edit);
 		if (ret < 0)
 			goto link_prealloc_failed;
 	}
