Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145518;
	b=uEXGkxHTpzNTrR8ULeDIyMypriGDDlAlp692AZ3XXiPXErNQmMbuBPpeYP/CNiQo73TY
	 KAgGfJdYpt5yxaH79daclDsddcNRr4gRg0lD9LEL4Ld1BzU4JKTKKf++hcpxTUTJcmXzO
	 V7mW2UpyzNN+8kn2vOCGXhWR4oO60/csvaiX92rnto6XGtFBNezhaoeQ6jvm50TIj57cr
	 FpUVe/CoojXaVlt3QZjNGLluEH1wGeYwvx8DncvG5IBfMtsb1NA5jvUokDd8KoV45wcXt
	 XTDY/cBx8LpEbxMIbD30B8tzXPs6mwFBRV/HJnuoD2hhe8SVKIFQAUOwZvQMwJIWx9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pQJUx6ypc4o3F5G0O5gXjuGEsgo3kc1pWgICLX0mtuM=;
	b=tZY5P85GxMgR044X0CeF26RaHXaGwWvhcBp+jgT1ZFCBv+JDYZT3/SLZdlvt3ZXEQABb
	 ABH9dRge1sMVO5X6xaKlZMW1t4lJYJ/iuyGLFjvDuuaRiXc2kAE8k0LWY8q7qN3i+kXeM
	 vwfccfPzpThBF5OtWZFhCK79gKUcqQcIuQ6cGZCMYlScyA5/7eYIzeJ94xNh3d0Uw/pBE
	 p/oo7TpDl7P3P/bsffqMxjYzjnnOUwJtKrMwXHfrFuiCa11tsgMMVwYh1gLpz8VHqT9sq
	 3nmoVQZfNq9yD59ntrL6d4ewFkKj8WEFjXHsEL4HnelYeBasIjZRCZnxYcpyWozG1tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VX3zSGD+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9BC6E606A31A;
	Tue, 27 Oct 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VX3zSGD+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A88F31F01825;
	Tue, 27 Oct 2026 23:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145517;
	bh=pQJUx6ypc4o3F5G0O5gXjuGEsgo3kc1pWgICLX0mtuM=;
	h=From:To:Cc:Subject:Date;
	b=VX3zSGD+NG3YsQtyuFeRp6qn9QUdUxg+2Dy7tRrTYY8bi2M2M2ckXzjm+f86Gqlui
	 Yu/0jqvwV2yJwbPsYuv7SFD4FL2O725zhpePfVuFxDFwOxVDI27lHf0b8N67sBJ2Bt
	 wSNx43Jmrs170ne4gdcp15pTYH82rjjJYYlNDDAsC9ztmgWYtiGhs0mWFlEHXfcHJW
	 r7RU/jxWw/ggIh++nCTeMa6G5Jy9cyPN3d2IqyasABoACQY2NTM/V86iM6KAoYqUYD
	 Jx33CUpSbjisj/yIFYWLuQ6pD4yhY2JOUJGkZdvLS9uJG1Oz0bG/kTbPyfbhLpn+55
	 TQDmoqEQIt9Xw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: key_garbage_collector(): process in chunks
Date: Wed, 28 Oct 2026 01:58:19 +0200
Message-ID: <20261027235820.2002072-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
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
2. Define KEY_GC_CHUNK_SIZE, set to 1024 keys, as the bound for the number
   of items scanned and destroyed.
3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
   the RCU grace period. Drain the graveyard before advancing key-type
   reaping.
4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
   the continuations.

The following test was performed:

1. Add 499995 "unused" keys.
2. Add 499994 "expiring" keys i.e., keys with expiration times.
3. Clear the first keyring.
4. Wait for the timeouts expire from the second.

When tested with QEMU using x86-64 and aarch64 (emulated) architectures the
elapsed the results were the following:

- x86-64: chunk max: 125 ms, total increase: 5%
- aarch64: chunk max: 235 ms, total increase: 6%

Tests were performed using a laptop with AMD 4650U Zen 2 archtitecture CPU.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/gc.c       | 111 +++++++++++++++++++++++++++++----------
 security/keys/internal.h |   1 -
 security/keys/key.c      |   2 +-
 3 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d4..54a805b01ef5 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -10,16 +10,27 @@
 #include <keys/keyring-type.h>
 #include "internal.h"
 
-/*
- * Delay between key revocation/expiry in seconds
- */
-unsigned key_gc_delay = 5 * 60;
+#define KEY_GC_CHUNK_SIZE 1024
 
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
@@ -34,6 +45,7 @@ static unsigned long key_gc_flags;
 #define KEY_GC_KEY_EXPIRED	0	/* A key expired and needs unlinking */
 #define KEY_GC_REAP_KEYTYPE	1	/* A keytype is being unregistered */
 #define KEY_GC_REAPING_KEYTYPE	2	/* Cleared when keytype reaped */
+#define KEY_GC_REAP_REQUESTED	3	/* Another complete pass was requested */
 
 
 /*
@@ -44,6 +56,20 @@ struct key_type key_type_dead = {
 	.name = ".dead",
 };
 
+/*
+ * Schedule a new GC pass or re-schedule an ongoing GC pass.
+ */
+static void key_schedule_gc_work(void)
+{
+	/*
+	 * Order caller updates before setting KEY_GC_REAP_REQUESTED, given that
+	 * set_bit() is unordered.
+	 */
+	smp_mb__before_atomic();
+	set_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
+	schedule_work(&key_gc_work.work);
+}
+
 /*
  * Schedule a garbage collection run.
  * - time precision isn't particularly important
@@ -57,7 +83,7 @@ void key_schedule_gc(time64_t gc_at)
 
 	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
-		schedule_work(&key_gc_work);
+		key_schedule_gc_work();
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run = gc_at;
@@ -85,7 +111,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
 void key_schedule_gc_links(void)
 {
 	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
-	schedule_work(&key_gc_work);
+	key_schedule_gc_work();
 }
 
 /*
@@ -119,7 +145,7 @@ void key_gc_keytype(struct key_type *ktype)
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
 
 	kdebug("schedule");
-	schedule_work(&key_gc_work);
+	key_schedule_gc_work();
 
 	kdebug("sleep");
 	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
@@ -134,7 +160,9 @@ void key_gc_keytype(struct key_type *ktype)
  */
 static noinline void key_gc_unused_keys(struct list_head *keys)
 {
-	while (!list_empty(keys)) {
+	unsigned int chunk = KEY_GC_CHUNK_SIZE;
+
+	while (!list_empty(keys) && chunk--) {
 		struct key *key =
 			list_entry(keys->next, struct key, graveyard_link);
 		short state = key->state;
@@ -178,21 +206,31 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 static void key_garbage_collector(struct work_struct *work)
 {
 	static LIST_HEAD(graveyard);
-	static u8 gc_state;		/* Internal persistent state */
+	typeof(key_gc_work) *gc = &key_gc_work;
+	u8 gc_state = gc->state;
 #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
 #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
+#define KEY_GC_DESTROYING	0x04	/* - We need to destroy keys */
 #define KEY_GC_REAPING_DEAD_1	0x10	/* - We need to mark dead keys */
 #define KEY_GC_REAPING_DEAD_2	0x20	/* - We need to reap dead key links */
 #define KEY_GC_REAPING_DEAD_3	0x40	/* - We need to reap dead keys */
 #define KEY_GC_FOUND_DEAD_KEY	0x80	/* - We found at least one dead key */
 
-	struct rb_node *cursor;
+	unsigned int chunk = KEY_GC_CHUNK_SIZE;
 	struct key *key;
-	time64_t new_timer, limit, expiry;
+	time64_t expiry;
 
 	kenter("[%lx,%x]", key_gc_flags, gc_state);
 
-	limit = ktime_get_real_seconds();
+	if (gc_state & KEY_GC_DESTROYING)
+		goto destroy_keys;
+	if (gc->cursor) {
+		spin_lock(&key_serial_lock);
+		goto continue_scanning;
+	}
+
+	test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
+	gc->start = ktime_get_real_seconds();
 
 	/* Work out what we're going to be doing in this pass */
 	gc_state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
@@ -204,19 +242,20 @@ static void key_garbage_collector(struct work_struct *work)
 		gc_state |= KEY_GC_REAPING_DEAD_1;
 	kdebug("new pass %x", gc_state);
 
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
@@ -239,10 +278,10 @@ static void key_garbage_collector(struct work_struct *work)
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
 
@@ -269,7 +308,12 @@ static void key_garbage_collector(struct work_struct *work)
 	spin_unlock(&key_serial_lock);
 
 maybe_resched:
-	if (cursor) {
+	if (gc->cursor) {
+		if (!chunk) {
+			gc->state = gc_state;
+			schedule_work(&key_gc_work.work);
+			return;
+		}
 		cond_resched();
 		spin_lock(&key_serial_lock);
 		goto continue_scanning;
@@ -281,9 +325,9 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 	kdebug("pass complete");
 
-	if (new_timer != TIME64_MAX) {
-		new_timer += key_gc_delay;
-		key_schedule_gc(new_timer);
+	if (gc->end != TIME64_MAX) {
+		gc->end += key_gc_delay;
+		key_schedule_gc(gc->end);
 	}
 
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
@@ -297,10 +341,19 @@ static void key_garbage_collector(struct work_struct *work)
 		synchronize_rcu();
 	}
 
+	gc_state |= KEY_GC_DESTROYING;
+
+destroy_keys:
 	if (!list_empty(&graveyard)) {
 		kdebug("gc keys");
 		key_gc_unused_keys(&graveyard);
+		if (!list_empty(&graveyard)) {
+			gc->state = gc_state;
+			schedule_work(&key_gc_work.work);
+			return;
+		}
 	}
+	gc_state &= ~KEY_GC_DESTROYING;
 
 	if (unlikely(gc_state & (KEY_GC_REAPING_DEAD_1 |
 				 KEY_GC_REAPING_DEAD_2))) {
@@ -321,8 +374,10 @@ static void key_garbage_collector(struct work_struct *work)
 		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}
 
-	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
+	gc->state = gc_state;
+	if ((gc_state & KEY_GC_REAP_AGAIN) ||
+	    test_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags))
+		schedule_work(&key_gc_work.work);
 	kleave(" [end %x]", gc_state);
 	return;
 
@@ -353,7 +408,7 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 found_keyring:
 	spin_unlock(&key_serial_lock);
-	keyring_gc(key, limit);
+	keyring_gc(key, gc->start);
 	goto maybe_resched;
 
 	/* We found a dead key that is still referenced.  Reset its type and
diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..cca936f5015d 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -162,7 +162,6 @@ extern bool lookup_user_key_possessed(const struct key *key,
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
 
-extern struct work_struct key_gc_work;
 extern unsigned key_gc_delay;
 extern void keyring_gc(struct key *keyring, time64_t limit);
 extern void keyring_restriction_gc(struct key *keyring,
diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..5c2d0e3b49e6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -670,7 +670,7 @@ void key_put(struct key *key)
 			}
 			/* Mark key as safe for GC after key->user done. */
 			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
-			schedule_work(&key_gc_work);
+			key_schedule_gc(0);
 		}
 	}
 }
-- 
2.47.3

