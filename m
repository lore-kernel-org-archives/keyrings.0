From: David Howells <dhowells@redhat.com>
Date: Wed, 04 Oct 2017 13:09:27 +0000
Subject: [PATCH 2/4] KEYS: Provide KEYCTL_GET/SET_ACL
Message-Id: <150712256736.28796.5313045383738198800.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
In-Reply-To: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Provide keyctl() operations to get and set a key's ACL.  The get operation,
wrapped by libkeyutils, looks like:

	int ret = keyctl_get_acl(key_serial_t key, struct key_ace *acl,
				 size_t max_acl_size);

where the buffer to take the ACL is pointed to by acl and has size
max_acl_size in bytes.  If the buffer is big enough, the ACL is written
into the buffer.  The actual size of the ACL in bytes is returned whether
or not an ACL is written.  VIEW permission is required for this.

The set operation looks like:

	int ret = keyctl_set_acl(key_serial_t key, const struct key_ace *acl,
				 size_t acl_size);

where acl is the acl to set and it is acl_size bytes in size.  0 is
returned on success.  SET_SECURITY permission is required for this.


The ACL consists of an array of elements of the following form:

	struct key_ace {
		union {
			uid_t		uid;
			gid_t		gid;
			unsigned int	subject_id;
		};
		unsigned int mask;
	};

where the top four bits of mask indicate the type of subject being checked:

	KEY_ACE_SUBJECT_ID	A subject specified by ->subject_id
	KEY_ACE_UID		A UID directly specified by ->uid
	KEY_ACE_GID		A GID directly specified by ->gid
	KEY_ACE__IDENTITY	Mask for these bits

and if KEY_ACE_SUBJECT_ID is specified, subject_id is one of the following:

	KEY_ACE_POSSESSOR	The possessor of the key
	KEY_ACE_OWNER		The owner of the key
	KEY_ACE_GROUP		The key's group
	KEY_ACE_OTHER		Everyone else

Each subject_id may occur only once in an ACL.

The bottom 28 bits of mask indicate the permissions being granted:

	KEY_ACE_VIEW		Can view the key metadata
	KEY_ACE_READ		Can read the key content
	KEY_ACE_WRITE		Can update/modify the key content
	KEY_ACE_SEARCH		Can find the key by searching/requesting
	KEY_ACE_LINK		Can make a link to the key
	KEY_ACE_SET_SECURITY	Can set security
	KEY_ACE_INVAL		Can invalidate
	KEY_ACE_REVOKE		Can revoke
	KEY_ACE_JOIN		Can join this keyring
	KEY_ACE_CLEAR		Can clear this keyring
	KEY_ACE__PERMS		Mask for these bits

Currently, the ACL is limited to a maximum of 16 entries.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/keyctl.h |    2 +
 security/keys/compat.c      |    6 ++
 security/keys/internal.h    |    7 ++
 security/keys/keyctl.c      |   10 +++
 security/keys/permission.c  |  161 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index caed64c568b5..f112ab545198 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -125,6 +125,8 @@ struct key_ace {
 #define KEYCTL_GET_PERSISTENT		22	/* get a user's persistent keyring */
 #define KEYCTL_DH_COMPUTE		23	/* Compute Diffie-Hellman values */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
+#define KEYCTL_GET_ACL			30	/* Get a key's ACL */
+#define KEYCTL_SET_ACL			31	/* Set a key's ACL */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/security/keys/compat.c b/security/keys/compat.c
index e87c89c0177c..4a6918f68f6b 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -141,6 +141,12 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 		return keyctl_restrict_keyring(arg2, compat_ptr(arg3),
 					       compat_ptr(arg4));
 
+	case KEYCTL_GET_ACL:
+		return keyctl_get_acl(arg2, compat_ptr(arg3), arg4);
+
+	case KEYCTL_SET_ACL:
+		return keyctl_set_acl(arg2, compat_ptr(arg3), arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 2123727f2751..1562923755d9 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -302,6 +302,13 @@ static inline long compat_keyctl_dh_compute(
 #endif
 #endif
 
+extern long keyctl_get_acl(key_serial_t keyid,
+			   struct key_ace __user *_acl,
+			   size_t nr_elem);
+extern long keyctl_set_acl(key_serial_t keyid,
+			   const struct key_ace __user *_acl,
+			   size_t nr_elem);
+
 
 /*
  * Debugging key validation
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 965c7907718a..f95e3fdba865 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1797,6 +1797,16 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					       (const char __user *) arg3,
 					       (const char __user *) arg4);
 
+	case KEYCTL_GET_ACL:
+		return keyctl_get_acl((key_serial_t)arg2,
+				      (struct key_ace __user *)arg3,
+				      (size_t)arg4);
+
+	case KEYCTL_SET_ACL:
+		return keyctl_set_acl((key_serial_t)arg2,
+				      (const struct key_ace __user *)arg3,
+				      (size_t)arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 1f8756ae2902..b236ab0417e3 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -217,3 +217,164 @@ void key_put_acl(struct key_acl *acl)
 	if (refcount_dec_and_test(&acl->usage))
 		kfree_rcu(acl, rcu);
 }
+
+/*
+ * Get the ACL attached to key.
+ */
+long keyctl_get_acl(key_serial_t keyid,
+		    struct key_ace __user *_acl,
+		    size_t max_acl_size)
+{
+	struct user_namespace *ns;
+	struct key_acl *acl;
+	struct key *key, *instkey;
+	key_ref_t key_ref;
+	long ret;
+	int i;
+
+	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_VIEW);
+	if (IS_ERR(key_ref)) {
+		if (PTR_ERR(key_ref) != -EACCES)
+			return PTR_ERR(key_ref);
+
+		/* viewing a key under construction is also permitted if we
+		 * have the authorisation token handy */
+		instkey = key_get_instantiation_authkey(keyid);
+		if (IS_ERR(instkey))
+			return PTR_ERR(instkey);
+		key_put(instkey);
+
+		key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, 0);
+		if (IS_ERR(key_ref))
+			return PTR_ERR(key_ref);
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	down_read(&key->sem);
+	acl = key->acl;
+	refcount_inc(&acl->usage);
+	up_read(&key->sem);
+
+	if (acl->nr_ace * sizeof(struct key_ace) > max_acl_size)
+		goto out;
+
+	ns = current_user_ns();
+	ret = -EFAULT;
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct kernel_key_ace *ace = &acl->aces[i];
+
+		if (put_user(ace->mask, &_acl[i].mask) < 0)
+			goto error;
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SUBJECT_ID:
+			if (put_user(ace->subject_id, &_acl[i].subject_id) < 0)
+				goto error;
+			break;
+		}
+	}
+
+out:
+	ret = acl->nr_ace * sizeof(struct key_ace);
+error:
+	return ret;
+}
+
+/*
+ * Get ACL from userspace.
+ */
+static struct key_acl *key_get_acl_from_user(const struct key_ace __user *_acl,
+					     size_t acl_size)
+{
+	struct user_namespace *ns;
+	struct key_acl *acl;
+	long ret;
+	int nr_ace, i;
+
+	if (acl_size % sizeof(struct key_ace) != 0)
+		return ERR_PTR(-EINVAL);
+	nr_ace = acl_size / sizeof(struct key_ace);
+	if (nr_ace > 16)
+		return ERR_PTR(-EINVAL);
+
+	acl = kzalloc(sizeof(struct key_acl) + sizeof(struct kernel_key_ace) * nr_ace,
+		      GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&acl->usage, 1);
+	acl->nr_ace = nr_ace;
+	ns = current_user_ns();
+	for (i = 0; i < nr_ace; i++) {
+		struct kernel_key_ace *ace = &acl->aces[i];
+
+		if (get_user(ace->mask, &_acl[i].mask) < 0)
+			goto fault;
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SUBJECT_ID:
+			if (get_user(ace->subject_id, &_acl[i].subject_id) < 0)
+				goto fault;
+			if (ace->subject_id = 0 ||
+			    ace->subject_id > KEY_ACE_POSSESSOR)
+				goto inval;
+			break;
+		default:
+			goto inval;
+		}
+	}
+
+	return acl;
+
+fault:
+	ret = -EFAULT;
+	goto error;
+inval:
+	ret = -EINVAL;
+error:
+	key_put_acl(acl);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Attach a new ACL to a key.
+ */
+long keyctl_set_acl(key_serial_t keyid,
+		    const struct key_ace __user *_acl,
+		    size_t acl_size)
+{
+	struct key_acl *acl, *discard;
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	acl = key_get_acl_from_user(_acl, acl_size);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	discard = acl;
+
+	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_SETSEC);
+	if (IS_ERR(key_ref)) {
+		ret = PTR_ERR(key_ref);
+		goto error_acl;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	ret = -EACCES;
+	down_write(&key->sem);
+
+	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+		discard = rcu_dereference_protected(key->acl,
+						    lockdep_is_held(&key->sem));
+		rcu_assign_pointer(key->acl, acl);
+		ret = 0;
+	}
+
+	up_write(&key->sem);
+	key_put(key);
+error_acl:
+	key_put_acl(discard);
+	return ret;
+}

