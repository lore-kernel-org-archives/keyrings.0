From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Oct 2017 23:35:40 +0000
Subject: Re: [RFC][PATCH] KEYS: Replace uid/gid/perm permissions checking with ACL
Message-Id: <15431.1506987340@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171002025906.GA23539@zzz.localdomain>
	<10635.1506467135@warthog.procyon.org.uk>
	<23861.1506512501@warthog.procyon.org.uk>
In-Reply-To: <20171002025906.GA23539@zzz.localdomain>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> This is interesting work, though it adds complexity and makes a lot of
> subtle (and potentially breaking) changes to which permissions are required
> for various things.  First I think you need to start out with a better
> statement of the problems you are trying to solve.  The patch does much more
> than simply split up the SETATTR permission --- for example, it also adds
> the ability to assign permissions to specific uids, gids, and capabilities.
> Who is planning to use those features and why?

I should split out the additional subject types (uid, gid, cap-based) into a
separate patch, but having them in one patch helped design it.

> The proposed changes to keyctl_setperm_key() actually never enable INVAL at
> all

Fixed.  Now done if KEY_xxx_SEARCH is given.

> >     will return an error if SETACL has been called on a key.
> 
> That is simplest, but it doesn't match the behavior of POSIX ACLs, for
> example.  With POSIX ACLs you can still chmod() a file that has an ACL.

Does chmod() remove a POSIX ACL from a file?

> >     The KEYCTL_DESCRIBE function then creates a permissions mask to return
> >     depending on possessor, owner, group and other ACEs, indicating
> >     SETATTR if any of INVAL, REVOKE and SET_SECURITY are set and
> >     indicating WRITE if any of WRITE, REVOKE or CLEAR are set.
> 
> Ignoring ACEs for specific users, groups, and capabilities may be problematic
> because the returned mask will under-estimate rather than over-estimate the
> permissions that have been granted.

You have a point, but KEYCTL_DESCRIBE doesn't return the set of permissions
that has been granted to the caller.  The KEYCTL_DESCRIBE interface can't be
made to accurately describe the ACL.

> With POSIX ACLs, for example, the union of all permissions that have been
> granted to any subjects other than the regular ones

Define 'regular ones'.  For the keys case, do you mean possessor, user, group
and other?

> is reflected in the group entry.  I believe that's generally considered
> better from a security perspective, because then no permissions are "hidden"
> from a listing of the regular (non-ACL) permissions only.

I'm not sure how that helps.  If there's a group ID set, then displaying extra
permissions for it because, say, there's a matching UID-specific ACE present
would be giving a false picture of the permissions set.


> >     Note that the value subsequently returned by KEYCTL_DESCRIBE may not
> >     match the value set with KEYCTL_SETATTR - but this is already true
> >     because keys that lack ->read() can't have READ set and keys that lack
> >     ->write() can't have WRITE set.
> 
> Not true; you *can* set READ on a key that lacks ->read() and WRITE on a key
> that lacks ->update().  They are only omitted from the default permissions.

You are right.  This should be fixed, assuming we don't move to some other
permissions model.

> >     The KEYCTL_SET_TIMEOUT function then is permitted if WRITE or SETSEC is
> >     set, or if the caller has a valid instantiation auth token.
> 
> This doesn't match the code, which asks for WRITE permission only.  It's
> also a breaking change which needs to be justified on its own.  Also I'm not
> sure that WRITE permission actually makes sense, given that
> KEYCTL_SET_TIMEOUT doesn't modify the payload of the key.

I'm not sure I agree.  Whilst it doesn't modify the payload of a key, it is
*about* the lifetime of that payload IMO.

However, given that add_key() grants WRITE and SET_SECURITY/SETATTR permission
to the caller (assuming they stick the new key in a keyring they 'possess')
and request_key() grants permission directly to the upcall to set the timeout,
I wonder how much that matters.  It's just that it's not in the same class as
changing the key permissions.

> Designators into flexible arrays are a gcc extension which doesn't work with
> clang.

Fix clang?  gcc is the standard.  ;-)

> It's also difficult to read these lists of ACEs.  An ACE should read as
> "who", then "what".  But now it reads as "part of who", then "what", then
> "the rest of who".

True.  That makes it occupy less space, though.  I could also flip the order
of .mask and .special_id.

One thing I was wondering about is whether I should make the core ACLs R/O and
skip the inc/dec on the refcount if is_kernel_rodata() on the ACL is true.

> 	.aces = {
> 		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_READ),
> 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH),
> 	}

Yeah, that looks nicer.

> > +#define KEY_ACE_SPECIAL		0x10000000 /* A specific subject */
> 
> What is a "specific subject"?

'Subject' as in the entity performing the action.  'Specific subject' as
specified by .special_id.  I'm not sure 'specific' is the right word, or
'special' for that matter, but it's how I specify 'macro' things like
'possessor' or 'this key's owner'.

Maybe KEY_ACE_FIXED_SUBJECT or KEY_ACE_MACRO_SUBJECT?  I guess KEY_ACE_UID and
KEY_ACE_GID more fit 'specific subject'.

> > +#define KEY_ACE_ROOT		5	/* The user namespace root user */
> 
> Which user namespace?
>
> > +#define KEY_ACE_SYS_ADMIN	6	/* Anyone with CAP_SYS_ADMIN */
> > +#define KEY_ACE_NET_ADMIN	7	/* Anyone with CAP_NET_ADMIN */
> 
> In what user namespace?

cred->user_ns as per the cred passed to key_task_permission().

Having dicussed these a bit with Eric Biederman, I'm thinking I probably want
to rejig this, perhaps in favour of specifying the owner of a particular user
namespace.  However, I do think, as mentioned above, I need to split this bit
out into a subsequent patch.

> > +#define KEYCTL_GET_ACL			30	/* Get a key's ACL */
> > +#define KEYCTL_SET_ACL			31	/* Set a key's ACL */
> 
> The implementations of these don't seem to be included in the patch.

As I stated.  I do have implementations of these now, which I've attached to
the bottom of this message.

> The CLEAR permission is weird because WRITE is a superset of it.  (Clearing
> a keyring is equivalent to unlinking all keys in it.)  Permissions should be
> orthogonal.

I know, but I want to be able to grant just the ability to clear a keyring to
the admin.

> Did you consider instead having one permission for adding links
> to a keyring and one for deleting links?  I'm thinking about use cases
> similar to that which the sticky bit on files is used for...

Actually, that would've been better - and possibly could've avoided the need
for invalidate - though invalidate is applied to a specific key, not a
keyring.

However, what do you do about key replacement where a link to an old key is
replaced by add_key() with a link to a new key?  Do you have to have both
permits?  Or a third REPLACE permit?

> No magic numbers please.  What are 0x3f and 0x1f?

Things I don't have symbols for.  I would like to avoid using KEY_OTH_xxx when
referring to values that weren't originally 'other'.  I didn't succeed,
though, as I'm sure you noticed, so I could just use combinations of
KEY_OTH_xxx, I guess.

> Also, this code is assuming that the subject values are numbered in a certain
> way.

The UAPI is defined so.

Further, key_task_permission() in current Linus will fail if this is not so.

> > +		if (key->type = &key_type_keyring) {
> > +			ace->mask |= KEY_ACE_JOIN;
> 
> Why is JOIN permission always given to keyrings?

It isn't, except if one calls KEYCTL_SETPERM or if a keyring is created by
join_session_keyring() or as a normal session keyrign.  add_key() creates
keyrings with default_key_acl.

> If someone has JOIN permission (or LINK permission, for that matter) on a
> keyring than they can acquire the possessor permissions.  So always giving
> JOIN defeats the point of having all the different non-possessor
> permissions...

Without this patch, join_session_keyring() doesn't impose any permissions on
joining a keyring, though find_keyring_by_name() requires SEARCH permission on
a named keyring to be able to find it (and still does - though this should
perhaps be switched to JOIN also).

Yes, LINK permission can be used to 'possess' a keyring - but only if you're
granted it.

I can alter KEYCTL_SETPERM to only give KEY_ACE_JOIN if KEY_ACE_SEARCH.

The problem is that I have to supply JOIN to be backwardly compatible, which
makes it arguable that I need to add it to default_key_acl also.

I should probably make it widely available in the main patch and add a
separate patch limiting its availability.

> Granting INVAL permission is missing.

Fixed.  Setting SEARCH sets INVAL in KEYCTL_SETPERM.

> >  	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
> > -				  KEY_NEED_SETATTR);
> > +				  KEY_NEED_WRITE);
> 
> As mentioned earlier, this is a breaking change which needs to be justified on
> its own.

I can undo this and defer the thought to a later patch.

> Why call groups_search() when the key gid isn't valid?

Fixed.

> This is wrong because 'desired_perm' may contain multiple permissions ---

No, it can't.  I've fixed the comment.

It was never specified what was meant by specifying multiple permissions and I
don't think I ever used that directly.  The nearest I came was to make
multiple calls to key_{,task_}permission() so that it was obvious in the
caller what was meant.

> The handling for REVOKE is weird, since it makes it possible that by *adding*
> permissions, it can appear that WRITE permission was removed.

I know.  But there's no way to render an ACL down to an old-style permissions
mask accurately.  Revocation permission was enabled by having either SETATTR
or WRITE permission, but WRITE permission was disabled under some
circumstances if ->write() didn't exist.

> Also, why isn't JOIN handled here?

What would you represent it as?

Currently, the nearest thing to a JOIN permission is SEARCH, since you need
that to find the keyring by name in the first place; beyond that, there is no
permission needed to join a keyring.

I can make JOIN enable SEARCH, but if you pass it back to KEYCTL_SETPERM,
you're going to enable SEARCH and JOIN, even if you didn't have SEARCH before.

There isn't an easy answer.

> Again, ignoring the "non-special" ACEs will cause the returned permissions
> mask to be an under-estimate rather than an over-estimate.  I'm not sure
> that's a good idea.

There isn't really a viable alternative.  perm isn't what you, the caller,
have available to you.

> > +void key_put_acl(struct key_acl *acl)
> > +{
> > +	if (refcount_dec_and_test(&acl->usage))
> > +		call_rcu(&acl->rcu, key_acl_rcu);
> > +}
> 
> Use kfree_rcu().

Good idea.  I was thinking that could only deal with objects in which the
rcu_head was first, but that doesn't appear to be the case.

> Bug: this will break from the loop if it encounters an ACE for uid or gid 4
> (the value of KEY_ACE_POSSESSOR).  It needs to check for KEY_ACE_SPECIAL
> before special_id = KEY_ACE_POSSESSOR can be considered meaningful.

Fixed.

> It's not obvious what 'tp' means.  How about:
> 
> static struct key_acl thread_keyring_acl = {
> 	...
> };
> 
> #define process_keyring_acl thread_keyring_acl

I dislike that.  I've changed it to:

static struct key_acl thread_and_process_keyring_acl = ...

> Why give JOIN permission to anonymous session keyrings? They shouldn't be
> joinable --- and they weren't prior to this patch, since they were *not* given
> KEY_USR_SEARCH permission.

Point.  Fixed.

> This is also a behavior change which needs to be explained and justified on
> its own.  A named keyring created with keyctl_join_session_keyring(name) was
> not previously joinable by default, but after this patch it is.

Yeah - this should be its own patch.  If you create a named keyring with
KEYCTL_JOIN_SESSION_KEYRING, doing this again in another process with the same
name ought to join the first one if it's owned by you and lets you find it.

> find_keyring_by_name() also checks for SEARCH permission.  Now this checks for
> JOIN as well.  Is it intentional that two different permissions are being
> checked?

As previously mentioned, just JOIN should probably be used.  In effect, SEARCH
is also being split from JOIN.

> > +	if (perm & KEY_NEED_INVAL)
> > +		oldstyle_perm |= KEY_NEED_SEARCH;
> 
> Isn't this going to need to be SETATTR rather than SEARCH?

No.  Current code requires SEARCH (or CAP_SYS_ADMIN +
KEY_FLAG_ROOT_CAN_INVAL), not SETATTR.  It was *your* proposal to make it use
SETATTR instead.

> Even if we can't update SELinux to be aware of the new-style permissions we
> still need to fix the "search also means delete" bug.  Otherwise it will
> remain impossible to use SELinux to enforce a read-only view of a key
> hierarchy.

SELinux will need fixing if you want to be able to do that.  I need to discuss
how to do this with the SELinux people.

> > +	if (perm & KEY_NEED_REVOKE)
> > +		oldstyle_perm |= KEY_NEED_WRITE;
> 
> Another breaking change which needs to be explained and justified.  Before
> either the write or setattr SELinux key permissions was sufficient for
> revocation, but now only write is.

Fixed.

> > +	if (perm & KEY_NEED_SETSEC)
> > +		oldstyle_perm |= 0x20;
> 
> Magic number.

The symbol no longer exists.  I've #defined OLD_KEY_NEED_SETATTR to it in
hooks.c.

> > +	if (perm & KEY_NEED_JOIN)
> > +		oldstyle_perm |= KEY_NEED_LINK;
> 
> The old-style permission for joining keyrings was SEARCH, not LINK.
> Probably it *should* have been LINK, but it's still a breaking change which
> needs to be justified on its own...

Changed to SEARCH.

> Why does Smack ignore requests for SEARCH permission?

No idea.

David

---
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
index a699c5937cbe..1c6efdf04445 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -302,6 +302,14 @@ static inline long compat_keyctl_dh_compute(
 #endif
 #endif
 
+extern long keyctl_get_acl(key_serial_t keyid,
+			   struct user_key_ace __user *_acl,
+			   size_t nr_elem);
+extern long keyctl_set_acl(key_serial_t keyid,
+			   const struct user_key_ace __user *_acl,
+			   size_t nr_elem);
+
+
 /*
  * Debugging key validation
  */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 51fefec80cce..2773461c96ec 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -961,6 +961,8 @@ long keyctl_setperm_key(key_serial_t id, unsigned int perm)
 			ace->mask |= KEY_ACE_REVOKE;
 		if (subset & KEY_OTH_SETATTR)
 			ace->mask |= KEY_ACE_SET_SECURITY;
+		if (subset & KEY_OTH_SEARCH)
+			ace->mask |= KEY_ACE_INVAL;
 		if (key->type = &key_type_keyring) {
 			ace->mask |= KEY_ACE_JOIN;
 			if (subset & KEY_OTH_WRITE)
@@ -1768,6 +1770,16 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					       (const char __user *) arg3,
 					       (const char __user *) arg4);
 
+	case KEYCTL_GET_ACL:
+		return keyctl_get_acl((key_serial_t)arg2,
+				      (struct user_key_ace __user *)arg3,
+				      (size_t)arg4);
+
+	case KEYCTL_SET_ACL:
+		return keyctl_set_acl((key_serial_t)arg2,
+				      (const struct user_key_ace __user *)arg3,
+				      (size_t)arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 5e186b0f802d..7056ae3e8d8d 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/user_namespace.h>
+#include <linux/uaccess.h>
 #include "internal.h"
 
 struct key_acl default_key_acl = {
@@ -243,3 +244,184 @@ void key_put_acl(struct key_acl *acl)
 	if (refcount_dec_and_test(&acl->usage))
 		call_rcu(&acl->rcu, key_acl_rcu);
 }
+
+/*
+ * Get the ACL attached to key.
+ */
+long keyctl_get_acl(key_serial_t keyid,
+		    struct user_key_ace __user *_acl,
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
+	if (acl->nr_ace * sizeof(struct user_key_ace) > max_acl_size)
+		goto out;
+
+	ns = current_user_ns();
+	ret = -EFAULT;
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+
+		if (put_user(ace->mask, &_acl[i].mask) < 0)
+			goto error;
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SPECIAL:
+			if (put_user(ace->special_id, &_acl[i].special_id) < 0)
+				goto error;
+			break;
+		case KEY_ACE_UID:
+			if (put_user(from_kuid_munged(ns, ace->uid), &_acl[i].uid) < 0)
+				goto error;
+			break;
+		case KEY_ACE_GID:
+			if (put_user(from_kgid_munged(ns, ace->gid), &_acl[i].gid) < 0)
+				goto error;
+			break;
+		}
+	}
+
+out:
+	ret = acl->nr_ace * sizeof(struct user_key_ace);
+error:
+	return ret;
+}
+
+/*
+ * Get ACL from userspace.
+ */
+static struct key_acl *key_get_acl_from_user(const struct user_key_ace __user *_acl,
+					     size_t acl_size)
+{
+	struct user_namespace *ns;
+	struct key_acl *acl;
+	long ret;
+	int nr_ace, i;
+
+	if (acl_size % sizeof(struct user_key_ace) != 0)
+		return ERR_PTR(-EINVAL);
+	nr_ace = acl_size / sizeof(struct user_key_ace);
+	if (nr_ace > 16)
+		return ERR_PTR(-EINVAL);
+
+	acl = kzalloc(sizeof(struct key_acl) + sizeof(struct key_ace) * nr_ace,
+		      GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&acl->usage, 1);
+	acl->nr_ace = nr_ace;
+	ns = current_user_ns();
+	for (i = 0; i < nr_ace; i++) {
+		struct key_ace *ace = &acl->aces[i];
+		uid_t uid;
+		gid_t gid;
+
+		if (get_user(ace->mask, &_acl[i].mask) < 0)
+			goto fault;
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SPECIAL:
+			if (get_user(ace->special_id, &_acl[i].special_id) < 0)
+				goto fault;
+			if (ace->special_id = 0 ||
+			    ace->special_id > KEY_ACE_NET_ADMIN)
+				goto inval;
+			break;
+		case KEY_ACE_UID:
+			if (get_user(uid, &_acl[i].uid) < 0)
+				goto fault;
+			ace->uid = make_kuid(ns, uid);
+			break;
+		case KEY_ACE_GID:
+			if (get_user(gid, &_acl[i].gid) < 0)
+				goto fault;
+			ace->gid = make_kgid(ns, gid);
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
+		    const struct user_key_ace __user *_acl,
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
