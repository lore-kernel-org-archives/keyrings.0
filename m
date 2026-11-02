Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621756;
	b=Ay36z5SeJhuHLDzG9M4XYVUyyTBVhEGbugvQicRCprNWiyQle8GWWEuXdnpXWiDGhsVG
	 ZB9YvGzIJyPRCozGOS7f+u8i0TFywqXGUqnvrMQ8izIPw1HTe/+MEHmE+XjsEoW/UgzDF
	 0LCHQmSTxT10jGYTkC4oI+mclb6oaPZnqrRCCBJL9H5P148kYJNqu3XbGJRH9UYEn2dd6
	 rONCnnD/gqTuyjUZlshgrXzjlnqeeKceBLqrJxoXUw7eG6Vrjg8yoVqp/2CRmm0To2t2+
	 jy6lCyCZ1STda82NxplIllysyjNkXl8LOr/MvmuSdm2ztd3sTtRxpWytUKdGo7IepQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621756;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ziyeTvPm3BFDyaFh77swtWkSzgaxNwvlyxfo1cDiP4w=;
	b=Q6EBROV25esrYJsHnt5tq5daISWj22ESS341JUeCiMMPJ9oPJLBWwHTg3o15TCrkJv2l
	 JqmUpLGGJ0A6h6XhESYqEj8QygfqNxZVsBTV49Frm6N3I22YG1VwoEEL4NlauZqYChLUC
	 Z7kf7H+zyV5AYWaRVyNT/md8uB+yhKL8fHqeiCbcnC7vKtnAIHM1jjGx93/mo6g5pBZMA
	 3LuE45Va7BImadL9Dh1jYxVUJBSSs+kLFeBRfT2CKOEcX4eFYKrK+nNPqd0t9P9yUpSxC
	 10yNGti35ougKpiJ+NoI3t+tUdz9bDuaVcR73OKMeOLfoWzDc/IUluip55MyjGWC+5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUDyqcLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0F7860A5BDA;
	Mon,  2 Nov 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUDyqcLV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EC9D01F01801;
	Mon,  2 Nov 2026 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621755;
	bh=ziyeTvPm3BFDyaFh77swtWkSzgaxNwvlyxfo1cDiP4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUDyqcLVneWyI/GRaGpI5vKfldgN3bHImPXBK0SNPauo0RbIsQ0MGYED0OFvWMUmB
	 uREcO0fmmQLUiFakfC+Zht3t262Lv3FJ5FClxsZo/f73TgU8VXYDxrLE2b5nnELdPQ
	 +CerV1ZKEWTMatQUAgZludlWBHtKtSEaU37qAqXWbQXSZSxN7ODykiEiol3atnVQUE
	 sDsuYFDPgOHV75Y2BiqV1FAoZaeG8ONia2VVJb2llso1yFGdxoxzGh1vHoREBUALqN
	 5RNcnGYzb2I+HlFxAc77JV2Aw3jRJgzTDfKfelCTjAF3iGsr55VBCwt5h2Y52ScERF
	 fqPuQZZTfpZ8Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH 2/4] KEYS: Pin the backing module for struct key_type
Date: Mon,  2 Nov 2026 14:15:13 +0200
Message-ID: <20261102121518.1197453-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102121518.1197453-1-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
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
key_gc_unused_keys() and keyring_destroy(). These functions are the entry
points for keys and restrictions.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key-type.h |  6 +++++-
 security/keys/gc.c       |  3 +++
 security/keys/key.c      | 33 ++++++++++++++++++++++-----------
 security/keys/keyring.c  | 32 +++++++++++++++++++++++++-------
 4 files changed, 55 insertions(+), 19 deletions(-)

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
index eda445f815d4..df5c614e4d1d 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/security.h>
 #include <keys/keyring-type.h>
 #include "internal.h"
@@ -137,6 +138,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 	while (!list_empty(keys)) {
 		struct key *key =
 			list_entry(keys->next, struct key, graveyard_link);
+		struct module *owner = key->type->owner;
 		short state = key->state;
 
 		list_del(&key->graveyard_link);
@@ -165,6 +167,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 
 		memzero_explicit(key, sizeof(*key));
 		kmem_cache_free(key_jar, key);
+		module_put(owner);
 	}
 }
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc13710..5ba8810f903d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -234,19 +235,24 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 	key = ERR_PTR(-EINVAL);
 	if (!desc || !*desc)
-		goto error;
+		goto out;
+
+	if (!try_module_get(type->owner)) {
+		key = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	if (type->vet_description) {
 		ret = type->vet_description(desc);
 		if (ret < 0) {
 			key = ERR_PTR(ret);
-			goto error;
+			goto out_put_module;
 		}
 	}
 
 	desclen = strlen(desc);
 	if (desclen >= KEY_MAX_DESC_SIZE)
-		goto error;
+		goto out_put_module;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
@@ -323,8 +329,6 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	refcount_inc(&key->domain_tag->usage);
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
-
-error:
 	return key;
 
 security_error:
@@ -338,7 +342,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 	key_user_put(user);
 	key = ERR_PTR(ret);
-	goto error;
+	goto out_put_module;
 
 no_memory_3:
 	kmem_cache_free(key_jar, key);
@@ -352,13 +356,18 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key_user_put(user);
 no_memory_1:
 	key = ERR_PTR(-ENOMEM);
-	goto error;
+	goto out_put_module;
 
 no_quota:
 	spin_unlock_irqrestore(&user->lock, irqflags);
 	key_user_put(user);
 	key = ERR_PTR(-EDQUOT);
-	goto error;
+
+out_put_module:
+	module_put(type->owner);
+
+out:
+	return key;
 }
 EXPORT_SYMBOL(key_alloc);
 
@@ -1231,18 +1240,20 @@ int generic_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
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
 
+	ktype->owner = owner;
 	memset(&ktype->lock_class, 0, sizeof(ktype->lock_class));
 
 	ret = -EEXIST;
@@ -1264,7 +1275,7 @@ int register_key_type(struct key_type *ktype)
 	up_write(&key_types_sem);
 	return ret;
 }
-EXPORT_SYMBOL(register_key_type);
+EXPORT_SYMBOL(__register_key_type);
 
 /**
  * unregister_key_type - Unregister a type of key.
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5281da9d5bf7..2061fc2022a5 100644
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
@@ -1070,7 +1074,13 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 
 	if (IS_ERR(restrict_link)) {
 		ret = PTR_ERR(restrict_link);
-		goto error;
+		goto out;
+	}
+
+	if (restrict_link->keytype &&
+	    !try_module_get(restrict_link->keytype->owner)) {
+		ret = -ENOENT;
+		goto out_free_restriction;
 	}
 
 	down_write(&keyring->sem);
@@ -1088,12 +1098,20 @@ int keyring_restrict(key_ref_t keyring_ref, const char *type,
 	up_write(&keyring_serialise_restrict_sem);
 	up_write(&keyring->sem);
 
-	if (ret < 0) {
-		key_put(restrict_link->key);
-		kfree(restrict_link);
-	}
+	if (ret < 0)
+		goto out_put_module;
 
-error:
+	goto out;
+
+out_put_module:
+	if (restrict_link->keytype)
+		module_put(restrict_link->keytype->owner);
+
+out_free_restriction:
+	key_put(restrict_link->key);
+	kfree(restrict_link);
+
+out:
 	if (restrict_type)
 		key_type_put(restrict_type);
 
-- 
2.47.3

