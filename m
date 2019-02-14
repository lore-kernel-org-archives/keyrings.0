From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Feb 2019 16:57:35 +0000
Subject: [RFC PATCH 4/9] keys: Cache the hash value to avoid lots of recalculation
Message-Id: <155016345570.11489.12881645434285035244.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155016339876.11489.901851271827069026.stgit@warthog.procyon.org.uk>
In-Reply-To: <155016339876.11489.901851271827069026.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Cache the hash of the key's type and description in the index key so that
we're not recalculating it every time we look at a key during a search.
The hash function does a bunch of multiplications, so evading those is
probably worthwhile - especially as this is done for every key examined
during a search.

This also allows the methods used by assoc_array to get chunks of index-key
to be simplified.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h      |    3 +++
 security/keys/internal.h |    8 +-------
 security/keys/key.c      |    2 +-
 security/keys/keyring.c  |   28 ++++++++++++++++++++--------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 33d87cb2d469..b39f5876b66d 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -86,6 +86,8 @@ struct keyring_list;
 struct keyring_name;
 
 struct keyring_index_key {
+	/* [!] If this structure is altered, the union in struct key must change too! */
+	unsigned long		hash;			/* Hash value */
 	union {
 		struct {
 #ifdef __LITTLE_ENDIAN /* Put desc_len at the LSB of x */
@@ -213,6 +215,7 @@ struct key {
 	union {
 		struct keyring_index_key index_key;
 		struct {
+			unsigned long	hash;
 			unsigned long	len_desc;
 			struct key_type	*type;		/* type of key */
 			char		*description;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 02592d24f13a..3154ba59a2f0 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -89,13 +89,7 @@ extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
 extern wait_queue_head_t request_key_conswq;
 
-
-static inline void key_set_index_key(struct keyring_index_key *index_key)
-{
-	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
-	memcpy(index_key->desc, index_key->description, n);
-}
-
+extern void key_set_index_key(struct keyring_index_key *index_key);
 extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 1d0250a8990e..1568b0028ba4 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -285,12 +285,12 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL);
 	if (!key->index_key.description)
 		goto no_memory_3;
+	key->index_key.type = type;
 	key_set_index_key(&key->index_key);
 
 	refcount_set(&key->usage, 1);
 	init_rwsem(&key->sem);
 	lockdep_set_class(&key->sem, &type->lock_class);
-	key->index_key.type = type;
 	key->user = user;
 	key->quotalen = quotalen;
 	key->datalen = type->def_datalen;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index bece229aeccd..11c44ad07b5b 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -168,7 +168,7 @@ static u64 mult_64x32_and_fold(u64 x, u32 y)
 /*
  * Hash a key type and description.
  */
-static unsigned long hash_key_type_and_desc(const struct keyring_index_key *index_key)
+static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
@@ -206,10 +206,22 @@ static unsigned long hash_key_type_and_desc(const struct keyring_index_key *inde
 	 * zero for keyrings and non-zero otherwise.
 	 */
 	if (index_key->type != &key_type_keyring && (hash & fan_mask) = 0)
-		return hash | (hash >> (ASSOC_ARRAY_KEY_CHUNK_SIZE - level_shift)) | 1;
-	if (index_key->type = &key_type_keyring && (hash & fan_mask) != 0)
-		return (hash + (hash << level_shift)) & ~fan_mask;
-	return hash;
+		hash |= (hash >> (ASSOC_ARRAY_KEY_CHUNK_SIZE - level_shift)) | 1;
+	else if (index_key->type = &key_type_keyring && (hash & fan_mask) != 0)
+		hash = (hash + (hash << level_shift)) & ~fan_mask;
+	index_key->hash = hash;
+}
+
+/*
+ * Finalise an index key to include a part of the description actually in the
+ * index key and to add in the hash too.
+ */
+void key_set_index_key(struct keyring_index_key *index_key)
+{
+	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
+	memcpy(index_key->desc, index_key->description, n);
+
+	hash_key_type_and_desc(index_key);
 }
 
 /*
@@ -227,7 +239,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
 	case 0:
-		return hash_key_type_and_desc(index_key);
+		return index_key->hash;
 	case 1:
 		return index_key->x;
 	case 2:
@@ -280,8 +292,8 @@ static int keyring_diff_objects(const void *object, const void *data)
 	int level, i;
 
 	level = 0;
-	seg_a = hash_key_type_and_desc(a);
-	seg_b = hash_key_type_and_desc(b);
+	seg_a = a->hash;
+	seg_b = b->hash;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
