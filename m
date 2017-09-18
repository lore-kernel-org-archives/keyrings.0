From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 18 Sep 2017 20:48:08 +0000
Subject: [PATCH] KEYS: fix race between updating and finding negative key
Message-Id: <20170918204808.119855-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In keyring_search_iterator() and in wait_for_key_construction(), we
check whether the key has been negatively instantiated, and if so
retrieve the ->reject_error, which is in union with ->payload.

The problem is that no lock can be held during this, and it's impossible
to update KEY_FLAG_NEGATIVE atomically with respect to ->reject_error
and ->payload.  Updating ->reject_error or ->payload first as
key_update(), __key_update(), and key_reject_and_link() do is
insufficient because ->reject_error can be observed to have a bogus
value, having been overwritten with ->payload, before KEY_FLAG_NEGATIVE
is cleared.

Conversely, if we were to change KEY_FLAG_NEGATIVE first, then someone
could use ->reject_error or ->payload before it has been set.

Fix the bug by moving ->reject_error out of the union with ->payload,
then using nonzero ->reject_error to mean that the key is negative.

This eliminates the need for KEY_FLAG_NEGATIVE, which we remove as well
so that we don't have to handle memory ordering between
KEY_FLAG_NEGATIVE and ->reject_error.  We *do* still need to handle
memory ordering between KEY_FLAG_INSTANTIATED and ->reject_error, but
that was needed before (and for KEY_FLAG_NEGATIVE as well --- though it
wasn't done correctly, which was another bug).

The following program reproduces the primary bug, which dates back to
v4.4 when ->reject_error and ->payload were placed in union:

    #include <stdlib.h>
    #include <unistd.h>
    #include <keyutils.h>

    int main(void)
    {
        int ringid = keyctl_join_session_keyring(NULL);

        if (fork()) {
            for (;;) {
                usleep(rand() % 4096);
                add_key("user", "desc", "x", 1, ringid);
                keyctl_clear(ringid);
            }
        } else {
            for (;;)
                request_key("user", "desc", "", ringid);
        }
    }

It causes the following crash:

    BUG: unable to handle kernel paging request at fffffffffd39a6b0
    IP: __key_link_begin+0x0/0x100
    PGD 7a0a067 P4D 7a0a067 PUD 7a0c067 PMD 0
    Oops: 0000 [#1] SMP
    CPU: 1 PID: 165 Comm: keyctl_negate_r Not tainted 4.14.0-rc1 #377
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-20170228_101828-anatol 04/01/2014
    task: ffff9791fd809140 task.stack: ffffacba402bc000
    RIP: 0010:__key_link_begin+0x0/0x100
    RSP: 0018:ffffacba402bfdc8 EFLAGS: 00010282
    RAX: ffff9791fd809140 RBX: fffffffffd39a620 RCX: 0000000000000008
    RDX: ffffacba402bfdd0 RSI: fffffffffd39a6a0 RDI: ffff9791fd810600
    RBP: ffffacba402bfdf8 R08: 0000000000000063 R09: ffffffff94845620
    R10: 8080808080808080 R11: 0000000000000004 R12: ffff9791fd810600
    R13: ffff9791fd39a940 R14: fffffffffd39a6a0 R15: 0000000000000000
    FS:  00007fbf14a90740(0000) GS:ffff9791ffd00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: fffffffffd39a6b0 CR3: 000000003b910003 CR4: 00000000003606e0
    Call Trace:
     ? key_link+0x28/0xb0
     ? search_process_keyrings+0x13/0x100
     request_key_and_link+0xcb/0x550
     ? keyring_instantiate+0x110/0x110
     ? key_default_cmp+0x20/0x20
     SyS_request_key+0xc0/0x160
     ? exit_to_usermode_loop+0x5e/0x80
     entry_SYSCALL_64_fastpath+0x1a/0xa5
    RIP: 0033:0x7fbf14190bb9
    RSP: 002b:00007ffd8e4fe6c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f9
    RAX: ffffffffffffffda RBX: 0000000036cc28fb RCX: 00007fbf14190bb9
    RDX: 000055748b56ca4a RSI: 000055748b56ca46 RDI: 000055748b56ca4b
    RBP: 000055748b56ca4a R08: 0000000000000001 R09: 0000000000000001
    R10: 0000000036cc28fb R11: 0000000000000246 R12: 000055748b56c8b0
    R13: 00007ffd8e4fe7d0 R14: 0000000000000000 R15: 0000000000000000
    Code: c5 0f 85 69 ff ff ff 48 c7 c3 82 ff ff ff eb ab 45 31 ed e9 18 ff ff ff 85 c0 75 8d eb d2 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 83 7e 10 00 0f 84 c5 00 00 00 55 48 89 e5 41 57 41 56 41 55
    RIP: __key_link_begin+0x0/0x100 RSP: ffffacba402bfdc8
    CR2: fffffffffd39a6b0

Fixes: 146aa8b1453b ("KEYS: Merge the type-specific data with the payload data")
Cc: <stable@vger.kernel.org>	[v4.4+]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/key.h                      | 34 ++++++++++++++++++++++++++++----
 security/keys/encrypted-keys/encrypted.c |  2 +-
 security/keys/gc.c                       |  4 +---
 security/keys/key.c                      | 16 ++++++++++-----
 security/keys/keyctl.c                   |  2 +-
 security/keys/keyring.c                  |  5 ++---
 security/keys/proc.c                     |  2 +-
 security/keys/request_key.c              |  8 ++++----
 security/keys/trusted.c                  |  2 +-
 security/keys/user_defined.c             |  2 +-
 10 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e315e16b6ff8..e4b05ade798a 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -181,7 +181,6 @@ struct key {
 #define KEY_FLAG_REVOKED	2	/* set if key had been revoked */
 #define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
 #define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
-#define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
 #define KEY_FLAG_ROOT_CAN_CLEAR	6	/* set if key can be cleared by root without permission */
 #define KEY_FLAG_INVALIDATED	7	/* set if key has been invalidated */
 #define KEY_FLAG_BUILTIN	8	/* set if key is built in to the kernel */
@@ -213,9 +212,22 @@ struct key {
 			struct list_head name_link;
 			struct assoc_array keys;
 		};
-		int reject_error;
 	};
 
+	/*
+	 * This is set to a negative error value if the key is negatively
+	 * instantiated.
+	 *
+	 * This could in theory be in union with ->payload, with a separate flag
+	 * indicating that the key is negative.  But that doesn't work because
+	 * sometimes we need to check this without holding a lock.
+	 *
+	 * Note that keys can go from negative to positive but not vice versa.
+	 * That is, if KEY_FLAG_INSTANTIATED is set and this field is 0, then
+	 * the key is positive, and it cannot turn negative out from under you.
+	 */
+	int reject_error;
+
 	/* This is set on a keyring to restrict the addition of a link to a key
 	 * to it.  If this structure isn't provided then it is assumed that the
 	 * keyring is open to any addition.  It is ignored for non-keyring
@@ -353,6 +365,18 @@ extern void key_set_timeout(struct key *, unsigned);
 #define	KEY_NEED_SETATTR 0x20	/* Require permission to change attributes */
 #define	KEY_NEED_ALL	0x3f	/* All the above permissions */
 
+/**
+ * key_is_negative - Determine if a key has been negatively instantiated
+ * @key: The key to check.
+ *
+ * Return true if the specified key has been negatively instantiated, false
+ * otherwise.
+ */
+static inline bool key_is_negative(const struct key *key)
+{
+	return READ_ONCE(key->reject_error) != 0;
+}
+
 /**
  * key_is_instantiated - Determine if a key has been positively instantiated
  * @key: The key to check.
@@ -362,8 +386,10 @@ extern void key_set_timeout(struct key *, unsigned);
  */
 static inline bool key_is_instantiated(const struct key *key)
 {
-	return test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
-		!test_bit(KEY_FLAG_NEGATIVE, &key->flags);
+	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
+		return false;
+	smp_rmb(); /* pairs with smp_wmb() in key_reject_and_link() */
+	return !key_is_negative(key);
 }
 
 #define dereference_key_rcu(KEY)					\
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 69855ba0d3b3..f54b92868bc3 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -847,7 +847,7 @@ static int encrypted_update(struct key *key, struct key_preparsed_payload *prep)
 	size_t datalen = prep->datalen;
 	int ret = 0;
 
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags))
+	if (key_is_negative(key))
 		return -ENOKEY;
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 87cb260e4890..0adc52be3ea9 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -135,9 +135,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 		key_check(key);
 
 		/* Throw away the key data if the key is instantiated */
-		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
-		    !test_bit(KEY_FLAG_NEGATIVE, &key->flags) &&
-		    key->type->destroy)
+		if (key_is_instantiated(key) && key->type->destroy)
 			key->type->destroy(key);
 
 		security_key_free(key);
diff --git a/security/keys/key.c b/security/keys/key.c
index eb914a838840..bed5b6c2ef20 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -578,11 +578,17 @@ int key_reject_and_link(struct key *key,
 
 	/* can't instantiate twice */
 	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
-		/* mark the key as being negatively instantiated */
 		atomic_inc(&key->user->nikeys);
-		key->reject_error = -error;
+
+		/* mark the key as being negatively instantiated */
+		WRITE_ONCE(key->reject_error, -error);
+
+		/*
+		 * pairs with smp_rmb() in key_is_instantiated() and
+		 * wait_for_key_construction()
+		 */
 		smp_wmb();
-		set_bit(KEY_FLAG_NEGATIVE, &key->flags);
+
 		set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
 		now = current_kernel_time();
 		key->expiry = now.tv_sec + timeout;
@@ -753,7 +759,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	ret = key->type->update(key, prep);
 	if (ret = 0)
 		/* updating a negative key instantiates it */
-		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		WRITE_ONCE(key->reject_error, 0);
 
 	up_write(&key->sem);
 
@@ -987,7 +993,7 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	ret = key->type->update(key, &prep);
 	if (ret = 0)
 		/* updating a negative key instantiates it */
-		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		WRITE_ONCE(key->reject_error, 0);
 
 	up_write(&key->sem);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 365ff85d7e27..c9d94f61d183 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -766,7 +766,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	key = key_ref_to_ptr(key_ref);
 
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
+	if (key_is_negative(key)) {
 		ret = -ENOKEY;
 		goto error2;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4fa82a8a9c0e..5a13858d74fb 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -597,9 +597,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
 		/* we set a different error code if we pass a negative key */
-		if (kflags & (1 << KEY_FLAG_NEGATIVE)) {
-			smp_rmb();
-			ctx->result = ERR_PTR(key->reject_error);
+		ctx->result = ERR_PTR(READ_ONCE(key->reject_error));
+		if (ctx->result) {
 			kleave(" = %d [neg]", ctx->skipped_ret);
 			goto skipped;
 		}
diff --git a/security/keys/proc.c b/security/keys/proc.c
index de834309d100..e5e41f3c547d 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -246,7 +246,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		   showflag(key, 'D', KEY_FLAG_DEAD),
 		   showflag(key, 'Q', KEY_FLAG_IN_QUOTA),
 		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
-		   showflag(key, 'N', KEY_FLAG_NEGATIVE),
+		   key_is_negative(key) ? 'N' : '-',
 		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 63e63a42db3c..5cddca6bef37 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -595,10 +595,10 @@ int wait_for_key_construction(struct key *key, bool intr)
 			  intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 	if (ret)
 		return -ERESTARTSYS;
-	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
-		smp_rmb();
-		return key->reject_error;
-	}
+	smp_rmb(); /* pairs with smp_wmb() in key_reject_and_link() */
+	ret = READ_ONCE(key->reject_error);
+	if (ret)
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
index 3d8c68eba516..a5506400836c 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -114,7 +114,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 
 	/* attach the new data, displacing the old */
 	key->expiry = prep->expiry;
-	if (!test_bit(KEY_FLAG_NEGATIVE, &key->flags))
+	if (!key_is_negative(key))
 		zap = dereference_key_locked(key);
 	rcu_assign_keypointer(key, prep->payload.data[0]);
 	prep->payload.data[0] = NULL;
-- 
2.14.1.690.gbb1197296e-goog

