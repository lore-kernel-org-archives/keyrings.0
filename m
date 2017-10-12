From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:17:18 +0000
Subject: [PATCH 11/15] KEYS: Fix race between updating and finding a negative key
Message-Id: <150783943845.10956.15764836246288785418.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Consolidate KEY_FLAG_INSTANTIATED, KEY_FLAG_NEGATIVE and the rejection
error into one field such that:

 (1) The instantiation state can be modified/read atomically.

 (2) The error can be accessed atomically with the state.

 (3) The error isn't stored unioned with the payload pointers.

Possibly the revocation flags can also be combined with this also.

Fixes: 146aa8b1453b ("KEYS: Merge the type-specific data with the payload data")
Cc: <stable@vger.kernel.org>	[v4.4+]
Reported-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h                      |   37 ++++++++++++++++++------------
 security/keys/encrypted-keys/encrypted.c |    2 +-
 security/keys/gc.c                       |    7 +++---
 security/keys/key.c                      |   28 ++++++++++++++---------
 security/keys/keyctl.c                   |    9 +++----
 security/keys/keyring.c                  |    8 +++---
 security/keys/proc.c                     |   11 ++++++---
 security/keys/process_keys.c             |    8 ++++--
 security/keys/request_key.c              |    7 ++----
 security/keys/trusted.c                  |    2 +-
 security/keys/user_defined.c             |    2 +-
 11 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e315e16b6ff8..f50e88c52bd0 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -138,6 +138,11 @@ struct key_restriction {
 	struct key_type *keytype;
 };
 
+enum key_state {
+	KEY_IS_UNINSTANTIATED,
+	KEY_IS_INSTANTIATED,
+};
+
 /*****************************************************************************/
 /*
  * authentication token / access credential / keyring
@@ -169,6 +174,7 @@ struct key {
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
 						 */
+	short			state;		/* Key state (+) or rejection error (-) */
 
 #ifdef KEY_DEBUGGING
 	unsigned		magic;
@@ -176,18 +182,16 @@ struct key {
 #endif
 
 	unsigned long		flags;		/* status flags (change with bitops) */
-#define KEY_FLAG_INSTANTIATED	0	/* set if key has been instantiated */
-#define KEY_FLAG_DEAD		1	/* set if key type has been deleted */
-#define KEY_FLAG_REVOKED	2	/* set if key had been revoked */
-#define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
-#define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
-#define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
-#define KEY_FLAG_ROOT_CAN_CLEAR	6	/* set if key can be cleared by root without permission */
-#define KEY_FLAG_INVALIDATED	7	/* set if key has been invalidated */
-#define KEY_FLAG_BUILTIN	8	/* set if key is built in to the kernel */
-#define KEY_FLAG_ROOT_CAN_INVAL	9	/* set if key can be invalidated by root without permission */
-#define KEY_FLAG_KEEP		10	/* set if key should not be removed */
-#define KEY_FLAG_UID_KEYRING	11	/* set if key is a user or user session keyring */
+#define KEY_FLAG_DEAD		0	/* set if key type has been deleted */
+#define KEY_FLAG_REVOKED	1	/* set if key had been revoked */
+#define KEY_FLAG_IN_QUOTA	2	/* set if key consumes quota */
+#define KEY_FLAG_USER_CONSTRUCT	3	/* set if key is being constructed in userspace */
+#define KEY_FLAG_ROOT_CAN_CLEAR	4	/* set if key can be cleared by root without permission */
+#define KEY_FLAG_INVALIDATED	5	/* set if key has been invalidated */
+#define KEY_FLAG_BUILTIN	6	/* set if key is built in to the kernel */
+#define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
+#define KEY_FLAG_KEEP		8	/* set if key should not be removed */
+#define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
@@ -213,7 +217,6 @@ struct key {
 			struct list_head name_link;
 			struct assoc_array keys;
 		};
-		int reject_error;
 	};
 
 	/* This is set on a keyring to restrict the addition of a link to a key
@@ -362,8 +365,12 @@ extern void key_set_timeout(struct key *, unsigned);
  */
 static inline bool key_is_instantiated(const struct key *key)
 {
-	return test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
-		!test_bit(KEY_FLAG_NEGATIVE, &key->flags);
+	return key->state = KEY_IS_INSTANTIATED;
+}
+
+static inline bool key_is_negative(const struct key *key)
+{
+	return key->state < 0;
 }
 
 #define dereference_key_rcu(KEY)					\
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 535db141f4da..d92cbf9687c3 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -854,7 +854,7 @@ static int encrypted_update(struct key *key, struct key_preparsed_payload *prep)
 	size_t datalen = prep->datalen;
 	int ret = 0;
 
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags))
+	if (key_is_negative(key))
 		return -ENOKEY;
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 87cb260e4890..1578f671a213 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -129,14 +129,15 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 	while (!list_empty(keys)) {
 		struct key *key  			list_entry(keys->next, struct key, graveyard_link);
+		short state = READ_ONCE(key->state);
+
 		list_del(&key->graveyard_link);
 
 		kdebug("- %u", key->serial);
 		key_check(key);
 
 		/* Throw away the key data if the key is instantiated */
-		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
-		    !test_bit(KEY_FLAG_NEGATIVE, &key->flags) &&
+		if (state = KEY_IS_INSTANTIATED &&
 		    key->type->destroy)
 			key->type->destroy(key);
 
@@ -151,7 +152,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 		}
 
 		atomic_dec(&key->user->nkeys);
-		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
+		if (state = KEY_IS_INSTANTIATED)
 			atomic_dec(&key->user->nikeys);
 
 		key_user_put(key->user);
diff --git a/security/keys/key.c b/security/keys/key.c
index eb914a838840..de1b789ad29f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -402,6 +402,15 @@ int key_payload_reserve(struct key *key, size_t datalen)
 EXPORT_SYMBOL(key_payload_reserve);
 
 /*
+ * Change the key state to being instantiated.
+ */
+static void mark_key_instantiated(struct key *key, int reject_error)
+{
+	smp_wmb(); /* Commit the payload before setting the state */
+	key->state = (reject_error < 0) ? reject_error : KEY_IS_INSTANTIATED;
+}
+
+/*
  * Instantiate a key and link it into the target keyring atomically.  Must be
  * called with the target keyring's semaphore writelocked.  The target key's
  * semaphore need not be locked as instantiation is serialised by
@@ -424,14 +433,14 @@ static int __key_instantiate_and_link(struct key *key,
 	mutex_lock(&key_construction_mutex);
 
 	/* can't instantiate twice */
-	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+	if (key->state = KEY_IS_UNINSTANTIATED) {
 		/* instantiate the key */
 		ret = key->type->instantiate(key, prep);
 
 		if (ret = 0) {
 			/* mark the key as being instantiated */
 			atomic_inc(&key->user->nikeys);
-			set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
+			mark_key_instantiated(key, 0);
 
 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 				awaken = 1;
@@ -577,13 +586,10 @@ int key_reject_and_link(struct key *key,
 	mutex_lock(&key_construction_mutex);
 
 	/* can't instantiate twice */
-	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+	if (key->state = KEY_IS_UNINSTANTIATED) {
 		/* mark the key as being negatively instantiated */
 		atomic_inc(&key->user->nikeys);
-		key->reject_error = -error;
-		smp_wmb();
-		set_bit(KEY_FLAG_NEGATIVE, &key->flags);
-		set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
+		mark_key_instantiated(key, -error);
 		now = current_kernel_time();
 		key->expiry = now.tv_sec + timeout;
 		key_schedule_gc(key->expiry + key_gc_delay);
@@ -752,8 +758,8 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 
 	ret = key->type->update(key, prep);
 	if (ret = 0)
-		/* updating a negative key instantiates it */
-		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		/* Updating a negative key positively instantiates it */
+		mark_key_instantiated(key, 0);
 
 	up_write(&key->sem);
 
@@ -986,8 +992,8 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 
 	ret = key->type->update(key, &prep);
 	if (ret = 0)
-		/* updating a negative key instantiates it */
-		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		/* Updating a negative key positively instantiates it */
+		mark_key_instantiated(key, 0);
 
 	up_write(&key->sem);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 365ff85d7e27..5c30c54e01ed 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -766,10 +766,9 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	key = key_ref_to_ptr(key_ref);
 
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
-		ret = -ENOKEY;
-		goto error2;
-	}
+	ret = key->state;
+	if (ret < 0)
+		goto error2; /* Negatively instantiated */
 
 	/* see if we can read it directly */
 	ret = key_permission(key_ref, KEY_NEED_READ);
@@ -901,7 +900,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		atomic_dec(&key->user->nkeys);
 		atomic_inc(&newowner->nkeys);
 
-		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+		if (key->state = KEY_IS_INSTANTIATED) {
 			atomic_dec(&key->user->nikeys);
 			atomic_inc(&newowner->nikeys);
 		}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4fa82a8a9c0e..816948abff89 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -553,7 +553,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 {
 	struct keyring_search_context *ctx = iterator_data;
 	const struct key *key = keyring_ptr_to_key(object);
-	unsigned long kflags = key->flags;
+	unsigned long kflags = READ_ONCE(key->flags);
+	short state = READ_ONCE(key->state);
 
 	kenter("{%d}", key->serial);
 
@@ -597,9 +598,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
 		/* we set a different error code if we pass a negative key */
-		if (kflags & (1 << KEY_FLAG_NEGATIVE)) {
-			smp_rmb();
-			ctx->result = ERR_PTR(key->reject_error);
+		if (state < 0) {
+			ctx->result = ERR_PTR(state);
 			kleave(" = %d [neg]", ctx->skipped_ret);
 			goto skipped;
 		}
diff --git a/security/keys/proc.c b/security/keys/proc.c
index de834309d100..46fa0f1bfcc3 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -182,6 +182,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	unsigned long timo;
 	key_ref_t key_ref, skey_ref;
 	char xbuf[16];
+	short state;
 	int rc;
 
 	struct keyring_search_context ctx = {
@@ -236,17 +237,19 @@ static int proc_keys_show(struct seq_file *m, void *v)
 			sprintf(xbuf, "%luw", timo / (60*60*24*7));
 	}
 
+	state = READ_ONCE(key->state);
+
 #define showflag(KEY, LETTER, FLAG) \
 	(test_bit(FLAG,	&(KEY)->flags) ? LETTER : '-')
 
 	seq_printf(m, "%08x %c%c%c%c%c%c%c %5d %4s %08x %5d %5d %-9.9s ",
 		   key->serial,
-		   showflag(key, 'I', KEY_FLAG_INSTANTIATED),
+		   state = KEY_IS_INSTANTIATED ? 'I' : '-',
 		   showflag(key, 'R', KEY_FLAG_REVOKED),
 		   showflag(key, 'D', KEY_FLAG_DEAD),
 		   showflag(key, 'Q', KEY_FLAG_IN_QUOTA),
 		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
-		   showflag(key, 'N', KEY_FLAG_NEGATIVE),
+		   state < 0 ? 'N' : '-',
 		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
@@ -257,8 +260,10 @@ static int proc_keys_show(struct seq_file *m, void *v)
 
 #undef showflag
 
-	if (key->type->describe)
+	if (key->type->describe) {
+		smp_rmb(); /* Order access to payload after state set. */
 		key->type->describe(key, m);
+	}
 	seq_putc(m, '\n');
 
 	rcu_read_unlock();
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 293d3598153b..492217ff4924 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -729,9 +729,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 	}
 
 	ret = -EIO;
-	if (!(lflags & KEY_LOOKUP_PARTIAL) &&
-	    !test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
-		goto invalid_key;
+	if (!(lflags & KEY_LOOKUP_PARTIAL)) {
+		if (key->state != KEY_IS_INSTANTIATED)
+			goto invalid_key;
+		smp_rmb(); /* Order access to payload after state set. */
+	}
 
 	/* check the permissions */
 	ret = key_task_permission(key_ref, ctx.cred, perm);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 63e63a42db3c..a25f8378f704 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -595,10 +595,9 @@ int wait_for_key_construction(struct key *key, bool intr)
 			  intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 	if (ret)
 		return -ERESTARTSYS;
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
-		smp_rmb();
-		return key->reject_error;
-	}
+	ret = READ_ONCE(key->state);
+	if (ret < 0)
+		return ret;
 	return key_validate(key);
 }
 EXPORT_SYMBOL(wait_for_key_construction);
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ddfaebf60fc8..bd85315cbfeb 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1066,7 +1066,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	char *datablob;
 	int ret = 0;
 
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags))
+	if (key_is_negative(key))
 		return -ENOKEY;
 	p = key->payload.data[0];
 	if (!p->migratable)
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 3d8c68eba516..9afa64817d4f 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -114,7 +114,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 
 	/* attach the new data, displacing the old */
 	key->expiry = prep->expiry;
-	if (!test_bit(KEY_FLAG_NEGATIVE, &key->flags))
+	if (key->state < 0)
 		zap = dereference_key_locked(key);
 	rcu_assign_keypointer(key, prep->payload.data[0]);
 	prep->payload.data[0] = NULL;

