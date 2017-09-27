From: David Howells <dhowells@redhat.com>
Date: Wed, 27 Sep 2017 11:41:41 +0000
Subject: Re: [RFC][PATCH] KEYS: Replace uid/gid/perm permissions checking with ACL
Message-Id: <23861.1506512501@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <10635.1506467135@warthog.procyon.org.uk>
In-Reply-To: <10635.1506467135@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Here's a patch that partially implements ACLs on keys.  I haven't yet done
> KEYCTL_[GS]ET_ACL, but KEYCTL_SETATTR, KEYCTL_DESCRIBE and /proc/keys have
> been modified to deal with it.
> 
> Most of the keyutils testsuite passes, just the permissions tests that don't
> because there isn't a fully compatible mapping from SETATTR -> ACL ->
> DESCRIBE.

Here's an updated patch.  It still doesn't implement GET/SET_ACL, but it
passes almost all the tests in the keyutils testsuite, barring:

 (1) tests/keyctl/dh_compute/badargs: The first wrong-key-type test now
     returns EOPNOTSUPP rather than ENOKEY as READ permission isn't removed
     if the type doesn't have ->read().  You still can't actually read the
     key.

 (2) tests/keyctl/permitting/valid: The view-other-permissions test doesn't
     work as Other has been replaced with Everyone in the ACL.

All other tests still work.
---
commit 2b5fa6ac075006f129b376886a5e8b41d47efad1
Author: David Howells <dhowells@redhat.com>
Date:   Tue Sep 26 09:45:26 2017 +0100

    KEYS: Replace uid/gid/perm permissions checking with ACL
    
    Replace the uid/gid/perm permissions checking on a key with an ACL to allow
    the SETATTR permission to be split.  The problem is that SETATTR covers a
    slew of things, not all of which should be grouped together.  This
    includes:
    
     (1) Changing the key ownership.
    
     (2) Changing the security information.
    
     (3) Keyring restriction.
    
     (4) Expiry time.
    
     (5) Revocation.
    
    and it has also been proposed to add:
    
     (6) Invalidation.
    
    The above can be divided into three groups: Controlling access (1), (2) and
    (3), managing the content at construction time (4) and managing the key (5)
    and (6).
    
    
    Add an ACL set & get functions that use a list of elements of the following
    form:
    
            struct key_ace {
                    union {
                            uid_t           uid;
                            gid_t           gid;
                            unsigned int    special_id;
                    };
                    unsigned int mask;
            };
    
    where the top four bits of mask indicate the subject being checked:
    
            KEY_ACE_SPECIAL         A specific value
            KEY_ACE_UID             A nominated UID
            KEY_ACE_GID             A nominated GID
    
    and if SPECIAL is specified, special_id is one of the following:
    
            KEY_ACE_POSSESSOR       The possessor of the key
            KEY_ACE_OWNER           The owner of the key
            KEY_ACE_GROUP           The key's group
            KEY_ACE_OTHER           Everyone else
    
    Each special ID may only occur once in an ACL.
    
    The bottom 28 bits of mask indicate the permissions being granted:
    
            KEY_ACE_VIEW            Can view the key metadata
            KEY_ACE_READ            Can read the key content
            KEY_ACE_WRITE           Can update/modify the key content
            KEY_ACE_SEARCH          Can find the key by searching/requesting
            KEY_ACE_LINK            Can make a link to the key
            KEY_ACE_INVAL           Can invalidate
            KEY_ACE_REVOKE          Can revoke
            KEY_ACE_SET_SECURITY    Can set security
            KEY_ACE_JOIN            Can join this keyring
            KEY_ACE_CLEAR           Can clear this keyring
    
    The ACEs are purely additive; all ACEs that apply are considered.  I figure
    that it's unlikely that you'll give the key's Group permissions that you
    wouldn't give the Owner and Other permissions that you wouldn't give to both
    Group and Owner.  Possessor permissions are already additive.
    
    The functions are:
    
            keyctl(KEYCTL_GET_ACL, key_serial_t key,
                   struct key_ace *acl_buffer, unsigned int buflen);
    
            keyctl(KEYCTL_SET_ACL, key_serial_t key,
                   const struct key_ace *acl, unsigned int len);
    
    The KEYCTL_SETATTR function is then deprecated.  If called, it will
    construct an ACL to reflect the mask it is given, using possessor, owner,
    group and other ACE's as appropriate if any of those elements are granted
    any permissions.  SETATTR permission turns on all of INVAL, REVOKE and
    SET_SECURITY.  WRITE permission turns on WRITE, REVOKE and, if a keyring,
    CLEAR.  JOIN is turned on if a keyring is being altered.  KEYCTL_SETATTR
    will return an error if SETACL has been called on a key.
    
    The KEYCTL_DESCRIBE function then creates a permissions mask to return
    depending on possessor, owner, group and other ACEs, indicating SETATTR if
    any of INVAL, REVOKE and SET_SECURITY are set and indicating WRITE if any
    of WRITE, REVOKE or CLEAR are set.
    
    Note that the value subsequently returned by KEYCTL_DESCRIBE may not match
    the value set with KEYCTL_SETATTR - but this is already true because keys
    that lack ->read() can't have READ set and keys that lack ->write() can't
    have WRITE set.
    
    The KEYCTL_SET_TIMEOUT function then is permitted if WRITE or SETSEC is
    set, or if the caller has a valid instantiation auth token.
    
    The KEYCTL_INVALIDATE function then requires INVAL.
    
    The KEYCTL_REVOKE function then requires REVOKE.
    
    The KEYCTL_JOIN_SESSION_KEYRING function then requires JOIN to join an
    existing keyring.
    
    The JOIN permission is enabled by default for session keyrings and manually
    created keyrings only.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 3a507b9e2568..5f03a60ebb7f 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -23,6 +23,32 @@
 
 static struct key *blacklist_keyring;
 
+static struct key_acl blacklist_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_READ),
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_SEARCH),
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+static struct key_acl blacklist_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH),
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /*
  * The description must be a type prefix, a colon and then an even number of
  * hex digits.  The hash is kept in the description.
@@ -93,8 +119,7 @@ int mark_hash_blacklisted(const char *hash)
 				   hash,
 				   NULL,
 				   0,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW),
+				   &blacklist_key_acl,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
@@ -153,9 +178,7 @@ static int __init blacklist_init(void)
 		keyring_alloc(".blacklist",
 			      KUIDT_INIT(0), KGIDT_INIT(0),
 			      current_cred(),
-			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ |
-			      KEY_USR_SEARCH,
+			      &blacklist_keyring_acl,
 			      KEY_ALLOC_NOT_IN_QUOTA |
 			      KEY_FLAG_KEEP,
 			      NULL, NULL);
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 6251d1b27f0c..1516598377a5 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -27,6 +27,33 @@ static struct key *secondary_trusted_keys;
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
 
+static struct key_acl trusted_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_READ),
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH),
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+static struct key_acl trusted_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = (KEY_ACE_SPECIAL |
+			 KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /**
  * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
  *
@@ -99,9 +126,7 @@ static __init int system_trusted_keyring_init(void)
 	builtin_trusted_keys  		keyring_alloc(".builtin_trusted_keys",
 			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
-			      KEY_ALLOC_NOT_IN_QUOTA,
+			      &trusted_key_acl, KEY_ALLOC_NOT_IN_QUOTA,
 			      NULL, NULL);
 	if (IS_ERR(builtin_trusted_keys))
 		panic("Can't allocate builtin trusted keyring\n");
@@ -110,10 +135,7 @@ static __init int system_trusted_keyring_init(void)
 	secondary_trusted_keys  		keyring_alloc(".secondary_trusted_keys",
 			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
-			       KEY_USR_WRITE),
-			      KEY_ALLOC_NOT_IN_QUOTA,
+			      &trusted_keyring_acl, KEY_ALLOC_NOT_IN_QUOTA,
 			      get_builtin_and_secondary_restriction(),
 			      NULL);
 	if (IS_ERR(secondary_trusted_keys))
@@ -163,8 +185,7 @@ static __init int load_system_certificate_list(void)
 					   NULL,
 					   p,
 					   plen,
-					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					   KEY_USR_VIEW | KEY_USR_READ),
+					   &trusted_key_acl,
 					   KEY_ALLOC_NOT_IN_QUOTA |
 					   KEY_ALLOC_BUILT_IN |
 					   KEY_ALLOC_BYPASS_RESTRICTION);
diff --git a/fs/afs/security.c b/fs/afs/security.c
index faca66227ecf..9131c2032d3f 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -28,7 +28,7 @@ struct key *afs_request_key(struct afs_cell *cell)
 
 	_debug("key %s", cell->anonymous_key->description);
 	key = request_key(&key_type_rxrpc, cell->anonymous_key->description,
-			  NULL);
+			  NULL, NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
 			_leave(" = %ld", PTR_ERR(key));
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index b611fc2e8984..0ad45f5fac59 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -32,6 +32,40 @@
 #include "cifsproto.h"
 static const struct cred *spnego_cred;
 
+static struct key_acl cifs_spnego_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_INVAL,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
+static struct key_acl cifs_spnego_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_CLEAR,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
 /* create a new cifs key */
 static int
 cifs_spnego_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
@@ -168,7 +202,8 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo)
 
 	cifs_dbg(FYI, "key description = %s\n", description);
 	saved_cred = override_creds(spnego_cred);
-	spnego_key = request_key(&cifs_spnego_key_type, description, "");
+	spnego_key = request_key(&cifs_spnego_key_type, description, "",
+				 &cifs_spnego_key_acl);
 	revert_creds(saved_cred);
 
 #ifdef CONFIG_CIFS_DEBUG2
@@ -205,8 +240,7 @@ init_cifs_spnego(void)
 
 	keyring = keyring_alloc(".cifs_spnego",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&cifs_spnego_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -221,7 +255,6 @@ init_cifs_spnego(void)
 	 * instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up
 	 */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	spnego_cred = cred;
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index b98436f5c7c7..972f82601790 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -33,6 +33,40 @@
 #include "cifsproto.h"
 #include "cifs_debug.h"
 
+static struct key_acl cifs_idmap_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_INVAL,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
+static struct key_acl cifs_idmap_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_CLEAR,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
 /* security id for everyone/world system group */
 static const struct cifs_sid sid_everyone = {
 	1, 1, {0, 0, 0, 0, 0, 1}, {0} };
@@ -298,7 +332,8 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 
 	rc = 0;
 	saved_cred = override_creds(root_cred);
-	sidkey = request_key(&cifs_idmap_key_type, desc, "");
+	sidkey = request_key(&cifs_idmap_key_type, desc, "",
+			     &cifs_idmap_key_acl);
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
 		cifs_dbg(FYI, "%s: Can't map %cid %u to a SID\n",
@@ -403,7 +438,8 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
 		return -ENOMEM;
 
 	saved_cred = override_creds(root_cred);
-	sidkey = request_key(&cifs_idmap_key_type, sidstr, "");
+	sidkey = request_key(&cifs_idmap_key_type, sidstr, "",
+			     &cifs_idmap_key_acl);
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
 		cifs_dbg(FYI, "%s: Can't map SID %s to a %cid\n",
@@ -481,8 +517,7 @@ init_cifs_idmap(void)
 
 	keyring = keyring_alloc(".cifs_idmap",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&cifs_idmap_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -495,7 +530,6 @@ init_cifs_idmap(void)
 
 	/* instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	root_cred = cred;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 5aa2d278ca84..10ced2b32291 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2469,7 +2469,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 	}
 
 	cifs_dbg(FYI, "%s: desc=%s\n", __func__, desc);
-	key = request_key(&key_type_logon, desc, "");
+	key = request_key(&key_type_logon, desc, "", NULL);
 	if (IS_ERR(key)) {
 		if (!ses->domainName) {
 			cifs_dbg(FYI, "domainName is NULL\n");
@@ -2480,7 +2480,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 		/* didn't work, try to find a domain key */
 		sprintf(desc, "cifs:d:%s", ses->domainName);
 		cifs_dbg(FYI, "%s: desc=%s\n", __func__, desc);
-		key = request_key(&key_type_logon, desc, "");
+		key = request_key(&key_type_logon, desc, "", NULL);
 		if (IS_ERR(key)) {
 			rc = PTR_ERR(key);
 			goto out_err;
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index b5ab06fabc60..c8b259ca1b92 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -323,7 +323,7 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 	const char *buf;
 	int len;
 
-	key = request_key(&key_type_user, "fscache:objlist", NULL);
+	key = request_key(&key_type_user, "fscache:objlist", NULL, NULL);
 	if (IS_ERR(key))
 		goto no_config;
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index dd5d27da8c0c..d87e50cec1fb 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -70,6 +70,40 @@ struct idmap {
 	struct mutex		idmap_mutex;
 };
 
+static struct key_acl nfs_idmap_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_INVAL,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
+static struct key_acl nfs_idmap_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_CLEAR,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
 /**
  * nfs_fattr_init_names - initialise the nfs_fattr owner_name/group_name fields
  * @fattr: fully initialised struct nfs_fattr
@@ -199,8 +233,7 @@ int nfs_idmap_init(void)
 
 	keyring = keyring_alloc(".id_resolver",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&nfs_idmap_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -215,7 +248,6 @@ int nfs_idmap_init(void)
 	if (ret < 0)
 		goto failed_reg_legacy;
 
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	id_resolver_cache = cred;
@@ -277,15 +309,14 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 	if (ret <= 0)
 		return ERR_PTR(ret);
 
-	rkey = request_key(&key_type_id_resolver, desc, "");
+	rkey = request_key(&key_type_id_resolver, desc, "", &nfs_idmap_key_acl);
 	if (IS_ERR(rkey)) {
 		mutex_lock(&idmap->idmap_mutex);
 		rkey = request_key_with_auxdata(&key_type_id_resolver_legacy,
-						desc, "", 0, idmap);
+						desc, "", 0, idmap,
+						&nfs_idmap_key_acl);
 		mutex_unlock(&idmap->idmap_mutex);
 	}
-	if (!IS_ERR(rkey))
-		set_bit(KEY_FLAG_ROOT_CAN_INVAL, &rkey->flags);
 
 	kfree(desc);
 	return rkey;
@@ -310,8 +341,6 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 	}
 
 	rcu_read_lock();
-	rkey->perm |= KEY_USR_VIEW;
-
 	ret = key_validate(rkey);
 	if (ret < 0)
 		goto out_up;
diff --git a/include/linux/key.h b/include/linux/key.h
index e315e16b6ff8..d2467ee1ccca 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -31,13 +31,12 @@
 /* key handle serial number */
 typedef int32_t key_serial_t;
 
-/* key handle permissions mask */
-typedef uint32_t key_perm_t;
-
 struct key;
 
 #ifdef CONFIG_KEYS
 
+#include <linux/keyctl.h>
+
 #undef KEY_DEBUGGING
 
 #define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
@@ -72,8 +71,6 @@ struct key;
 #define KEY_OTH_SETATTR	0x00000020
 #define KEY_OTH_ALL	0x0000003f
 
-#define KEY_PERM_UNDEF	0xffffffff
-
 struct seq_file;
 struct user_struct;
 struct signal_struct;
@@ -95,6 +92,22 @@ union key_payload {
 	void			*data[4];
 };
 
+struct key_ace {
+	unsigned int		mask;
+	union {
+		kuid_t		uid;
+		kgid_t		gid;
+		unsigned int	special_id;
+	};
+};
+
+struct key_acl {
+	refcount_t		usage;
+	unsigned int		nr_ace;
+	struct rcu_head		rcu;
+	struct key_ace		aces[];
+};
+
 /*****************************************************************************/
 /*
  * key reference with possession attribute handling
@@ -156,6 +169,7 @@ struct key {
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
 	void			*security;	/* security data for this key */
+	struct key_acl		__rcu *acl;
 	union {
 		time_t		expiry;		/* time at which key expires (or 0) */
 		time_t		revoked_at;	/* time at which key was revoked */
@@ -163,7 +177,6 @@ struct key {
 	time_t			last_used_at;	/* last time used for LRU keyring discard */
 	kuid_t			uid;
 	kgid_t			gid;
-	key_perm_t		perm;		/* access permissions */
 	unsigned short		quotalen;	/* length added to quota */
 	unsigned short		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
@@ -182,12 +195,11 @@ struct key {
 #define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
 #define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
 #define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
-#define KEY_FLAG_ROOT_CAN_CLEAR	6	/* set if key can be cleared by root without permission */
 #define KEY_FLAG_INVALIDATED	7	/* set if key has been invalidated */
 #define KEY_FLAG_BUILTIN	8	/* set if key is built in to the kernel */
-#define KEY_FLAG_ROOT_CAN_INVAL	9	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		10	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	11	/* set if key is a user or user session keyring */
+#define KEY_FLAG_HAS_ACL	12	/* Set if KEYCTL_SETACL called on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
@@ -234,7 +246,7 @@ extern struct key *key_alloc(struct key_type *type,
 			     const char *desc,
 			     kuid_t uid, kgid_t gid,
 			     const struct cred *cred,
-			     key_perm_t perm,
+			     struct key_acl *acl,
 			     unsigned long flags,
 			     struct key_restriction *restrict_link);
 
@@ -268,24 +280,28 @@ static inline void key_ref_put(key_ref_t key_ref)
 
 extern struct key *request_key(struct key_type *type,
 			       const char *description,
-			       const char *callout_info);
+			       const char *callout_info,
+			       struct key_acl *acl);
 
 extern struct key *request_key_with_auxdata(struct key_type *type,
 					    const char *description,
 					    const void *callout_info,
 					    size_t callout_len,
-					    void *aux);
+					    void *aux,
+					    struct key_acl *acl);
 
 extern struct key *request_key_async(struct key_type *type,
 				     const char *description,
 				     const void *callout_info,
-				     size_t callout_len);
+				     size_t callout_len,
+				     struct key_acl *acl);
 
 extern struct key *request_key_async_with_auxdata(struct key_type *type,
 						  const char *description,
 						  const void *callout_info,
 						  size_t callout_len,
-						  void *aux);
+						  void *aux,
+						  struct key_acl *acl);
 
 extern int wait_for_key_construction(struct key *key, bool intr);
 
@@ -296,7 +312,7 @@ extern key_ref_t key_create_or_update(key_ref_t keyring,
 				      const char *description,
 				      const void *payload,
 				      size_t plen,
-				      key_perm_t perm,
+				      struct key_acl *acl,
 				      unsigned long flags);
 
 extern int key_update(key_ref_t key,
@@ -311,7 +327,7 @@ extern int key_unlink(struct key *keyring,
 
 extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 				 const struct cred *cred,
-				 key_perm_t perm,
+				 struct key_acl *acl,
 				 unsigned long flags,
 				 struct key_restriction *restrict_link,
 				 struct key *dest);
@@ -345,13 +361,16 @@ extern void key_set_timeout(struct key *, unsigned);
 /*
  * The permissions required on a key that we're looking up.
  */
-#define	KEY_NEED_VIEW	0x01	/* Require permission to view attributes */
-#define	KEY_NEED_READ	0x02	/* Require permission to read content */
-#define	KEY_NEED_WRITE	0x04	/* Require permission to update / modify */
-#define	KEY_NEED_SEARCH	0x08	/* Require permission to search (keyring) or find (key) */
-#define	KEY_NEED_LINK	0x10	/* Require permission to link */
-#define	KEY_NEED_SETATTR 0x20	/* Require permission to change attributes */
-#define	KEY_NEED_ALL	0x3f	/* All the above permissions */
+#define	KEY_NEED_VIEW	0x001	/* Require permission to view attributes */
+#define	KEY_NEED_READ	0x002	/* Require permission to read content */
+#define	KEY_NEED_WRITE	0x004	/* Require permission to update / modify */
+#define	KEY_NEED_SEARCH	0x008	/* Require permission to search (keyring) or find (key) */
+#define	KEY_NEED_LINK	0x010	/* Require permission to link */
+#define	KEY_NEED_INVAL	0x020	/* Require permission to invalidate key */
+#define	KEY_NEED_REVOKE	0x040	/* Require permission to revoke key */
+#define	KEY_NEED_SETSEC	0x080	/* Require permission to set owner, group, ACL */
+#define	KEY_NEED_JOIN	0x100	/* Require permission to join keyring as session */
+#define	KEY_NEED_CLEAR	0x200	/* Require permission to clear a keyring */
 
 /**
  * key_is_instantiated - Determine if a key has been positively instantiated
diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
new file mode 100644
index 000000000000..7a738569a673
--- /dev/null
+++ b/include/linux/keyctl.h
@@ -0,0 +1,3 @@
+#define key_ace user_key_ace
+#include <uapi/linux/keyctl.h>
+#undef key_ace
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index ef16df06642a..8a9e829ef499 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -14,6 +14,40 @@
 
 #include <linux/types.h>
 
+/* Keyring ACL definitions */
+struct key_ace {
+	unsigned int		mask;
+#define KEY_ACE_VIEW		0x00000001 /* Can describe the key */
+#define KEY_ACE_READ		0x00000002 /* Can read the key content */
+#define KEY_ACE_WRITE		0x00000004 /* Can update/modify the key content */
+#define KEY_ACE_SEARCH		0x00000008 /* Can find the key by search */
+#define KEY_ACE_LINK		0x00000010 /* Can make a link to the key */
+#define KEY_ACE_INVAL		0x00000020 /* Can invalidate the key */
+#define KEY_ACE_REVOKE		0x00000040 /* Can revoke the key */
+#define KEY_ACE_SET_SECURITY	0x00000080 /* Can set owner, group, ACL */
+#define KEY_ACE_JOIN		0x00000100 /* Can join keyring */
+#define KEY_ACE_CLEAR		0x00000200 /* Can clear keyring */
+#define KEY_ACE__ORDINARY	0x0000001f /* Ordinary permissions */
+#define KEY_ACE__PERMS		0x0fffffff
+#define KEY_ACE_SPECIAL		0x10000000 /* A specific subject */
+#define KEY_ACE_UID		0x20000000 /* A nominated UID */
+#define KEY_ACE_GID		0x30000000 /* A nominated GID */
+#define KEY_ACE__IDENTITY	0xf0000000
+
+	union {
+		uid_t		uid;
+		gid_t		gid;
+		unsigned int	special_id;
+#define KEY_ACE_EVERYONE	1	/* Everyone, including owner and group */
+#define KEY_ACE_GROUP		2	/* The key's group */
+#define KEY_ACE_OWNER		3	/* The owner of the key */
+#define KEY_ACE_POSSESSOR	4	/* Any process that possesses of the key */
+#define KEY_ACE_ROOT		5	/* The user namespace root user */
+#define KEY_ACE_SYS_ADMIN	6	/* Anyone with CAP_SYS_ADMIN */
+#define KEY_ACE_NET_ADMIN	7	/* Anyone with CAP_NET_ADMIN */
+	};
+};
+
 /* special process keyring shortcut IDs */
 #define KEY_SPEC_THREAD_KEYRING		-1	/* - key ID for thread-specific keyring */
 #define KEY_SPEC_PROCESS_KEYRING	-2	/* - key ID for process-specific keyring */
@@ -61,6 +95,8 @@
 #define KEYCTL_GET_PERSISTENT		22	/* get a user's persistent keyring */
 #define KEYCTL_DH_COMPUTE		23	/* Compute Diffie-Hellman values */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
+#define KEYCTL_GET_ACL			30	/* Get a key's ACL */
+#define KEYCTL_SET_ACL			31	/* Set a key's ACL */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 8737412c7b27..9ef48527896a 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -45,6 +45,23 @@ const struct cred *dns_resolver_cache;
 
 #define	DNS_ERRORNO_OPTION	"dnserror"
 
+static struct key_acl dns_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_CLEAR,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
 /*
  * Preparse instantiation data for a dns_resolver key.
  *
@@ -279,8 +296,7 @@ static int __init init_dns_resolver(void)
 
 	keyring = keyring_alloc(".dns_resolver",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&dns_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -293,7 +309,6 @@ static int __init init_dns_resolver(void)
 
 	/* instruct request_key() to use this special keyring as a cache for
 	 * the results it looks up */
-	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 	dns_resolver_cache = cred;
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index af781010753b..367186023af6 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -46,6 +46,23 @@
 
 #include "internal.h"
 
+static struct key_acl dns_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 3,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+	.aces[2] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_INVAL,
+		.special_id = KEY_ACE_NET_ADMIN,
+	},
+};
+
 /**
  * dns_query - Query the DNS
  * @type: Query type (or NULL for straight host->IP lookup)
@@ -122,7 +139,7 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	 * add_key() to preinstall malicious redirections
 	 */
 	saved_cred = override_creds(dns_resolver_cache);
-	rkey = request_key(&key_type_dns_resolver, desc, options);
+	rkey = request_key(&key_type_dns_resolver, desc, options, &dns_key_acl);
 	revert_creds(saved_cred);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
@@ -131,9 +148,6 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	}
 
 	down_read(&rkey->sem);
-	set_bit(KEY_FLAG_ROOT_CAN_INVAL, &rkey->flags);
-	rkey->perm |= KEY_USR_VIEW;
-
 	ret = key_validate(rkey);
 	if (ret < 0)
 		goto put;
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index e7f6b8823eb6..3e8639ac9f14 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -27,6 +27,15 @@
 #include <keys/user-type.h>
 #include "ar-internal.h"
 
+static struct key_acl rxrpc_null_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 1,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+};
+
 static int rxrpc_vet_description_s(const char *);
 static int rxrpc_preparse(struct key_preparsed_payload *);
 static int rxrpc_preparse_s(struct key_preparsed_payload *);
@@ -912,7 +921,7 @@ int rxrpc_request_key(struct rxrpc_sock *rx, char __user *optval, int optlen)
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
-	key = request_key(&key_type_rxrpc, description, NULL);
+	key = request_key(&key_type_rxrpc, description, NULL, NULL);
 	if (IS_ERR(key)) {
 		kfree(description);
 		_leave(" = %ld", PTR_ERR(key));
@@ -943,7 +952,7 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, char __user *optval,
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
-	key = request_key(&key_type_keyring, description, NULL);
+	key = request_key(&key_type_keyring, description, NULL, NULL);
 	if (IS_ERR(key)) {
 		kfree(description);
 		_leave(" = %ld", PTR_ERR(key));
@@ -1024,7 +1033,7 @@ struct key *rxrpc_get_null_key(const char *keyname)
 
 	key = key_alloc(&key_type_rxrpc, keyname,
 			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-			KEY_POS_SEARCH, KEY_ALLOC_NOT_IN_QUOTA, NULL);
+			&rxrpc_null_key_acl, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(key))
 		return key;
 
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 69855ba0d3b3..dfcc68d341f5 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -303,7 +303,7 @@ static struct key *request_user_key(const char *master_desc, const u8 **master_k
 	const struct user_key_payload *upayload;
 	struct key *ukey;
 
-	ukey = request_key(&key_type_user, master_desc, NULL);
+	ukey = request_key(&key_type_user, master_desc, NULL, NULL);
 	if (IS_ERR(ukey))
 		goto error;
 
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index cbf0bc127a73..675d335c93fd 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -34,7 +34,7 @@ struct key *request_trusted_key(const char *trusted_desc,
 	struct trusted_key_payload *tpayload;
 	struct key *tkey;
 
-	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
+	tkey = request_key(&key_type_trusted, trusted_desc, NULL, NULL);
 	if (IS_ERR(tkey))
 		goto error;
 
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 87cb260e4890..094eca1e1f42 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -155,6 +155,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 			atomic_dec(&key->user->nikeys);
 
 		key_user_put(key->user);
+		key_put_acl(key->acl);
 
 		kfree(key->description);
 
@@ -225,7 +226,6 @@ static void key_garbage_collector(struct work_struct *work)
 			if (key->type = key_gc_dead_keytype) {
 				gc_state |= KEY_GC_FOUND_DEAD_KEY;
 				set_bit(KEY_FLAG_DEAD, &key->flags);
-				key->perm = 0;
 				goto skip_dead_key;
 			} else if (key->type = &key_type_keyring &&
 				   key->restrict_link) {
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 503adbae7b0d..a699c5937cbe 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -88,7 +88,8 @@ extern struct rb_root key_serial_tree;
 extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
 extern wait_queue_head_t request_key_conswq;
-
+extern struct key_acl default_key_acl;
+extern struct key_acl joinable_keyring_acl;
 
 extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
@@ -153,13 +154,14 @@ extern struct key *request_key_and_link(struct key_type *type,
 					const void *callout_info,
 					size_t callout_len,
 					void *aux,
+					struct key_acl *acl,
 					struct key *dest_keyring,
 					unsigned long flags);
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
 extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
-				 key_perm_t perm);
+				 u32 desired_perm);
 #define KEY_LOOKUP_CREATE	0x01
 #define KEY_LOOKUP_PARTIAL	0x02
 #define KEY_LOOKUP_FOR_UNLINK	0x04
@@ -178,7 +180,9 @@ extern void key_gc_keytype(struct key_type *ktype);
 
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
-			       key_perm_t perm);
+			       u32 desired_perm);
+extern unsigned int key_acl_to_perm(const struct key_acl *acl);
+extern void key_put_acl(struct key_acl *acl);
 
 /*
  * Check to see whether permission is granted to use a key in the desired way.
@@ -234,7 +238,7 @@ extern long keyctl_keyring_search(key_serial_t, const char __user *,
 				  const char __user *, key_serial_t);
 extern long keyctl_read_key(key_serial_t, char __user *, size_t);
 extern long keyctl_chown_key(key_serial_t, uid_t, gid_t);
-extern long keyctl_setperm_key(key_serial_t, key_perm_t);
+extern long keyctl_setperm_key(key_serial_t, unsigned int);
 extern long keyctl_instantiate_key(key_serial_t, const void __user *,
 				   size_t, key_serial_t);
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
diff --git a/security/keys/key.c b/security/keys/key.c
index eb914a838840..f342bf586006 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -199,7 +199,7 @@ static inline void key_alloc_serial(struct key *key)
  * @uid: The owner of the new key.
  * @gid: The group ID for the new key's group permissions.
  * @cred: The credentials specifying UID namespace.
- * @perm: The permissions mask of the new key.
+ * @acl: The ACL to attach to the new key.
  * @flags: Flags specifying quota properties.
  * @restrict_link: Optional link restriction for new keyrings.
  *
@@ -227,7 +227,7 @@ static inline void key_alloc_serial(struct key *key)
  */
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      kuid_t uid, kgid_t gid, const struct cred *cred,
-		      key_perm_t perm, unsigned long flags,
+		      struct key_acl *acl, unsigned long flags,
 		      struct key_restriction *restrict_link)
 {
 	struct key_user *user = NULL;
@@ -250,6 +250,9 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	desclen = strlen(desc);
 	quotalen = desclen + 1 + type->def_datalen;
 
+	if (!acl)
+		acl = &default_key_acl;
+
 	/* get hold of the key tracking for this user */
 	user = key_user_lookup(uid);
 	if (!user)
@@ -295,7 +298,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->datalen = type->def_datalen;
 	key->uid = uid;
 	key->gid = gid;
-	key->perm = perm;
+	refcount_inc(&acl->usage);
+	rcu_assign_pointer(key->acl, acl);
 	key->restrict_link = restrict_link;
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
@@ -775,7 +779,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
  * @description: The searchable description for the key.
  * @payload: The data to use to instantiate or update the key.
  * @plen: The length of @payload.
- * @perm: The permissions mask for a new key.
+ * @acl: The ACL to attach if a key is created.
  * @flags: The quota flags for a new key.
  *
  * Search the destination keyring for a key of the same description and if one
@@ -798,7 +802,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			       const char *description,
 			       const void *payload,
 			       size_t plen,
-			       key_perm_t perm,
+			       struct key_acl *acl,
 			       unsigned long flags)
 {
 	struct keyring_index_key index_key = {
@@ -889,22 +893,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			goto found_matching_key;
 	}
 
-	/* if the client doesn't provide, decide on the permissions we want */
-	if (perm = KEY_PERM_UNDEF) {
-		perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
-		perm |= KEY_USR_VIEW;
-
-		if (index_key.type->read)
-			perm |= KEY_POS_READ;
-
-		if (index_key.type = &key_type_keyring ||
-		    index_key.type->update)
-			perm |= KEY_POS_WRITE;
-	}
-
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
-			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
+			cred->fsuid, cred->fsgid, cred, acl, flags, NULL);
 	if (IS_ERR(key)) {
 		key_ref = ERR_CAST(key);
 		goto error_link_end;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 365ff85d7e27..51fefec80cce 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -120,8 +120,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	/* create or update the requested key and add it to the target
 	 * keyring */
 	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, KEY_PERM_UNDEF,
-				       KEY_ALLOC_IN_QUOTA);
+				       payload, plen, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -211,7 +210,8 @@ SYSCALL_DEFINE4(request_key, const char __user *, _type,
 
 	/* do the search */
 	key = request_key_and_link(ktype, description, callout_info,
-				   callout_len, NULL, key_ref_to_ptr(dest_ref),
+				   callout_len, NULL, NULL,
+				   key_ref_to_ptr(dest_ref),
 				   KEY_ALLOC_IN_QUOTA);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
@@ -373,16 +373,10 @@ long keyctl_revoke_key(key_serial_t id)
 	struct key *key;
 	long ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_WRITE);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_REVOKE);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
-		if (ret != -EACCES)
-			goto error;
-		key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
-		if (IS_ERR(key_ref)) {
-			ret = PTR_ERR(key_ref);
-			goto error;
-		}
+		goto error;
 	}
 
 	key = key_ref_to_ptr(key_ref);
@@ -416,32 +410,18 @@ long keyctl_invalidate_key(key_serial_t id)
 
 	kenter("%d", id);
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_INVAL);
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
@@ -461,31 +441,17 @@ long keyctl_keyring_clear(key_serial_t ringid)
 	struct key *keyring;
 	long ret;
 
-	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_CLEAR);
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
@@ -590,6 +556,7 @@ long keyctl_describe_key(key_serial_t keyid,
 			 size_t buflen)
 {
 	struct key *key, *instkey;
+	unsigned int perm;
 	key_ref_t key_ref;
 	char *infobuf;
 	long ret;
@@ -619,6 +586,10 @@ long keyctl_describe_key(key_serial_t keyid,
 	key = key_ref_to_ptr(key_ref);
 	desclen = strlen(key->description);
 
+	rcu_read_lock();
+	perm = key_acl_to_perm(rcu_dereference(key->acl));
+	rcu_read_unlock();
+
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
 	infobuf = kasprintf(GFP_KERNEL,
@@ -626,7 +597,7 @@ long keyctl_describe_key(key_serial_t keyid,
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
-			    key->perm);
+			    perm);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
@@ -844,7 +815,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		goto error;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -939,18 +910,25 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
  * the key need not be fully instantiated yet.  If the caller does not have
  * sysadmin capability, it may only change the permission on keys that it owns.
  */
-long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
+long keyctl_setperm_key(key_serial_t id, unsigned int perm)
 {
+	struct key_acl *acl, *discard;
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
+	int nr, i, j;
 
-	ret = -EINVAL;
 	if (perm & ~(KEY_POS_ALL | KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL))
-		goto error;
+		return -EINVAL;
+	
+	nr = 0;
+	if (perm & KEY_POS_ALL) nr++;
+	if (perm & KEY_USR_ALL) nr++;
+	if (perm & KEY_GRP_ALL) nr++;
+	if (perm & KEY_OTH_ALL) nr++;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -958,17 +936,55 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 
 	key = key_ref_to_ptr(key_ref);
 
+	ret = -EOPNOTSUPP;
+	if (test_bit(KEY_FLAG_HAS_ACL, &key->flags))
+		goto error_key;
+
+	ret = -ENOMEM;
+	acl = kzalloc(sizeof(struct key_acl) + sizeof(struct key_ace) * nr,
+		      GFP_KERNEL);
+	if (!acl)
+		goto error_key;
+
+	refcount_set(&acl->usage, 1);
+	acl->nr_ace = nr;
+	j = 0;
+	for (i = 0; i < 4; i++) {
+		struct key_ace *ace = &acl->aces[j];
+		unsigned int subset = (perm >> (i * 8)) & 0x3f;
+
+		if (!subset)
+			continue;
+		ace->special_id = KEY_ACE_EVERYONE + i;
+		ace->mask = KEY_ACE_SPECIAL | (subset & 0x1f);
+		if (subset & (KEY_OTH_WRITE | KEY_OTH_SETATTR))
+			ace->mask |= KEY_ACE_REVOKE;
+		if (subset & KEY_OTH_SETATTR)
+			ace->mask |= KEY_ACE_SET_SECURITY;
+		if (key->type = &key_type_keyring) {
+			ace->mask |= KEY_ACE_JOIN;
+			if (subset & KEY_OTH_WRITE)
+				ace->mask |= KEY_ACE_CLEAR;
+		}
+		j++;
+	}
+
 	/* make the changes with the locks held to prevent chown/chmod races */
+	discard = acl;
 	ret = -EACCES;
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
 	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
-		key->perm = perm;
+		discard = rcu_dereference_protected(key->acl,
+						    lockdep_is_held(&key->sem));
+		rcu_assign_pointer(key->acl, acl);
 		ret = 0;
 	}
 
 	up_write(&key->sem);
+	key_put_acl(discard);
+error_key:
 	key_put(key);
 error:
 	return ret;
@@ -1333,7 +1349,7 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
 	long ret;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_WRITE);
 	if (IS_ERR(key_ref)) {
 		/* setting the timeout on a key under construction is permitted
 		 * if we have the authorisation token handy */
@@ -1604,7 +1620,7 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
 	char *restriction = NULL;
 	long ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 
@@ -1692,7 +1708,7 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 	case KEYCTL_SETPERM:
 		return keyctl_setperm_key((key_serial_t) arg2,
-					  (key_perm_t) arg3);
+					  (unsigned int)arg3);
 
 	case KEYCTL_INSTANTIATE:
 		return keyctl_instantiate_key((key_serial_t) arg2,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4fa82a8a9c0e..ea7e2620ca03 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -489,11 +489,19 @@ static long keyring_read(const struct key *keyring,
 	return ctx.count;
 }
 
-/*
- * Allocate a keyring and link into the destination keyring.
+/**
+ * keyring_alloc - Allocate a keyring and link into the destination
+ * @description: The key description to allow the key to be searched out.
+ * @uid: The owner of the new key.
+ * @gid: The group ID for the new key's group permissions.
+ * @cred: The credentials specifying UID namespace.
+ * @acl: The ACL to attach to the new key.
+ * @flags: Flags specifying quota properties.
+ * @restrict_link: Optional link restriction for new keyrings.
+ * @dest: Destination keyring.
  */
 struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
-			  const struct cred *cred, key_perm_t perm,
+			  const struct cred *cred, struct key_acl *acl,
 			  unsigned long flags,
 			  struct key_restriction *restrict_link,
 			  struct key *dest)
@@ -502,7 +510,7 @@ struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 	int ret;
 
 	keyring = key_alloc(&key_type_keyring, description,
-			    uid, gid, cred, perm, flags, restrict_link);
+			    uid, gid, cred, acl, flags, restrict_link);
 	if (!IS_ERR(keyring)) {
 		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
 		if (ret < 0) {
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 732cc0beffdf..5e186b0f802d 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -11,13 +11,41 @@
 
 #include <linux/module.h>
 #include <linux/security.h>
+#include <linux/user_namespace.h>
 #include "internal.h"
 
+struct key_acl default_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+struct key_acl joinable_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE_VIEW | KEY_ACE_READ |
+					   KEY_ACE_LINK | KEY_ACE_JOIN),
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /**
  * key_task_permission - Check a key can be used
  * @key_ref: The key to check.
  * @cred: The credentials to use.
- * @perm: The permissions to check for.
+ * @desired_perm: The permissions to check for.
  *
  * Check to see whether permission is granted to use a key in the desired way,
  * but permit the security modules to override.
@@ -28,53 +56,83 @@
  * permissions bits or the LSM check.
  */
 int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
-			unsigned perm)
+			unsigned int desired_perm)
 {
-	struct key *key;
-	key_perm_t kperm;
-	int ret;
+	const struct key_acl *acl;
+	const struct key *key;
+	unsigned int allow = 0;
+	int i;
 
 	key = key_ref_to_ptr(key_ref);
 
-	/* use the second 8-bits of permissions for keys the caller owns */
-	if (uid_eq(key->uid, cred->fsuid)) {
-		kperm = key->perm >> 16;
-		goto use_these_perms;
-	}
-
-	/* use the third 8-bits of permissions for keys the caller has a group
-	 * membership in common with */
-	if (gid_valid(key->gid) && key->perm & KEY_GRP_ALL) {
-		if (gid_eq(key->gid, cred->fsgid)) {
-			kperm = key->perm >> 8;
-			goto use_these_perms;
-		}
-
-		ret = groups_search(cred->group_info, key->gid);
-		if (ret) {
-			kperm = key->perm >> 8;
-			goto use_these_perms;
+	rcu_read_lock();
+
+	acl = rcu_dereference(key->acl);
+	if (!acl || acl->nr_ace = 0)
+		goto no_access_rcu;
+
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SPECIAL:
+			switch (ace->special_id) {
+			case KEY_ACE_POSSESSOR:
+				if (is_key_possessed(key_ref))
+					allow |= ace->mask;
+				break;
+			case KEY_ACE_OWNER:
+				if (uid_eq(key->uid, cred->fsuid))
+					allow |= ace->mask;
+				break;
+			case KEY_ACE_GROUP:
+				if (gid_valid(key->gid) &&
+				    gid_eq(key->gid, cred->fsgid))
+					allow |= ace->mask;
+				else if (groups_search(cred->group_info, key->gid))
+					allow |= ace->mask;
+				break;
+			case KEY_ACE_EVERYONE:
+				allow |= ace->mask;
+				break;
+			case KEY_ACE_ROOT:
+				if (uid_eq(key->uid, cred->user_ns->owner))
+					allow |= ace->mask;
+				break;
+			case KEY_ACE_SYS_ADMIN:
+				if (ns_capable(&init_user_ns, CAP_SYS_ADMIN))
+					allow |= ace->mask;
+				break;
+			case KEY_ACE_NET_ADMIN:
+				if (ns_capable(&init_user_ns, CAP_NET_ADMIN))
+					allow |= ace->mask;
+				break;
+			}
+			break;
+		case KEY_ACE_UID:
+			if (uid_eq(ace->uid, cred->fsuid))
+				allow |= ace->mask;
+			break;
+		case KEY_ACE_GID:
+			if (gid_eq(ace->gid, cred->fsgid))
+				allow |= ace->mask;
+			else if (groups_search(cred->group_info, ace->gid))
+				allow |= ace->mask;
+			break;
 		}
 	}
 
-	/* otherwise use the least-significant 8-bits */
-	kperm = key->perm;
-
-use_these_perms:
+	rcu_read_unlock();
 
-	/* use the top 8-bits of permissions for keys the caller possesses
-	 * - possessor permissions are additive with other permissions
-	 */
-	if (is_key_possessed(key_ref))
-		kperm |= key->perm >> 24;
+	if (!(allow & desired_perm))
+		goto no_access;
 
-	kperm = kperm & perm & KEY_NEED_ALL;
+	return security_key_permission(key_ref, cred, desired_perm);
 
-	if (kperm != perm)
-		return -EACCES;
-
-	/* let LSM be the final arbiter */
-	return security_key_permission(key_ref, cred, perm);
+no_access_rcu:
+	rcu_read_unlock();
+no_access:
+	return -EACCES;
 }
 EXPORT_SYMBOL(key_task_permission);
 
@@ -108,3 +166,80 @@ int key_validate(const struct key *key)
 	return 0;
 }
 EXPORT_SYMBOL(key_validate);
+
+/*
+ * Roughly render an ACL to a permissions mask.
+ */
+unsigned int key_acl_to_perm(const struct key_acl *acl)
+{
+	unsigned int perm = 0;
+	int i;
+
+	if (!acl || acl->nr_ace = 0)
+		return 0;
+
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+		unsigned int mask = ace->mask & KEY_ACE__PERMS;
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SPECIAL:
+			switch (ace->special_id) {
+			case KEY_ACE_POSSESSOR:
+				perm |= (mask & 0x1f) << 24;
+				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
+					perm |= KEY_POS_SETATTR;
+				if (mask & KEY_ACE_CLEAR)
+					perm |= KEY_POS_WRITE;
+				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_POS_SETATTR))
+					perm |= KEY_POS_WRITE;
+				break;
+			case KEY_ACE_OWNER:
+				perm |= (mask & 0x1f) << 16;
+				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
+					perm |= KEY_USR_SETATTR;
+				if (mask & KEY_ACE_CLEAR)
+					perm |= KEY_USR_WRITE;
+				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_USR_SETATTR))
+					perm |= KEY_USR_WRITE;
+				break;
+			case KEY_ACE_GROUP:
+				perm |= (mask & 0x1f) << 8;
+				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
+					perm |= KEY_GRP_SETATTR;
+				if (mask & KEY_ACE_CLEAR)
+					perm |= KEY_GRP_WRITE;
+				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_GRP_SETATTR))
+					perm |= KEY_GRP_WRITE;
+				break;
+			case KEY_ACE_EVERYONE:
+				perm |= (mask & 0x1f);
+				if (mask & (KEY_ACE_INVAL | KEY_ACE_SET_SECURITY))
+					perm |= KEY_OTH_SETATTR;
+				if (mask & KEY_ACE_CLEAR)
+					perm |= KEY_OTH_WRITE;
+				if ((mask & KEY_ACE_REVOKE) && !(perm & KEY_OTH_SETATTR))
+					perm |= KEY_OTH_WRITE;
+				break;
+			}
+		}
+
+		//printk("[%d] %08x %08x %08x\n", i, ace->special_id, ace->mask, perm);
+	}
+
+	return perm;
+}
+
+static void key_acl_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct key_acl, rcu));
+}
+
+/*
+ * Destroy a key's ACL.
+ */
+void key_put_acl(struct key_acl *acl)
+{
+	if (refcount_dec_and_test(&acl->usage))
+		call_rcu(&acl->rcu, key_acl_rcu);
+}
diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index d0cb5b32eff7..0410a196a8f7 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -16,6 +16,33 @@
 
 unsigned persistent_keyring_expiry = 3 * 24 * 3600; /* Expire after 3 days of non-use */
 
+static struct key_acl persistent_register_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_SEARCH | KEY_ACE_WRITE,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+static struct key_acl persistent_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | (KEY_ACE__ORDINARY | KEY_ACE_CLEAR |
+					   KEY_ACE_INVAL),
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /*
  * Create the persistent keyring register for the current user namespace.
  *
@@ -26,8 +53,7 @@ static int key_create_persistent_register(struct user_namespace *ns)
 	struct key *reg = keyring_alloc(".persistent_register",
 					KUIDT_INIT(0), KGIDT_INIT(0),
 					current_cred(),
-					((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					 KEY_USR_VIEW | KEY_USR_READ),
+					&persistent_register_keyring_acl,
 					KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
@@ -60,8 +86,7 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 
 	persistent = keyring_alloc(index_key->description,
 				   uid, INVALID_GID, current_cred(),
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW | KEY_USR_READ),
+				   &persistent_keyring_acl,
 				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
 				   ns->persistent_keyring_register);
 	if (IS_ERR(persistent))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index de834309d100..4361455abe78 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -176,13 +176,15 @@ static void proc_keys_stop(struct seq_file *p, void *v)
 
 static int proc_keys_show(struct seq_file *m, void *v)
 {
+	const struct key_acl *acl;
 	struct rb_node *_p = v;
 	struct key *key = rb_entry(_p, struct key, serial_node);
 	struct timespec now;
 	unsigned long timo;
 	key_ref_t key_ref, skey_ref;
 	char xbuf[16];
-	int rc;
+	bool check_pos;
+	int i, rc;
 
 	struct keyring_search_context ctx = {
 		.index_key.type		= key->type,
@@ -194,12 +196,25 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		.flags			= KEYRING_SEARCH_NO_STATE_CHECK,
 	};
 
-	key_ref = make_key_ref(key, 0);
+	rcu_read_lock();
+
+	acl = rcu_dereference(key->acl);
+	check_pos = false;
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+		if (ace->special_id = KEY_ACE_POSSESSOR) {
+			if ((ace->mask & (KEY_ACE__IDENTITY | KEY_ACE_VIEW)) =
+			    (KEY_ACE_SPECIAL | KEY_ACE_VIEW))
+				check_pos = true;
+			break;
+		}
+	}
 
 	/* determine if the key is possessed by this process (a test we can
 	 * skip if the key does not indicate the possessor can view it
 	 */
-	if (key->perm & KEY_POS_VIEW) {
+	key_ref = make_key_ref(key, 0);
+	if (check_pos) {
 		skey_ref = search_my_process_keyrings(&ctx);
 		if (!IS_ERR(skey_ref)) {
 			key_ref_put(skey_ref);
@@ -214,8 +229,6 @@ static int proc_keys_show(struct seq_file *m, void *v)
 
 	now = current_kernel_time();
 
-	rcu_read_lock();
-
 	/* come up with a suitable timeout value */
 	if (key->expiry = 0) {
 		memcpy(xbuf, "perm", 5);
@@ -250,7 +263,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
-		   key->perm,
+		   key_acl_to_perm(acl),
 		   from_kuid_munged(seq_user_ns(m), key->uid),
 		   from_kgid_munged(seq_user_ns(m), key->gid),
 		   key->type->name);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 293d3598153b..29c08dca78e6 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -38,6 +38,45 @@ struct key_user root_key_user = {
 	.uid		= GLOBAL_ROOT_UID,
 };
 
+static struct key_acl user_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__ORDINARY,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+static struct key_acl tp_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
+static struct key_acl session_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE__PERMS,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_JOIN,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /*
  * Install the user and user session keyrings for the current process's UID.
  */
@@ -46,12 +85,10 @@ int install_user_keyrings(void)
 	struct user_struct *user;
 	const struct cred *cred;
 	struct key *uid_keyring, *session_keyring;
-	key_perm_t user_keyring_perm;
 	char buf[20];
 	int ret;
 	uid_t uid;
 
-	user_keyring_perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL;
 	cred = current_cred();
 	user = cred->user;
 	uid = from_kuid(cred->user_ns, user->uid);
@@ -76,9 +113,9 @@ int install_user_keyrings(void)
 		uid_keyring = find_keyring_by_name(buf, true);
 		if (IS_ERR(uid_keyring)) {
 			uid_keyring = keyring_alloc(buf, user->uid, INVALID_GID,
-						    cred, user_keyring_perm,
+						    cred, &user_keyring_acl,
 						    KEY_ALLOC_UID_KEYRING |
-							KEY_ALLOC_IN_QUOTA,
+						    KEY_ALLOC_IN_QUOTA,
 						    NULL, NULL);
 			if (IS_ERR(uid_keyring)) {
 				ret = PTR_ERR(uid_keyring);
@@ -94,9 +131,9 @@ int install_user_keyrings(void)
 		if (IS_ERR(session_keyring)) {
 			session_keyring  				keyring_alloc(buf, user->uid, INVALID_GID,
-					      cred, user_keyring_perm,
+					      cred, &user_keyring_acl,
 					      KEY_ALLOC_UID_KEYRING |
-						  KEY_ALLOC_IN_QUOTA,
+					      KEY_ALLOC_IN_QUOTA,
 					      NULL, NULL);
 			if (IS_ERR(session_keyring)) {
 				ret = PTR_ERR(session_keyring);
@@ -143,8 +180,7 @@ int install_thread_keyring_to_cred(struct cred *new)
 		return 0;
 
 	keyring = keyring_alloc("_tid", new->uid, new->gid, new,
-				KEY_POS_ALL | KEY_USR_VIEW,
-				KEY_ALLOC_QUOTA_OVERRUN,
+				&tp_keyring_acl, KEY_ALLOC_QUOTA_OVERRUN,
 				NULL, NULL);
 	if (IS_ERR(keyring))
 		return PTR_ERR(keyring);
@@ -190,8 +226,7 @@ int install_process_keyring_to_cred(struct cred *new)
 		return 0;
 
 	keyring = keyring_alloc("_pid", new->uid, new->gid, new,
-				KEY_POS_ALL | KEY_USR_VIEW,
-				KEY_ALLOC_QUOTA_OVERRUN,
+				&tp_keyring_acl, KEY_ALLOC_QUOTA_OVERRUN,
 				NULL, NULL);
 	if (IS_ERR(keyring))
 		return PTR_ERR(keyring);
@@ -244,8 +279,7 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 			flags = KEY_ALLOC_IN_QUOTA;
 
 		keyring = keyring_alloc("_ses", cred->uid, cred->gid, cred,
-					KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
-					flags, NULL, NULL);
+					&session_keyring_acl, flags, NULL, NULL);
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	} else {
@@ -531,7 +565,7 @@ bool lookup_user_key_possessed(const struct key *key,
  * returned key reference.
  */
 key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
-			  key_perm_t perm)
+			  unsigned int desired_perm)
 {
 	struct keyring_search_context ctx = {
 		.match_data.cmp		= lookup_user_key_possessed,
@@ -717,12 +751,12 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		case -ERESTARTSYS:
 			goto invalid_key;
 		default:
-			if (perm)
+			if (desired_perm)
 				goto invalid_key;
 		case 0:
 			break;
 		}
-	} else if (perm) {
+	} else if (desired_perm) {
 		ret = key_validate(key);
 		if (ret < 0)
 			goto invalid_key;
@@ -734,9 +768,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		goto invalid_key;
 
 	/* check the permissions */
-	ret = key_task_permission(key_ref, ctx.cred, perm);
-	if (ret < 0)
-		goto invalid_key;
+	if (desired_perm) {
+		ret = key_task_permission(key_ref, ctx.cred, desired_perm);
+		if (ret < 0)
+			goto invalid_key;
+	}
 
 	key->last_used_at = current_kernel_time().tv_sec;
 
@@ -800,8 +836,7 @@ long join_session_keyring(const char *name)
 	if (PTR_ERR(keyring) = -ENOKEY) {
 		/* not found - try and create a new one */
 		keyring = keyring_alloc(
-			name, old->uid, old->gid, old,
-			KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ | KEY_USR_LINK,
+			name, old->uid, old->gid, old, &joinable_keyring_acl,
 			KEY_ALLOC_IN_QUOTA, NULL, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
@@ -815,6 +850,11 @@ long join_session_keyring(const char *name)
 		goto error3;
 	}
 
+	ret = key_task_permission(make_key_ref(keyring, false), old,
+				  KEY_NEED_JOIN);
+	if (ret < 0)
+		goto error3;
+
 	/* we've got a keyring - now to install it */
 	ret = install_session_keyring_to_cred(new, keyring);
 	if (ret < 0)
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 63e63a42db3c..2f7906c231a6 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -116,8 +116,7 @@ static int call_sbin_request_key(struct key_construction *cons,
 
 	cred = get_current_cred();
 	keyring = keyring_alloc(desc, cred->fsuid, cred->fsgid, cred,
-				KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
-				KEY_ALLOC_QUOTA_OVERRUN, NULL, NULL);
+				NULL, KEY_ALLOC_QUOTA_OVERRUN, NULL, NULL);
 	put_cred(cred);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -332,11 +331,11 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key *dest_keyring,
 			       unsigned long flags,
 			       struct key_user *user,
+			       struct key_acl *acl,
 			       struct key **_key)
 {
 	struct assoc_array_edit *edit;
 	struct key *key;
-	key_perm_t perm;
 	key_ref_t key_ref;
 	int ret;
 
@@ -346,17 +345,9 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	*_key = NULL;
 	mutex_lock(&user->cons_lock);
 
-	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
-	perm |= KEY_USR_VIEW;
-	if (ctx->index_key.type->read)
-		perm |= KEY_POS_READ;
-	if (ctx->index_key.type = &key_type_keyring ||
-	    ctx->index_key.type->update)
-		perm |= KEY_POS_WRITE;
-
 	key = key_alloc(ctx->index_key.type, ctx->index_key.description,
 			ctx->cred->fsuid, ctx->cred->fsgid, ctx->cred,
-			perm, flags, NULL);
+			NULL, flags, NULL);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
@@ -432,6 +423,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 					  const char *callout_info,
 					  size_t callout_len,
 					  void *aux,
+					  struct key_acl *acl,
 					  struct key *dest_keyring,
 					  unsigned long flags)
 {
@@ -450,7 +442,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 
 	construct_get_dest_keyring(&dest_keyring);
 
-	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key);
+	ret = construct_alloc_key(ctx, dest_keyring, flags, user, acl, &key);
 	key_user_put(user);
 
 	if (ret = 0) {
@@ -486,6 +478,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
  * @aux: Auxiliary data for the upcall.
+ * @acl: The ACL to attach if a new key is created.
  * @dest_keyring: Where to cache the key.
  * @flags: Flags to key_alloc().
  *
@@ -511,6 +504,7 @@ struct key *request_key_and_link(struct key_type *type,
 				 const void *callout_info,
 				 size_t callout_len,
 				 void *aux,
+				 struct key_acl *acl,
 				 struct key *dest_keyring,
 				 unsigned long flags)
 {
@@ -565,7 +559,7 @@ struct key *request_key_and_link(struct key_type *type,
 			goto error_free;
 
 		key = construct_key_and_link(&ctx, callout_info, callout_len,
-					     aux, dest_keyring, flags);
+					     aux, acl, dest_keyring, flags);
 	}
 
 error_free:
@@ -608,6 +602,7 @@ EXPORT_SYMBOL(wait_for_key_construction);
  * @type: Type of key.
  * @description: The searchable description of the key.
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found, new keys are always allocated in the user's quota,
@@ -619,7 +614,8 @@ EXPORT_SYMBOL(wait_for_key_construction);
  */
 struct key *request_key(struct key_type *type,
 			const char *description,
-			const char *callout_info)
+			const char *callout_info,
+			struct key_acl *acl)
 {
 	struct key *key;
 	size_t callout_len = 0;
@@ -628,7 +624,7 @@ struct key *request_key(struct key_type *type,
 	if (callout_info)
 		callout_len = strlen(callout_info);
 	key = request_key_and_link(type, description, callout_info, callout_len,
-				   NULL, NULL, KEY_ALLOC_IN_QUOTA);
+				   NULL, acl, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key)) {
 		ret = wait_for_key_construction(key, false);
 		if (ret < 0) {
@@ -647,6 +643,7 @@ EXPORT_SYMBOL(request_key);
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
  * @aux: Auxiliary data for the upcall.
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found and new keys are always allocated in the user's quota.
@@ -658,13 +655,14 @@ struct key *request_key_with_auxdata(struct key_type *type,
 				     const char *description,
 				     const void *callout_info,
 				     size_t callout_len,
-				     void *aux)
+				     void *aux,
+				     struct key_acl *acl)
 {
 	struct key *key;
 	int ret;
 
 	key = request_key_and_link(type, description, callout_info, callout_len,
-				   aux, NULL, KEY_ALLOC_IN_QUOTA);
+				   aux, acl, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key)) {
 		ret = wait_for_key_construction(key, false);
 		if (ret < 0) {
@@ -682,6 +680,7 @@ EXPORT_SYMBOL(request_key_with_auxdata);
  * @description: The searchable description of the key.
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found, new keys are always allocated in the user's quota and
@@ -693,10 +692,11 @@ EXPORT_SYMBOL(request_key_with_auxdata);
 struct key *request_key_async(struct key_type *type,
 			      const char *description,
 			      const void *callout_info,
-			      size_t callout_len)
+			      size_t callout_len,
+			      struct key_acl *acl)
 {
 	return request_key_and_link(type, description, callout_info,
-				    callout_len, NULL, NULL,
+				    callout_len, NULL, acl, NULL,
 				    KEY_ALLOC_IN_QUOTA);
 }
 EXPORT_SYMBOL(request_key_async);
@@ -708,6 +708,7 @@ EXPORT_SYMBOL(request_key_async);
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
  * @aux: Auxiliary data for the upcall.
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found and new keys are always allocated in the user's quota.
@@ -719,9 +720,11 @@ struct key *request_key_async_with_auxdata(struct key_type *type,
 					   const char *description,
 					   const void *callout_info,
 					   size_t callout_len,
-					   void *aux)
+					   void *aux,
+					   struct key_acl *acl)
 {
 	return request_key_and_link(type, description, callout_info,
-				    callout_len, aux, NULL, KEY_ALLOC_IN_QUOTA);
+				    callout_len, aux, acl,
+				    NULL, KEY_ALLOC_IN_QUOTA);
 }
 EXPORT_SYMBOL(request_key_async_with_auxdata);
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 6ebf1af8fce9..d810a54070f7 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -29,6 +29,19 @@ static void request_key_auth_revoke(struct key *);
 static void request_key_auth_destroy(struct key *);
 static long request_key_auth_read(const struct key *, char __user *, size_t);
 
+static struct key_acl request_key_auth_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces[0] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH,
+		.special_id = KEY_ACE_POSSESSOR,
+	},
+	.aces[1] = {
+		.mask = KEY_ACE_SPECIAL | KEY_ACE_VIEW,
+		.special_id = KEY_ACE_OWNER,
+	},
+};
+
 /*
  * The request-key authorisation key type definition.
  */
@@ -203,8 +216,8 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    cred->fsuid, cred->fsgid, cred,
-			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
-			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
+			    &request_key_auth_acl,
+			    KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
 		goto error_free_rka;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d304736852..7c06837802be 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6157,6 +6157,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
+	unsigned oldstyle_perm;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
@@ -6165,12 +6166,25 @@ static int selinux_key_permission(key_ref_t key_ref,
 	if (perm = 0)
 		return 0;
 
+	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
+				KEY_NEED_SEARCH | KEY_NEED_LINK);
+	if (perm & KEY_NEED_INVAL)
+		oldstyle_perm |= KEY_NEED_SEARCH;
+	if (perm & KEY_NEED_REVOKE)
+		oldstyle_perm |= KEY_NEED_WRITE;
+	if (perm & KEY_NEED_SETSEC)
+		oldstyle_perm |= 0x20;
+	if (perm & KEY_NEED_JOIN)
+		oldstyle_perm |= KEY_NEED_LINK;
+	if (perm & KEY_NEED_CLEAR)
+		oldstyle_perm |= KEY_NEED_WRITE;
+	
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
-	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, oldstyle_perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 319add31b4a4..2cd323206310 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4377,7 +4377,8 @@ static int smack_key_permission(key_ref_t key_ref,
 #endif
 	if (perm & KEY_NEED_READ)
 		request = MAY_READ;
-	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
+	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETSEC |
+		    KEY_NEED_INVAL | KEY_NEED_REVOKE | KEY_NEED_CLEAR))
 		request = MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
