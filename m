Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621765;
	b=nD9JiiDhGrqWigoOd1EwZ74UhyUYX9jwLA05vypTPKWytglowV1jttkc7RaPdtP/m4p8
	 /iApGJnX9+TbP7CCXdF5TdWEpkSbB8AD1DsvIW0CJ4q6VV0ovyGpexPyR6VLWKf232NSl
	 6HAqvvyxNNInzXf9tJXvmeHpVB6jxd7lN2P+TGprjfXNYNGZdDlAI+ivyUXa+TPtoVDh/
	 9x3OYdsgre4Qqda6MXWFm4fNVWCObdz6IyXnbkg3Z8cL+VD+WSXPV4AHWLFMLLV8LpkDM
	 0016+4mf6gzAjfS+fpBp4ysRTtZsNT52D19akSH3RIK7FGFbETQOyyzqlf7n8tyhyoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WpLDsRwimu47hyRRLvXEi3CARIG877KZeTYZ+fUXXTM=;
	b=r/UvkqqDXAeYNHD2vDCsGk/EuK1hJYfAKwSQN9dCVHNJ2e+f9Gsdh4t7vR4NWHyewDvC
	 mp81FndesLXpSH19v8J9YJ0oy3mfKwT+vaWAZWSELD0MyKL6FbzJY2PA1y+At/hfYC4Sq
	 jXZPgsJUgrHtZa09kDhNHhKEpdDox4QdaVl/2U2zbvVJJch2EmWbFZ0ATubYaYbRFwZae
	 OVzkJ9cOblrqPwQU+LLv5e415YTBYngXRqeIw7qZCWwUCrzJJsLLp+v8/R69HjbKB9FKg
	 eYB2KHwL3lZGu5h6V0I70BkLfDR9LzqshpFTo0g0SbD3bQwoPivpFXwm7MonLQ3dnQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBIHs1WY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E8210606A85F;
	Mon,  2 Nov 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBIHs1WY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0F91C1F0180D;
	Mon,  2 Nov 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621764;
	bh=WpLDsRwimu47hyRRLvXEi3CARIG877KZeTYZ+fUXXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RBIHs1WYf1dV70X/rIm5tCjVH7kgVYJuWKf9jayesFHGELiHhgJllfKeoMgXpdgRO
	 Nrahr5+azRbZW8AbAlcpc4e4j+tLUX6ge+HjbCaRh8f3GNogvwHj0gHmwmxsR4AP8U
	 Xw8LTB8j+vGVscGhMQ6HympVHD/BWAdhsyLfGDMlq2PJF8EkGfsWzuRCvzEkVBRhOy
	 aN19Op4QmA2ImUc0SwPtnOexu4jgQhS86d0gSKXhpMLT7gbTfer6ma4tMUBn87RBly
	 7Z5VaSgxh84hTxdmg6sQb012KV5XL1c05vlgR4h4OC8n3kBOsILFrAOuFttjrou1CD
	 sFYSvhLLAsqYg==
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
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS)
Subject: [RFC PATCH 4/4] KEYS: key_garbage_collector(): process in chunks
Date: Mon,  2 Nov 2026 14:15:15 +0200
Message-ID: <20261102121518.1197453-5-jarkko@kernel.org>
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

key_garbage_collector() has a design that is not resistant enough for
workqueue lockups. The duration scales up relative to the number of items
in the serial tree, which causes a reoccuring theme of being guilty of
causing workqueue lockups.

Resolve the problem by processing in chunks:

1. Declare a static variable key_gc_work, which owns the garbage collection
   in-flight state, and key_schedule_gc_work() for re-scheduling the work.
2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
   of items scanned and destroyed.
3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
   the RCU grace period.
4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
   the continuations.

keygcbench results without the patch:

unused:   min=413.359 avg=1817.240 max=3221.120 var=1970880.024
expired:  min=0.002 avg=1360.124 max=2481.990 var=1055093.994
combined: min=0.002 avg=1542.970 max=3221.120 var=1471557.422

keygcbench results with the patch:

unused:   min=0.005 avg=0.126 max=54.173 var=0.946
expired:  min=0.002 avg=0.210 max=216.470 var=7.894
combined: min=0.002 avg=0.158 max=216.470 var=3.627

These results translate to:

- >99.9% drop in the combined variance.
- 3.0% increase in the total task time.

The value 64 for KEY_GC_CHUNK_SIZE was cherry-picked from the set {1, 2,
..., 1024} by running the benchmark for each chunk size three times.

At the far left variance is 97% lower but at the same time total time
grows by 133%, when compared to the selected chunk size. The size was
picked based on getting a reasonable variance with a minimal throughput
decline.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/package/keygcbench
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/gc.c       | 132 ++++++++++++++++++++++++++-------------
 security/keys/internal.h |   3 +-
 security/keys/key.c      |   4 +-
 security/keys/keyring.c  |   2 +-
 4 files changed, 94 insertions(+), 47 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 876c30c019ad..fc1e5e39b828 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -11,16 +11,27 @@
 #include <keys/keyring-type.h>
 #include "internal.h"
 
-/*
- * Delay between key revocation/expiry in seconds
- */
-unsigned key_gc_delay = 5 * 60;
+#define KEY_GC_CHUNK_SIZE 64
 
 /*
  * Reaper for unused keys.
  */
 static void key_garbage_collector(struct work_struct *work);
-DECLARE_WORK(key_gc_work, key_garbage_collector);
+
+static struct {
+	time64_t start;			/* expiry range start */
+	time64_t end;			/* expiry range end */
+	struct rb_node *cursor;		/* serial tree position */
+	u8 state;			/* state flags */
+	struct work_struct work;	/* work item */
+} key_gc_work = {
+	.work = __WORK_INITIALIZER(key_gc_work.work, key_garbage_collector),
+};
+
+/*
+ * Delay between key revocation/expiry in seconds
+ */
+unsigned int key_gc_delay = 5 * 60;
 
 /*
  * Reaper for links from keyrings to dead keys.
@@ -31,6 +42,23 @@ static DEFINE_TIMER(key_gc_timer, key_gc_timer_func);
 static time64_t key_gc_next_run = TIME64_MAX;
 static unsigned long key_gc_flags;
 #define KEY_GC_KEY_EXPIRED	0	/* A key expired and needs unlinking */
+#define KEY_GC_REAP_REQUESTED	1	/* Another complete pass was requested */
+
+/*
+ * Schedule a new GC pass or re-schedule an ongoing GC pass.
+ */
+void key_schedule_gc_work(bool expired)
+{
+	unsigned long flags = BIT(KEY_GC_REAP_REQUESTED);
+
+	if (expired)
+		flags |= BIT(KEY_GC_KEY_EXPIRED);
+
+	/* Publish all request flags together, after the caller's updates. */
+	set_mask_bits(&key_gc_flags, 0, flags);
+	schedule_work(&key_gc_work.work);
+}
+
 /*
  * Schedule a garbage collection run.
  * - time precision isn't particularly important
@@ -44,7 +72,8 @@ void key_schedule_gc(time64_t gc_at)
 
 	if (gc_at <= now) {
 		kdebug("IMMEDIATE");
-		schedule_work(&key_gc_work);
+		/* Catch expirations that became due during the scan. */
+		key_schedule_gc_work(true);
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run = gc_at;
@@ -66,15 +95,6 @@ void key_set_expiry(struct key *key, time64_t expiry)
 	}
 }
 
-/*
- * Schedule a dead links collection run.
- */
-void key_schedule_gc_links(void)
-{
-	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
-	schedule_work(&key_gc_work);
-}
-
 /*
  * Some key's cleanup time was met after it expired, so we need to get the
  * reaper to go through a cycle finding expired keys.
@@ -83,7 +103,7 @@ static void key_gc_timer_func(struct timer_list *unused)
 {
 	kenter("");
 	key_gc_next_run = TIME64_MAX;
-	key_schedule_gc_links();
+	key_schedule_gc_work(true);
 }
 
 /*
@@ -91,7 +111,9 @@ static void key_gc_timer_func(struct timer_list *unused)
  */
 static noinline void key_gc_unused_keys(struct list_head *keys)
 {
-	while (!list_empty(keys)) {
+	unsigned int chunk = KEY_GC_CHUNK_SIZE;
+
+	while (!list_empty(keys) && chunk--) {
 		struct key *key =
 			list_entry(keys->next, struct key, graveyard_link);
 		struct module *owner = key->type->owner;
@@ -137,35 +159,45 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 static void key_garbage_collector(struct work_struct *work)
 {
 	static LIST_HEAD(graveyard);
-	u8 gc_state = 0;
+	typeof(key_gc_work) *gc = &key_gc_work;
 #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
 #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
+#define KEY_GC_DESTROYING	0x04	/* - We need to destroy keys */
 
-	struct rb_node *cursor;
+	unsigned int chunk = KEY_GC_CHUNK_SIZE;
 	struct key *key;
-	time64_t new_timer, limit, expiry;
+	time64_t expiry;
 
-	kenter("[%lx]", key_gc_flags);
+	kenter("[%lx,%x]", key_gc_flags, gc->state);
 
-	limit = ktime_get_real_seconds();
+	if (gc->state & KEY_GC_DESTROYING)
+		goto destroy_keys;
+	if (gc->cursor) {
+		spin_lock(&key_serial_lock);
+		goto continue_scanning;
+	}
 
+	test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
+	gc->start = ktime_get_real_seconds();
+	gc->state = 0;
 	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
-		gc_state |= KEY_GC_REAPING_LINKS;
-	kdebug("new pass %x", gc_state);
+		gc->state |= KEY_GC_REAPING_LINKS;
+	kdebug("new pass %x", gc->state);
 
-	new_timer = TIME64_MAX;
+	gc->end = TIME64_MAX;
 
 	/* As only this function is permitted to remove things from the key
 	 * serial tree, if cursor is non-NULL then it will always point to a
 	 * valid node in the tree - even if lock got dropped.
 	 */
 	spin_lock(&key_serial_lock);
-	cursor = rb_first(&key_serial_tree);
+	gc->cursor = rb_first(&key_serial_tree);
 
 continue_scanning:
-	while (cursor) {
-		key = rb_entry(cursor, struct key, serial_node);
-		cursor = rb_next(cursor);
+	while (gc->cursor && chunk) {
+		key = rb_entry(gc->cursor, struct key, serial_node);
+		gc->cursor = rb_next(gc->cursor);
+		chunk--;
 
 		if (!test_bit_acquire(KEY_FLAG_USER_ALIVE, &key->flags)) {
 			/* Clobber key->user after final put seen. */
@@ -176,14 +208,14 @@ static void key_garbage_collector(struct work_struct *work)
 		if (expiry != TIME64_MAX) {
 			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
 				expiry += key_gc_delay;
-			if (expiry > limit && expiry < new_timer) {
+			if (expiry > gc->start && expiry < gc->end) {
 				kdebug("will expire %x in %lld",
-				       key_serial(key), key->expiry - limit);
-				new_timer = key->expiry;
+				       key_serial(key), key->expiry - gc->start);
+				gc->end = key->expiry;
 			}
 		}
 
-		if ((gc_state & KEY_GC_REAPING_LINKS) &&
+		if ((gc->state & KEY_GC_REAPING_LINKS) &&
 		    key->type == &key_type_keyring)
 			goto found_keyring;
 
@@ -195,7 +227,11 @@ static void key_garbage_collector(struct work_struct *work)
 	spin_unlock(&key_serial_lock);
 
 maybe_resched:
-	if (cursor) {
+	if (gc->cursor) {
+		if (!chunk) {
+			schedule_work(&key_gc_work.work);
+			return;
+		}
 		cond_resched();
 		spin_lock(&key_serial_lock);
 		goto continue_scanning;
@@ -207,9 +243,9 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 	kdebug("pass complete");
 
-	if (new_timer != TIME64_MAX) {
-		new_timer += key_gc_delay;
-		key_schedule_gc(new_timer);
+	if (gc->end != TIME64_MAX) {
+		gc->end += key_gc_delay;
+		key_schedule_gc(gc->end);
 	}
 
 	if (!list_empty(&graveyard)) {
@@ -220,13 +256,25 @@ static void key_garbage_collector(struct work_struct *work)
 		 */
 		kdebug("gc sync");
 		synchronize_rcu();
+	}
+
+	gc->state |= KEY_GC_DESTROYING;
+
+destroy_keys:
+	if (!list_empty(&graveyard)) {
 		kdebug("gc keys");
 		key_gc_unused_keys(&graveyard);
+		if (!list_empty(&graveyard)) {
+			schedule_work(&key_gc_work.work);
+			return;
+		}
 	}
+	gc->state &= ~KEY_GC_DESTROYING;
 
-	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
-	kleave(" [end %x]", gc_state);
+	if ((gc->state & KEY_GC_REAP_AGAIN) ||
+	    test_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags))
+		schedule_work(&key_gc_work.work);
+	kleave(" [end %x]", gc->state);
 	return;
 
 	/* We found an unreferenced key - once we've removed it from the tree,
@@ -238,7 +286,7 @@ static void key_garbage_collector(struct work_struct *work)
 	spin_unlock(&key_serial_lock);
 
 	list_add_tail(&key->graveyard_link, &graveyard);
-	gc_state |= KEY_GC_REAP_AGAIN;
+	gc->state |= KEY_GC_REAP_AGAIN;
 	goto maybe_resched;
 
 	/* We found a keyring and we need to check the payload for links to
@@ -248,6 +296,6 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 found_keyring:
 	spin_unlock(&key_serial_lock);
-	keyring_gc(key, limit);
+	keyring_gc(key, gc->start);
 	goto maybe_resched;
 }
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 005d609ae2df..976f16baf632 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -161,12 +161,11 @@ extern bool lookup_user_key_possessed(const struct key *key,
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
 
-extern struct work_struct key_gc_work;
 extern unsigned key_gc_delay;
 extern void keyring_gc(struct key *keyring, time64_t limit);
 void key_set_expiry(struct key *key, time64_t expiry);
 extern void key_schedule_gc(time64_t gc_at);
-extern void key_schedule_gc_links(void);
+void key_schedule_gc_work(bool expired);
 
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
diff --git a/security/keys/key.c b/security/keys/key.c
index f396e56d640f..e6569f89cca9 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -679,7 +679,7 @@ void key_put(struct key *key)
 			}
 			/* Mark key as safe for GC after key->user done. */
 			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
-			schedule_work(&key_gc_work);
+			key_schedule_gc_work(false);
 		}
 	}
 }
@@ -1200,7 +1200,7 @@ void key_invalidate(struct key *key)
 		down_write_nested(&key->sem, 1);
 		if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
 			notify_key(key, NOTIFY_KEY_INVALIDATED, 0);
-			key_schedule_gc_links();
+			key_schedule_gc_work(true);
 		}
 		up_write(&key->sem);
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 94a886a84bd6..b2ae7a65b186 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -266,7 +266,7 @@ void key_remove_domain(struct key_tag *domain_tag)
 {
 	domain_tag->removed = true;
 	if (!key_put_tag(domain_tag))
-		key_schedule_gc_links();
+		key_schedule_gc_work(true);
 }
 
 /*
-- 
2.47.3

