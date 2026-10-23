Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758526;
	b=FaLKoMDrXFsUnjWwNoUM3FGmK+zNt/AmbhUJUVIDK9DR9WqN85A59eZf+iGRGDOdTml5
	 I3wthSpAHmgpWLf+0pSKvzdHATR+2SxbOrc3EMEY/yRLrhXIWvQBTj/thpzRZwU070gDt
	 6qE7f7IuQ4BmNaO8zoKUeBmBxM8INmgXIPtOGGJ/37u2tZdAs7S7Yku53aoUBcDAgQ+aI
	 n9ieHInO48UdKeo5uh1SgwOEOcZKPLHfhL2k0HzKmVdH+ljYnHJiDBlw5ypuQaAgwSZCZ
	 8FHYx4BnwsvuhhGqSDaHEt+Wg6RHwoXBVFIQQ4PL/URcxjhrNtGSUjIROahho9NNVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aZv0u4Ct2TsWavBAhSAYeOxZ43kr7eIvCCN6mEjrQhA=;
	b=OoXSSMORXxh9TGFB5zUxkaPLxD5DkjHabd1ZRWK2LPIoItwmhXrsbjcalqqjjReC9JXW
	 x61NS65HYO5hDtDg0OTS/bmOWIPn3qNAXHCb4m60Oh3kcGZkpP76GwWc9aUiPKDyo8gnf
	 W6daxCsiLTVhv/OW0QJbu3gFwy3yt5v8CLSUFGbpgFBdTEbKAFAXBJL3DyKT8g3Q2skEW
	 kUqbPXOSydXjU6WFL459N/pXBMUtiY2sqEu1bcQpaIeVUN22m84h1IuAJRHG7OcVFQxlo
	 jsEMOyjYGJXSNuubNLBomPGWclNRDMF146kcnyKt8xxvcOb7txqVRjgFVzOgWp9HIXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ip/lIfO0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8F0EB606A323;
	Fri, 23 Oct 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ip/lIfO0
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 814B41F01828;
	Fri, 23 Oct 2026 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758525;
	bh=aZv0u4Ct2TsWavBAhSAYeOxZ43kr7eIvCCN6mEjrQhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ip/lIfO01+VwGDusdfZK0yNQYKdZr6efrD+4s8unU2oWHtyQyE8VTVrWwyWS7SHUi
	 ZHFDg1+Jxdnf01aNly+Ut73sHL5KqRRSZaJy/4MZDeBaRtDADnSEFkhWqx+fcB/ypZ
	 QTWmIMswVVNRQ2oNXmOtEpMeJzzNPcPU/6DOTCnDAXW9itf4DFb4IjXrOMEWk0vsly
	 JTg6twvib5lpvYX3u2qt4Rde/G15sorpDufnL7ktjc47o/UIExjZc+1OQW+aM8pahp
	 F9c4N1TJ09K89zck9TlCD3+asFQso8yCQZUvVVutb/ufmycBAPlMKqC99mFRUsZ9zL
	 2sDQ9upp0D53w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 5/6] KEYS: Replace assoc_array with rhashtable
Date: Fri, 23 Oct 2026 15:09:25 +0300
Message-ID: <20261023120953.1206778-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023120953.1206778-1-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keyring subsystem depends on assoc_array for searching keys by their
description, type and domain. It is the sole user of this data structure,
which has during the age of LLMs transformed into a maintenance nightmare.

assoc_array needs to be replaced with a data structure meeting the
following criteria:

1. Must be suitable for a sparse key-value store.
2. Must have multiple in-kernel users.
3. Would be nice if it had dedicated maintainers.

rhashtable is likely the best pick from the available options as it is
designed for a sparse key space, has dedicated maintainers, and multiple
in-kernel users.

assoc_array is replaced with two new data types:

- keyring_index: contains a searchable index of links to keys and an RCU
  protected list for active links, which is used to provide stable walks.
- keyring_link: a keyring node and its contents. Multiple of these can be
  associated with a key as it can belong to multiple keyrings.

assoc_array_edit is substituted with two-element array of keyring_link
pointers with no specific data type defined.

Jenkins hash digest's used by rhashtable are rehashed from the SipHash
digests of search keys and links.

Assisted-by: LLM
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/keys/keyring-type.h |   1 -
 include/linux/key.h         |  19 +-
 security/keys/Kconfig       |   1 -
 security/keys/internal.h    |   9 +-
 security/keys/key.c         |  20 +-
 security/keys/keyring.c     | 860 ++++++++++++++++--------------------
 security/keys/request_key.c |  10 +-
 7 files changed, 408 insertions(+), 512 deletions(-)

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
index df2034fc5436..93fb279b0882 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -17,7 +17,6 @@
 #include <linux/sysctl.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
-#include <linux/assoc_array.h>
 #include <linux/refcount.h>
 #include <linux/time64.h>
 
@@ -107,6 +106,7 @@ struct key_owner;
 struct key_tag;
 struct keyring_list;
 struct keyring_name;
+struct keyring_index;
 
 struct key_tag {
 	struct rcu_head		rcu;
@@ -118,18 +118,7 @@ struct key_tag {
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
@@ -253,7 +242,7 @@ struct key {
 		struct keyring_index_key index_key;
 		struct {
 			unsigned long	hash;
-			unsigned long	len_desc;
+			unsigned int	desc_len;
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
@@ -271,7 +260,7 @@ struct key {
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
index b7b622bc36a1..894461585bfa 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -21,6 +21,7 @@
 #include <linux/vmalloc.h>
 
 struct iovec;
+struct keyring_link;
 
 #ifdef __KDEBUG
 #define kenter(FMT, ...) \
@@ -98,13 +99,13 @@ extern int __key_move_lock(struct key *l_keyring, struct key *u_keyring,
 			   const struct keyring_index_key *index_key);
 extern int __key_link_begin(struct key *keyring,
 			    const struct keyring_index_key *index_key,
-			    struct assoc_array_edit **_edit);
+			    struct keyring_link *_edit[2]);
 extern int __key_link_check_live_key(struct key *keyring, struct key *key);
 extern void __key_link(struct key *keyring, struct key *key,
-		       struct assoc_array_edit **_edit);
+		       struct keyring_link *_edit[2]);
 extern void __key_link_end(struct key *keyring,
 			   const struct keyring_index_key *index_key,
-			   struct assoc_array_edit *edit);
+			   struct keyring_link *edit[2]);
 
 extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 				    const struct keyring_index_key *index_key);
@@ -122,7 +123,7 @@ struct keyring_search_context {
 #define KEYRING_SEARCH_SKIP_EXPIRED	0x0020	/* Ignore expired keys (intention to replace) */
 #define KEYRING_SEARCH_RECURSE		0x0040	/* Search child keyrings also */
 
-	int (*iterator)(const void *object, void *iterator_data);
+	int (*iterator)(const struct key *key, void *iterator_data);
 
 	/* Internal stuff */
 	int			skipped_ret;
diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..57f746b72026 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -430,7 +430,7 @@ static int __key_instantiate_and_link(struct key *key,
 				      struct key_preparsed_payload *prep,
 				      struct key *keyring,
 				      struct key *authkey,
-				      struct assoc_array_edit **_edit)
+				      struct keyring_link *_edit[2])
 {
 	int ret, awaken;
 
@@ -505,7 +505,7 @@ int key_instantiate_and_link(struct key *key,
 			     struct key *authkey)
 {
 	struct key_preparsed_payload prep;
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit[2] = {};
 	int ret;
 
 	memset(&prep, 0, sizeof(prep));
@@ -525,7 +525,7 @@ int key_instantiate_and_link(struct key *key,
 		if (ret < 0)
 			goto error;
 
-		ret = __key_link_begin(keyring, &key->index_key, &edit);
+		ret = __key_link_begin(keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto error_link_end;
 
@@ -539,7 +539,7 @@ int key_instantiate_and_link(struct key *key,
 		}
 	}
 
-	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
+	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, edit);
 
 error_link_end:
 	if (keyring)
@@ -580,7 +580,7 @@ int key_reject_and_link(struct key *key,
 			struct key *keyring,
 			struct key *authkey)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit[2] = {};
 	int ret, awaken, link_ret = 0;
 
 	key_check(key);
@@ -602,7 +602,7 @@ int key_reject_and_link(struct key *key,
 				__key_link_end(keyring, &key->index_key, edit);
 				return -EPERM;
 			}
-			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
+			link_ret = __key_link_begin(keyring, &key->index_key, edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
 		}
@@ -625,7 +625,7 @@ int key_reject_and_link(struct key *key,
 
 		/* and link it into the destination keyring */
 		if (keyring && link_ret == 0)
-			__key_link(keyring, key, &edit);
+			__key_link(keyring, key, edit);
 
 		/* disable the authorisation key */
 		if (authkey)
@@ -825,7 +825,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		.description	= description,
 	};
 	struct key_preparsed_payload prep;
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit[2] = {};
 	const struct cred *cred = current_cred();
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
@@ -886,7 +886,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_free_prep;
 	}
 
-	ret = __key_link_begin(keyring, &index_key, &edit);
+	ret = __key_link_begin(keyring, &index_key, edit);
 	if (ret < 0) {
 		key_ref = ERR_PTR(ret);
 		goto error_link_end;
@@ -953,7 +953,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	/* instantiate it and link it into the target keyring */
-	ret = __key_instantiate_and_link(key, &prep, keyring, NULL, &edit);
+	ret = __key_instantiate_and_link(key, &prep, keyring, NULL, edit);
 	if (ret < 0) {
 		key_put(key);
 		key_ref = ERR_PTR(ret);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4642754db6bf..49373f629803 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -16,10 +16,10 @@
 #include <linux/nsproxy.h>
 #include <linux/once.h>
 #include <linux/random.h>
+#include <linux/rhashtable.h>
 #include <linux/siphash.h>
+#include <linux/workqueue.h>
 #include <keys/keyring-type.h>
-#include <keys/user-type.h>
-#include <linux/assoc_array_priv.h>
 #include <linux/uaccess.h>
 #include <net/net_namespace.h>
 #include "internal.h"
@@ -31,25 +31,159 @@
 #define KEYRING_SEARCH_MAX_DEPTH 6
 
 /*
- * We mark pointers we pass to the associative array with bit 1 set if
- * they're keyrings and clear otherwise.
+ * Keyrings are inserted at the head of @list, other keys at the tail, so
+ * recursive search can stop at the first non-keyring.
  */
-#define KEYRING_PTR_SUBTYPE	0x2UL
+struct keyring_index {
+	struct rhashtable	ht;
+	struct list_head	list;		/* Active keys */
+	unsigned long		nr;		/* Number of active keys */
+	struct rcu_work		rcu_work;
+};
+
+/*
+ * __key_link_begin() inserts new links with @key NULL so allocation happens
+ * before __key_link().  @hash is cached so resizing can hash links while @key
+ * is NULL.
+ */
+struct keyring_link {
+	struct rcu_head		rcu;
+	struct rhash_head	node;
+	struct key __rcu	*key;		/* NULL while inactive */
+	struct list_head	list;
+	u32			hash;
+};
 
-static inline bool keyring_ptr_is_keyring(const struct assoc_array_ptr *x)
+static u32 keyring_hashfn(const void *data, u32 len, u32 seed)
 {
-	return (unsigned long)x & KEYRING_PTR_SUBTYPE;
+	const struct keyring_index_key *index_key = data;
+
+	return jhash_1word(index_key->hash, seed);
 }
-static inline struct key *keyring_ptr_to_key(const struct assoc_array_ptr *x)
+
+static u32 keyring_obj_hashfn(const void *data, u32 len, u32 seed)
 {
-	void *object = assoc_array_ptr_to_leaf(x);
-	return (struct key *)((unsigned long)object & ~KEYRING_PTR_SUBTYPE);
+	const struct keyring_link *link = data;
+
+	return jhash_1word(link->hash, seed);
 }
-static inline void *keyring_key_to_ptr(struct key *key)
+
+static bool keyring_index_key_equal(const struct keyring_index_key *a,
+				    const struct keyring_index_key *b)
 {
-	if (key->type == &key_type_keyring)
-		return (void *)((unsigned long)key | KEYRING_PTR_SUBTYPE);
-	return key;
+	return a->type == b->type &&
+		a->domain_tag == b->domain_tag &&
+		a->desc_len == b->desc_len &&
+		memcmp(a->description, b->description, a->desc_len) == 0;
+}
+
+static int keyring_obj_cmpfn(struct rhashtable_compare_arg *arg,
+			     const void *obj)
+{
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
+static int keyring_iterate(const struct key *keyring,
+			   int (*iterator)(const struct key *key, void *data),
+			   void *data)
+{
+	struct keyring_index *links;
+	struct keyring_link *link;
+	int ret;
+
+	guard(rcu)();
+	links = rcu_dereference(keyring->links);
+	if (links) {
+		list_for_each_entry_rcu(link, &links->list, list) {
+			ret = iterator(keyring_link_key(link), data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void keyring_link_free_rcu(struct rcu_head *rcu)
+{
+	struct keyring_link *link = container_of(rcu, struct keyring_link, rcu);
+
+	key_put(rcu_dereference_raw(link->key));
+	kfree(link);
+}
+
+static void keyring_remove_link(struct keyring_index *links,
+				struct keyring_link *link)
+{
+	WARN_ON(rhashtable_remove_fast(&links->ht, &link->node,
+				       keyring_link_params));
+	list_del_rcu(&link->list);
+	WRITE_ONCE(links->nr, links->nr - 1);
+	call_rcu(&link->rcu, keyring_link_free_rcu);
+}
+
+static void keyring_index_free(struct keyring_index *links)
+{
+	struct keyring_link *link, *tmp;
+
+	rhashtable_destroy(&links->ht);
+	list_for_each_entry_safe(link, tmp, &links->list, list) {
+		key_put(rcu_dereference_protected(link->key, true));
+		kfree(link);
+	}
+
+	kfree(links);
+}
+
+static void keyring_index_free_work(struct work_struct *work)
+{
+	struct keyring_index *links = container_of(to_rcu_work(work),
+						 struct keyring_index, rcu_work);
+
+	keyring_index_free(links);
+}
+
+static void keyring_remove_all_links(struct key *keyring)
+{
+	struct keyring_index *links = keyring_index_locked(keyring);
+
+	if (!links)
+		return;
+	rcu_assign_pointer(keyring->links, NULL);
+	/* rhashtable_destroy() can sleep waiting for resize work. */
+	queue_rcu_work(system_dfl_wq, &links->rcu_work);
 }
 
 static DEFINE_RWLOCK(keyring_name_lock);
@@ -143,7 +277,7 @@ static void keyring_free_preparse(struct key_preparsed_payload *prep)
 static int keyring_instantiate(struct key *keyring,
 			       struct key_preparsed_payload *prep)
 {
-	assoc_array_init(&keyring->keys);
+	RCU_INIT_POINTER(keyring->links, NULL);
 	/* make the keyring available by name if it has one */
 	keyring_publish_name(keyring);
 	return 0;
@@ -175,13 +309,10 @@ static u64 key_index_id(atomic64_t *id)
 }
 
 /*
- * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
- * traversal order, so no part of the index may contain kernel addresses.
+ * Hash a key type, domain and description.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
-	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
-	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
 	static siphash_key_t hash_key __read_mostly;
 	unsigned long hash;
 	u64 acc;
@@ -193,30 +324,19 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
-	if (ASSOC_ARRAY_KEY_CHUNK_SIZE == 32)
+	if (BITS_PER_LONG == 32)
 		hash ^= acc >> 32;
 
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
+ * Finalise an index key to set the domain tag and index IDs, and to calculate
+ * the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
 	static struct key_tag default_domain_tag = { .usage = REFCOUNT_INIT(1), };
-	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
-
-	memcpy(index_key->desc, index_key->description, n);
 
 	if (!index_key->domain_tag) {
 		if (index_key->type->flags & KEY_TYPE_NET_DOMAIN)
@@ -268,150 +388,6 @@ void key_remove_domain(struct key_tag *domain_tag)
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
@@ -423,6 +399,8 @@ static const struct assoc_array_ops keyring_assoc_array_ops = {
  */
 static void keyring_destroy(struct key *keyring)
 {
+	struct keyring_index *links;
+
 	if (keyring->description) {
 		write_lock(&keyring_name_lock);
 
@@ -440,7 +418,18 @@ static void keyring_destroy(struct key *keyring)
 		kfree(keyres);
 	}
 
-	assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
+	links = rcu_dereference_protected(keyring->links, true);
+	if (links)
+		keyring_index_free(links);
+}
+
+static unsigned long keyring_nr_links(const struct key *keyring)
+{
+	const struct keyring_index *links;
+
+	guard(rcu)();
+	links = rcu_dereference(keyring->links);
+	return links ? READ_ONCE(links->nr) : 0;
 }
 
 /**
@@ -449,7 +438,7 @@ static void keyring_destroy(struct key *keyring)
  */
 bool keyring_is_empty(const struct key *keyring)
 {
-	return READ_ONCE(keyring->keys.nr_leaves_on_tree) == 0;
+	return keyring_nr_links(keyring) == 0;
 }
 EXPORT_SYMBOL(keyring_is_empty);
 
@@ -458,14 +447,17 @@ EXPORT_SYMBOL(keyring_is_empty);
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
@@ -477,10 +469,9 @@ struct keyring_read_iterator_context {
 	key_serial_t		*buffer;
 };
 
-static int keyring_read_iterator(const void *object, void *data)
+static int keyring_read_iterator(const struct key *key, void *data)
 {
 	struct keyring_read_iterator_context *ctx = data;
-	const struct key *key = keyring_ptr_to_key(object);
 
 	kenter("{%s,%d},,{%zu/%zu}",
 	       key->type->name, key->serial, ctx->count, ctx->buflen);
@@ -516,8 +507,7 @@ static long keyring_read(const struct key *keyring,
 		ctx.buffer = (key_serial_t *)buffer;
 		ctx.buflen = buflen;
 		ctx.count = 0;
-		ret = assoc_array_iterate(&keyring->keys,
-					  keyring_read_iterator, &ctx);
+		ret = keyring_iterate(keyring, keyring_read_iterator, &ctx);
 		if (ret < 0) {
 			kleave(" = %ld [iterate]", ret);
 			return ret;
@@ -525,7 +515,7 @@ static long keyring_read(const struct key *keyring,
 	}
 
 	/* Return the size of the buffer needed */
-	ret = keyring->keys.nr_leaves_on_tree * sizeof(key_serial_t);
+	ret = keyring_nr_links(keyring) * sizeof(key_serial_t);
 	if (ret <= buflen)
 		kleave("= %ld [ok]", ret);
 	else
@@ -593,10 +583,9 @@ bool key_default_cmp(const struct key *key,
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
 
@@ -663,19 +652,78 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 /*
  * Search inside a keyring for a key.  We can search by walking to it
  * directly based on its index-key or we can iterate over the entire
- * tree looking for it, based on the match function.
+ * list looking for it, based on the match function.
  */
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
+		return ctx->iterator(key, ctx);
+	}
+
+	return keyring_iterate(keyring, ctx->iterator, ctx);
+}
+
+/*
+ * Depth-first search of @keyring and its nested keyrings.
+ */
+static int search_keyring_tree(struct key *keyring,
+			       struct keyring_search_context *ctx, int depth)
+{
+	struct keyring_index *links;
+	struct keyring_link *link;
+	int ret;
 
-		object = assoc_array_find(&keyring->keys,
-					  &keyring_assoc_array_ops,
-					  &ctx->index_key);
-		return object ? ctx->iterator(object, ctx) : 0;
+	if (keyring->flags & ((1 << KEY_FLAG_INVALIDATED) |
+			      (1 << KEY_FLAG_REVOKED)))
+		return 0;
+
+	if (search_keyring(keyring, ctx))
+		goto found;
+
+	if (!(ctx->flags & KEYRING_SEARCH_RECURSE))
+		return 0;
+	links = rcu_dereference(keyring->links);
+	if (!links)
+		return 0;
+
+	list_for_each_entry_rcu(link, &links->list, list) {
+		struct key *key = keyring_link_key(link);
+
+		if (key->type != &key_type_keyring)
+			break;
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
+
+		ret = search_keyring_tree(key, ctx, depth + 1);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			goto found;
 	}
-	return assoc_array_iterate(&keyring->keys, ctx->iterator, ctx);
+
+	return 0;
+
+found:
+	if (!(ctx->flags & KEYRING_SEARCH_NO_UPDATE_TIME))
+		keyring->last_used_at = ctx->now;
+	return 1;
 }
 
 /*
@@ -685,17 +733,7 @@ static int search_keyring(struct key *keyring, struct keyring_search_context *ct
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
@@ -713,9 +751,9 @@ static bool search_nested_keyrings(struct key *keyring,
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
@@ -727,152 +765,11 @@ static bool search_nested_keyrings(struct key *keyring,
 
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
@@ -880,8 +777,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	if (!(ctx->flags & KEYRING_SEARCH_NO_UPDATE_TIME)) {
 		key->last_used_at = ctx->now;
 		keyring->last_used_at = ctx->now;
-		while (sp > 0)
-			stack[--sp].keyring->last_used_at = ctx->now;
 	}
 	kleave(" = true");
 	return true;
@@ -1128,8 +1023,8 @@ EXPORT_SYMBOL(keyring_restrict);
 key_ref_t find_key_to_update(key_ref_t keyring_ref,
 			     const struct keyring_index_key *index_key)
 {
+	struct keyring_link *link;
 	struct key *keyring, *key;
-	const void *object;
 
 	keyring = key_ref_to_ptr(keyring_ref);
 
@@ -1137,17 +1032,16 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 	       keyring->serial, index_key->type->name, index_key->description);
 
 	guard(rcu)();
-	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
-				  index_key);
+	link = keyring_find_link(rcu_dereference(keyring->links), index_key);
 
-	if (object)
+	if (link)
 		goto found;
 
 	kleave(" = NULL");
 	return NULL;
 
 found:
-	key = keyring_ptr_to_key(object);
+	key = keyring_link_key(link);
 	if (key->flags & ((1 << KEY_FLAG_INVALIDATED) |
 			  (1 << KEY_FLAG_REVOKED))) {
 		kleave(" = NULL [x]");
@@ -1217,11 +1111,10 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	return keyring;
 }
 
-static int keyring_detect_cycle_iterator(const void *object,
+static int keyring_detect_cycle_iterator(const struct key *key,
 					 void *iterator_data)
 {
 	struct keyring_search_context *ctx = iterator_data;
-	const struct key *key = keyring_ptr_to_key(object);
 
 	kenter("{%d}", key->serial);
 
@@ -1317,14 +1210,38 @@ int __key_move_lock(struct key *l_keyring, struct key *u_keyring,
 	return 0;
 }
 
+static struct keyring_index *keyring_get_index(struct key *keyring)
+{
+	struct keyring_index *links __free(kfree) =
+		keyring_index_locked(keyring);
+	int ret;
+
+	if (links)
+		return_ptr(links);
+
+	links = kzalloc_obj(struct keyring_index);
+	if (!links)
+		return ERR_PTR(-ENOMEM);
+	ret = rhashtable_init(&links->ht, &keyring_link_params);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	INIT_LIST_HEAD(&links->list);
+	INIT_RCU_WORK(&links->rcu_work, keyring_index_free_work);
+	rcu_assign_pointer(keyring->links, links);
+	return_ptr(links);
+}
+
 /*
  * Preallocate memory so that a key can be linked into to a keyring.
  */
 int __key_link_begin(struct key *keyring,
 		     const struct keyring_index_key *index_key,
-		     struct assoc_array_edit **_edit)
+		     struct keyring_link *_edit[2])
 {
-	struct assoc_array_edit *edit;
+	struct keyring_link *link __free(kfree) = NULL;
+	struct keyring_index *links;
+	struct keyring_link *replace;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1334,39 +1251,48 @@ int __key_link_begin(struct key *keyring,
 	BUG_ON(*_edit != NULL);
 
 	*_edit = NULL;
+	_edit[1] = NULL;
 
 	ret = -EKEYREVOKED;
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
 
+	ret = -ENOMEM;
+	link = kzalloc_obj(struct keyring_link);
+	if (!link)
+		goto error;
+	link->hash = index_key->hash;
+
+	replace = keyring_find_link(links, index_key);
 	/* If we're not replacing a link in-place then we're going to need some
 	 * extra quota.
 	 */
-	if (!edit->dead_leaf) {
+	if (!replace) {
 		ret = key_payload_reserve(keyring,
 					  keyring->datalen + KEYQUOTA_LINK_BYTES);
 		if (ret < 0)
-			goto error_cancel;
+			goto error;
+
+		ret = rhashtable_insert_fast(&links->ht, &link->node,
+					     keyring_link_params);
+		if (ret < 0) {
+			key_payload_reserve(keyring,
+					    keyring->datalen - KEYQUOTA_LINK_BYTES);
+			goto error;
+		}
 	}
 
-	*_edit = edit;
+	_edit[0] = no_free_ptr(link);
+	_edit[1] = replace;
 	kleave(" = 0");
 	return 0;
 
-error_cancel:
-	assoc_array_cancel_edit(edit);
 error:
 	kleave(" = %d", ret);
 	return ret;
@@ -1396,12 +1322,30 @@ int __key_link_check_live_key(struct key *keyring, struct key *key)
  * combination.
  */
 void __key_link(struct key *keyring, struct key *key,
-		struct assoc_array_edit **_edit)
+		struct keyring_link *_edit[2])
 {
+	struct keyring_index *links = keyring_index_locked(keyring);
+	struct keyring_link *link = _edit[0], *old = _edit[1];
+
 	__key_get(key);
-	assoc_array_insert_set_object(*_edit, keyring_key_to_ptr(key));
-	assoc_array_apply_edit(*_edit);
+	rcu_assign_pointer(link->key, key);
+
+	if (old) {
+		WARN_ON(rhashtable_replace_fast(&links->ht, &old->node,
+						&link->node,
+						keyring_link_params));
+		list_replace_rcu(&old->list, &link->list);
+		call_rcu(&old->rcu, keyring_link_free_rcu);
+	} else {
+		if (key->type == &key_type_keyring)
+			list_add_rcu(&link->list, &links->list);
+		else
+			list_add_tail_rcu(&link->list, &links->list);
+		WRITE_ONCE(links->nr, links->nr + 1);
+	}
+
 	*_edit = NULL;
+	_edit[1] = NULL;
 	notify_key(keyring, NOTIFY_KEY_LINKED, key_serial(key));
 }
 
@@ -1412,20 +1356,31 @@ void __key_link(struct key *keyring, struct key *key,
  */
 void __key_link_end(struct key *keyring,
 		    const struct keyring_index_key *index_key,
-		    struct assoc_array_edit *edit)
+		    struct keyring_link *edit[2])
 	__releases(&keyring->sem)
 	__releases(&keyring_serialise_link_lock)
 {
+	struct keyring_link *link = edit[0];
+
 	BUG_ON(index_key->type == NULL);
 	kenter("%d,%s,", keyring->serial, index_key->type->name);
 
-	if (edit) {
-		if (!edit->dead_leaf) {
+	if (link) {
+		if (!edit[1]) {
 			key_payload_reserve(keyring,
 				keyring->datalen - KEYQUOTA_LINK_BYTES);
+			WARN_ON(rhashtable_remove_fast(&keyring_index_locked(keyring)->ht,
+						       &link->node,
+						       keyring_link_params));
+			call_rcu(&link->rcu, keyring_link_free_rcu);
+		} else {
+			kfree(link);
 		}
-		assoc_array_cancel_edit(edit);
+
+		edit[0] = NULL;
+		edit[1] = NULL;
 	}
+
 	up_write(&keyring->sem);
 
 	if (index_key->type == &key_type_keyring)
@@ -1455,9 +1410,9 @@ static int __key_link_check_restriction(struct key *keyring, struct key *key)
  * of the user's key data quota to hold the link.
  *
  * Returns 0 if successful, -ENOTDIR if the keyring isn't a keyring,
- * -EKEYREVOKED if the keyring has been revoked, -ENFILE if the keyring is
- * full, -EDQUOT if there is insufficient key data quota remaining to add
- * another link or -ENOMEM if there's insufficient memory.
+ * -EKEYREVOKED if the keyring has been revoked, -EDQUOT if there is insufficient
+ * key data quota remaining to add another link or -ENOMEM if there's
+ * insufficient memory.
  *
  * It is assumed that the caller has checked that it is permitted for a link to
  * be made (the keyring should have Write permission and the key Link
@@ -1465,7 +1420,7 @@ static int __key_link_check_restriction(struct key *keyring, struct key *key)
  */
 int key_link(struct key *keyring, struct key *key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit[2] = {};
 	int ret;
 
 	kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
@@ -1477,7 +1432,7 @@ int key_link(struct key *keyring, struct key *key)
 	if (ret < 0)
 		goto error;
 
-	ret = __key_link_begin(keyring, &key->index_key, &edit);
+	ret = __key_link_begin(keyring, &key->index_key, edit);
 	if (ret < 0)
 		goto error_end;
 
@@ -1486,7 +1441,7 @@ int key_link(struct key *keyring, struct key *key)
 	if (ret == 0)
 		ret = __key_link_check_live_key(keyring, key);
 	if (ret == 0)
-		__key_link(keyring, key, &edit);
+		__key_link(keyring, key, edit);
 
 error_end:
 	__key_link_end(keyring, &key->index_key, edit);
@@ -1513,27 +1468,21 @@ static int __key_unlink_lock(struct key *keyring)
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
 
@@ -1541,27 +1490,13 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
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
@@ -1571,9 +1506,8 @@ static void __key_unlink_end(struct key *keyring,
  *
  * This function will write-lock the keyring's semaphore.
  *
- * Returns 0 if successful, -ENOTDIR if the keyring isn't a keyring, -ENOENT if
- * the key isn't linked to by the keyring or -ENOMEM if there's insufficient
- * memory.
+ * Returns 0 if successful, -ENOTDIR if the keyring isn't a keyring or -ENOENT if
+ * the key isn't linked to by the keyring.
  *
  * It is assumed that the caller has checked that it is permitted for a link to
  * be removed (the keyring should have Write permission; no permissions are
@@ -1581,7 +1515,7 @@ static void __key_unlink_end(struct key *keyring,
  */
 int key_unlink(struct key *keyring, struct key *key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit = NULL;
 	int ret;
 
 	key_check(keyring);
@@ -1593,8 +1527,8 @@ int key_unlink(struct key *keyring, struct key *key)
 
 	ret = __key_unlink_begin(keyring, key, &edit);
 	if (ret == 0)
-		__key_unlink(keyring, key, &edit);
-	__key_unlink_end(keyring, key, edit);
+		__key_unlink(keyring, key, edit);
+	up_write(&keyring->sem);
 	return ret;
 }
 EXPORT_SYMBOL(key_unlink);
@@ -1614,11 +1548,10 @@ EXPORT_SYMBOL(key_unlink);
  * some of the user's key data quota to hold the link on @to_keyring.
  *
  * Returns 0 if successful, -ENOTDIR if either keyring isn't a keyring,
- * -EKEYREVOKED if either keyring has been revoked, -ENFILE if the second
- * keyring is full, -EDQUOT if there is insufficient key data quota remaining
- * to add another link or -ENOMEM if there's insufficient memory.  If
- * KEYCTL_MOVE_EXCL is set, then -EEXIST will be returned if there's already a
- * matching key in @to_keyring.
+ * -EKEYREVOKED if either keyring has been revoked, -EDQUOT if there is
+ * insufficient key data quota remaining to add another link or -ENOMEM if
+ * there's insufficient memory.  If KEYCTL_MOVE_EXCL is set, then -EEXIST will
+ * be returned if there's already a matching key in @to_keyring.
  *
  * It is assumed that the caller has checked that it is permitted for a link to
  * be made (the keyring should have Write permission and the key Link
@@ -1629,7 +1562,8 @@ int key_move(struct key *key,
 	     struct key *to_keyring,
 	     unsigned int flags)
 {
-	struct assoc_array_edit *from_edit = NULL, *to_edit = NULL;
+	struct keyring_link *from_edit = NULL;
+	struct keyring_link *to_edit[2] = {};
 	int ret;
 
 	kenter("%d,%d,%d", key->serial, from_keyring->serial, to_keyring->serial);
@@ -1647,12 +1581,12 @@ int key_move(struct key *key,
 	ret = __key_unlink_begin(from_keyring, key, &from_edit);
 	if (ret < 0)
 		goto error;
-	ret = __key_link_begin(to_keyring, &key->index_key, &to_edit);
+	ret = __key_link_begin(to_keyring, &key->index_key, to_edit);
 	if (ret < 0)
 		goto error;
 
 	ret = -EEXIST;
-	if (to_edit->dead_leaf && (flags & KEYCTL_MOVE_EXCL))
+	if (to_edit[1] && (flags & KEYCTL_MOVE_EXCL))
 		goto error;
 
 	ret = __key_link_check_restriction(to_keyring, key);
@@ -1662,11 +1596,11 @@ int key_move(struct key *key,
 	if (ret < 0)
 		goto error;
 
-	__key_unlink(from_keyring, key, &from_edit);
-	__key_link(to_keyring, key, &to_edit);
+	__key_unlink(from_keyring, key, from_edit);
+	__key_link(to_keyring, key, to_edit);
 error:
 	__key_link_end(to_keyring, &key->index_key, to_edit);
-	__key_unlink_end(from_keyring, key, from_edit);
+	up_write(&from_keyring->sem);
 out:
 	kleave(" = %d", ret);
 	return ret;
@@ -1683,27 +1617,17 @@ EXPORT_SYMBOL(key_move);
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
 
@@ -1714,30 +1638,12 @@ EXPORT_SYMBOL(keyring_clear);
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
-}
-
-static bool keyring_gc_select_iterator(void *object, void *iterator_data)
-{
-	struct key *key = keyring_ptr_to_key(object);
-	time64_t *limit = iterator_data;
-
-	if (key_is_dead(key, *limit))
-		return false;
-	key_get(key);
-	return true;
+	keyring_remove_all_links(keyring);
+	key_payload_reserve(keyring, 0);
 }
 
-static int keyring_gc_check_iterator(const void *object, void *iterator_data)
+static int keyring_gc_check_iterator(const struct key *key, void *iterator_data)
 {
-	const struct key *key = keyring_ptr_to_key(object);
 	time64_t *limit = iterator_data;
 
 	key_check(key);
@@ -1752,7 +1658,8 @@ static int keyring_gc_check_iterator(const void *object, void *iterator_data)
  */
 void keyring_gc(struct key *keyring, time64_t limit)
 {
-	int result;
+	struct keyring_index *links;
+	struct keyring_link *link, *tmp;
 
 	kenter("%x{%s}", keyring->serial, keyring->description ?: "");
 
@@ -1761,11 +1668,7 @@ void keyring_gc(struct key *keyring, time64_t limit)
 		goto dont_gc;
 
 	/* scan the keyring looking for dead keys */
-	rcu_read_lock();
-	result = assoc_array_iterate(&keyring->keys,
-				     keyring_gc_check_iterator, &limit);
-	rcu_read_unlock();
-	if (result == true)
+	if (keyring_iterate(keyring, keyring_gc_check_iterator, &limit))
 		goto do_gc;
 
 dont_gc:
@@ -1774,8 +1677,13 @@ void keyring_gc(struct key *keyring, time64_t limit)
 
 do_gc:
 	down_write(&keyring->sem);
-	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
-		       keyring_gc_select_iterator, &limit);
+	links = keyring_index_locked(keyring);
+	if (links) {
+		list_for_each_entry_safe(link, tmp, &links->list, list)
+			if (key_is_dead(keyring_link_key(link), limit))
+				keyring_remove_link(links, link);
+	}
+
 	up_write(&keyring->sem);
 	kleave(" [gc]");
 }
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index ef00c2b08fe0..6394c40539ee 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -372,7 +372,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key_user *user,
 			       struct key **_key)
 {
-	struct assoc_array_edit *edit = NULL;
+	struct keyring_link *edit[2] = {};
 	struct key *key;
 	key_perm_t perm;
 	key_ref_t key_ref;
@@ -425,10 +425,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		goto key_already_present;
 
 	if (dest_keyring) {
-		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		ret = __key_link_begin(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_alloc_failed;
-		__key_link(dest_keyring, key, &edit);
+		__key_link(dest_keyring, key, edit);
 	}
 
 	mutex_unlock(&key_construction_mutex);
@@ -446,12 +446,12 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
-		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		ret = __key_link_begin(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_alloc_failed_unlocked;
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
-			__key_link(dest_keyring, key, &edit);
+			__key_link(dest_keyring, key, edit);
 		__key_link_end(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;
-- 
2.47.3

