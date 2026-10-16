Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A31EB1AA;
	Fri, 16 Oct 2026 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187656; cv=none; b=N49wlaoPQY8hDiw4ZYQorVa37cxceuF42MdGe/lz8Iko4ox90WSOMz2dd9zMCXR9cx9ezCYlrmk7ZVTXtHzPxyvL8iJmxL8suDJWq7GyIbO7T/PltnMjiMf/XeDA8Wtr5lVZOJtHtgxhpU1rGGIbkV9Qbtju/OeemMN6lnnyjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187656; c=relaxed/simple;
	bh=o2LnLAk6OeGPckzi48whQqj3P3EC+nnXlrEW9P7aJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puYuEYJeP8ZVQZT71q9lcDkmdoiIhRBS+gw9gG2K5iIiXdCrBtAxIH989kuFyVwQLtaw3jkFOsbLSrTO/vG/VGShpjevNqcRjyjpCN6QPAuOowML1ozbA/2DDwEctTFxP5jKvXHIx7HZkaFVf6zjEyrRR/jmJwuxPuGSoBt9dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eskDTISe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eskDTISe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 65FE71F000C4;
	Fri, 16 Oct 2026 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187654;
	bh=6L+9e0dyy7Mnfg2hyt/8/Hhwq/TUuoaPXlwWPmES1YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eskDTISeHPwF5V7BeQ1YNWrNvM0UTP4Yy+7e0XditiF1Rjp2MbvoXaG2gV71n9nQG
	 xDDLAgBTlQQWFatFN9/t9OitH4CPYrykrWW/lQKB4capDTjcaucX7mors0a8dyoteD
	 rcVQNQ691CELhdiSCI7kIow/ZDDEYouJhccJp9mre1BKKFHg0vXPriUD6xiYC2cHzD
	 UxLgBhq6uzBeAkQWeYPWOQYiVU+P97Nhz6Tc2YjtuxHOXsRQ68YjVbim/Dbnfill7B
	 6/9ha2mO8CDufm+z9X4N7F0SaQdV3KvJZLdOHzR2yCXkaFi6fQKV02ih5Q67+ge45k
	 ravQbpYMKOJPQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct keyring_index
Date: Sat, 17 Oct 2026 00:53:03 +0300
Message-ID: <20261016215326.4110064-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016215326.4110064-1-jarkko@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux keyring would be better off without struct assoc_array given the
overhead caused by sole ownership of it. Linux has multiple popular choices
for key-value store and there is nothing special in lib/assoc_array.c that
would make it stand out enough to be ratiaonalize the time spent on
maintaining it.

A keyring has a sparse data population, making rhashtable a plausible
choice. Multiple subsystems rely on it, and best of all, rhashtable has
dedicated maintainers.

Replace assoc_array with struct keyring_index, allocated for a keyring on
its first link attempt. Initialize its ht member with rhashtable_init()
to store links indexed by key type, domain tag and description.

Maintain two linked lists in the index:

- all: enumerate committed links without retrying hash table walks when
  the table resizes.
- keyrings: visit nested keyrings during recursive search without scanning
  links to other key types.

A key can belong to several keyrings. Represent each link with struct
keyring_link so it has separate hash table and list nodes and holds its
own key reference. Traverse the lists under RCU and defer freeing removed
links and dropping their key references until after a grace period.

Assisted-by: LLM
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/keys/keyring-type.h |   1 -
 include/linux/key.h         |  19 +-
 security/keys/Kconfig       |   1 -
 security/keys/internal.h    |  10 +-
 security/keys/key.c         |   8 +-
 security/keys/keyring.c     | 885 +++++++++++++++++-------------------
 security/keys/request_key.c |   2 +-
 7 files changed, 434 insertions(+), 492 deletions(-)

diff --git a/include/keys/keyring-type.h b/include/keys/keyring-type.h
index 1dc83862f519..314832f5dc4a 100644
--- a/include/keys/keyring-type.h
+++ b/include/keys/keyring-type.h
@@ -9,6 +9,5 @@
 #define _KEYS_KEYRING_TYPE_H
 
 #include <linux/key.h>
-#include <linux/assoc_array.h>
 
 #endif /* _KEYS_KEYRING_TYPE_H */
diff --git a/include/linux/key.h b/include/linux/key.h
index d82253b06c54..1285c992a293 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -17,7 +17,6 @@
 #include <linux/sysctl.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
-#include <linux/assoc_array.h>
 #include <linux/refcount.h>
 #include <linux/time64.h>
 
@@ -104,6 +103,7 @@ struct key_owner;
 struct key_tag;
 struct keyring_list;
 struct keyring_name;
+struct keyring_index;
 
 struct key_tag {
 	struct rcu_head		rcu;
@@ -115,18 +115,7 @@ struct key_tag {
 struct keyring_index_key {
 	/* [!] If this structure is altered, the union in struct key must change too! */
 	unsigned long		hash;			/* Hash value */
-	union {
-		struct {
-#ifdef __LITTLE_ENDIAN /* Put desc_len at the LSB of x */
-			u16	desc_len;
-			char	desc[sizeof(long) - 2];	/* First few chars of description */
-#else
-			char	desc[sizeof(long) - 2];	/* First few chars of description */
-			u16	desc_len;
-#endif
-		};
-		unsigned long x;
-	};
+	unsigned int		desc_len;
 	struct key_type		*type;
 	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
@@ -250,7 +239,7 @@ struct key {
 		struct keyring_index_key index_key;
 		struct {
 			unsigned long	hash;
-			unsigned long	len_desc;
+			unsigned int	desc_len;
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
@@ -268,7 +257,7 @@ struct key {
 		struct {
 			/* Keyring bits */
 			struct list_head name_link;
-			struct assoc_array keys;
+			struct keyring_index __rcu *links;
 		};
 	};
 
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index f4510d8cb485..3f64d60d0f8a 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig KEYS
 	bool "Enable access key retention support"
-	select ASSOCIATIVE_ARRAY
 	help
 	  This option provides support for retaining authentication tokens and
 	  access keys in the kernel.
diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..3f1a43026f2f 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -96,15 +96,17 @@ extern int __key_link_lock(struct key *keyring,
 			   const struct keyring_index_key *index_key);
 extern int __key_move_lock(struct key *l_keyring, struct key *u_keyring,
 			   const struct keyring_index_key *index_key);
+struct keyring_link;
+
 extern int __key_link_begin(struct key *keyring,
 			    const struct keyring_index_key *index_key,
-			    struct assoc_array_edit **_edit);
+			    struct keyring_link **_edit);
 extern int __key_link_check_live_key(struct key *keyring, struct key *key);
 extern void __key_link(struct key *keyring, struct key *key,
-		       struct assoc_array_edit **_edit);
+		       struct keyring_link **_edit);
 extern void __key_link_end(struct key *keyring,
 			   const struct keyring_index_key *index_key,
-			   struct assoc_array_edit *edit);
+			   struct keyring_link *edit);
 
 extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 				    const struct keyring_index_key *index_key);
@@ -122,7 +124,7 @@ struct keyring_search_context {
 #define KEYRING_SEARCH_SKIP_EXPIRED	0x0020	/* Ignore expired keys (intention to replace) */
 #define KEYRING_SEARCH_RECURSE		0x0040	/* Search child keyrings also */
 
-	int (*iterator)(const void *object, void *iterator_data);
+	int (*iterator)(const struct key *key, void *iterator_data);
 
 	/* Internal stuff */
 	int			skipped_ret;
diff --git a/security/keys/key.c b/security/keys/key.c
index 144745684334..9197daf40e24 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -443,7 +443,7 @@ static int __key_instantiate_and_link(struct key *key,
 				      struct key_preparsed_payload *prep,
 				      struct key *keyring,
 				      struct key *authkey,
-				      struct assoc_array_edit **_edit)
+				      struct keyring_link **_edit)
 {
 	int ret, awaken;
 
@@ -518,7 +518,7 @@ int key_instantiate_and_link(struct key *key,
 			     struct key *authkey)
 {
 	struct key_preparsed_payload prep;
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	int ret;
 
 	memset(&prep, 0, sizeof(prep));
@@ -593,7 +593,7 @@ int key_reject_and_link(struct key *key,
 			struct key *keyring,
 			struct key *authkey)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	int ret, awaken, link_ret = 0;
 
 	key_check(key);
@@ -838,7 +838,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		.description	= description,
 	};
 	struct key_preparsed_payload prep;
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	const struct cred *cred = current_cred();
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 613d1db41611..d6809dcd392a 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -14,12 +14,12 @@
 #include <linux/err.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
+#include <keys/keyring-type.h>
+#include <keys/user-type.h>
 #include <linux/once.h>
 #include <linux/random.h>
+#include <linux/rhashtable.h>
 #include <linux/siphash.h>
-#include <keys/keyring-type.h>
-#include <keys/user-type.h>
-#include <linux/assoc_array_priv.h>
 #include <linux/uaccess.h>
 #include <net/net_namespace.h>
 #include "internal.h"
@@ -31,25 +31,183 @@
 #define KEYRING_SEARCH_MAX_DEPTH 6
 
 /*
- * We mark pointers we pass to the associative array with bit 1 set if
- * they're keyrings and clear otherwise.
+ * The contents of a keyring, allocated when the first link is made.
+ *
+ * Modified only with keyring->sem write-locked; read under RCU.  @ht indexes
+ * the links by index key, for direct lookup.  @all holds every committed link
+ * and @keyrings the committed links to keyrings, for iteration: an RCU walk of
+ * a list sees every entry that stays on it for the duration of the walk, which
+ * a walk of @ht racing with a resize does not.
+ */
+struct keyring_index {
+	struct rhashtable	ht;
+	struct list_head	all;
+	struct list_head	keyrings;
+	unsigned long		nr;		/* Number of committed links */
+};
+
+/*
+ * One link from a keyring to a key.
+ *
+ * __key_link_begin() allocates it and, unless it replaces an existing link,
+ * inserts it in the hash table with ->key NULL; lookups skip it until
+ * __key_link() stores ->key.  So all the allocation, and every failure, comes
+ * before __key_link(), which cannot fail.
+ *
+ * ->hash is copied from the index key at __key_link_begin() and never changes,
+ * so the hash table can rehash the link without looking at the key, whose
+ * type the garbage collector may change (key_type_dead).
  */
-#define KEYRING_PTR_SUBTYPE	0x2UL
+struct keyring_link {
+	struct rhash_head	node;
+	struct key __rcu	*key;		/* NULL while reserved */
+	unsigned long		hash;
+	struct list_head	all_link;	/* in keyring_index::all */
+	struct list_head	keyrings_link;	/* in keyring_index::keyrings */
+	struct keyring_link	*replaces;	/* Link this one replaces, or NULL */
+	bool			is_keyring;
+	struct rcu_head		rcu;
+};
+
+static u32 keyring_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct keyring_index_key *index_key = data;
+
+	return jhash_2words((u32)index_key->hash,
+			    (u32)((u64)index_key->hash >> 32), seed);
+}
 
-static inline bool keyring_ptr_is_keyring(const struct assoc_array_ptr *x)
+static u32 keyring_obj_hashfn(const void *data, u32 len, u32 seed)
 {
-	return (unsigned long)x & KEYRING_PTR_SUBTYPE;
+	const struct keyring_link *link = data;
+
+	return jhash_2words((u32)link->hash, (u32)((u64)link->hash >> 32), seed);
 }
-static inline struct key *keyring_ptr_to_key(const struct assoc_array_ptr *x)
+
+static bool keyring_index_key_equal(const struct keyring_index_key *a,
+				    const struct keyring_index_key *b)
 {
-	void *object = assoc_array_ptr_to_leaf(x);
-	return (struct key *)((unsigned long)object & ~KEYRING_PTR_SUBTYPE);
+	return a->type == b->type &&
+		a->domain_tag == b->domain_tag &&
+		a->desc_len == b->desc_len &&
+		memcmp(a->description, b->description, a->desc_len) == 0;
 }
-static inline void *keyring_key_to_ptr(struct key *key)
+
+/*
+ * Called under RCU or with the bucket locked.  A reserved link matches
+ * nothing.
+ */
+static int keyring_obj_cmpfn(struct rhashtable_compare_arg *arg,
+			     const void *obj)
 {
-	if (key->type == &key_type_keyring)
-		return (void *)((unsigned long)key | KEYRING_PTR_SUBTYPE);
-	return key;
+	const struct keyring_link *link = obj;
+	const struct key *key = rcu_dereference_check(link->key, true);
+
+	return !key || !keyring_index_key_equal(&key->index_key, arg->key);
+}
+
+static const struct rhashtable_params keyring_link_params = {
+	.head_offset		= offsetof(struct keyring_link, node),
+	.hashfn			= keyring_hashfn,
+	.obj_hashfn		= keyring_obj_hashfn,
+	.obj_cmpfn		= keyring_obj_cmpfn,
+	.min_size		= 4,
+	.nelem_hint		= 3,
+	.automatic_shrinking	= true,
+};
+
+static struct keyring_index *keyring_index_locked(const struct key *keyring)
+{
+	return rcu_dereference_protected(keyring->links,
+					 lockdep_is_held(&keyring->sem));
+}
+
+/*
+ * Find the committed link for an index key in a keyring.  Called under RCU or
+ * with keyring->sem held.
+ */
+static struct keyring_link *keyring_find_link(struct keyring_index *links,
+					      const struct keyring_index_key *index_key)
+{
+	if (!links)
+		return NULL;
+	return rhashtable_lookup_fast(&links->ht, index_key, keyring_link_params);
+}
+
+static struct key *keyring_link_key(const struct keyring_link *link)
+{
+	return rcu_dereference_check(link->key, true);
+}
+
+/*
+ * Pass each key linked from a keyring to @iterator until it returns non-zero.
+ * Returns the last value @iterator returned, or 0 if the keyring is empty.
+ * Concurrent links and unlinks may be seen or not; a key that stays linked
+ * throughout is passed to @iterator.
+ */
+static int keyring_iterate(const struct key *keyring,
+			   int (*iterator)(const struct key *key, void *data),
+			   void *data)
+{
+	struct keyring_index *links;
+	struct keyring_link *link;
+	int ret = 0;
+
+	rcu_read_lock();
+	links = rcu_dereference(keyring->links);
+	if (links) {
+		list_for_each_entry_rcu(link, &links->all, all_link) {
+			ret = iterator(keyring_link_key(link), data);
+			if (ret)
+				break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Drop the link's reference on its key after a grace period, as an RCU reader
+ * that found the key through the link may still take a reference on it with
+ * __key_get() (keyring_search_rcu()).
+ */
+static void keyring_link_free_rcu(struct rcu_head *rcu)
+{
+	struct keyring_link *link = container_of(rcu, struct keyring_link, rcu);
+
+	key_put(rcu_dereference_raw(link->key));
+	kfree(link);
+}
+
+/*
+ * Remove a committed link.  The caller holds keyring->sem write-locked.
+ */
+static void keyring_remove_link(struct keyring_index *links,
+				struct keyring_link *link)
+{
+	WARN_ON(rhashtable_remove_fast(&links->ht, &link->node,
+				       keyring_link_params));
+	list_del_rcu(&link->all_link);
+	if (link->is_keyring)
+		list_del_rcu(&link->keyrings_link);
+	WRITE_ONCE(links->nr, links->nr - 1);
+	call_rcu(&link->rcu, keyring_link_free_rcu);
+}
+
+/*
+ * Remove every link from a keyring.  The caller holds keyring->sem
+ * write-locked.  A concurrent RCU reader can see some of the links gone and
+ * others not yet.
+ */
+static void keyring_remove_all_links(struct key *keyring)
+{
+	struct keyring_index *links = keyring_index_locked(keyring);
+	struct keyring_link *link, *tmp;
+
+	if (!links)
+		return;
+	list_for_each_entry_safe(link, tmp, &links->all, all_link)
+		keyring_remove_link(links, link);
 }
 
 static DEFINE_RWLOCK(keyring_name_lock);
@@ -143,7 +301,7 @@ static void keyring_free_preparse(struct key_preparsed_payload *prep)
 static int keyring_instantiate(struct key *keyring,
 			       struct key_preparsed_payload *prep)
 {
-	assoc_array_init(&keyring->keys);
+	RCU_INIT_POINTER(keyring->links, NULL);
 	/* make the keyring available by name if it has one */
 	keyring_publish_name(keyring);
 	return 0;
@@ -175,13 +333,10 @@ static u64 key_index_id(atomic64_t *id)
 }
 
 /*
- * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
- * traversal order, so no part of the index may contain kernel addresses.
+ * Hash a key type, domain and description using address-independent IDs.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
-	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
-	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
 	static siphash_key_t hash_key __read_mostly;
 	unsigned long hash;
 	u64 acc;
@@ -193,30 +348,17 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
-	if (ASSOC_ARRAY_KEY_CHUNK_SIZE == 32)
+	if (BITS_PER_LONG == 32)
 		hash ^= acc >> 32;
-
-	/* Squidge all the keyrings into a separate part of the tree to
-	 * ordinary keys by making sure the lowest level segment in the hash is
-	 * zero for keyrings and non-zero otherwise.
-	 */
-	if (index_key->type != &key_type_keyring && (hash & fan_mask) == 0)
-		hash |= (hash >> (ASSOC_ARRAY_KEY_CHUNK_SIZE - level_shift)) | 1;
-	else if (index_key->type == &key_type_keyring && (hash & fan_mask) != 0)
-		hash = (hash + (hash << level_shift)) & ~fan_mask;
 	index_key->hash = hash;
 }
 
 /*
- * Finalise an index key to include a part of the description actually in the
- * index key, to set the domain tag and index IDs, and to calculate the hash.
+ * Finalise an index key: set the domain tag and index IDs, and calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
 	static struct key_tag default_domain_tag = { .usage = REFCOUNT_INIT(1), };
-	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
-
-	memcpy(index_key->desc, index_key->description, n);
 
 	if (!index_key->domain_tag) {
 		if (index_key->type->flags & KEY_TYPE_NET_DOMAIN)
@@ -268,150 +410,6 @@ void key_remove_domain(struct key_tag *domain_tag)
 		key_schedule_gc_links();
 }
 
-/*
- * Build the next index key chunk.
- *
- * The hash and inline description are followed by the 64-bit type and domain
- * IDs, low word first, and then by the rest of the description.
- * We return it one word-sized chunk at a time.
- */
-static unsigned long keyring_get_key_chunk(const void *data, int level)
-{
-	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
-	const struct keyring_index_key *index_key = data;
-	int desc_len = index_key->desc_len;
-	unsigned long chunk = 0;
-	int n = sizeof(chunk);
-	unsigned int offset;
-	const u8 *d;
-
-	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
-	switch (level) {
-	case 0:
-		return index_key->hash;
-	case 1:
-		return index_key->x;
-	}
-
-	level -= 2;
-	if (level < id_chunks)
-		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
-	level -= id_chunks;
-	if (level < id_chunks)
-		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
-	level -= id_chunks;
-
-	offset = sizeof(index_key->desc) + level * sizeof(long);
-	if (desc_len <= offset)
-		return 0;
-
-	d = index_key->description + offset;
-	desc_len -= offset;
-	if (desc_len > n)
-		desc_len = n;
-	d += desc_len;
-	do {
-		chunk <<= 8;
-		chunk |= *--d;
-	} while (--desc_len > 0);
-	return chunk;
-}
-
-static unsigned long keyring_get_object_key_chunk(const void *object, int level)
-{
-	const struct key *key = keyring_ptr_to_key(object);
-	return keyring_get_key_chunk(&key->index_key, level);
-}
-
-static bool keyring_compare_object(const void *object, const void *data)
-{
-	const struct keyring_index_key *index_key = data;
-	const struct key *key = keyring_ptr_to_key(object);
-
-	return key->index_key.type == index_key->type &&
-		key->index_key.domain_tag == index_key->domain_tag &&
-		key->index_key.desc_len == index_key->desc_len &&
-		memcmp(key->index_key.description, index_key->description,
-		       index_key->desc_len) == 0;
-}
-
-/*
- * Compare the index keys of a pair of objects and determine the bit position
- * at which they differ - if they differ.
- */
-static int keyring_diff_objects(const void *object, const void *data)
-{
-	const struct key *key_a = keyring_ptr_to_key(object);
-	const struct keyring_index_key *a = &key_a->index_key;
-	const struct keyring_index_key *b = data;
-	unsigned long seg_a, seg_b;
-	int level, i;
-	u64 diff;
-
-	level = 0;
-	seg_a = a->hash;
-	seg_b = b->hash;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
-
-	/* The inline description contributes one machine-word-sized chunk. */
-	seg_a = a->x;
-	seg_b = b->x;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
-
-	diff = a->type_id ^ b->type_id;
-	if (diff)
-		return level * 8 + __ffs64(diff);
-	level += sizeof(u64);
-
-	diff = a->domain_id ^ b->domain_id;
-	if (diff)
-		return level * 8 + __ffs64(diff);
-	level += sizeof(u64);
-
-	i = sizeof(a->desc);
-	if (a->desc_len <= i)
-		goto same;
-
-	for (; i < a->desc_len; i++) {
-		seg_a = *(unsigned char *)(a->description + i);
-		seg_b = *(unsigned char *)(b->description + i);
-		if ((seg_a ^ seg_b) != 0)
-			goto differ_plus_i;
-	}
-
-same:
-	return -1;
-
-differ_plus_i:
-	level += i - (int)sizeof(a->desc);
-differ:
-	i = level * 8 + __ffs(seg_a ^ seg_b);
-	return i;
-}
-
-/*
- * Free an object after stripping the keyring flag off of the pointer.
- */
-static void keyring_free_object(void *object)
-{
-	key_put(keyring_ptr_to_key(object));
-}
-
-/*
- * Operations for keyring management by the index-tree routines.
- */
-static const struct assoc_array_ops keyring_assoc_array_ops = {
-	.get_key_chunk		= keyring_get_key_chunk,
-	.get_object_key_chunk	= keyring_get_object_key_chunk,
-	.compare_object		= keyring_compare_object,
-	.diff_objects		= keyring_diff_objects,
-	.free_object		= keyring_free_object,
-};
-
 /*
  * Clean up a keyring when it is destroyed.  Unpublish its name if it had one
  * and dispose of its data.
@@ -423,6 +421,9 @@ static const struct assoc_array_ops keyring_assoc_array_ops = {
  */
 static void keyring_destroy(struct key *keyring)
 {
+	struct keyring_index *links;
+	struct keyring_link *link, *tmp;
+
 	if (keyring->description) {
 		write_lock(&keyring_name_lock);
 
@@ -440,7 +441,31 @@ static void keyring_destroy(struct key *keyring)
 		kfree(keyres);
 	}
 
-	assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
+	links = rcu_dereference_protected(keyring->links, true);
+	if (links) {
+		/* First, as it waits for a resize that may be walking the links. */
+		rhashtable_destroy(&links->ht);
+		list_for_each_entry_safe(link, tmp, &links->all, all_link) {
+			key_put(rcu_dereference_protected(link->key, true));
+			kfree(link);
+		}
+		kfree(links);
+	}
+}
+
+/*
+ * The number of links in a keyring.
+ */
+static unsigned long keyring_nr_links(const struct key *keyring)
+{
+	const struct keyring_index *links;
+	unsigned long nr;
+
+	rcu_read_lock();
+	links = rcu_dereference(keyring->links);
+	nr = links ? READ_ONCE(links->nr) : 0;
+	rcu_read_unlock();
+	return nr;
 }
 
 /**
@@ -449,7 +474,7 @@ static void keyring_destroy(struct key *keyring)
  */
 bool keyring_is_empty(const struct key *keyring)
 {
-	return READ_ONCE(keyring->keys.nr_leaves_on_tree) == 0;
+	return keyring_nr_links(keyring) == 0;
 }
 EXPORT_SYMBOL(keyring_is_empty);
 
@@ -458,14 +483,17 @@ EXPORT_SYMBOL(keyring_is_empty);
  */
 static void keyring_describe(const struct key *keyring, struct seq_file *m)
 {
+	unsigned long nr;
+
 	if (keyring->description)
 		seq_puts(m, keyring->description);
 	else
 		seq_puts(m, "[anon]");
 
 	if (key_is_positive(keyring)) {
-		if (keyring->keys.nr_leaves_on_tree != 0)
-			seq_printf(m, ": %lu", keyring->keys.nr_leaves_on_tree);
+		nr = keyring_nr_links(keyring);
+		if (nr != 0)
+			seq_printf(m, ": %lu", nr);
 		else
 			seq_puts(m, ": empty");
 	}
@@ -477,10 +505,9 @@ struct keyring_read_iterator_context {
 	key_serial_t		*buffer;
 };
 
-static int keyring_read_iterator(const void *object, void *data)
+static int keyring_read_iterator(const struct key *key, void *data)
 {
 	struct keyring_read_iterator_context *ctx = data;
-	const struct key *key = keyring_ptr_to_key(object);
 
 	kenter("{%s,%d},,{%zu/%zu}",
 	       key->type->name, key->serial, ctx->count, ctx->buflen);
@@ -516,8 +543,7 @@ static long keyring_read(const struct key *keyring,
 		ctx.buffer = (key_serial_t *)buffer;
 		ctx.buflen = buflen;
 		ctx.count = 0;
-		ret = assoc_array_iterate(&keyring->keys,
-					  keyring_read_iterator, &ctx);
+		ret = keyring_iterate(keyring, keyring_read_iterator, &ctx);
 		if (ret < 0) {
 			kleave(" = %ld [iterate]", ret);
 			return ret;
@@ -525,7 +551,7 @@ static long keyring_read(const struct key *keyring,
 	}
 
 	/* Return the size of the buffer needed */
-	ret = keyring->keys.nr_leaves_on_tree * sizeof(key_serial_t);
+	ret = keyring_nr_links(keyring) * sizeof(key_serial_t);
 	if (ret <= buflen)
 		kleave("= %ld [ok]", ret);
 	else
@@ -593,10 +619,9 @@ bool key_default_cmp(const struct key *key,
 /*
  * Iteration function to consider each key found.
  */
-static int keyring_search_iterator(const void *object, void *iterator_data)
+static int keyring_search_iterator(const struct key *key, void *iterator_data)
 {
 	struct keyring_search_context *ctx = iterator_data;
-	const struct key *key = keyring_ptr_to_key(object);
 	unsigned long kflags = READ_ONCE(key->flags);
 	short state = key_read_state(key);
 
@@ -668,14 +693,74 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 static int search_keyring(struct key *keyring, struct keyring_search_context *ctx)
 {
 	if (ctx->match_data.lookup_type == KEYRING_SEARCH_LOOKUP_DIRECT) {
-		const void *object;
+		struct keyring_link *link;
+		struct key *key;
+
+		link = keyring_find_link(rcu_dereference(keyring->links),
+					 &ctx->index_key);
+		if (!link)
+			return 0;
+		key = keyring_link_key(link);
+		return key ? ctx->iterator(key, ctx) : 0;
+	}
+	return keyring_iterate(keyring, ctx->iterator, ctx);
+}
+
+/*
+ * Search @keyring, which is @depth keyrings below the one the search began
+ * at, and then the keyrings linked from it, depth first.  The recursion is
+ * bounded by KEYRING_SEARCH_MAX_DEPTH.
+ *
+ * Returns 1 if a key was found, 0 if not, or -ELOOP to end the search.
+ */
+static int search_keyring_tree(struct key *keyring,
+			       struct keyring_search_context *ctx, int depth)
+{
+	struct keyring_index *links;
+	struct keyring_link *link;
+	int ret;
+
+	if (keyring->flags & ((1 << KEY_FLAG_INVALIDATED) |
+			      (1 << KEY_FLAG_REVOKED)))
+		return 0;
+
+	/* The keys in this keyring before the keyrings in it */
+	if (search_keyring(keyring, ctx))
+		goto found;
+
+	if (!(ctx->flags & KEYRING_SEARCH_RECURSE))
+		return 0;
+	links = rcu_dereference(keyring->links);
+	if (!links)
+		return 0;
+
+	list_for_each_entry_rcu(link, &links->keyrings, keyrings_link) {
+		struct key *key = keyring_link_key(link);
+
+		if (depth >= KEYRING_SEARCH_MAX_DEPTH) {
+			if (!(ctx->flags & KEYRING_SEARCH_DETECT_TOO_DEEP))
+				return 0;
+			ctx->result = ERR_PTR(-ELOOP);
+			return -ELOOP;
+		}
+
+		if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
+		    key_task_permission(make_key_ref(key, ctx->possessed),
+					ctx->cred, KEY_NEED_SEARCH) < 0)
+			continue;
 
-		object = assoc_array_find(&keyring->keys,
-					  &keyring_assoc_array_ops,
-					  &ctx->index_key);
-		return object ? ctx->iterator(object, ctx) : 0;
+		ret = search_keyring_tree(key, ctx, depth + 1);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			goto found;
 	}
-	return assoc_array_iterate(&keyring->keys, ctx->iterator, ctx);
+	return 0;
+
+found:
+	if (!(ctx->flags & KEYRING_SEARCH_NO_UPDATE_TIME))
+		keyring->last_used_at = ctx->now;
+	return 1;
 }
 
 /*
@@ -685,17 +770,7 @@ static int search_keyring(struct key *keyring, struct keyring_search_context *ct
 static bool search_nested_keyrings(struct key *keyring,
 				   struct keyring_search_context *ctx)
 {
-	struct {
-		struct key *keyring;
-		struct assoc_array_node *node;
-		int slot;
-	} stack[KEYRING_SEARCH_MAX_DEPTH];
-
-	struct assoc_array_shortcut *shortcut;
-	struct assoc_array_node *node;
-	struct assoc_array_ptr *ptr;
 	struct key *key;
-	int sp = 0, slot;
 
 	kenter("{%d},{%s,%s}",
 	       keyring->serial,
@@ -713,9 +788,9 @@ static bool search_nested_keyrings(struct key *keyring,
 	 * and whether it is valid or not.
 	 */
 	if (ctx->match_data.lookup_type == KEYRING_SEARCH_LOOKUP_ITERATE ||
-	    keyring_compare_object(keyring, &ctx->index_key)) {
+	    keyring_index_key_equal(&keyring->index_key, &ctx->index_key)) {
 		ctx->skipped_ret = 2;
-		switch (ctx->iterator(keyring_key_to_ptr(keyring), ctx)) {
+		switch (ctx->iterator(keyring, ctx)) {
 		case 1:
 			goto found;
 		case 2:
@@ -727,152 +802,11 @@ static bool search_nested_keyrings(struct key *keyring,
 
 	ctx->skipped_ret = 0;
 
-	/* Start processing a new keyring */
-descend_to_keyring:
-	kdebug("descend to %d", keyring->serial);
-	if (keyring->flags & ((1 << KEY_FLAG_INVALIDATED) |
-			      (1 << KEY_FLAG_REVOKED)))
-		goto not_this_keyring;
-
-	/* Search through the keys in this keyring before its searching its
-	 * subtrees.
-	 */
-	if (search_keyring(keyring, ctx))
-		goto found;
-
-	/* Then manually iterate through the keyrings nested in this one.
-	 *
-	 * Start from the root node of the index tree.  Because of the way the
-	 * hash function has been set up, keyrings cluster on the leftmost
-	 * branch of the root node (root slot 0) or in the root node itself.
-	 * Non-keyrings avoid the leftmost branch of the root entirely (root
-	 * slots 1-15).
-	 */
-	if (!(ctx->flags & KEYRING_SEARCH_RECURSE))
-		goto not_this_keyring;
-
-	ptr = READ_ONCE(keyring->keys.root);
-	if (!ptr)
-		goto not_this_keyring;
-
-	if (assoc_array_ptr_is_shortcut(ptr)) {
-		/* If the root is a shortcut, either the keyring only contains
-		 * keyring pointers (everything clusters behind root slot 0) or
-		 * doesn't contain any keyring pointers.
-		 */
-		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
-			goto not_this_keyring;
-
-		ptr = READ_ONCE(shortcut->next_node);
-		node = assoc_array_ptr_to_node(ptr);
-		goto begin_node;
-	}
-
-	node = assoc_array_ptr_to_node(ptr);
-	ptr = node->slots[0];
-	if (!assoc_array_ptr_is_meta(ptr))
-		goto begin_node;
-
-descend_to_node:
-	/* Descend to a more distal node in this keyring's content tree and go
-	 * through that.
-	 */
-	kdebug("descend");
-	if (assoc_array_ptr_is_shortcut(ptr)) {
-		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		ptr = READ_ONCE(shortcut->next_node);
-		BUG_ON(!assoc_array_ptr_is_node(ptr));
-	}
-	node = assoc_array_ptr_to_node(ptr);
-
-begin_node:
-	kdebug("begin_node");
-	slot = 0;
-ascend_to_node:
-	/* Go through the slots in a node */
-	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = READ_ONCE(node->slots[slot]);
-
-		if (assoc_array_ptr_is_meta(ptr)) {
-			if (node->back_pointer ||
-			    assoc_array_ptr_is_shortcut(ptr))
-				goto descend_to_node;
-		}
-
-		if (!keyring_ptr_is_keyring(ptr))
-			continue;
-
-		key = keyring_ptr_to_key(ptr);
-
-		if (sp >= KEYRING_SEARCH_MAX_DEPTH) {
-			if (ctx->flags & KEYRING_SEARCH_DETECT_TOO_DEEP) {
-				ctx->result = ERR_PTR(-ELOOP);
-				return false;
-			}
-			goto not_this_keyring;
-		}
-
-		/* Search a nested keyring */
-		if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
-		    key_task_permission(make_key_ref(key, ctx->possessed),
-					ctx->cred, KEY_NEED_SEARCH) < 0)
-			continue;
-
-		/* stack the current position */
-		stack[sp].keyring = keyring;
-		stack[sp].node = node;
-		stack[sp].slot = slot;
-		sp++;
-
-		/* begin again with the new keyring */
-		keyring = key;
-		goto descend_to_keyring;
-	}
-
-	/* We've dealt with all the slots in the current node, so now we need
-	 * to ascend to the parent and continue processing there.
-	 */
-	ptr = READ_ONCE(node->back_pointer);
-	slot = node->parent_slot;
-
-	if (ptr && assoc_array_ptr_is_shortcut(ptr)) {
-		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		ptr = READ_ONCE(shortcut->back_pointer);
-		slot = shortcut->parent_slot;
-	}
-	if (!ptr)
-		goto not_this_keyring;
-	node = assoc_array_ptr_to_node(ptr);
-	slot++;
-
-	/* If we've ascended to the root (zero backpointer), we must have just
-	 * finished processing the leftmost branch rather than the root slots -
-	 * so there can't be any more keyrings for us to find.
-	 */
-	if (node->back_pointer) {
-		kdebug("ascend %d", slot);
-		goto ascend_to_node;
-	}
-
-	/* The keyring we're looking at was disqualified or didn't contain a
-	 * matching key.
-	 */
-not_this_keyring:
-	kdebug("not_this_keyring %d", sp);
-	if (sp <= 0) {
+	if (search_keyring_tree(keyring, ctx, 0) <= 0) {
 		kleave(" = false");
 		return false;
 	}
 
-	/* Resume the processing of a keyring higher up in the tree */
-	sp--;
-	keyring = stack[sp].keyring;
-	node = stack[sp].node;
-	slot = stack[sp].slot + 1;
-	kdebug("ascend to %d [%d]", keyring->serial, slot);
-	goto ascend_to_node;
-
 	/* We found a viable match */
 found:
 	key = key_ref_to_ptr(ctx->result);
@@ -880,8 +814,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	if (!(ctx->flags & KEYRING_SEARCH_NO_UPDATE_TIME)) {
 		key->last_used_at = ctx->now;
 		keyring->last_used_at = ctx->now;
-		while (sp > 0)
-			stack[--sp].keyring->last_used_at = ctx->now;
 	}
 	kleave(" = true");
 	return true;
@@ -1123,8 +1055,8 @@ EXPORT_SYMBOL(keyring_restrict);
 key_ref_t find_key_to_update(key_ref_t keyring_ref,
 			     const struct keyring_index_key *index_key)
 {
+	struct keyring_link *link;
 	struct key *keyring, *key;
-	const void *object;
 
 	keyring = key_ref_to_ptr(keyring_ref);
 
@@ -1132,17 +1064,15 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 	       keyring->serial, index_key->type->name, index_key->description);
 
 	guard(rcu)();
-	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
-				  index_key);
-
-	if (object)
+	link = keyring_find_link(rcu_dereference(keyring->links), index_key);
+	key = link ? keyring_link_key(link) : NULL;
+	if (key)
 		goto found;
 
 	kleave(" = NULL");
 	return NULL;
 
 found:
-	key = keyring_ptr_to_key(object);
 	if (key->flags & ((1 << KEY_FLAG_INVALIDATED) |
 			  (1 << KEY_FLAG_REVOKED))) {
 		kleave(" = NULL [x]");
@@ -1212,11 +1142,10 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	return keyring;
 }
 
-static int keyring_detect_cycle_iterator(const void *object,
+static int keyring_detect_cycle_iterator(const struct key *key,
 					 void *iterator_data)
 {
 	struct keyring_search_context *ctx = iterator_data;
-	const struct key *key = keyring_ptr_to_key(object);
 
 	kenter("{%d}", key->serial);
 
@@ -1313,13 +1242,45 @@ int __key_move_lock(struct key *l_keyring, struct key *u_keyring,
 }
 
 /*
- * Preallocate memory so that a key can be linked into to a keyring.
+ * Get a keyring's contents, allocating them for the first link.  The caller
+ * holds keyring->sem write-locked.
+ */
+static struct keyring_index *keyring_get_index(struct key *keyring)
+{
+	struct keyring_index *links = keyring_index_locked(keyring);
+	int ret;
+
+	if (links)
+		return links;
+
+	links = kzalloc_obj(struct keyring_index);
+	if (!links)
+		return ERR_PTR(-ENOMEM);
+	ret = rhashtable_init(&links->ht, &keyring_link_params);
+	if (ret < 0) {
+		kfree(links);
+		return ERR_PTR(ret);
+	}
+	INIT_LIST_HEAD(&links->all);
+	INIT_LIST_HEAD(&links->keyrings);
+	rcu_assign_pointer(keyring->links, links);
+	return links;
+}
+
+/*
+ * Reserve a link so that a key can be linked into a keyring by __key_link(),
+ * which cannot fail.
+ *
+ * If the keyring has a link for the index key already, the new link will
+ * replace it.  Otherwise the new link is inserted in the hash table now, with
+ * no key, and lookups skip it until __key_link() sets the key.
  */
 int __key_link_begin(struct key *keyring,
 		     const struct keyring_index_key *index_key,
-		     struct assoc_array_edit **_edit)
+		     struct keyring_link **_edit)
 {
-	struct assoc_array_edit *edit;
+	struct keyring_index *links;
+	struct keyring_link *link;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1334,34 +1295,43 @@ int __key_link_begin(struct key *keyring,
 	if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
 		goto error;
 
-	/* Create an edit script that will insert/replace the key in the
-	 * keyring tree.
-	 */
-	edit = assoc_array_insert(&keyring->keys,
-				  &keyring_assoc_array_ops,
-				  index_key,
-				  NULL);
-	if (IS_ERR(edit)) {
-		ret = PTR_ERR(edit);
+	links = keyring_get_index(keyring);
+	if (IS_ERR(links)) {
+		ret = PTR_ERR(links);
 		goto error;
 	}
 
-	/* If we're not replacing a link in-place then we're going to need some
-	 * extra quota.
-	 */
-	if (!edit->dead_leaf) {
+	ret = -ENOMEM;
+	link = kzalloc_obj(struct keyring_link);
+	if (!link)
+		goto error;
+	link->hash = index_key->hash;
+
+	link->replaces = keyring_find_link(links, index_key);
+	if (!link->replaces) {
+		/* We're not replacing a link in-place, so we're going to need
+		 * some extra quota.
+		 */
 		ret = key_payload_reserve(keyring,
 					  keyring->datalen + KEYQUOTA_LINK_BYTES);
 		if (ret < 0)
-			goto error_cancel;
+			goto error_free;
+
+		ret = rhashtable_insert_fast(&links->ht, &link->node,
+					     keyring_link_params);
+		if (ret < 0) {
+			key_payload_reserve(keyring,
+					    keyring->datalen - KEYQUOTA_LINK_BYTES);
+			goto error_free;
+		}
 	}
 
-	*_edit = edit;
+	*_edit = link;
 	kleave(" = 0");
 	return 0;
 
-error_cancel:
-	assoc_array_cancel_edit(edit);
+error_free:
+	kfree(link);
 error:
 	kleave(" = %d", ret);
 	return ret;
@@ -1391,11 +1361,35 @@ int __key_link_check_live_key(struct key *keyring, struct key *key)
  * combination.
  */
 void __key_link(struct key *keyring, struct key *key,
-		struct assoc_array_edit **_edit)
+		struct keyring_link **_edit)
 {
+	struct keyring_index *links = keyring_index_locked(keyring);
+	struct keyring_link *link = *_edit, *old = link->replaces;
+
 	__key_get(key);
-	assoc_array_insert_set_object(*_edit, keyring_key_to_ptr(key));
-	assoc_array_apply_edit(*_edit);
+	link->is_keyring = key->type == &key_type_keyring;
+	rcu_assign_pointer(link->key, key);
+
+	if (old) {
+		/* The two links have the same index key, so the same hash and
+		 * the same type.
+		 */
+		WARN_ON(rhashtable_replace_fast(&links->ht, &old->node,
+						&link->node,
+						keyring_link_params));
+		list_replace_rcu(&old->all_link, &link->all_link);
+		if (link->is_keyring)
+			list_replace_rcu(&old->keyrings_link,
+					 &link->keyrings_link);
+		call_rcu(&old->rcu, keyring_link_free_rcu);
+	} else {
+		list_add_tail_rcu(&link->all_link, &links->all);
+		if (link->is_keyring)
+			list_add_tail_rcu(&link->keyrings_link,
+					  &links->keyrings);
+		WRITE_ONCE(links->nr, links->nr + 1);
+	}
+
 	*_edit = NULL;
 	notify_key(keyring, NOTIFY_KEY_LINKED, key_serial(key));
 }
@@ -1407,7 +1401,7 @@ void __key_link(struct key *keyring, struct key *key,
  */
 void __key_link_end(struct key *keyring,
 		    const struct keyring_index_key *index_key,
-		    struct assoc_array_edit *edit)
+		    struct keyring_link *edit)
 	__releases(&keyring->sem)
 	__releases(&keyring_serialise_link_lock)
 {
@@ -1415,11 +1409,18 @@ void __key_link_end(struct key *keyring,
 	kenter("%d,%s,", keyring->serial, index_key->type->name);
 
 	if (edit) {
-		if (!edit->dead_leaf) {
+		/* A reserved link that was not used. */
+		if (!edit->replaces) {
 			key_payload_reserve(keyring,
 				keyring->datalen - KEYQUOTA_LINK_BYTES);
+			WARN_ON(rhashtable_remove_fast(&keyring_index_locked(keyring)->ht,
+						       &edit->node,
+						       keyring_link_params));
+			/* RCU readers may be looking at it in a hash chain. */
+			call_rcu(&edit->rcu, keyring_link_free_rcu);
+		} else {
+			kfree(edit);
 		}
-		assoc_array_cancel_edit(edit);
 	}
 	up_write(&keyring->sem);
 
@@ -1460,7 +1461,7 @@ static int __key_link_check_restriction(struct key *keyring, struct key *key)
  */
 int key_link(struct key *keyring, struct key *key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	int ret;
 
 	kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
@@ -1508,27 +1509,21 @@ static int __key_unlink_lock(struct key *keyring)
  * Begin the process of unlinking a key from a keyring.
  */
 static int __key_unlink_begin(struct key *keyring, struct key *key,
-			      struct assoc_array_edit **_edit)
+			      struct keyring_link **_edit)
 {
-	struct assoc_array_edit *edit;
-	const void *object;
+	struct keyring_link *link;
 
 	BUG_ON(*_edit != NULL);
 
-	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
-				  &key->index_key);
-	if (!object || keyring_ptr_to_key(object) != key)
+	link = keyring_find_link(keyring_index_locked(keyring),
+				 &key->index_key);
+	if (!link)
 		return -ENOENT;
 
-	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
-				  &key->index_key);
-	if (IS_ERR(edit))
-		return PTR_ERR(edit);
-
-	if (!edit)
+	if (keyring_link_key(link) != key)
 		return -ENOENT;
 
-	*_edit = edit;
+	*_edit = link;
 	return 0;
 }
 
@@ -1536,27 +1531,13 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
  * Apply an unlink change.
  */
 static void __key_unlink(struct key *keyring, struct key *key,
-			 struct assoc_array_edit **_edit)
+			 struct keyring_link *link)
 {
-	assoc_array_apply_edit(*_edit);
+	keyring_remove_link(keyring_index_locked(keyring), link);
 	notify_key(keyring, NOTIFY_KEY_UNLINKED, key_serial(key));
-	*_edit = NULL;
 	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
 }
 
-/*
- * Finish unlinking a key from to a keyring.
- */
-static void __key_unlink_end(struct key *keyring,
-			     struct key *key,
-			     struct assoc_array_edit *edit)
-	__releases(&keyring->sem)
-{
-	if (edit)
-		assoc_array_cancel_edit(edit);
-	up_write(&keyring->sem);
-}
-
 /**
  * key_unlink - Unlink the first link to a key from a keyring.
  * @keyring: The keyring to remove the link from.
@@ -1576,7 +1557,7 @@ static void __key_unlink_end(struct key *keyring,
  */
 int key_unlink(struct key *keyring, struct key *key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	int ret;
 
 	key_check(keyring);
@@ -1588,8 +1569,8 @@ int key_unlink(struct key *keyring, struct key *key)
 
 	ret = __key_unlink_begin(keyring, key, &edit);
 	if (ret == 0)
-		__key_unlink(keyring, key, &edit);
-	__key_unlink_end(keyring, key, edit);
+		__key_unlink(keyring, key, edit);
+	up_write(&keyring->sem);
 	return ret;
 }
 EXPORT_SYMBOL(key_unlink);
@@ -1624,7 +1605,7 @@ int key_move(struct key *key,
 	     struct key *to_keyring,
 	     unsigned int flags)
 {
-	struct assoc_array_edit *from_edit = NULL, *to_edit = NULL;
+	struct keyring_link *from_edit = NULL, *to_edit = NULL;
 	int ret;
 
 	kenter("%d,%d,%d", key->serial, from_keyring->serial, to_keyring->serial);
@@ -1647,7 +1628,7 @@ int key_move(struct key *key,
 		goto error;
 
 	ret = -EEXIST;
-	if (to_edit->dead_leaf && (flags & KEYCTL_MOVE_EXCL))
+	if (to_edit->replaces && (flags & KEYCTL_MOVE_EXCL))
 		goto error;
 
 	ret = __key_link_check_restriction(to_keyring, key);
@@ -1657,11 +1638,11 @@ int key_move(struct key *key,
 	if (ret < 0)
 		goto error;
 
-	__key_unlink(from_keyring, key, &from_edit);
+	__key_unlink(from_keyring, key, from_edit);
 	__key_link(to_keyring, key, &to_edit);
 error:
 	__key_link_end(to_keyring, &key->index_key, to_edit);
-	__key_unlink_end(from_keyring, key, from_edit);
+	up_write(&from_keyring->sem);
 out:
 	kleave(" = %d", ret);
 	return ret;
@@ -1678,27 +1659,17 @@ EXPORT_SYMBOL(key_move);
  */
 int keyring_clear(struct key *keyring)
 {
-	struct assoc_array_edit *edit;
-	int ret;
-
 	if (keyring->type != &key_type_keyring)
 		return -ENOTDIR;
 
 	down_write(&keyring->sem);
 
-	edit = assoc_array_clear(&keyring->keys, &keyring_assoc_array_ops);
-	if (IS_ERR(edit)) {
-		ret = PTR_ERR(edit);
-	} else {
-		if (edit)
-			assoc_array_apply_edit(edit);
-		notify_key(keyring, NOTIFY_KEY_CLEARED, 0);
-		key_payload_reserve(keyring, 0);
-		ret = 0;
-	}
+	keyring_remove_all_links(keyring);
+	notify_key(keyring, NOTIFY_KEY_CLEARED, 0);
+	key_payload_reserve(keyring, 0);
 
 	up_write(&keyring->sem);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(keyring_clear);
 
@@ -1709,30 +1680,12 @@ EXPORT_SYMBOL(keyring_clear);
  */
 static void keyring_revoke(struct key *keyring)
 {
-	struct assoc_array_edit *edit;
-
-	edit = assoc_array_clear(&keyring->keys, &keyring_assoc_array_ops);
-	if (!IS_ERR(edit)) {
-		if (edit)
-			assoc_array_apply_edit(edit);
-		key_payload_reserve(keyring, 0);
-	}
+	keyring_remove_all_links(keyring);
+	key_payload_reserve(keyring, 0);
 }
 
-static bool keyring_gc_select_iterator(void *object, void *iterator_data)
+static int keyring_gc_check_iterator(const struct key *key, void *iterator_data)
 {
-	struct key *key = keyring_ptr_to_key(object);
-	time64_t *limit = iterator_data;
-
-	if (key_is_dead(key, *limit))
-		return false;
-	key_get(key);
-	return true;
-}
-
-static int keyring_gc_check_iterator(const void *object, void *iterator_data)
-{
-	const struct key *key = keyring_ptr_to_key(object);
 	time64_t *limit = iterator_data;
 
 	key_check(key);
@@ -1747,6 +1700,8 @@ static int keyring_gc_check_iterator(const void *object, void *iterator_data)
  */
 void keyring_gc(struct key *keyring, time64_t limit)
 {
+	struct keyring_index *links;
+	struct keyring_link *link, *tmp;
 	int result;
 
 	kenter("%x{%s}", keyring->serial, keyring->description ?: "");
@@ -1756,10 +1711,7 @@ void keyring_gc(struct key *keyring, time64_t limit)
 		goto dont_gc;
 
 	/* scan the keyring looking for dead keys */
-	rcu_read_lock();
-	result = assoc_array_iterate(&keyring->keys,
-				     keyring_gc_check_iterator, &limit);
-	rcu_read_unlock();
+	result = keyring_iterate(keyring, keyring_gc_check_iterator, &limit);
 	if (result == true)
 		goto do_gc;
 
@@ -1769,10 +1721,11 @@ void keyring_gc(struct key *keyring, time64_t limit)
 
 do_gc:
 	down_write(&keyring->sem);
-	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
-		       keyring_gc_select_iterator, &limit);
-	key_payload_reserve(keyring,
-			    keyring->keys.nr_leaves_on_tree * KEYQUOTA_LINK_BYTES);
+	links = keyring_index_locked(keyring);
+	list_for_each_entry_safe(link, tmp, &links->all, all_link)
+		if (key_is_dead(keyring_link_key(link), limit))
+			keyring_remove_link(links, link);
+	key_payload_reserve(keyring, links->nr * KEYQUOTA_LINK_BYTES);
 	up_write(&keyring->sem);
 	kleave(" [gc]");
 }
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index fa2bb9f2f538..4da23cf8e447 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -372,7 +372,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key_user *user,
 			       struct key **_key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	struct key *key;
 	key_perm_t perm;
 	key_ref_t key_ref;
-- 
2.47.3

