From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 02 Oct 2017 02:59:06 +0000
Subject: Re: [RFC][PATCH] KEYS: Replace uid/gid/perm permissions checking with ACL
Message-Id: <20171002025906.GA23539@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <10635.1506467135@warthog.procyon.org.uk>
	<23861.1506512501@warthog.procyon.org.uk>
In-Reply-To: <23861.1506512501@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi David,

On Wed, Sep 27, 2017 at 12:41:41PM +0100, David Howells wrote:
>     
>     Replace the uid/gid/perm permissions checking on a key with an ACL to allow
>     the SETATTR permission to be split.  The problem is that SETATTR covers a
>     slew of things, not all of which should be grouped together.  This
>     includes:
>     
>      (1) Changing the key ownership.
>     
>      (2) Changing the security information.
>     
>      (3) Keyring restriction.
>     
>      (4) Expiry time.
>     
>      (5) Revocation.
>     
>     and it has also been proposed to add:
>     
>      (6) Invalidation.
>     
>     The above can be divided into three groups: Controlling access (1), (2) and
>     (3), managing the content at construction time (4) and managing the key (5)
>     and (6).

This is interesting work, though it adds complexity and makes a lot of subtle
(and potentially breaking) changes to which permissions are required for various
things.  First I think you need to start out with a better statement of the
problems you are trying to solve.  The patch does much more than simply split up
the SETATTR permission --- for example, it also adds the ability to assign
permissions to specific uids, gids, and capabilities.  Who is planning to use
those features and why?

>     The KEYCTL_SETATTR function is then deprecated.  If called, it will

KEYCTL_SETPERM

>     construct an ACL to reflect the mask it is given, using possessor, owner,
>     group and other ACE's as appropriate if any of those elements are granted
>     any permissions.  SETATTR permission turns on all of INVAL, REVOKE and
>     SET_SECURITY.  WRITE permission turns on WRITE, REVOKE and, if a keyring,
>     CLEAR.  JOIN is turned on if a keyring is being altered.

The proposed changes to keyctl_setperm_key() actually never enable INVAL at all,
which doesn't match the description here.  Also, all breaking changes need to be
justified.  If keyctl_setperm(key, KEY_*_SEARCH) is no longer going to allow the
key to be invalidated (as I had proposed earlier), that is really its own change
which needs its own justification; it shouldn't be hidden in a larger patch.

>     will return an error if SETACL has been called on a key.

That is simplest, but it doesn't match the behavior of POSIX ACLs, for example.
With POSIX ACLs you can still chmod() a file that has an ACL.

>     The KEYCTL_DESCRIBE function then creates a permissions mask to return
>     depending on possessor, owner, group and other ACEs, indicating SETATTR if
>     any of INVAL, REVOKE and SET_SECURITY are set and indicating WRITE if any
>     of WRITE, REVOKE or CLEAR are set.

Ignoring ACEs for specific users, groups, and capabilities may be problematic
because the returned mask will under-estimate rather than over-estimate the
permissions that have been granted.  With POSIX ACLs, for example, the union of
all permissions that have been granted to any subjects other than the regular
ones is reflected in the group entry.  I believe that's generally considered
better from a security perspective, because then no permissions are "hidden"
from a listing of the regular (non-ACL) permissions only.

>     Note that the value subsequently returned by KEYCTL_DESCRIBE may not match
>     the value set with KEYCTL_SETATTR - but this is already true because keys
>     that lack ->read() can't have READ set and keys that lack ->write() can't
>     have WRITE set.

Not true; you *can* set READ on a key that lacks ->read() and WRITE on a key
that lacks ->update().  They are only omitted from the default permissions.

>     The KEYCTL_SET_TIMEOUT function then is permitted if WRITE or SETSEC is
>     set, or if the caller has a valid instantiation auth token.

This doesn't match the code, which asks for WRITE permission only.  It's also a
breaking change which needs to be justified on its own.  Also I'm not sure that
WRITE permission actually makes sense, given that KEYCTL_SET_TIMEOUT doesn't
modify the payload of the key.

> +static struct key_acl blacklist_key_acl = {
> +	.usage	= REFCOUNT_INIT(1),
> +	.nr_ace	= 2,
> +	.aces[0] = {
> +		.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_READ),
> +		.special_id = KEY_ACE_POSSESSOR,
> +	},
> +	.aces[1] = {
> +		.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_SEARCH),
> +		.special_id = KEY_ACE_OWNER,
> +	},
> +};

Designators into flexible arrays are a gcc extension which doesn't work with
clang.  Use this instead:

	.aces = {
		{
			.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_READ),
			.special_id = KEY_ACE_POSSESSOR,
		},
		{
			.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_SEARCH),
			.special_id = KEY_ACE_OWNER,
		},
	},

It's also difficult to read these lists of ACEs.  An ACE should read as "who",
then "what".  But now it reads as "part of who", then "what", then "the rest of
who".  It may be helpful to define some macros to create the entries more
concisely:

	.aces = {
		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_READ),
		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH),
	}

> diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
> new file mode 100644
> index 000000000000..7a738569a673
> --- /dev/null
> +++ b/include/linux/keyctl.h
> @@ -0,0 +1,3 @@
> +#define key_ace user_key_ace
> +#include <uapi/linux/keyctl.h>
> +#undef key_ace

This is ugly.  How about using kernel_key_ace for the internal kernel version?

> +#define KEY_ACE_SPECIAL		0x10000000 /* A specific subject */

What is a "specific subject"?

> +#define KEY_ACE_ROOT		5	/* The user namespace root user */

Which user namespace?

> +#define KEY_ACE_SYS_ADMIN	6	/* Anyone with CAP_SYS_ADMIN */
> +#define KEY_ACE_NET_ADMIN	7	/* Anyone with CAP_NET_ADMIN */

In what user namespace?

> +#define KEYCTL_GET_ACL			30	/* Get a key's ACL */
> +#define KEYCTL_SET_ACL			31	/* Set a key's ACL */

The implementations of these don't seem to be included in the patch.

> @@ -461,31 +441,17 @@ long keyctl_keyring_clear(key_serial_t ringid)
>  	struct key *keyring;
>  	long ret;
>  
> -	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
> +	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_CLEAR);
>  	if (IS_ERR(keyring_ref)) {
>  		ret = PTR_ERR(keyring_ref);
> -
> -		/* Root is permitted to invalidate certain special keyrings */
> -		if (capable(CAP_SYS_ADMIN)) {
> -			keyring_ref = lookup_user_key(ringid, 0, 0);
> -			if (IS_ERR(keyring_ref))
> -				goto error;
> -			if (test_bit(KEY_FLAG_ROOT_CAN_CLEAR,
> -				     &key_ref_to_ptr(keyring_ref)->flags))
> -				goto clear;
> -			goto error_put;
> -		}
> -
>  		goto error;
>  	}

The CLEAR permission is weird because WRITE is a superset of it.  (Clearing a
keyring is equivalent to unlinking all keys in it.)  Permissions should be
orthogonal.  Did you consider instead having one permission for adding links to
a keyring and one for deleting links?  I'm thinking about use cases similar to
that which the sticky bit on files is used for...

> +	for (i = 0; i < 4; i++) {
> +		struct key_ace *ace = &acl->aces[j];
> +		unsigned int subset = (perm >> (i * 8)) & 0x3f;
> +
> +		if (!subset)
> +			continue;
> +		ace->special_id = KEY_ACE_EVERYONE + i;
> +		ace->mask = KEY_ACE_SPECIAL | (subset & 0x1f);

No magic numbers please.  What are 0x3f and 0x1f?

Also, this code is assuming that the subject values are numbered in a certain
way.  There should be some BUILD_BUG_ON()s to verify that.

> +		if (subset & (KEY_OTH_WRITE | KEY_OTH_SETATTR))
> +			ace->mask |= KEY_ACE_REVOKE;
> +		if (subset & KEY_OTH_SETATTR)
> +			ace->mask |= KEY_ACE_SET_SECURITY;
> +		if (key->type = &key_type_keyring) {
> +			ace->mask |= KEY_ACE_JOIN;

Why is JOIN permission always given to keyrings?  If someone has JOIN permission
(or LINK permission, for that matter) on a keyring than they can acquire the
possessor permissions.  So always giving JOIN defeats the point of having all
the different non-possessor permissions...

> +			if (subset & KEY_OTH_WRITE)
> +				ace->mask |= KEY_ACE_CLEAR;
> +		}

Granting INVAL permission is missing.

> @@ -1333,7 +1349,7 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
>  	long ret;
>  
>  	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
> -				  KEY_NEED_SETATTR);
> +				  KEY_NEED_WRITE);

As mentioned earlier, this is a breaking change which needs to be justified on
its own.

> +	rcu_read_lock();
> +
> +	acl = rcu_dereference(key->acl);
> +	if (!acl || acl->nr_ace = 0)
> +		goto no_access_rcu;
> +
> +	for (i = 0; i < acl->nr_ace; i++) {
> +		const struct key_ace *ace = &acl->aces[i];
> +
> +		switch (ace->mask & KEY_ACE__IDENTITY) {
> +		case KEY_ACE_SPECIAL:
> +			switch (ace->special_id) {
> +			case KEY_ACE_POSSESSOR:
> +				if (is_key_possessed(key_ref))
> +					allow |= ace->mask;
> +				break;
> +			case KEY_ACE_OWNER:
> +				if (uid_eq(key->uid, cred->fsuid))
> +					allow |= ace->mask;
> +				break;
> +			case KEY_ACE_GROUP:
> +				if (gid_valid(key->gid) &&
> +				    gid_eq(key->gid, cred->fsgid))
> +					allow |= ace->mask;
> +				else if (groups_search(cred->group_info, key->gid))
> +					allow |= ace->mask;

Why call groups_search() when the key gid isn't valid?

> +			case KEY_ACE_ROOT:
> +				if (uid_eq(key->uid, cred->user_ns->owner))
> +					allow |= ace->mask;
> +				break;

Not sure I understand this.  So if someone owns the key, then they actually have
all the "root" privileges as well, since they can create and enter a new user
namespace where they are "root"?  That may not be what people expect.

> +			case KEY_ACE_SYS_ADMIN:
> +				if (ns_capable(&init_user_ns, CAP_SYS_ADMIN))
> +					allow |= ace->mask;
> +				break;

Also known as capable(CAP_SYS_ADMIN).  But also, why does it handle namespaces
differently from KEY_ACE_ROOT?

> +			case KEY_ACE_NET_ADMIN:
> +				if (ns_capable(&init_user_ns, CAP_NET_ADMIN))
> +					allow |= ace->mask;
> +				break;
> +			}
> +			break;

capable(CAP_NET_ADMIN), and see above.

> +	if (!(allow & desired_perm))
> +		goto no_access;

This is wrong because 'desired_perm' may contain multiple permissions --- and if
*any* are denied, then the permission check should fail.  It should be:

	if (desired_perm & ~allow)
		goto no_access;

> +unsigned int key_acl_to_perm(const struct key_acl *acl)
> +{
> +	unsigned int perm = 0;
> +	int i;
> +
> +	if (!acl || acl->nr_ace = 0)
> +		return 0;
> +
> +	for (i = 0; i < acl->nr_ace; i++) {
> +		const struct key_ace *ace = &acl->aces[i];
> +		unsigned int mask = ace->mask & KEY_ACE__PERMS;
> +
> +		switch (ace->mask & KEY_ACE__IDENTITY) {
> +		case KEY_ACE_SPECIAL:
> +			switch (ace->special_id) {
> +			case KEY_ACE_POSSESSOR:
> +				perm |= (mask & 0x1f) << 24;
> +				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
> +					perm |= KEY_POS_SETATTR;
> +				if (mask & KEY_ACE_CLEAR)
> +					perm |= KEY_POS_WRITE;
> +				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_POS_SETATTR))
> +					perm |= KEY_POS_WRITE;
> +				break;

The handling for REVOKE is weird, since it makes it possible that by *adding*
permissions, it can appear that WRITE permission was removed.

Also, why isn't JOIN handled here?

> +			case KEY_ACE_OWNER:
> +				perm |= (mask & 0x1f) << 16;
> +				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
> +					perm |= KEY_USR_SETATTR;
> +				if (mask & KEY_ACE_CLEAR)
> +					perm |= KEY_USR_WRITE;
> +				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_USR_SETATTR))
> +					perm |= KEY_USR_WRITE;
> +				break;
> +			case KEY_ACE_GROUP:
> +				perm |= (mask & 0x1f) << 8;
> +				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
> +					perm |= KEY_GRP_SETATTR;
> +				if (mask & KEY_ACE_CLEAR)
> +					perm |= KEY_GRP_WRITE;
> +				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_GRP_SETATTR))
> +					perm |= KEY_GRP_WRITE;
> +				break;
> +			case KEY_ACE_EVERYONE:
> +				perm |= (mask & 0x1f);
> +				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
> +					perm |= KEY_OTH_SETATTR;
> +				if (mask & KEY_ACE_CLEAR)
> +					perm |= KEY_OTH_WRITE;
> +				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_OTH_SETATTR))
> +					perm |= KEY_OTH_WRITE;
> +				break;
> +			}

Again, ignoring the "non-special" ACEs will cause the returned permissions mask
to be an under-estimate rather than an over-estimate.  I'm not sure that's a
good idea.

> +static void key_acl_rcu(struct rcu_head *rcu)
> +{
> +	kfree(container_of(rcu, struct key_acl, rcu));
> +}
> +
> +/*
> + * Destroy a key's ACL.
> + */
> +void key_put_acl(struct key_acl *acl)
> +{
> +	if (refcount_dec_and_test(&acl->usage))
> +		call_rcu(&acl->rcu, key_acl_rcu);
> +}

Use kfree_rcu().

> +	rcu_read_lock();
> +
> +	acl = rcu_dereference(key->acl);
> +	check_pos = false;
> +	for (i = 0; i < acl->nr_ace; i++) {
> +		const struct key_ace *ace = &acl->aces[i];
> +		if (ace->special_id = KEY_ACE_POSSESSOR) {
> +			if ((ace->mask & (KEY_ACE__IDENTITY | KEY_ACE_VIEW)) =
> +			    (KEY_ACE_SPECIAL | KEY_ACE_VIEW))
> +				check_pos = true;
> +			break;
> +		}
> +	}

Bug: this will break from the loop if it encounters an ACE for uid or gid 4 (the
value of KEY_ACE_POSSESSOR).  It needs to check for KEY_ACE_SPECIAL before
special_id = KEY_ACE_POSSESSOR can be considered meaningful.

> +static struct key_acl tp_keyring_acl = {
> +	.usage	= REFCOUNT_INIT(1),
> +	.nr_ace	= 2,
> +	.aces[0] = {
> +		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
> +		.special_id = KEY_ACE_POSSESSOR,
> +	},
> +	.aces[1] = {
> +		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
> +		.special_id = KEY_ACE_OWNER,
> +	},
> +};

It's not obvious what 'tp' means.  How about:

static struct key_acl thread_keyring_acl = {
	...
};

#define process_keyring_acl thread_keyring_acl

> +
> +static struct key_acl session_keyring_acl = {
> +	.usage	= REFCOUNT_INIT(1),
> +	.nr_ace	= 2,
> +	.aces[0] = {
> +		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
> +		.special_id = KEY_ACE_POSSESSOR,
> +	},
> +	.aces[1] = {
> +		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_JOIN,
> +		.special_id = KEY_ACE_OWNER,
> +	},
> +};
...
>  
>  		keyring = keyring_alloc("_ses", cred->uid, cred->gid, cred,
> -					KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
> -					flags, NULL, NULL);
> +					&session_keyring_acl, flags, NULL, NULL);
>  		if (IS_ERR(keyring))
>  			return PTR_ERR(keyring);

Why give JOIN permission to anonymous session keyrings? They shouldn't be
joinable --- and they weren't prior to this patch, since they were *not* given
KEY_USR_SEARCH permission.

> @@ -800,8 +836,7 @@ long join_session_keyring(const char *name)
>  	if (PTR_ERR(keyring) = -ENOKEY) {
>  		/* not found - try and create a new one */
>  		keyring = keyring_alloc(
> -			name, old->uid, old->gid, old,
> -			KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ | KEY_USR_LINK,
> +			name, old->uid, old->gid, old, &joinable_keyring_acl,
>  			KEY_ALLOC_IN_QUOTA, NULL, NULL);
>  		if (IS_ERR(keyring)) {
>  			ret = PTR_ERR(keyring);
> @@ -815,6 +850,11 @@ long join_session_keyring(const char *name)
>  		goto error3;
>  	}

This is also a behavior change which needs to be explained and justified on its
own.  A named keyring created with keyctl_join_session_keyring(name) was not
previously joinable by default, but after this patch it is.

>  
> +	ret = key_task_permission(make_key_ref(keyring, false), old,
> +				  KEY_NEED_JOIN);
> +	if (ret < 0)
> +		goto error3;
> +

find_keyring_by_name() also checks for SEARCH permission.  Now this checks for
JOIN as well.  Is it intentional that two different permissions are being
checked?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5d304736852..7c06837802be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6157,6 +6157,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>  {
>  	struct key *key;
>  	struct key_security_struct *ksec;
> +	unsigned oldstyle_perm;
>  	u32 sid;
>  
>  	/* if no specific permissions are requested, we skip the
> @@ -6165,12 +6166,25 @@ static int selinux_key_permission(key_ref_t key_ref,
>  	if (perm = 0)
>  		return 0;
>  
> +	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
> +				KEY_NEED_SEARCH | KEY_NEED_LINK);
> +	if (perm & KEY_NEED_INVAL)
> +		oldstyle_perm |= KEY_NEED_SEARCH;

Isn't this going to need to be SETATTR rather than SEARCH?  Even if we can't
update SELinux to be aware of the new-style permissions we still need to fix the
"search also means delete" bug.  Otherwise it will remain impossible to use
SELinux to enforce a read-only view of a key hierarchy.

> +	if (perm & KEY_NEED_REVOKE)
> +		oldstyle_perm |= KEY_NEED_WRITE;

Another breaking change which needs to be explained and justified.  Before
either the write or setattr SELinux key permissions was sufficient for
revocation, but now only write is.

> +	if (perm & KEY_NEED_SETSEC)
> +		oldstyle_perm |= 0x20;

Magic number.

> +	if (perm & KEY_NEED_JOIN)
> +		oldstyle_perm |= KEY_NEED_LINK;

The old-style permission for joining keyrings was SEARCH, not LINK.  Probably it
*should* have been LINK, but it's still a breaking change which needs to be
justified on its own...

> @@ -4377,7 +4377,8 @@ static int smack_key_permission(key_ref_t key_ref,
>  #endif
>  	if (perm & KEY_NEED_READ)
>  		request = MAY_READ;
> -	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
> +	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETSEC |
> +		    KEY_NEED_INVAL | KEY_NEED_REVOKE | KEY_NEED_CLEAR))
>  		request = MAY_WRITE;
>  	rc = smk_access(tkp, keyp->security, request, &ad);
>  	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);

Why does Smack ignore requests for SEARCH permission?

Eric
