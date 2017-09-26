From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 26 Sep 2017 20:11:05 +0000
Subject: [PATCH v2 6/6] KEYS: remove KEY_FLAG_NEGATIVE
Message-Id: <20170926201105.126166-7-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170926201105.126166-1-ebiggers3@gmail.com>
In-Reply-To: <20170926201105.126166-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that a key's reject_error is stored in the flags word, we can check
for nonzero reject_error rather than for KEY_FLAG_NEGATIVE.  Do this,
then remove KEY_FLAG_NEGATIVE.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/key.h                      | 20 ++++++++++++--------
 security/keys/encrypted-keys/encrypted.c |  2 +-
 security/keys/gc.c                       |  4 +---
 security/keys/key.c                      |  4 +---
 security/keys/keyctl.c                   |  2 +-
 security/keys/keyring.c                  |  2 +-
 security/keys/proc.c                     |  2 +-
 security/keys/request_key.c              |  2 +-
 security/keys/trusted.c                  |  2 +-
 security/keys/user_defined.c             |  2 +-
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index fcb79eedbdb5..ecae4c1e4375 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -181,13 +181,12 @@ struct key {
 #define KEY_FLAG_REVOKED	2	/* set if key had been revoked */
 #define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
 #define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
-#define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
-#define KEY_FLAG_ROOT_CAN_CLEAR	6	/* set if key can be cleared by root without permission */
-#define KEY_FLAG_INVALIDATED	7	/* set if key has been invalidated */
-#define KEY_FLAG_BUILTIN	8	/* set if key is built in to the kernel */
-#define KEY_FLAG_ROOT_CAN_INVAL	9	/* set if key can be invalidated by root without permission */
-#define KEY_FLAG_KEEP		10	/* set if key should not be removed */
-#define KEY_FLAG_UID_KEYRING	11	/* set if key is a user or user session keyring */
+#define KEY_FLAG_ROOT_CAN_CLEAR	5	/* set if key can be cleared by root without permission */
+#define KEY_FLAG_INVALIDATED	6	/* set if key has been invalidated */
+#define KEY_FLAG_BUILTIN	7	/* set if key is built in to the kernel */
+#define KEY_FLAG_ROOT_CAN_INVAL	8	/* set if key can be invalidated by root without permission */
+#define KEY_FLAG_KEEP		9	/* set if key should not be removed */
+#define KEY_FLAG_UID_KEYRING	10	/* set if key is a user or user session keyring */
 
 	/*
 	 * If the key is negatively instantiated, then bits 20-31 hold the error
@@ -376,7 +375,12 @@ static inline bool key_is_instantiated(const struct key *key)
 	unsigned long flags = smp_load_acquire(&key->flags);
 
 	return (flags & KEY_FLAG_INSTANTIATED) &&
-		!(flags & KEY_FLAG_NEGATIVE);
+		!(flags & KEY_FLAGS_REJECT_ERROR_MASK);
+}
+
+static inline bool key_is_negative(const struct key *key)
+{
+	return key->flags & KEY_FLAGS_REJECT_ERROR_MASK;
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
index 3ffb6829972f..990573a14666 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -407,10 +407,8 @@ static void mark_key_instantiated(struct key *key, unsigned int reject_error)
 
 	do {
 		old = READ_ONCE(key->flags);
-		new = (old & ~(KEY_FLAG_NEGATIVE |
-			       KEY_FLAGS_REJECT_ERROR_MASK)) |
+		new = (old & ~KEY_FLAGS_REJECT_ERROR_MASK) |
 		      KEY_FLAG_INSTANTIATED |
-		      (reject_error ? KEY_FLAG_NEGATIVE : 0) |
 		      (reject_error << KEY_FLAGS_REJECT_ERROR_SHIFT);
 	} while (cmpxchg_release(&key->flags, old, new) != old);
 }
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 19a09e121089..e90b352cc3bd 100644
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
index 1dfff0eac474..16d21d0e5e45 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -599,7 +599,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
 		/* we set a different error code if we pass a negative key */
-		if (kflags & (1 << KEY_FLAG_NEGATIVE)) {
+		if (kflags & KEY_FLAGS_REJECT_ERROR_MASK) {
 			ctx->result = ERR_PTR(-(int)(kflags >>
 						KEY_FLAGS_REJECT_ERROR_SHIFT));
 			kleave(" = %d [neg]", ctx->skipped_ret);
diff --git a/security/keys/proc.c b/security/keys/proc.c
index a038069ac46a..7d34e70f8aa1 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -250,7 +250,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		   showflag(flags, 'D', KEY_FLAG_DEAD),
 		   showflag(flags, 'Q', KEY_FLAG_IN_QUOTA),
 		   showflag(flags, 'U', KEY_FLAG_USER_CONSTRUCT),
-		   showflag(flags, 'N', KEY_FLAG_NEGATIVE),
+		   (flags & KEY_FLAGS_REJECT_ERROR_MASK) ? 'N' : '-',
 		   showflag(flags, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 0aab68344837..1953ceb33efc 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -599,7 +599,7 @@ int wait_for_key_construction(struct key *key, bool intr)
 
 	/* Pairs with RELEASE in mark_key_instantiated() */
 	flags = smp_load_acquire(&key->flags);
-	if (flags & (1 << KEY_FLAG_NEGATIVE))
+	if (flags & KEY_FLAGS_REJECT_ERROR_MASK)
 		return -(int)(flags >> KEY_FLAGS_REJECT_ERROR_SHIFT);
 
 	return key_validate(key);
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
2.14.1.992.g2c7b836f3a-goog

