From: David Howells <dhowells@redhat.com>
Date: Wed, 04 Oct 2017 13:09:34 +0000
Subject: [PATCH 3/4] KEYS: Add the ability to grant permissions to an administrator
Message-Id: <150712257470.28796.6984541311150667881.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
In-Reply-To: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Add support for specifying a privilege available to an administrator, such
as invalidation of a network data caching key or the clearing of a cache
keyring.

This is done by setting the fields of a key ACE to:

	{
		.mask = KEY_ACE_SUBJECT_ID | perms,
		.subject_id = KEY_ACE_SYS_ADMIN
	}

or:

	KEY_SYS_ADMIN_ACE(perms)

where perms is the permissions desired, such as KEY_ACE_INVAL or
KEY_ACE_CLEAR.

This allows the KEY_FLAG_ROOT_CAN_CLEAR and KEY_FLAG_ROOT_CAN_INVAL key
flags to be removed in favour of using an ACL.

KEY_ACE_SYS_ADMIN specifies the administator of the root user namespace,
rather than user namespace pointer to by the creds being used.

This is then used to allow the administrator to invalidate various network
filesystem keys and clear the associated keyrings.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cifs/cifs_spnego.c        |    7 ++++---
 fs/cifs/cifsacl.c            |    7 ++++---
 fs/nfs/nfs4idmap.c           |    9 ++++-----
 include/linux/key.h          |    7 +++++--
 include/uapi/linux/keyctl.h  |    1 +
 net/dns_resolver/dns_key.c   |    4 ++--
 net/dns_resolver/dns_query.c |    4 ++--
 security/keys/keyctl.c       |   28 ----------------------------
 security/keys/permission.c   |    6 +++++-
 9 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 557be8100e0c..1dbf647a1579 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -34,19 +34,21 @@ static const struct cred *spnego_cred;
 
 static struct key_acl cifs_spnego_key_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
 		KEY_OWNER_ACE(KEY_ACE_VIEW),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_INVAL),
 	}
 };
 
 static struct key_acl cifs_spnego_keyring_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_CLEAR),
 	}
 };
 
@@ -239,7 +241,6 @@ init_cifs_spnego(void)
 	 * instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up
 	 */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	spnego_cred = cred;
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index ee0b6ed07bf3..bb03a45305c5 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -35,19 +35,21 @@
 
 static struct key_acl cifs_idmap_key_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
 		KEY_OWNER_ACE(KEY_ACE_VIEW),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_INVAL),
 	}
 };
 
 static struct key_acl cifs_idmap_keyring_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_CLEAR),
 	}
 };
 
@@ -514,7 +516,6 @@ init_cifs_idmap(void)
 
 	/* instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	root_cred = cred;
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 13de8d91cbf6..7249c6dc37b0 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -72,19 +72,21 @@ struct idmap {
 
 static struct key_acl nfs_idmap_key_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
 		KEY_OWNER_ACE(KEY_ACE_VIEW),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_INVAL),
 	}
 };
 
 static struct key_acl nfs_idmap_keyring_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_CLEAR),
 	}
 };
 
@@ -232,7 +234,6 @@ int nfs_idmap_init(void)
 	if (ret < 0)
 		goto failed_reg_legacy;
 
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	id_resolver_cache = cred;
@@ -302,8 +303,6 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 						&nfs_idmap_key_acl);
 		mutex_unlock(&idmap->idmap_mutex);
 	}
-	if (!IS_ERR(rkey))
-		set_bit(KEY_FLAG_ROOT_CAN_INVAL, &rkey->flags);
 
 	kfree(desc);
 	return rkey;
diff --git a/include/linux/key.h b/include/linux/key.h
index 11a667c760a9..13aa3440e9b5 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -86,6 +86,11 @@ struct key_acl {
 		.subject_id = KEY_ACE_OWNER		\
 	}
 
+#define KEY_SYS_ADMIN_ACE(perms) {			\
+		.mask = KEY_ACE_SUBJECT_ID | (perms),	\
+		.subject_id = KEY_ACE_SYS_ADMIN		\
+	}
+
 /*****************************************************************************/
 /*
  * key reference with possession attribute handling
@@ -173,10 +178,8 @@ struct key {
 #define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
 #define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
 #define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
-#define KEY_FLAG_ROOT_CAN_CLEAR	6	/* set if key can be cleared by root without permission */
 #define KEY_FLAG_INVALIDATED	7	/* set if key has been invalidated */
 #define KEY_FLAG_BUILTIN	8	/* set if key is built in to the kernel */
-#define KEY_FLAG_ROOT_CAN_INVAL	9	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		10	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	11	/* set if key is a user or user session keyring */
 #define KEY_FLAG_HAS_ACL	12	/* Set if KEYCTL_SETACL called on key */
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index f112ab545198..134052cba4f4 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -40,6 +40,7 @@ struct key_ace {
 #define KEY_ACE_GROUP		2	/* The key's group */
 #define KEY_ACE_OWNER		3	/* The owner of the key */
 #define KEY_ACE_POSSESSOR	4	/* Any process that possesses of the key */
+#define KEY_ACE_SYS_ADMIN	5	/* Anyone with CAP_SYS_ADMIN */
 	};
 };
 
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 2b77f834fede..0fdbc2952352 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -47,10 +47,11 @@ const struct cred *dns_resolver_cache;
 
 static struct key_acl dns_keyring_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_CLEAR),
 	}
 };
 
@@ -301,7 +302,6 @@ static int __init init_dns_resolver(void)
 
 	/* instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	dns_resolver_cache = cred;
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index c09468d575d6..add4502cf12a 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -48,10 +48,11 @@
 
 static struct key_acl dns_key_acl = {
 	.usage	= REFCOUNT_INIT(1),
-	.nr_ace	= 2,
+	.nr_ace	= 3,
 	.aces = {
 		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
 		KEY_OWNER_ACE(KEY_ACE_VIEW),
+		KEY_SYS_ADMIN_ACE(KEY_ACE_INVAL),
 	}
 };
 
@@ -140,7 +141,6 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	}
 
 	down_read(&rkey->sem);
-	set_bit(KEY_FLAG_ROOT_CAN_INVAL, &rkey->flags);
 	ret = key_validate(rkey);
 	if (ret < 0)
 		goto put;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index f95e3fdba865..dc6da2559d6d 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -413,29 +413,15 @@ long keyctl_invalidate_key(key_serial_t id)
 	key_ref = lookup_user_key(id, 0, KEY_NEED_INVAL);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
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
 		goto error;
 	}
 
-invalidate:
 	key = key_ref_to_ptr(key_ref);
 	ret = 0;
 	if (test_bit(KEY_FLAG_KEEP, &key->flags))
 		ret = -EPERM;
 	else
 		key_invalidate(key);
-error_put:
 	key_ref_put(key_ref);
 error:
 	kleave(" = %ld", ret);
@@ -458,28 +444,14 @@ long keyctl_keyring_clear(key_serial_t ringid)
 	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_CLEAR);
 	if (IS_ERR(keyring_ref)) {
 		ret = PTR_ERR(keyring_ref);
-
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
 		goto error;
 	}
 
-clear:
 	keyring = key_ref_to_ptr(keyring_ref);
 	if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
 		ret = -EPERM;
 	else
 		ret = keyring_clear(keyring);
-error_put:
 	key_ref_put(keyring_ref);
 error:
 	return ret;
diff --git a/security/keys/permission.c b/security/keys/permission.c
index b236ab0417e3..390885eb2bb7 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -99,6 +99,10 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 			case KEY_ACE_EVERYONE:
 				allow |= ace->mask;
 				break;
+			case KEY_ACE_SYS_ADMIN:
+				if (ns_capable(&init_user_ns, CAP_SYS_ADMIN))
+					allow |= ace->mask;
+				break;
 			}
 			break;
 		}
@@ -317,7 +321,7 @@ static struct key_acl *key_get_acl_from_user(const struct key_ace __user *_acl,
 			if (get_user(ace->subject_id, &_acl[i].subject_id) < 0)
 				goto fault;
 			if (ace->subject_id = 0 ||
-			    ace->subject_id > KEY_ACE_POSSESSOR)
+			    ace->subject_id > KEY_ACE_SYS_ADMIN)
 				goto inval;
 			break;
 		default:

