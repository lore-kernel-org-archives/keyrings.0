From: David Howells <dhowells@redhat.com>
Date: Thu, 14 May 2020 16:58:59 +0000
Subject: [PATCH] keys: Move permissions checking decisions into the checking code
Message-Id: <3999877.1589475539@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

How about this then?

David
---
commit fa37b6c7e2f86d16ede1e0e3cb73857152d51825
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 14 17:48:55 2020 +0100

    keys: Move permissions checking decisions into the checking code
    
    Overhaul the permissions checking, moving the decisions of which permits to
    request for what operation and what overrides to allow into the permissions
    checking functions in keyrings, SELinux and Smack.
    
    To this end, the KEY_NEED_* constants are turned into an enum and expanded
    in number to cover operation types individually.
    
    Note that some more tweaking is probably needed to separate kernel uses,
    e.g. AFS using rxrpc keys, from direct userspace users.
    
    Some overrides are available and this needs to be handled specially:
    
     (1) KEY_FLAG_KEEP in key->flags - The key may not be deleted and/or things
         may not be removed from the keyring.
    
     (2) KEY_FLAG_ROOT_CAN_CLEAR in key->flags - The keyring can be cleared by
         CAP_SYS_ADMIN.
    
     (3) KEY_FLAG_ROOT_CAN_INVAL in key->flags - The key can be invalidated by
         CAP_SYS_ADMIN.
    
     (4) An appropriate auth token being set in cred->request_key_auth that
         gives a process transient permission to view and instantiate a key.
         This is used by the kernel to delegate instantiation to userspace.
    
    Note that this requires some tweaks to the testsuite as some of the error
    codes change.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
    cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    cc: Paul Moore <paul@paul-moore.com>
    cc: Stephen Smalley <stephen.smalley.work@gmail.com>
    cc: Casey Schaufler <casey@schaufler-ca.com>
    cc: keyrings@vger.kernel.org
    cc: selinux@vger.kernel.org

diff --git a/include/linux/key.h b/include/linux/key.h
index b99b40db08fc..7fb00128c5ba 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -71,6 +71,34 @@ struct net;
 
 #define KEY_PERM_UNDEF	0xffffffff
 
+/*
+ * The permissions required on a key that we're looking up.
+ */
+enum key_need_perm {
+	/* 0 is left undefined */
+	KEY_NEED_ASSUME_AUTHORITY = 1,	/* Want to assume instantiation authority */
+	KEY_NEED_CHOWN,			/* Want to change key's ownership/group */
+	KEY_NEED_DESCRIBE,		/* Want to get a key's attributes */
+	KEY_NEED_GET_SECURITY,		/* Want to get a key's security label */
+	KEY_NEED_INSTANTIATE,		/* Want to instantiate a key */
+	KEY_NEED_INVALIDATE,		/* Want to invalidate key */
+	KEY_NEED_JOIN,			/* Want to set a keyring as the session keyring */
+	KEY_NEED_KEYRING_ADD,		/* Want to add a link to a keyring */
+	KEY_NEED_KEYRING_CLEAR,		/* Want to clear a keyring */
+	KEY_NEED_KEYRING_DELETE,	/* Want to remove a link from a keyring */
+	KEY_NEED_LINK,			/* Want to create a link to a key */
+	KEY_NEED_READ,			/* Want to read content to userspace */
+	KEY_NEED_REVOKE,		/* Want to revoke a key */
+	KEY_NEED_SEARCH,		/* Want to find a key in a search */
+	KEY_NEED_SETPERM,		/* Want to set the permissions mask */
+	KEY_NEED_SET_RESTRICTION,	/* Want to set a restriction on a keyring */
+	KEY_NEED_SET_TIMEOUT,		/* Want to set the expiration time on a key */
+	KEY_NEED_UNLINK,		/* Want to remove a link from a key */
+	KEY_NEED_UPDATE,		/* Want to update a key's payload */
+	KEY_NEED_USE,			/* Want to use a key (in kernel) */
+	KEY_NEED_WATCH,			/* Want to watch a key for events */
+};
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
@@ -420,20 +448,9 @@ static inline key_serial_t key_serial(const struct key *key)
 extern void key_set_timeout(struct key *, unsigned);
 
 extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
-				 key_perm_t perm);
+				 enum key_need_perm need_perm);
 extern void key_free_user_ns(struct user_namespace *);
 
-/*
- * The permissions required on a key that we're looking up.
- */
-#define	KEY_NEED_VIEW	0x01	/* Require permission to view attributes */
-#define	KEY_NEED_READ	0x02	/* Require permission to read content */
-#define	KEY_NEED_WRITE	0x04	/* Require permission to update / modify */
-#define	KEY_NEED_SEARCH	0x08	/* Require permission to search (keyring) or find (key) */
-#define	KEY_NEED_LINK	0x10	/* Require permission to link */
-#define	KEY_NEED_SETATTR 0x20	/* Require permission to change attributes */
-#define	KEY_NEED_ALL	0x3f	/* All the above permissions */
-
 static inline short key_read_state(const struct key *key)
 {
 	/* Barrier versus mark_key_instantiated(). */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 733659613bf8..72debb96b002 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -357,7 +357,7 @@ LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
 	 unsigned long flags)
 LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
-	 unsigned perm)
+	 enum key_need_perm need_perm, unsigned int flags)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
 #endif /* CONFIG_KEYS */
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3f1374cffb76..1cb01f6d2bed 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1102,6 +1102,14 @@
  *	@cred points to the credentials to provide the context against which to
  *	evaluate the security data on the key.
  *	@perm describes the combination of permissions required of this key.
+ *	@flags indicates any special conditions set in the normal checks, such
+ *	as:
+ *		KEY_PERMISSION_USED_AUTH_OVERRIDE - A lack of permission was
+ *		overridden by the presence of an instantiation authorisation
+ *		token.
+ *		KEY_PERMISSION_USED_SYSADMIN_OVERRIDE - A lack of permission was
+ *		overridden by the presence of a KEY_FLAG_ROOT_CAN_xxx flag on
+ *		the key an the success of a CAP_SYS_ADMIN check.
  *	Return 0 if permission is granted, -ve error otherwise.
  * @key_getsecurity:
  *	Get a textual representation of the security context attached to a key
diff --git a/include/linux/security.h b/include/linux/security.h
index e7914e4e0b02..a6a5fefcf4e0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1762,13 +1762,17 @@ static inline int security_path_chroot(const struct path *path)
 }
 #endif	/* CONFIG_SECURITY_PATH */
 
+/* Flags for security_key_permission() */
+#define KEY_PERMISSION_USED_AUTH_OVERRIDE	0x01 /* Auth token overrode lack of permission */
+#define KEY_PERMISSION_USED_SYSADMIN_OVERRIDE	0x02 /* Sysadmin overrode lack of permission */
+
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 
 int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
 void security_key_free(struct key *key);
-int security_key_permission(key_ref_t key_ref,
-			    const struct cred *cred, unsigned perm);
+int security_key_permission(key_ref_t key_ref, const struct cred *cred,
+			    enum key_need_perm need_perm, unsigned int flags);
 int security_key_getsecurity(struct key *key, char **_buffer);
 
 #else
@@ -1786,7 +1790,8 @@ static inline void security_key_free(struct key *key)
 
 static inline int security_key_permission(key_ref_t key_ref,
 					  const struct cred *cred,
-					  unsigned perm)
+					  enum key_need_perm need_perm,
+					  unsigned int flags)
 {
 	return 0;
 }
diff --git a/security/keys/dh.c b/security/keys/dh.c
index c4c629bb1c03..e43731d22310 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -22,10 +22,8 @@ static ssize_t dh_data_from_key(key_serial_t keyid, void **data)
 	ssize_t ret;
 
 	key_ref = lookup_user_key(keyid, 0, KEY_NEED_READ);
-	if (IS_ERR(key_ref)) {
-		ret = -ENOKEY;
-		goto error;
-	}
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
 	key = key_ref_to_ptr(key_ref);
 
@@ -52,7 +50,6 @@ static ssize_t dh_data_from_key(key_serial_t keyid, void **data)
 	}
 
 	key_put(key);
-error:
 	return ret;
 }
 
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 28e17f4f3328..d97cb9d98dc3 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -108,6 +108,14 @@ extern void __key_link_end(struct key *keyring,
 
 extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 				    const struct keyring_index_key *index_key);
+extern key_ref_t key_create_or_update_perm_checked(key_ref_t keyring_ref,
+						   const char *type,
+						   const char *description,
+						   const void *payload,
+						   size_t plen,
+						   key_perm_t perm,
+						   unsigned long flags);
+extern int key_update_perm_checked(key_ref_t key_ref, const void *payload, size_t plen);
 
 extern struct key *keyring_search_instkey(struct key *keyring,
 					  key_serial_t target_id);
@@ -165,9 +173,9 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
-#define KEY_LOOKUP_FOR_UNLINK	0x04
+#define KEY_LOOKUP_CREATE		0x01
+#define KEY_LOOKUP_PARTIAL		0x02
+#define KEY_LOOKUP_AUTH_OVERRIDE	0x04
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
@@ -183,7 +191,7 @@ extern void key_gc_keytype(struct key_type *ktype);
 
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
-			       key_perm_t perm);
+			       enum key_need_perm need_perm);
 
 static inline void notify_key(struct key *key,
 			      enum key_notification_subtype subtype, u32 aux)
@@ -205,9 +213,10 @@ static inline void notify_key(struct key *key,
 /*
  * Check to see whether permission is granted to use a key in the desired way.
  */
-static inline int key_permission(const key_ref_t key_ref, unsigned perm)
+static inline int key_permission(const key_ref_t key_ref,
+				 enum key_need_perm need_perm)
 {
-	return key_task_permission(key_ref, current_cred(), perm);
+	return key_task_permission(key_ref, current_cred(), need_perm);
 }
 
 extern struct key_type key_type_request_key_auth;
diff --git a/security/keys/key.c b/security/keys/key.c
index e282c6179b21..d77d5dd61d42 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -755,7 +755,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	int ret;
 
 	/* need write permission on the key to update it */
-	ret = key_permission(key_ref, KEY_NEED_WRITE);
+	ret = key_permission(key_ref, KEY_NEED_UPDATE);
 	if (ret < 0)
 		goto error;
 
@@ -810,13 +810,13 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
  * On success, the possession flag from the keyring ref will be tacked on to
  * the key ref before it is returned.
  */
-key_ref_t key_create_or_update(key_ref_t keyring_ref,
-			       const char *type,
-			       const char *description,
-			       const void *payload,
-			       size_t plen,
-			       key_perm_t perm,
-			       unsigned long flags)
+key_ref_t key_create_or_update_perm_checked(key_ref_t keyring_ref,
+					    const char *type,
+					    const char *description,
+					    const void *payload,
+					    size_t plen,
+					    key_perm_t perm,
+					    unsigned long flags)
 {
 	struct keyring_index_key index_key = {
 		.description	= description,
@@ -894,14 +894,6 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		}
 	}
 
-	/* if we're going to allocate a new key, we're going to have
-	 * to modify the keyring */
-	ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-	if (ret < 0) {
-		key_ref = ERR_PTR(ret);
-		goto error_link_end;
-	}
-
 	/* if it's possible to update this type of key, search for an existing
 	 * key of the same type and description in the destination keyring and
 	 * update that instead if possible
@@ -981,6 +973,27 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	goto error_free_prep;
 }
+
+key_ref_t key_create_or_update(key_ref_t keyring_ref,
+			       const char *type,
+			       const char *description,
+			       const void *payload,
+			       size_t plen,
+			       key_perm_t perm,
+			       unsigned long flags)
+{
+	int ret;
+
+	/* if we're going to allocate a new key, we're going to have
+	 * to modify the keyring */
+	ret = key_permission(keyring_ref, KEY_NEED_KEYRING_ADD);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return key_create_or_update_perm_checked(keyring_ref, type,
+						 description, payload,
+						 plen, perm, flags);
+}
 EXPORT_SYMBOL(key_create_or_update);
 
 /**
@@ -996,19 +1009,12 @@ EXPORT_SYMBOL(key_create_or_update);
  * Returns 0 on success, -EACCES if not permitted and -EOPNOTSUPP if the key
  * type does not support updating.  The key type may return other errors.
  */
-int key_update(key_ref_t key_ref, const void *payload, size_t plen)
+int key_update_perm_checked(key_ref_t key_ref, const void *payload, size_t plen)
 {
 	struct key_preparsed_payload prep;
 	struct key *key = key_ref_to_ptr(key_ref);
 	int ret;
 
-	key_check(key);
-
-	/* the key must be writable */
-	ret = key_permission(key_ref, KEY_NEED_WRITE);
-	if (ret < 0)
-		return ret;
-
 	/* attempt to update it if supported */
 	if (!key->type->update)
 		return -EOPNOTSUPP;
@@ -1040,6 +1046,20 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 		key->type->free_preparse(&prep);
 	return ret;
 }
+
+int key_update(key_ref_t key_ref, const void *payload, size_t plen)
+{
+	int ret;
+
+	key_check(key_ref_to_ptr(key_ref));
+
+	/* the key must be writable */
+	ret = key_permission(key_ref, KEY_NEED_UPDATE);
+	if (ret < 0)
+		return ret;
+
+	return key_update_perm_checked(key_ref, payload, plen);
+}
 EXPORT_SYMBOL(key_update);
 
 /**
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 7d8de1c9a478..5e25b431a9b5 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -123,7 +123,8 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	}
 
 	/* find the target keyring (which must be writable) */
-	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE,
+				      KEY_NEED_KEYRING_ADD);
 	if (IS_ERR(keyring_ref)) {
 		ret = PTR_ERR(keyring_ref);
 		goto error3;
@@ -131,9 +132,9 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 
 	/* create or update the requested key and add it to the target
 	 * keyring */
-	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, KEY_PERM_UNDEF,
-				       KEY_ALLOC_IN_QUOTA);
+	key_ref = key_create_or_update_perm_checked(keyring_ref, type, description,
+						    payload, plen, KEY_PERM_UNDEF,
+						    KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -207,7 +208,7 @@ SYSCALL_DEFINE4(request_key, const char __user *, _type,
 	dest_ref = NULL;
 	if (destringid) {
 		dest_ref = lookup_user_key(destringid, KEY_LOOKUP_CREATE,
-					   KEY_NEED_WRITE);
+					   KEY_NEED_KEYRING_ADD);
 		if (IS_ERR(dest_ref)) {
 			ret = PTR_ERR(dest_ref);
 			goto error3;
@@ -351,14 +352,14 @@ long keyctl_update_key(key_serial_t id,
 	}
 
 	/* find the target key (which must be writable) */
-	key_ref = lookup_user_key(id, 0, KEY_NEED_WRITE);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_UPDATE);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error2;
 	}
 
 	/* update the key */
-	ret = key_update(key_ref, payload, plen);
+	ret = key_update_perm_checked(key_ref, payload, plen);
 
 	key_ref_put(key_ref);
 error2:
@@ -382,31 +383,14 @@ long keyctl_update_key(key_serial_t id,
 long keyctl_revoke_key(key_serial_t id)
 {
 	key_ref_t key_ref;
-	struct key *key;
-	long ret;
-
-	key_ref = lookup_user_key(id, 0, KEY_NEED_WRITE);
-	if (IS_ERR(key_ref)) {
-		ret = PTR_ERR(key_ref);
-		if (ret != -EACCES)
-			goto error;
-		key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
-		if (IS_ERR(key_ref)) {
-			ret = PTR_ERR(key_ref);
-			goto error;
-		}
-	}
 
-	key = key_ref_to_ptr(key_ref);
-	ret = 0;
-	if (test_bit(KEY_FLAG_KEEP, &key->flags))
-		ret = -EPERM;
-	else
-		key_revoke(key);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_REVOKE);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
+	key_revoke(key_ref_to_ptr(key_ref));
 	key_ref_put(key_ref);
-error:
-	return ret;
+	return 0;
 }
 
 /*
@@ -423,41 +407,16 @@ long keyctl_revoke_key(key_serial_t id)
 long keyctl_invalidate_key(key_serial_t id)
 {
 	key_ref_t key_ref;
-	struct key *key;
-	long ret;
 
 	kenter("%d", id);
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
-	if (IS_ERR(key_ref)) {
-		ret = PTR_ERR(key_ref);
-
-		/* Root is permitted to invalidate certain special keys */
-		if (capable(CAP_SYS_ADMIN)) {
-			key_ref = lookup_user_key(id, 0, 0);
-			if (IS_ERR(key_ref))
-				goto error;
-			if (test_bit(KEY_FLAG_ROOT_CAN_INVAL,
-				     &key_ref_to_ptr(key_ref)->flags))
-				goto invalidate;
-			goto error_put;
-		}
-
-		goto error;
-	}
+	key_ref = lookup_user_key(id, 0, KEY_NEED_INVALIDATE);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
-invalidate:
-	key = key_ref_to_ptr(key_ref);
-	ret = 0;
-	if (test_bit(KEY_FLAG_KEEP, &key->flags))
-		ret = -EPERM;
-	else
-		key_invalidate(key);
-error_put:
+	key_invalidate(key_ref_to_ptr(key_ref));
 	key_ref_put(key_ref);
-error:
-	kleave(" = %ld", ret);
-	return ret;
+	return 0;
 }
 
 /*
@@ -470,36 +429,15 @@ long keyctl_invalidate_key(key_serial_t id)
 long keyctl_keyring_clear(key_serial_t ringid)
 {
 	key_ref_t keyring_ref;
-	struct key *keyring;
 	long ret;
 
-	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
-	if (IS_ERR(keyring_ref)) {
-		ret = PTR_ERR(keyring_ref);
+	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE,
+				      KEY_NEED_KEYRING_CLEAR);
+	if (IS_ERR(keyring_ref))
+		return PTR_ERR(keyring_ref);
 
-		/* Root is permitted to invalidate certain special keyrings */
-		if (capable(CAP_SYS_ADMIN)) {
-			keyring_ref = lookup_user_key(ringid, 0, 0);
-			if (IS_ERR(keyring_ref))
-				goto error;
-			if (test_bit(KEY_FLAG_ROOT_CAN_CLEAR,
-				     &key_ref_to_ptr(keyring_ref)->flags))
-				goto clear;
-			goto error_put;
-		}
-
-		goto error;
-	}
-
-clear:
-	keyring = key_ref_to_ptr(keyring_ref);
-	if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
-		ret = -EPERM;
-	else
-		ret = keyring_clear(keyring);
-error_put:
+	ret = keyring_clear(key_ref_to_ptr(keyring_ref));
 	key_ref_put(keyring_ref);
-error:
 	return ret;
 }
 
@@ -519,7 +457,8 @@ long keyctl_keyring_link(key_serial_t id, key_serial_t ringid)
 	key_ref_t keyring_ref, key_ref;
 	long ret;
 
-	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE,
+				      KEY_NEED_KEYRING_ADD);
 	if (IS_ERR(keyring_ref)) {
 		ret = PTR_ERR(keyring_ref);
 		goto error;
@@ -554,28 +493,21 @@ long keyctl_keyring_link(key_serial_t id, key_serial_t ringid)
 long keyctl_keyring_unlink(key_serial_t id, key_serial_t ringid)
 {
 	key_ref_t keyring_ref, key_ref;
-	struct key *keyring, *key;
 	long ret;
 
-	keyring_ref = lookup_user_key(ringid, 0, KEY_NEED_WRITE);
+	keyring_ref = lookup_user_key(ringid, 0, KEY_NEED_KEYRING_DELETE);
 	if (IS_ERR(keyring_ref)) {
 		ret = PTR_ERR(keyring_ref);
 		goto error;
 	}
 
-	key_ref = lookup_user_key(id, KEY_LOOKUP_FOR_UNLINK, 0);
+	key_ref = lookup_user_key(id, KEY_LOOKUP_PARTIAL, KEY_NEED_UNLINK);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error2;
 	}
 
-	keyring = key_ref_to_ptr(keyring_ref);
-	key = key_ref_to_ptr(key_ref);
-	if (test_bit(KEY_FLAG_KEEP, &keyring->flags) &&
-	    test_bit(KEY_FLAG_KEEP, &key->flags))
-		ret = -EPERM;
-	else
-		ret = key_unlink(keyring, key);
+	ret = key_unlink(key_ref_to_ptr(keyring_ref), key_ref_to_ptr(key_ref));
 
 	key_ref_put(key_ref);
 error2:
@@ -607,13 +539,13 @@ long keyctl_keyring_move(key_serial_t id, key_serial_t from_ringid,
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 
-	from_ref = lookup_user_key(from_ringid, 0, KEY_NEED_WRITE);
+	from_ref = lookup_user_key(from_ringid, 0, KEY_NEED_KEYRING_DELETE);
 	if (IS_ERR(from_ref)) {
 		ret = PTR_ERR(from_ref);
 		goto error2;
 	}
 
-	to_ref = lookup_user_key(to_ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	to_ref = lookup_user_key(to_ringid, KEY_LOOKUP_CREATE, KEY_NEED_KEYRING_ADD);
 	if (IS_ERR(to_ref)) {
 		ret = PTR_ERR(to_ref);
 		goto error3;
@@ -647,33 +579,21 @@ long keyctl_describe_key(key_serial_t keyid,
 			 char __user *buffer,
 			 size_t buflen)
 {
-	struct key *key, *instkey;
+	struct key *key;
 	key_ref_t key_ref;
 	char *infobuf;
 	long ret;
 	int desclen, infolen;
 
-	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_VIEW);
-	if (IS_ERR(key_ref)) {
-		/* viewing a key under construction is permitted if we have the
-		 * authorisation token handy */
-		if (PTR_ERR(key_ref) == -EACCES) {
-			instkey = key_get_instantiation_authkey(keyid);
-			if (!IS_ERR(instkey)) {
-				key_put(instkey);
-				key_ref = lookup_user_key(keyid,
-							  KEY_LOOKUP_PARTIAL,
-							  0);
-				if (!IS_ERR(key_ref))
-					goto okay;
-			}
-		}
-
-		ret = PTR_ERR(key_ref);
-		goto error;
-	}
+	/* Viewing a key under construction is permitted if we have the
+	 * authorisation token handy.
+	 */
+	key_ref = lookup_user_key(keyid,
+				  KEY_LOOKUP_PARTIAL | KEY_LOOKUP_AUTH_OVERRIDE,
+				  KEY_NEED_DESCRIBE);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
-okay:
 	key = key_ref_to_ptr(key_ref);
 	desclen = strlen(key->description);
 
@@ -685,23 +605,21 @@ long keyctl_describe_key(key_serial_t keyid,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
-	if (!infobuf)
-		goto error2;
-	infolen = strlen(infobuf);
-	ret = infolen + desclen + 1;
-
-	/* consider returning the data */
-	if (buffer && buflen >= ret) {
-		if (copy_to_user(buffer, infobuf, infolen) != 0 ||
-		    copy_to_user(buffer + infolen, key->description,
-				 desclen + 1) != 0)
-			ret = -EFAULT;
-	}
+	if (infobuf) {
+		infolen = strlen(infobuf);
+		ret = infolen + desclen + 1;
+
+		/* consider returning the data */
+		if (buffer && buflen >= ret) {
+			if (copy_to_user(buffer, infobuf, infolen) != 0 ||
+			    copy_to_user(buffer + infolen, key->description,
+					 desclen + 1) != 0)
+				ret = -EFAULT;
+		}
 
-	kfree(infobuf);
-error2:
+		kfree(infobuf);
+	}
 	key_ref_put(key_ref);
-error:
 	return ret;
 }
 
@@ -747,7 +665,7 @@ long keyctl_keyring_search(key_serial_t ringid,
 	dest_ref = NULL;
 	if (destringid) {
 		dest_ref = lookup_user_key(destringid, KEY_LOOKUP_CREATE,
-					   KEY_NEED_WRITE);
+					   KEY_NEED_KEYRING_ADD);
 		if (IS_ERR(dest_ref)) {
 			ret = PTR_ERR(dest_ref);
 			goto error3;
@@ -817,9 +735,6 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
 /*
  * Read a key's payload.
  *
- * The key must either grant the caller Read permission, or it must grant the
- * caller Search permission when searched for from the process keyrings.
- *
  * If successful, we place up to buflen bytes of data into the buffer, if one
  * is provided, and return the amount of data that is available in the key,
  * irrespective of how much we copied into the buffer.
@@ -833,36 +748,11 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	size_t key_data_len;
 
 	/* find the key first */
-	key_ref = lookup_user_key(keyid, 0, 0);
-	if (IS_ERR(key_ref)) {
-		ret = -ENOKEY;
-		goto out;
-	}
+	key_ref = lookup_user_key(keyid, 0, KEY_NEED_READ);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
 	key = key_ref_to_ptr(key_ref);
-
-	ret = key_read_state(key);
-	if (ret < 0)
-		goto key_put_out; /* Negatively instantiated */
-
-	/* see if we can read it directly */
-	ret = key_permission(key_ref, KEY_NEED_READ);
-	if (ret == 0)
-		goto can_read_key;
-	if (ret != -EACCES)
-		goto key_put_out;
-
-	/* we can't; see if it's searchable from this process's keyrings
-	 * - we automatically take account of the fact that it may be
-	 *   dangling off an instantiation key
-	 */
-	if (!is_key_possessed(key_ref)) {
-		ret = -EACCES;
-		goto key_put_out;
-	}
-
-	/* the key is probably readable - now try to read it */
-can_read_key:
 	if (!key->type->read) {
 		ret = -EOPNOTSUPP;
 		goto key_put_out;
@@ -929,18 +819,16 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 key_put_out:
 	key_put(key);
-out:
 	return ret;
 }
 
 /*
  * Change the ownership of a key
  *
- * The key must grant the caller Setattr permission for this to work, though
- * the key need not be fully instantiated yet.  For the UID to be changed, or
- * for the GID to be changed to a group the caller is not a member of, the
- * caller must have sysadmin capability.  If either uid or gid is -1 then that
- * attribute is not changed.
+ * The key need not be fully instantiated for this operation to be applied.
+ * For the UID to be changed, or for the GID to be changed to a group the
+ * caller is not a member of, the caller must have sysadmin capability.  If
+ * either uid or gid is -1 then that attribute is not changed.
  *
  * If the UID is to be changed, the new user must have sufficient quota to
  * accept the key.  The quota deduction will be removed from the old user to
@@ -970,7 +858,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		goto error;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_CHOWN);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -1062,9 +950,9 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 /*
  * Change the permission mask on a key.
  *
- * The key must grant the caller Setattr permission for this to work, though
- * the key need not be fully instantiated yet.  If the caller does not have
- * sysadmin capability, it may only change the permission on keys that it owns.
+ * The key doesn't have to be fully instantiated yet for this to work.  If the
+ * caller does not have sysadmin capability, it may only change the permission
+ * on keys that it owns.
  */
 long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 {
@@ -1077,7 +965,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 		goto error;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETPERM);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -1104,7 +992,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 
 /*
  * Get the destination keyring for instantiation and check that the caller has
- * Write permission on it.
+ * permission to add a key to it.
  */
 static long get_instantiation_keyring(key_serial_t ringid,
 				      struct request_key_auth *rka,
@@ -1120,7 +1008,8 @@ static long get_instantiation_keyring(key_serial_t ringid,
 
 	/* if a specific keyring is nominated by ID, then use that */
 	if (ringid > 0) {
-		dkref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+		dkref = lookup_user_key(ringid, KEY_LOOKUP_CREATE,
+					KEY_NEED_KEYRING_ADD);
 		if (IS_ERR(dkref))
 			return PTR_ERR(dkref);
 		*_dest_keyring = key_ref_to_ptr(dkref);
@@ -1161,7 +1050,7 @@ static int keyctl_change_reqkey_auth(struct key *key)
  * Instantiate a key with the specified payload and link the key into the
  * destination keyring if one is given.
  *
- * The caller must have the appropriate instantiation permit set for this to
+ * The caller must have the appropriate instantiation token set for this to
  * work (see keyctl_assume_authority).  No other permissions are required.
  *
  * If successful, 0 will be returned.
@@ -1172,29 +1061,34 @@ long keyctl_instantiate_key_common(key_serial_t id,
 {
 	const struct cred *cred = current_cred();
 	struct request_key_auth *rka;
-	struct key *instkey, *dest_keyring;
+	struct key *key, *instkey, *dest_keyring;
+	key_ref_t kref;
 	size_t plen = from ? iov_iter_count(from) : 0;
 	void *payload;
 	long ret;
 
 	kenter("%d,,%zu,%d", id, plen, ringid);
 
+	if (plen > 1024 * 1024 - 1)
+		return -EINVAL;
+
 	if (!plen)
 		from = NULL;
 
-	ret = -EINVAL;
-	if (plen > 1024 * 1024 - 1)
-		goto error;
-
 	/* the appropriate instantiation authorisation key must have been
 	 * assumed before calling this */
-	ret = -EPERM;
 	instkey = cred->request_key_auth;
 	if (!instkey)
-		goto error;
+		return -EPERM;
+
+	kref = lookup_user_key(id, KEY_LOOKUP_PARTIAL, KEY_NEED_INSTANTIATE);
+	if (IS_ERR(kref))
+		return PTR_ERR(kref);
+	key = key_ref_to_ptr(kref);
 
+	ret = -EPERM;
 	rka = instkey->payload.data[0];
-	if (rka->target_key->serial != id)
+	if (rka->target_key != key)
 		goto error;
 
 	/* pull the payload in if one was supplied */
@@ -1218,7 +1112,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		goto error2;
 
 	/* instantiate the key and link it into a keyring */
-	ret = key_instantiate_and_link(rka->target_key, payload, plen,
+	ret = key_instantiate_and_link(key, payload, plen,
 				       dest_keyring, instkey);
 
 	key_put(dest_keyring);
@@ -1234,6 +1128,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		kvfree(payload);
 	}
 error:
+	key_put(key);
 	return ret;
 }
 
@@ -1337,7 +1232,8 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
 {
 	const struct cred *cred = current_cred();
 	struct request_key_auth *rka;
-	struct key *instkey, *dest_keyring;
+	struct key *key, *instkey, *dest_keyring;
+	key_ref_t kref;
 	long ret;
 
 	kenter("%d,%u,%u,%d", id, timeout, error, ringid);
@@ -1353,13 +1249,18 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
 
 	/* the appropriate instantiation authorisation key must have been
 	 * assumed before calling this */
-	ret = -EPERM;
 	instkey = cred->request_key_auth;
 	if (!instkey)
-		goto error;
+		return -EPERM;
+
+	kref = lookup_user_key(id, KEY_LOOKUP_PARTIAL, KEY_NEED_INSTANTIATE);
+	if (IS_ERR(kref))
+		return PTR_ERR(kref);
+	key = key_ref_to_ptr(kref);
 
+	ret = -EPERM;
 	rka = instkey->payload.data[0];
-	if (rka->target_key->serial != id)
+	if (rka->target_key != key)
 		goto error;
 
 	/* find the destination keyring if present (which must also be
@@ -1380,6 +1281,7 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
 		keyctl_change_reqkey_auth(NULL);
 
 error:
+	key_put(key);
 	return ret;
 }
 
@@ -1443,8 +1345,8 @@ long keyctl_set_reqkey_keyring(int reqkey_defl)
 /*
  * Set or clear the timeout on a key.
  *
- * Either the key must grant the caller Setattr permission or else the caller
- * must hold an instantiation authorisation token for the key.
+ * Either the key must grant the caller permission or else the caller must hold
+ * an instantiation authorisation token for the key.
  *
  * The timeout is either 0 to clear the timeout, or a number of seconds from
  * the current time.  The key and any links to the key will be automatically
@@ -1456,44 +1358,25 @@ long keyctl_set_reqkey_keyring(int reqkey_defl)
  */
 long keyctl_set_timeout(key_serial_t id, unsigned timeout)
 {
-	struct key *key, *instkey;
+	struct key *key;
 	key_ref_t key_ref;
-	long ret;
-
-	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
-	if (IS_ERR(key_ref)) {
-		/* setting the timeout on a key under construction is permitted
-		 * if we have the authorisation token handy */
-		if (PTR_ERR(key_ref) == -EACCES) {
-			instkey = key_get_instantiation_authkey(id);
-			if (!IS_ERR(instkey)) {
-				key_put(instkey);
-				key_ref = lookup_user_key(id,
-							  KEY_LOOKUP_PARTIAL,
-							  0);
-				if (!IS_ERR(key_ref))
-					goto okay;
-			}
-		}
 
-		ret = PTR_ERR(key_ref);
-		goto error;
-	}
+	/* Setting the timeout on a key under construction is permitted if we
+	 * have the authorisation token handy
+	 */
+	key_ref = lookup_user_key(id,
+				  KEY_LOOKUP_CREATE |
+				  KEY_LOOKUP_PARTIAL |
+				  KEY_LOOKUP_AUTH_OVERRIDE,
+				  KEY_NEED_SET_TIMEOUT);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
-okay:
 	key = key_ref_to_ptr(key_ref);
-	ret = 0;
-	if (test_bit(KEY_FLAG_KEEP, &key->flags)) {
-		ret = -EPERM;
-	} else {
-		key_set_timeout(key, timeout);
-		notify_key(key, NOTIFY_KEY_SETATTR, 0);
-	}
+	key_set_timeout(key, timeout);
+	notify_key(key, NOTIFY_KEY_SETATTR, 0);
 	key_put(key);
-
-error:
-	return ret;
+	return 0;
 }
 
 /*
@@ -1562,27 +1445,17 @@ long keyctl_get_security(key_serial_t keyid,
 			 char __user *buffer,
 			 size_t buflen)
 {
-	struct key *key, *instkey;
+	struct key *key;
 	key_ref_t key_ref;
 	char *context;
 	long ret;
 
-	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_VIEW);
-	if (IS_ERR(key_ref)) {
-		if (PTR_ERR(key_ref) != -EACCES)
-			return PTR_ERR(key_ref);
-
-		/* viewing a key under construction is also permitted if we
-		 * have the authorisation token handy */
-		instkey = key_get_instantiation_authkey(keyid);
-		if (IS_ERR(instkey))
-			return PTR_ERR(instkey);
-		key_put(instkey);
-
-		key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, 0);
-		if (IS_ERR(key_ref))
-			return PTR_ERR(key_ref);
-	}
+	key_ref = lookup_user_key(keyid,
+				  KEY_LOOKUP_PARTIAL |
+				  KEY_LOOKUP_AUTH_OVERRIDE,
+				  KEY_NEED_GET_SECURITY);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
 
 	key = key_ref_to_ptr(key_ref);
 	ret = security_key_getsecurity(key, &context);
@@ -1614,8 +1487,8 @@ long keyctl_get_security(key_serial_t keyid,
  * Attempt to install the calling process's session keyring on the process's
  * parent process.
  *
- * The keyring must exist and must grant the caller LINK permission, and the
- * parent process must be single-threaded and must have the same effective
+ * The keyring must exist and must grant the caller permission to join it, and
+ * the parent process must be single-threaded and must have the same effective
  * ownership as this process and mustn't be SUID/SGID.
  *
  * The keyring will be emplaced on the parent when it next resumes userspace.
@@ -1631,7 +1504,7 @@ long keyctl_session_to_parent(void)
 	struct cred *cred;
 	int ret;
 
-	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_LINK);
+	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_JOIN);
 	if (IS_ERR(keyring_r))
 		return PTR_ERR(keyring_r);
 
@@ -1733,7 +1606,7 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
 	char *restriction = NULL;
 	long ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_SET_RESTRICTION);
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 
@@ -1781,7 +1654,7 @@ long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
 	if (watch_id < -1 || watch_id > 0xff)
 		return -EINVAL;
 
-	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_VIEW);
+	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_WATCH);
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 	key = key_ref_to_ptr(key_ref);
diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..aece0651eeae 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -77,7 +77,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
  */
 static int keyctl_pkey_params_get(key_serial_t id,
 				  const char __user *_info,
-				  struct kernel_pkey_params *params)
+				  struct kernel_pkey_params *params,
+				  enum key_need_perm need_perm)
 {
 	key_ref_t key_ref;
 	void *p;
@@ -95,7 +96,7 @@ static int keyctl_pkey_params_get(key_serial_t id,
 	if (ret < 0)
 		return ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
+	key_ref = lookup_user_key(id, 0, need_perm);
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
@@ -113,7 +114,8 @@ static int keyctl_pkey_params_get(key_serial_t id,
 static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_params,
 				    const char __user *_info,
 				    int op,
-				    struct kernel_pkey_params *params)
+				    struct kernel_pkey_params *params,
+				    enum key_need_perm need_perm)
 {
 	struct keyctl_pkey_params uparams;
 	struct kernel_pkey_query info;
@@ -125,7 +127,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
 		return -EFAULT;
 
-	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);
+	ret = keyctl_pkey_params_get(uparams.key_id, _info, params, need_perm);
 	if (ret < 0)
 		return ret;
 
@@ -168,7 +170,7 @@ long keyctl_pkey_query(key_serial_t id,
 
 	memset(&params, 0, sizeof(params));
 
-	ret = keyctl_pkey_params_get(id, _info, &params);
+	ret = keyctl_pkey_params_get(id, _info, &params, KEY_NEED_DESCRIBE);
 	if (ret < 0)
 		goto error;
 
@@ -213,7 +215,8 @@ long keyctl_pkey_e_d_s(int op,
 	void *in, *out;
 	long ret;
 
-	ret = keyctl_pkey_params_get_2(_params, _info, op, &params);
+	ret = keyctl_pkey_params_get_2(_params, _info, op, &params,
+				       KEY_NEED_USE);
 	if (ret < 0)
 		goto error_params;
 
@@ -289,7 +292,7 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	long ret;
 
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
-				       &params);
+				       &params, KEY_NEED_USE);
 	if (ret < 0)
 		goto error_params;
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 14abfe765b7e..6199efbe19b4 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1167,7 +1167,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 				continue;
 		} else {
 			if (key_permission(make_key_ref(keyring, 0),
-					   KEY_NEED_SEARCH) < 0)
+					   KEY_NEED_JOIN) < 0)
 				continue;
 		}
 
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 085f907b64ac..ba8d3b548bbc 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -7,13 +7,120 @@
 
 #include <linux/export.h>
 #include <linux/security.h>
+#include <keys/request_key_auth-type.h>
 #include "internal.h"
 
+/*
+ * Determine if we have sufficient permission to perform a check.
+ */
+static int check_key_permission(struct key *key, const struct cred *cred,
+				key_perm_t perms, enum key_need_perm need_perm)
+{
+	struct request_key_auth *rka;
+
+	switch (need_perm) {
+	case KEY_NEED_ASSUME_AUTHORITY:
+		return 0;
+
+	case KEY_NEED_DESCRIBE:
+	case KEY_NEED_GET_SECURITY:
+		if (perms & KEY_OTH_VIEW)
+			return 0;
+		goto check_auth_override;
+
+	case KEY_NEED_CHOWN:
+	case KEY_NEED_SETPERM:
+	case KEY_NEED_SET_RESTRICTION:
+		return perms & KEY_OTH_SETATTR ? 0 : -EACCES;
+
+	case KEY_NEED_INSTANTIATE:
+		goto check_auth_override;
+
+	case KEY_NEED_INVALIDATE:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		if (perms & KEY_OTH_SEARCH)
+			return 0;
+		if (test_bit(KEY_FLAG_ROOT_CAN_INVAL, &key->flags))
+			goto check_sysadmin_override;
+		return -EACCES;
+
+	case KEY_NEED_JOIN:
+	case KEY_NEED_LINK:
+		return perms & KEY_OTH_LINK ? 0 : -EACCES;
+
+	case KEY_NEED_KEYRING_DELETE:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		/* Fall through. */
+	case KEY_NEED_KEYRING_ADD:
+		return perms & KEY_OTH_WRITE ? 0 : -EACCES;
+
+	case KEY_NEED_KEYRING_CLEAR:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		if (perms & KEY_OTH_WRITE)
+			return 0;
+		if (test_bit(KEY_FLAG_ROOT_CAN_CLEAR, &key->flags))
+			goto check_sysadmin_override;
+		return -EACCES;
+
+	case KEY_NEED_READ:
+		return perms & (KEY_OTH_READ | KEY_OTH_SEARCH) ? 0 : -EACCES;
+
+	case KEY_NEED_REVOKE:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		return perms & (KEY_OTH_WRITE | KEY_OTH_SETATTR) ? 0 : -EACCES;
+
+	case KEY_NEED_SEARCH:
+		return perms & KEY_OTH_SEARCH ? 0 : -EACCES;
+
+	case KEY_NEED_SET_TIMEOUT:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		if (perms & KEY_OTH_SETATTR)
+			return 0;
+		goto check_auth_override;
+
+	case KEY_NEED_UNLINK:
+		if (test_bit(KEY_FLAG_KEEP, &key->flags))
+			return -EPERM;
+		return 0;
+
+	case KEY_NEED_UPDATE:
+		return perms & KEY_OTH_WRITE ? 0 : -EACCES;
+
+	case KEY_NEED_USE:
+		return perms & (KEY_OTH_READ | KEY_OTH_SEARCH) ? 0 : -EACCES;
+
+	case KEY_NEED_WATCH:
+		return perms & KEY_OTH_VIEW ? 0 : -EACCES;
+
+	default:
+		WARN_ON(1);
+		return -EACCES;
+	}
+
+check_auth_override:
+	if (!cred->request_key_auth)
+		return -EACCES;
+	rka = cred->request_key_auth->payload.data[0];
+	if (rka->target_key != key)
+		return -EACCES;
+	return KEY_PERMISSION_USED_AUTH_OVERRIDE;
+
+check_sysadmin_override:
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	return KEY_PERMISSION_USED_SYSADMIN_OVERRIDE;
+}
+
 /**
  * key_task_permission - Check a key can be used
  * @key_ref: The key to check.
  * @cred: The credentials to use.
- * @perm: The permissions to check for.
+ * @need_perm: The permission required.
  *
  * Check to see whether permission is granted to use a key in the desired way,
  * but permit the security modules to override.
@@ -24,7 +131,7 @@
  * permissions bits or the LSM check.
  */
 int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
-			unsigned perm)
+			enum key_need_perm need_perm)
 {
 	struct key *key;
 	key_perm_t kperm;
@@ -57,20 +164,18 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 	kperm = key->perm;
 
 use_these_perms:
-
 	/* use the top 8-bits of permissions for keys the caller possesses
 	 * - possessor permissions are additive with other permissions
 	 */
 	if (is_key_possessed(key_ref))
 		kperm |= key->perm >> 24;
 
-	kperm = kperm & perm & KEY_NEED_ALL;
-
-	if (kperm != perm)
-		return -EACCES;
+	ret = check_key_permission(key, cred, kperm & KEY_OTH_ALL, need_perm);
+	if (ret < 0)
+		return ret;
 
-	/* let LSM be the final arbiter */
-	return security_key_permission(key_ref, cred, perm);
+	/* Let the LSMs be the final arbiter */
+	return security_key_permission(key_ref, cred, need_perm, ret);
 }
 EXPORT_SYMBOL(key_task_permission);
 
diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b2..6131a1528680 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -151,7 +151,7 @@ long keyctl_get_persistent(uid_t _uid, key_serial_t destid)
 	}
 
 	/* There must be a destination keyring */
-	dest_ref = lookup_user_key(destid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	dest_ref = lookup_user_key(destid, KEY_LOOKUP_CREATE, KEY_NEED_KEYRING_ADD);
 	if (IS_ERR(dest_ref))
 		return PTR_ERR(dest_ref);
 	if (key_ref_to_ptr(dest_ref)->type != &key_type_keyring) {
diff --git a/security/keys/proc.c b/security/keys/proc.c
index d0cde6685627..373e62556fa5 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -188,7 +188,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	}
 
 	/* check whether the current task is allowed to view the key */
-	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
+	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_DESCRIBE);
 	if (rc < 0)
 		return 0;
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 09541de31f2f..e39d9033c34c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -609,7 +609,7 @@ bool lookup_user_key_possessed(const struct key *key,
  * returned key reference.
  */
 key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
-			  key_perm_t perm)
+			  enum key_need_perm need_perm)
 {
 	struct keyring_search_context ctx = {
 		.match_data.cmp		= lookup_user_key_possessed,
@@ -773,35 +773,24 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
 	/* unlink does not use the nominated key in any way, so can skip all
 	 * the permission checks as it is only concerned with the keyring */
-	if (lflags & KEY_LOOKUP_FOR_UNLINK) {
-		ret = 0;
-		goto error;
-	}
+	if (need_perm != KEY_NEED_UNLINK) {
+		if (!(lflags & KEY_LOOKUP_PARTIAL)) {
+			ret = wait_for_key_construction(key, true);
+			if (ret < 0)
+				goto invalid_key;
 
-	if (!(lflags & KEY_LOOKUP_PARTIAL)) {
-		ret = wait_for_key_construction(key, true);
-		switch (ret) {
-		case -ERESTARTSYS:
-			goto invalid_key;
-		default:
-			if (perm)
+			ret = -EIO;
+			if (key_read_state(key) == KEY_IS_UNINSTANTIATED)
+				goto invalid_key;
+		} else {
+			ret = key_validate(key);
+			if (ret < 0)
 				goto invalid_key;
-		case 0:
-			break;
 		}
-	} else if (perm) {
-		ret = key_validate(key);
-		if (ret < 0)
-			goto invalid_key;
 	}
 
-	ret = -EIO;
-	if (!(lflags & KEY_LOOKUP_PARTIAL) &&
-	    key_read_state(key) == KEY_IS_UNINSTANTIATED)
-		goto invalid_key;
-
 	/* check the permissions */
-	ret = key_task_permission(key_ref, ctx.cred, perm);
+	ret = key_task_permission(key_ref, ctx.cred, need_perm);
 	if (ret < 0)
 		goto invalid_key;
 
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e1b9f1a80676..c835b7407a5f 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -332,10 +332,10 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 			BUG();
 		}
 
-		/*
-		 * Require Write permission on the keyring.  This is essential
-		 * because the default keyring may be the session keyring, and
-		 * joining a keyring only requires Search permission.
+		/* Require permission to add a link to the keyring.  This is
+		 * essential because the default keyring may be the session
+		 * keyring, and joining a keyring only requires Search
+		 * permission.
 		 *
 		 * However, this check is skipped for the "requestor keyring" so
 		 * that /sbin/request-key can itself use request_key() to add
@@ -343,7 +343,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 		 */
 		if (dest_keyring && do_perm_check) {
 			ret = key_permission(make_key_ref(dest_keyring, 1),
-					     KEY_NEED_WRITE);
+					     KEY_NEED_KEYRING_ADD);
 			if (ret) {
 				key_put(dest_keyring);
 				return ret;
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 41e9735006d0..588130b631b8 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -258,6 +258,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 	};
 	struct key *authkey;
 	key_ref_t authkey_ref;
+	int ret;
 
 	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
@@ -272,6 +273,12 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 		goto error;
 	}
 
+	ret = key_permission(authkey_ref, KEY_NEED_ASSUME_AUTHORITY);
+	if (ret < 0) {
+		key_ref_put(authkey_ref);
+		authkey = ERR_PTR(ret);
+	}
+
 	authkey = key_ref_to_ptr(authkey_ref);
 	if (test_bit(KEY_FLAG_REVOKED, &authkey->flags)) {
 		key_put(authkey);
diff --git a/security/security.c b/security/security.c
index c73334ab2882..e5e2200796f7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2398,10 +2398,10 @@ void security_key_free(struct key *key)
 	call_void_hook(key_free, key);
 }
 
-int security_key_permission(key_ref_t key_ref,
-			    const struct cred *cred, unsigned perm)
+int security_key_permission(key_ref_t key_ref, const struct cred *cred,
+			    enum key_need_perm need_perm, unsigned int flags)
 {
-	return call_int_hook(key_permission, 0, key_ref, cred, perm);
+	return call_int_hook(key_permission, 0, key_ref, cred, need_perm, flags);
 }
 
 int security_key_getsecurity(struct key *key, char **_buffer)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..0761787dee13 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,6 +91,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
+#include <keys/request_key_auth-type.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6539,27 +6540,144 @@ static void selinux_key_free(struct key *k)
 	kfree(ksec);
 }
 
+/*
+ * Convert the requested KEY_NEED_* permit into an SELinux KEY__* permission.
+ *
+ * flags may also convey override flags such as
+ * KEY_PERMISSION_USED_AUTH/SYSADMIN_OVERRIDE to indicate when the main
+ * permission check overrode the permissions on the key.
+ *
+ * Returns the perms to check for in *_perm and *_perm2.  If either perm is
+ * present, then the operation is allowed.
+ */
+static int selinux_keyperm_to_av(struct key *key, const struct cred *cred,
+				 unsigned int need_perm, unsigned int flags,
+				 u32 *_perm, u32 *_perm2)
+{
+	bool auth_can_override = false; /* See KEYCTL_ASSUME_AUTHORITY */
+	bool sysadmin_can_override = false;
+
+	switch (need_perm) {
+	case KEY_NEED_ASSUME_AUTHORITY:
+		return 0;
+
+	case KEY_NEED_DESCRIBE:
+	case KEY_NEED_GET_SECURITY:
+		*_perm = KEY__VIEW;
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_CHOWN:
+	case KEY_NEED_SETPERM:
+	case KEY_NEED_SET_RESTRICTION:
+		*_perm = KEY__SETATTR;
+		break;
+
+	case KEY_NEED_INSTANTIATE:
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_INVALIDATE:
+		*_perm = KEY__SEARCH;
+		if (test_bit(KEY_FLAG_ROOT_CAN_INVAL, &key->flags))
+			sysadmin_can_override = true;
+		break;
+
+	case KEY_NEED_JOIN:
+	case KEY_NEED_LINK:
+		*_perm = KEY__LINK;
+		break;
+
+	case KEY_NEED_KEYRING_ADD:
+	case KEY_NEED_KEYRING_DELETE:
+		*_perm = KEY__WRITE;
+		break;
+
+	case KEY_NEED_KEYRING_CLEAR:
+		*_perm = KEY__WRITE;
+		if (test_bit(KEY_FLAG_ROOT_CAN_CLEAR, &key->flags))
+			sysadmin_can_override = true;
+		break;
+
+	case KEY_NEED_READ:
+		*_perm = KEY__READ;
+		break;
+
+	case KEY_NEED_REVOKE:
+		*_perm = KEY__SETATTR;
+		*_perm2 = KEY__WRITE;
+		break;
+
+	case KEY_NEED_SEARCH:
+		*_perm = KEY__SEARCH;
+		break;
+
+	case KEY_NEED_SET_TIMEOUT:
+		*_perm = KEY__SETATTR;
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_UNLINK:
+		return 0; /* Mustn't prevent this; KEY_FLAG_KEEP is already
+			   * dealt with. */
+
+	case KEY_NEED_UPDATE:
+		*_perm = KEY__WRITE;
+		break;
+
+	case KEY_NEED_USE:
+		*_perm = KEY__READ;
+		*_perm2 = KEY__SEARCH;
+		break;
+
+	case KEY_NEED_WATCH:
+		*_perm = KEY__VIEW;
+		break;
+
+	default:
+		WARN_ON(1);
+		return -EPERM;
+	}
+
+	/* Just allow the operation if the process has an authorisation token.
+	 * The presence of the token means that the kernel delegated
+	 * instantiation of a key to the process - which is problematic if we
+	 * then say that the process isn't allowed to get the description of
+	 * the key or actually instantiate it.
+	 */
+	if (auth_can_override && cred->request_key_auth) {
+		struct request_key_auth *rka =
+			cred->request_key_auth->payload.data[0];
+		if (rka->target_key == key)
+			*_perm = 0;
+	}
+
+	return 0;
+}
+
 static int selinux_key_permission(key_ref_t key_ref,
 				  const struct cred *cred,
-				  unsigned perm)
+				  enum key_need_perm need_perm,
+				  unsigned int flags)
 {
-	struct key *key;
-	struct key_security_struct *ksec;
-	u32 sid;
+	struct key *key = key_ref_to_ptr(key_ref);
+	struct key_security_struct *ksec = key->security;
+	u32 sid, perm = 0, perm2 = 0;
+	int ret;
 
-	/* if no specific permissions are requested, we skip the
-	   permission check. No serious, additional covert channels
-	   appear to be created. */
-	if (perm == 0)
-		return 0;
+	ret = selinux_keyperm_to_av(key, cred, need_perm, flags, &perm, &perm2);
+	if (ret < 0 || !perm)
+		return ret;
 
 	sid = cred_sid(cred);
 
-	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ret = avc_has_perm(&selinux_state,
+			   sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+	if (ret == 0 || !perm2)
+		return ret;
 
 	return avc_has_perm(&selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+			    sid, ksec->sid, SECCLASS_KEY, perm2, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c61d175e195..ac9c93c48097 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4230,13 +4230,15 @@ static void smack_key_free(struct key *key)
  * smack_key_permission - Smack access on a key
  * @key_ref: gets to the object
  * @cred: the credentials to use
- * @perm: requested key permissions
+ * @need_perm: requested key permission
  *
  * Return 0 if the task has read and write to the object,
  * an error code otherwise
  */
 static int smack_key_permission(key_ref_t key_ref,
-				const struct cred *cred, unsigned perm)
+				const struct cred *cred,
+				enum key_need_perm need_perm,
+				unsigned int flags)
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
@@ -4244,12 +4246,6 @@ static int smack_key_permission(key_ref_t key_ref,
 	int request = 0;
 	int rc;
 
-	/*
-	 * Validate requested permissions
-	 */
-	if (perm & ~KEY_NEED_ALL)
-		return -EINVAL;
-
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
 		return -EINVAL;
@@ -4265,6 +4261,71 @@ static int smack_key_permission(key_ref_t key_ref,
 	if (tkp == NULL)
 		return -EACCES;
 
+	/*
+	 * Validate requested permissions
+	 */
+	switch (need_perm) {
+	case KEY_NEED_ASSUME_AUTHORITY:
+		return 0;
+
+	case KEY_NEED_DESCRIBE:
+	case KEY_NEED_GET_SECURITY:
+		request |= MAY_READ;
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_CHOWN:
+	case KEY_NEED_INVALIDATE:
+	case KEY_NEED_JOIN:
+	case KEY_NEED_LINK:
+	case KEY_NEED_KEYRING_ADD:
+	case KEY_NEED_KEYRING_CLEAR:
+	case KEY_NEED_KEYRING_DELETE:
+	case KEY_NEED_REVOKE:
+	case KEY_NEED_SETPERM:
+	case KEY_NEED_SET_RESTRICTION:
+	case KEY_NEED_UPDATE:
+		request |= MAY_WRITE;
+		break;
+
+	case KEY_NEED_INSTANTIATE:
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_READ:
+	case KEY_NEED_SEARCH:
+	case KEY_NEED_USE:
+	case KEY_NEED_WATCH:
+		request |= MAY_READ;
+		break;
+
+	case KEY_NEED_SET_TIMEOUT:
+		request |= MAY_WRITE;
+		auth_can_override = true;
+		break;
+
+	case KEY_NEED_UNLINK:
+		return 0; /* Mustn't prevent this; KEY_FLAG_KEEP is already
+			   * dealt with. */
+
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	/* Just allow the operation if the process has an authorisation token.
+	 * The presence of the token means that the kernel delegated
+	 * instantiation of a key to the process - which is problematic if we
+	 * then say that the process isn't allowed to get the description of
+	 * the key or actually instantiate it.
+	 */
+	if (auth_can_override && cred->request_key_auth) {
+		struct request_key_auth *rka =
+			cred->request_key_auth->payload.data[0];
+		if (rka->target_key == key)
+			*_perm = 0;
+	}
+
 	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
 		return 0;
 
@@ -4273,10 +4334,6 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
-		request |= MAY_READ;
-	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
-		request |= MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
 	return rc;
