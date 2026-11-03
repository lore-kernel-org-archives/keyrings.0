Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675007;
	b=asdG7Srv7q+z81hpaIaqKKq80mq8MBVB1TN0aB7miPe3jsU9Vk0XFhe5IqRf0Rli9LqC
	 fWnGgeHYt8cmOAGSSHN1h+AlAMt+UDkBQuD4HRRiV/1Uc4bRsP0ERPEFJDng1UawfXAy9
	 jZxFCwlZLBBpYx+n3R/YevgCM/0hw2kFFD7aNXB/+kMvmgciNbJZ5Ku0mwsS/y0ycKCKe
	 V/Yq4oLmojFfibxug4O1dwV6mqHYe0U6/jCWo1vYpEH3PRDfoyp4GVS37VURHk+g3cXVB
	 EDykfNh7qeZRmAqoJV6WCwxo6rrg8y6BsuPPUoFck2wO9W7LS7eO+E5oB72EH0lTD1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Uqw+5mlwITbWQBp+QPEhRs9ar6zOfcGAmPDQLIQUXow=;
	b=aZTnH5AZU7DJAPFKcHwCD5rXLYkLr5q9dQvNIPy+DTGGhsc+9p4FulogViShBHFk/qgC
	 smM4707oXTIeGHSxYKhmiuzBwT42PMGsLjWoTeHicTXKuqbu82jLwDwyvwYW/Yu8O48w/
	 cNBX3+pMLRH3yiAca9xDqtzfpN7UyAk3TzqwhFObcwPPIPuh+mmIiJxmOMzupRJAvPG21
	 xG25aWgxP2O1G66WO1AFCUnNP1+fx3vSEL7A2HQ4KKHlIsW3UtAQVGC+27FIqnImXOhoL
	 DAVMAvrFTZ6VSXneiOG/RODHb37bnwflkVNcHDa1N8n1pHn8/Xvd3aEmcAUUPE1Sw1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7cX7w9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B36B4606D826;
	Tue,  3 Nov 2026 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7cX7w9m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BBF3B1F00A1A;
	Tue,  3 Nov 2026 03:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675006;
	bh=Uqw+5mlwITbWQBp+QPEhRs9ar6zOfcGAmPDQLIQUXow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K7cX7w9md7w4IY06caeSyAp8ndjv1JWxlzXMmM54qmdBYP0qh5GUkf3s15/v8tbUN
	 bTiitpxKWkIrLn2Sde7EFjGqJ7FnxiwWdt2Fw+M5/K/1NaVRmgDWZq7+HBgbwR9roa
	 88DRtwrjdQao7wqpVohWY4iHXluxE+X7FcGEpZgyrm1jGkrhbDykOh2q2l+BtFQ/WC
	 MVGLAz3uoqdfECY+5OKB3doLKzMGfkdL0GoRHz608UvQ6trTNSwOooMjhFODstVz3C
	 A2MS/LomsVfWaLEmkfS9Bz4/j436Cs6C5dMB++y67vQZ8GveVABKLSEohhrpgmJDr6
	 nuh/Y3ZsNavWQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH v2 09/11] KEYS: Pin the backing kernel module for a key type
Date: Tue,  3 Nov 2026 05:02:14 +0200
Message-ID: <20261103030226.2685251-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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

Add the owner field (populated with THIS_MODULE) to struct key_type.

Pin the module in key_alloc() and keyring_restrict(), and release it in
key_gc_unused_keys() and keyring_destroy(), which are wires to the keys
and restrictions.

Reject module owners still in MODULE_STATE_COMING so that the failed
module_init() paths cannot leave behind referenced keys.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key-type.h |  6 ++++-
 security/keys/gc.c       |  3 +++
 security/keys/key.c      | 48 ++++++++++++++++++++++++++++++----------
 security/keys/keyring.c  | 33 ++++++++++++++++++++++-----
 4 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index c4f329b6ae3f..9ecec31ad571 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -10,9 +10,11 @@
 
 #include <linux/key.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_KEYS
 
+struct module;
 struct kernel_pkey_query;
 struct kernel_pkey_params;
 
@@ -161,6 +163,7 @@ struct key_type {
 				     const void *in, const void *in2);
 
 	/* internal fields */
+	struct module		*owner;
 	atomic64_t		index_id;	/* Opaque keyring index ID */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
@@ -168,7 +171,8 @@ struct key_type {
 
 extern struct key_type key_type_keyring;
 
-extern int register_key_type(struct key_type *ktype);
+int __register_key_type(struct key_type *ktype, struct module *owner);
+#define register_key_type(ktype) __register_key_type(ktype, THIS_MODULE)
 extern void unregister_key_type(struct key_type *ktype);
 
 extern int key_payload_reserve(struct key *key, size_t datalen);
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3cfbf00085b3..f4ae3e57a4be 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/security.h>
 #include <keys/keyring-type.h>
 #include "internal.h"
@@ -151,6 +152,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 	while (!list_empty(keys)) {
 		struct key *key =
 			list_entry(keys->next, struct key, graveyard_link);
+		struct module *owner = key->type->owner;
 		short state = key->state;
 
 		list_del(&key->graveyard_link);
@@ -179,6 +181,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 
 		memzero_explicit(key, sizeof(*key));
 		kmem_cache_free(key_jar, key);
+		module_put(owner);
 	}
 }
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc13710..0b2a03c511e5 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -234,19 +235,34 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 	key = ERR_PTR(-EINVAL);
 	if (!desc || !*desc)
-		goto error;
+		goto out;
+
+	/* Failed module initialization ignores outstanding module references. */
+	if ((type->owner && module_is_coming(type->owner)) ||
+	    !try_module_get(type->owner)) {
+		key = ERR_PTR(-ENOENT);
+		goto out;
+	}
+
+	if (restrict_link && restrict_link->keytype &&
+	    ((restrict_link->keytype->owner &&
+	      module_is_coming(restrict_link->keytype->owner)) ||
+	     !try_module_get(restrict_link->keytype->owner))) {
+		key = ERR_PTR(-ENOENT);
+		goto out_put_module;
+	}
 
 	if (type->vet_description) {
 		ret = type->vet_description(desc);
 		if (ret < 0) {
 			key = ERR_PTR(ret);
-			goto error;
+			goto out_put_restrict_module;
 		}
 	}
 
 	desclen = strlen(desc);
 	if (desclen >= KEY_MAX_DESC_SIZE)
-		goto error;
+		goto out_put_restrict_module;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
@@ -323,8 +339,6 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	refcount_inc(&key->domain_tag->usage);
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
-
-error:
 	return key;
 
 security_error:
@@ -338,7 +352,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 	key_user_put(user);
 	key = ERR_PTR(ret);
-	goto error;
+	goto out_put_restrict_module;
 
 no_memory_3:
 	kmem_cache_free(key_jar, key);
@@ -352,13 +366,22 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key_user_put(user);
 no_memory_1:
 	key = ERR_PTR(-ENOMEM);
-	goto error;
+	goto out_put_restrict_module;
 
 no_quota:
 	spin_unlock_irqrestore(&user->lock, irqflags);
 	key_user_put(user);
 	key = ERR_PTR(-EDQUOT);
-	goto error;
+
+out_put_restrict_module:
+	if (restrict_link && restrict_link->keytype)
+		module_put(restrict_link->keytype->owner);
+
+out_put_module:
+	module_put(type->owner);
+
+out:
+	return key;
 }
 EXPORT_SYMBOL(key_alloc);
 
@@ -1231,19 +1254,20 @@ int generic_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
 EXPORT_SYMBOL(generic_key_instantiate);
 
 /**
- * register_key_type - Register a type of key.
+ * __register_key_type - Register a type of key.
  * @ktype: The new key type.
+ * @owner: Module owning the key type.
  *
  * Register a new key type.
  *
  * Returns 0 on success or -EEXIST if a type of this name already exists.
  */
-int register_key_type(struct key_type *ktype)
+int __register_key_type(struct key_type *ktype, struct module *owner)
 {
 	struct key_type *p;
 	int ret;
 
-	memset(&ktype->lock_class, 0, sizeof(ktype->lock_class));
+	ktype->owner = owner;
 
 	ret = -EEXIST;
 	down_write(&key_types_sem);
@@ -1264,7 +1288,7 @@ int register_key_type(struct key_type *ktype)
 	up_write(&key_types_sem);
 	return ret;
 }
-EXPORT_SYMBOL(register_key_type);
+EXPORT_SYMBOL(__register_key_type);
 
 /**
  * unregister_key_type - Unregister a type of key.
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5281da9d5bf7..1561406b68fa 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/security.h>
@@ -436,6 +437,9 @@ static void keyring_destroy(struct key *keyring)
 	if (keyring->restrict_link) {
 		struct key_restriction *keyres = keyring->restrict_link;
 
+		if (keyres->keytype)
+			module_put(keyres->keytype->owner);
+
 		key_put(keyres->key);
 		kfree(keyres);
 	}
@@ -1062,7 +1066,7 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 
 		if (!restrict_type->lookup_restriction) {
 			ret = -ENOENT;
-			goto error;
+			goto out;
 		}
 
 		restrict_link = restrict_type->lookup_restriction(restriction);
@@ -1070,7 +1074,15 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 
 	if (IS_ERR(restrict_link)) {
 		ret = PTR_ERR(restrict_link);
-		goto error;
+		goto out;
+	}
+
+	if (restrict_link && restrict_link->keytype &&
+	    ((restrict_link->keytype->owner &&
+	      module_is_coming(restrict_link->keytype->owner)) ||
+	     !try_module_get(restrict_link->keytype->owner))) {
+		ret = -ENOENT;
+		goto out_free_restriction;
 	}
 
 	down_write(&keyring->sem);
@@ -1088,12 +1100,21 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 	up_write(&keyring_serialise_restrict_sem);
 	up_write(&keyring->sem);
 
-	if (ret < 0) {
+	if (ret < 0)
+		goto out_put_module;
+
+	goto out;
+
+out_put_module:
+	if (restrict_link && restrict_link->keytype)
+		module_put(restrict_link->keytype->owner);
+
+out_free_restriction:
+	if (restrict_link)
 		key_put(restrict_link->key);
-		kfree(restrict_link);
-	}
+	kfree(restrict_link);
 
-error:
+out:
 	if (restrict_type)
 		key_type_put(restrict_type);
 
-- 
2.47.3

