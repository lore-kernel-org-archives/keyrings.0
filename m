Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675012;
	b=pv5CCDHGf8OIhaUt/SYUVs3LWAQPr36YGrBb8Pknond5PTWVRe7yrkgJrjlaBYfOFKLA
	 F1eakVHvKCIU1JY2htbOpDeK6WPMTmeChaFhlHOfDghi3VmqLjXimCqsIvNzAKjOTfnU7
	 KWk5zvXD54acSdOpUjVkNzMULCRrX1WTexyG6FQ4AMBz9uU894dFtK7EefZYM8QVyXwzE
	 j0tNeyFPUjQT0r0SK3p0j4vkgrpJJCAIfzoGy2jwm3nI4Qwdt+nbgmSpKXlqOwLpkLxXS
	 pPLqxenn3ZSbugK6Zcw2qJzAI3ALkBlW8K9EewRhXBo/jvpX2bOKSszL848GP11sNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qq29FISM3H40Wc/LRNC9c5tsiEt3Ctry7ArVUrIcrWY=;
	b=chL1ZmT1GEZIEU0b86x35Ia+BVVnt8oYW862or63clz0qmGza00ZaU7VfwyQAe+jgtnx
	 MAAlXw5cIUahlcBTSXYoPN8R6ukJCHlkXIf1wlgtQfgESGjAapPWCQXaoDTEer6iQYrM8
	 r8qEKq2ngzTixOC/9/808SaJNhiiEu9IP5M/D4l0LkEQTdiU4y7w9pUlclbhD/AP2xHmG
	 0G02EF+AK8hiDj0SpCbW4S2Vq356kkW/j54yAzZeGK6o3cY43jgWtNWksnjaiGWwPZaOA
	 ngbv+3Ar8f9/8TIAqXFD/YjXijzABFZaknKubzB7sMSwrQ3zQPz+W13a+cpbsTW79ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kpv7nPpA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AA792606EE80;
	Tue,  3 Nov 2026 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kpv7nPpA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A5C501F00919;
	Tue,  3 Nov 2026 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675011;
	bh=qq29FISM3H40Wc/LRNC9c5tsiEt3Ctry7ArVUrIcrWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kpv7nPpAK1+GpzcdWOj4LONklaJjAikFT2TekvAApGd24fUhG4Xai2hSteYdlNxsL
	 rFK8AKMNZPFoQgrvAebdOljsSVhJQD5UotGGOwhtB3UBJY6eqA0SwHPkMh0tU3yjRr
	 X07HI8NbawPH6b2oCFPfg1OPtg6ayGsJMgADW7RAl6r9SGlbAaMKKA/Zx+VqMc4XFh
	 545bxoSiOpialRGvouu8MDLrk2HrS06Zz7W+5eGSlh3ubgW1V4SUZ3Vnk/dc+UGlwu
	 kakxEifmpH6j5I8GbFP2BFq5OU1v+eTiV4HcZbBGCWKFjAtJVqwyIIns1/qCyXJHVt
	 v0g1/rPvtq2Og==
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
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 10/11] KEYS: Remove key_type_dead
Date: Tue,  3 Nov 2026 05:02:15 +0200
Message-ID: <20261103030226.2685251-11-jarkko@kernel.org>
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

unregister_key_type() no longer needs to retype live keys as keys and
restrictions pin the module while they reference it.

Remove key_type_dead and associated code from the keyring GC.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/gc.c       | 136 ++-------------------------------------
 security/keys/internal.h |   4 --
 security/keys/key.c      |   9 +--
 security/keys/keyring.c  |  50 --------------
 4 files changed, 9 insertions(+), 190 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index f4ae3e57a4be..334b86f2c1ca 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -43,22 +43,8 @@ static void key_gc_timer_func(struct timer_list *);
 static DEFINE_TIMER(key_gc_timer, key_gc_timer_func);
 
 static time64_t key_gc_next_run = TIME64_MAX;
-static struct key_type *key_gc_dead_keytype;
-
 static unsigned long key_gc_flags;
 #define KEY_GC_KEY_EXPIRED	0	/* A key expired and needs unlinking */
-#define KEY_GC_REAP_KEYTYPE	1	/* A keytype is being unregistered */
-#define KEY_GC_REAPING_KEYTYPE	2	/* Cleared when keytype reaped */
-
-
-/*
- * Any key whose type gets unregistered will be re-typed to this if it can't be
- * immediately unlinked.
- */
-struct key_type key_type_dead = {
-	.name = ".dead",
-};
-
 /*
  * Schedule a garbage collection run.
  * - time precision isn't particularly important
@@ -70,7 +56,7 @@ void key_schedule_gc(time64_t gc_at)
 
 	kenter("%lld", gc_at - now);
 
-	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
+	if (gc_at <= now) {
 		kdebug("IMMEDIATE");
 		schedule_work(&key_gc_work);
 	} else if (gc_at < key_gc_next_run) {
@@ -114,36 +100,6 @@ static void key_gc_timer_func(struct timer_list *unused)
 	key_schedule_gc_links();
 }
 
-/*
- * Reap keys of dead type.
- *
- * We use three flags to make sure we see three complete cycles of the garbage
- * collector: the first to mark keys of that type as being dead, the second to
- * collect dead links and the third to clean up the dead keys.  We have to be
- * careful as there may already be a cycle in progress.
- *
- * The caller must be holding key_types_sem.
- */
-void key_gc_keytype(struct key_type *ktype)
-{
-	kenter("%s", ktype->name);
-
-	key_gc_dead_keytype = ktype;
-	set_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-	smp_mb();
-	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
-
-	kdebug("schedule");
-	schedule_work(&key_gc_work);
-
-	kdebug("sleep");
-	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
-		    TASK_UNINTERRUPTIBLE);
-
-	key_gc_dead_keytype = NULL;
-	kleave("");
-}
-
 /*
  * Garbage collect a list of unreferenced, detached keys
  */
@@ -195,30 +151,20 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 static void key_garbage_collector(struct work_struct *work)
 {
 	static LIST_HEAD(graveyard);
-	static u8 gc_state;		/* Internal persistent state */
+	u8 gc_state = 0;
 #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
 #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
-#define KEY_GC_REAPING_DEAD_1	0x10	/* - We need to mark dead keys */
-#define KEY_GC_REAPING_DEAD_2	0x20	/* - We need to reap dead key links */
-#define KEY_GC_REAPING_DEAD_3	0x40	/* - We need to reap dead keys */
-#define KEY_GC_FOUND_DEAD_KEY	0x80	/* - We found at least one dead key */
 
 	struct rb_node *cursor;
 	struct key *key;
 	time64_t new_timer, limit, expiry;
 
-	kenter("[%lx,%x]", key_gc_flags, gc_state);
+	kenter("[%lx]", key_gc_flags);
 
 	limit = ktime_get_real_seconds();
 
-	/* Work out what we're going to be doing in this pass */
-	gc_state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
-	gc_state <<= 1;
 	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
 		gc_state |= KEY_GC_REAPING_LINKS;
-
-	if (test_and_clear_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags))
-		gc_state |= KEY_GC_REAPING_DEAD_1;
 	kdebug("new pass %x", gc_state);
 
 	new_timer = TIME64_MAX;
@@ -240,18 +186,6 @@ static void key_garbage_collector(struct work_struct *work)
 			goto found_unreferenced_key;
 		}
 
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
-			if (key->type == key_gc_dead_keytype) {
-				gc_state |= KEY_GC_FOUND_DEAD_KEY;
-				set_bit(KEY_FLAG_DEAD, &key->flags);
-				key->perm = 0;
-				goto skip_dead_key;
-			} else if (key->type == &key_type_keyring &&
-				   key->restrict_link) {
-				goto found_restricted_keyring;
-			}
-		}
-
 		expiry = key->expiry;
 		if (expiry != TIME64_MAX) {
 			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
@@ -263,21 +197,10 @@ static void key_garbage_collector(struct work_struct *work)
 			}
 		}
 
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2))
-			if (key->type == key_gc_dead_keytype)
-				gc_state |= KEY_GC_FOUND_DEAD_KEY;
-
-		if ((gc_state & KEY_GC_REAPING_LINKS) ||
-		    unlikely(gc_state & KEY_GC_REAPING_DEAD_2)) {
-			if (key->type == &key_type_keyring)
-				goto found_keyring;
-		}
-
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3))
-			if (key->type == key_gc_dead_keytype)
-				goto destroy_dead_key;
+		if ((gc_state & KEY_GC_REAPING_LINKS) &&
+		    key->type == &key_type_keyring)
+			goto found_keyring;
 
-	skip_dead_key:
 		if (spin_is_contended(&key_serial_lock) || need_resched())
 			goto contended;
 	}
@@ -303,8 +226,7 @@ static void key_garbage_collector(struct work_struct *work)
 		key_schedule_gc(new_timer);
 	}
 
-	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
-	    !list_empty(&graveyard)) {
+	if (!list_empty(&graveyard)) {
 		/* Make sure that all pending keyring payload destructions are
 		 * fulfilled and that people aren't now looking at dead or
 		 * dying keys that they don't have a reference upon or a link
@@ -312,32 +234,10 @@ static void key_garbage_collector(struct work_struct *work)
 		 */
 		kdebug("gc sync");
 		synchronize_rcu();
-	}
-
-	if (!list_empty(&graveyard)) {
 		kdebug("gc keys");
 		key_gc_unused_keys(&graveyard);
 	}
 
-	if (unlikely(gc_state & (KEY_GC_REAPING_DEAD_1 |
-				 KEY_GC_REAPING_DEAD_2))) {
-		if (!(gc_state & KEY_GC_FOUND_DEAD_KEY)) {
-			/* No remaining dead keys: short circuit the remaining
-			 * keytype reap cycles.
-			 */
-			kdebug("dead short");
-			gc_state &= ~(KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2);
-			gc_state |= KEY_GC_REAPING_DEAD_3;
-		} else {
-			gc_state |= KEY_GC_REAP_AGAIN;
-		}
-	}
-
-	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
-		kdebug("dead wake");
-		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-	}
-
 	if (gc_state & KEY_GC_REAP_AGAIN)
 		schedule_work(&key_gc_work);
 	kleave(" [end %x]", gc_state);
@@ -355,14 +255,6 @@ static void key_garbage_collector(struct work_struct *work)
 	gc_state |= KEY_GC_REAP_AGAIN;
 	goto maybe_resched;
 
-	/* We found a restricted keyring and need to update the restriction if
-	 * it is associated with the dead key type.
-	 */
-found_restricted_keyring:
-	spin_unlock(&key_serial_lock);
-	keyring_restriction_gc(key, key_gc_dead_keytype);
-	goto maybe_resched;
-
 	/* We found a keyring and we need to check the payload for links to
 	 * dead or expired keys.  We don't flag another reap immediately as we
 	 * have to wait for the old payload to be destroyed by RCU before we
@@ -372,18 +264,4 @@ static void key_garbage_collector(struct work_struct *work)
 	spin_unlock(&key_serial_lock);
 	keyring_gc(key, limit);
 	goto maybe_resched;
-
-	/* We found a dead key that is still referenced.  Reset its type and
-	 * destroy its payload with its semaphore held.
-	 */
-destroy_dead_key:
-	spin_unlock(&key_serial_lock);
-	kdebug("destroy key %d", key->serial);
-	down_write(&key->sem);
-	key->type = &key_type_dead;
-	if (key_gc_dead_keytype->destroy)
-		key_gc_dead_keytype->destroy(key);
-	memset(&key->payload, KEY_DESTROY, sizeof(key->payload));
-	up_write(&key->sem);
-	goto maybe_resched;
 }
diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..005d609ae2df 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -38,7 +38,6 @@ struct iovec;
 	no_printk(KERN_DEBUG FMT"\n", ##__VA_ARGS__)
 #endif
 
-extern struct key_type key_type_dead;
 extern struct key_type key_type_user;
 extern struct key_type key_type_logon;
 
@@ -165,12 +164,9 @@ extern void key_change_session_keyring(struct callback_head *twork);
 extern struct work_struct key_gc_work;
 extern unsigned key_gc_delay;
 extern void keyring_gc(struct key *keyring, time64_t limit);
-extern void keyring_restriction_gc(struct key *keyring,
-				   struct key_type *dead_type);
 void key_set_expiry(struct key *key, time64_t expiry);
 extern void key_schedule_gc(time64_t gc_at);
 extern void key_schedule_gc_links(void);
-extern void key_gc_keytype(struct key_type *ktype);
 
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
diff --git a/security/keys/key.c b/security/keys/key.c
index 0b2a03c511e5..df6af8066212 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1294,18 +1294,14 @@ EXPORT_SYMBOL(__register_key_type);
  * unregister_key_type - Unregister a type of key.
  * @ktype: The key type.
  *
- * Unregister a key type and mark all the extant keys of this type as dead.
- * Those keys of this type are then destroyed to get rid of their payloads and
- * they and their links will be garbage collected as soon as possible.
+ * Unregister a key type.
  */
 void unregister_key_type(struct key_type *ktype)
 {
 	down_write(&key_types_sem);
 	list_del_init(&ktype->link);
-	downgrade_write(&key_types_sem);
-	key_gc_keytype(ktype);
 	pr_notice("Key type %s unregistered\n", ktype->name);
-	up_read(&key_types_sem);
+	up_write(&key_types_sem);
 }
 EXPORT_SYMBOL(unregister_key_type);
 
@@ -1320,7 +1316,6 @@ void __init key_init(void)
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
-	list_add_tail(&key_type_dead.link, &key_types_list);
 	list_add_tail(&key_type_user.link, &key_types_list);
 	list_add_tail(&key_type_logon.link, &key_types_list);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1561406b68fa..294b13829d88 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1790,53 +1790,3 @@ void keyring_gc(struct key *keyring, time64_t limit)
 	up_write(&keyring->sem);
 	kleave(" [gc]");
 }
-
-/*
- * Garbage collect restriction pointers from a keyring.
- *
- * Keyring restrictions are associated with a key type, and must be cleaned
- * up if the key type is unregistered. The restriction is altered to always
- * reject additional keys so a keyring cannot be opened up by unregistering
- * a key type.
- *
- * Not called with any keyring locks held. The keyring's key struct will not
- * be deallocated under us as only our caller may deallocate it.
- *
- * The caller is required to hold key_types_sem and dead_type->sem. This is
- * fulfilled by key_gc_keytype() holding the locks on behalf of
- * key_garbage_collector(), which it invokes on a workqueue.
- */
-void keyring_restriction_gc(struct key *keyring, struct key_type *dead_type)
-{
-	struct key_restriction *keyres;
-
-	kenter("%x{%s}", keyring->serial, keyring->description ?: "");
-
-	/*
-	 * keyring->restrict_link is only assigned at key allocation time
-	 * or with the key type locked, so the only values that could be
-	 * concurrently assigned to keyring->restrict_link are for key
-	 * types other than dead_type. Given this, it's ok to check
-	 * the key type before acquiring keyring->sem.
-	 */
-	if (!dead_type || !keyring->restrict_link ||
-	    keyring->restrict_link->keytype != dead_type) {
-		kleave(" [no restriction gc]");
-		return;
-	}
-
-	/* Lock the keyring to ensure that a link is not in progress */
-	down_write(&keyring->sem);
-
-	keyres = keyring->restrict_link;
-
-	keyres->check = restrict_link_reject;
-
-	key_put(keyres->key);
-	keyres->key = NULL;
-	keyres->keytype = NULL;
-
-	up_write(&keyring->sem);
-
-	kleave(" [restriction gc]");
-}
-- 
2.47.3

