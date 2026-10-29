Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294969;
	b=ABXHpT5Nv6hLO8BECj52fFsdQuZrFQxYmroLf8wModxwoMaeTcAtZL8gF7pes+8uEHTI
	 Gmkm/UFojR0S8bLVSHN859Le9oSLCBME6XMfljBcw/x4uE9a69JmyXwKhEf6DQ64IAmNm
	 BFmg475M5aMF2dZlyoa3VVsamRGJdeSWLFT46IhFRfYtJYpoA0DG8zaeqnFpLQLFio6Yb
	 cduzNl0QD38vzhf5X86kwcXH+CLknczBqLkadUAxYbLxQ2oGy21hfgqbIhjs6jeR0BVhT
	 WqlpujXCgpxI6Zw9keI8EBlghk/9aiQmRYrzp6uhK5FDNec8xC69lPfqeDD3Nb0viTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FUrr9JXEu3X75PB7hiHCv/P1znyW5o/Q5VdMwINC2x4=;
	b=c8nlE0bCAyroRtrOoKJ3wuJEMLp1jZe9lILYPGSrNlOmwsWsBxXPlri7/Pw4FyHBHEO7
	 tI5YkRxl9oC9K0Qbp+TyzIAusmAN4UBDbmFwRDOiS/1NPyIGd8CRgk8oG7Yp+MDgEFk2Y
	 l3bHFW+M5o0x0MPl3VftSatB79+11kmOwDm2JoJ+bPG+6SgzQPIlHaeIRt/rslQ8XEK1X
	 H9ZVuzrfGlRUIVi/orWTylaT6M2wv6yKeadw4miQ/dJ6sUpBO78FMb0FzmkehUh1sNIGO
	 5A8sMAp8TYlqT/kS9nxpg+c3SKsse9iFuAzC8QaNNLQSfpL2QnH9kxv5ziBerEJw50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geLuecWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 429D2606A31A;
	Thu, 29 Oct 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geLuecWy
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 40C811F01816;
	Thu, 29 Oct 2026 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294968;
	bh=FUrr9JXEu3X75PB7hiHCv/P1znyW5o/Q5VdMwINC2x4=;
	h=From:To:Cc:Subject:Date;
	b=geLuecWyiYOAOR5nOES3OihP6RjLhtblaQ8krrdjpSS0+rUPOc1lPaBtOfXo7wUBL
	 IThPko/LDLjbpfMaJXRnUewa7Hs7+1wRschm+xrRxsX4or4F0KToUq6gErof9433Nv
	 12Vx6sCh5s2VKkqWWJ1r2i0SCnfZ4oSHU+IR33xk94N7I1+a/TjobfYSPJqysX9vZ9
	 lPAUjYghsKEoEDH5UT2xQvCgcYX5c2K/UVrFK1knlaGPEnEQsNJ0g/QxQ148I7nuD/
	 9P8uG/6JR8eYXnJNgQ6RGJeXUEyIIpuJz4Cg7hLiF+BscycHg4y+6iWuH9FkWpkUza
	 vgZtjcrtV910A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS)
Subject: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Date: Thu, 29 Oct 2026 19:29:17 +0200
Message-ID: <20261029172918.2118600-1-jarkko@kernel.org>
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
2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
   of items scanned and destroyed.
3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
   the RCU grace period. Drain the graveyard before advancing key-type
   reaping.
4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
   the continuations.

keygcbench results without the patch:

unused:   min=798.785 avg=4181.989 max=7565.193 var=11446068.927
expired:  min=0.003 avg=2404.971 max=4111.065 var=3061018.501
combined: min=0.003 avg=3115.778 max=7565.193 var=7172908.943

keygcbench results with the patch:

unused:   min=0.005 avg=0.125 max=79.590 var=1.088
expired:  min=0.002 avg=0.196 max=236.207 var=8.121
combined: min=0.002 avg=0.154 max=236.207 var=3.912

These results translate to:

- 93% drop in the combined variance.
- 2.2% increase in the total task time.

The value 64 for KEY_GC_CHUNK_SIZE was cherry-picked from the set {1, 2,
..., 1024} by running the benchmark for each chunk size three times.

At the far left variance is 97% lower but at the same time total time
grows by 133%, when compared to the selected chunk size. The size was
picked based on getting a reasonable variance with a minimal throughput
decline.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/package/keygcbench
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
- Benchmarked all the chunk sizes in {1, 2, ..., 1024} and cherry-picked
  based on that the chunk size of 64.
v4:
- Added syzkaller link, as the resolution can be reasoned from the benchmark
  results.
v3:
- Added new tests results made by using keygcbench.
- Added link to keygcbench.
v2:
- Fixed typo in the commit message.
- Drop the local variable gc_state.
---
 security/keys/gc.c       | 151 ++++++++++++++++++++++++++-------------
 security/keys/internal.h |   1 -
 security/keys/key.c      |   2 +-
 3 files changed, 102 insertions(+), 52 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d4..171977e56a78 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -10,16 +10,27 @@
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
@@ -178,54 +206,64 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 static void key_garbage_collector(struct work_struct *work)
 {
 	static LIST_HEAD(graveyard);
-	static u8 gc_state;		/* Internal persistent state */
+	typeof(key_gc_work) *gc = &key_gc_work;
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
 
-	kenter("[%lx,%x]", key_gc_flags, gc_state);
+	kenter("[%lx,%x]", key_gc_flags, gc->state);
 
-	limit = ktime_get_real_seconds();
+	if (gc->state & KEY_GC_DESTROYING)
+		goto destroy_keys;
+	if (gc->cursor) {
+		spin_lock(&key_serial_lock);
+		goto continue_scanning;
+	}
+
+	test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
+	gc->start = ktime_get_real_seconds();
 
 	/* Work out what we're going to be doing in this pass */
-	gc_state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
-	gc_state <<= 1;
+	gc->state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
+	gc->state <<= 1;
 	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
-		gc_state |= KEY_GC_REAPING_LINKS;
+		gc->state |= KEY_GC_REAPING_LINKS;
 
 	if (test_and_clear_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags))
-		gc_state |= KEY_GC_REAPING_DEAD_1;
-	kdebug("new pass %x", gc_state);
+		gc->state |= KEY_GC_REAPING_DEAD_1;
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
 			goto found_unreferenced_key;
 		}
 
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
+		if (unlikely(gc->state & KEY_GC_REAPING_DEAD_1)) {
 			if (key->type == key_gc_dead_keytype) {
-				gc_state |= KEY_GC_FOUND_DEAD_KEY;
+				gc->state |= KEY_GC_FOUND_DEAD_KEY;
 				set_bit(KEY_FLAG_DEAD, &key->flags);
 				key->perm = 0;
 				goto skip_dead_key;
@@ -239,24 +277,24 @@ static void key_garbage_collector(struct work_struct *work)
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
 
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2))
+		if (unlikely(gc->state & KEY_GC_REAPING_DEAD_2))
 			if (key->type == key_gc_dead_keytype)
-				gc_state |= KEY_GC_FOUND_DEAD_KEY;
+				gc->state |= KEY_GC_FOUND_DEAD_KEY;
 
-		if ((gc_state & KEY_GC_REAPING_LINKS) ||
-		    unlikely(gc_state & KEY_GC_REAPING_DEAD_2)) {
+		if ((gc->state & KEY_GC_REAPING_LINKS) ||
+		    unlikely(gc->state & KEY_GC_REAPING_DEAD_2)) {
 			if (key->type == &key_type_keyring)
 				goto found_keyring;
 		}
 
-		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3))
+		if (unlikely(gc->state & KEY_GC_REAPING_DEAD_3))
 			if (key->type == key_gc_dead_keytype)
 				goto destroy_dead_key;
 
@@ -269,7 +307,11 @@ static void key_garbage_collector(struct work_struct *work)
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
@@ -281,12 +323,12 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 	kdebug("pass complete");
 
-	if (new_timer != TIME64_MAX) {
-		new_timer += key_gc_delay;
-		key_schedule_gc(new_timer);
+	if (gc->end != TIME64_MAX) {
+		gc->end += key_gc_delay;
+		key_schedule_gc(gc->end);
 	}
 
-	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
+	if (unlikely(gc->state & KEY_GC_REAPING_DEAD_2) ||
 	    !list_empty(&graveyard)) {
 		/* Make sure that all pending keyring payload destructions are
 		 * fulfilled and that people aren't now looking at dead or
@@ -297,33 +339,42 @@ static void key_garbage_collector(struct work_struct *work)
 		synchronize_rcu();
 	}
 
+	gc->state |= KEY_GC_DESTROYING;
+
+destroy_keys:
 	if (!list_empty(&graveyard)) {
 		kdebug("gc keys");
 		key_gc_unused_keys(&graveyard);
+		if (!list_empty(&graveyard)) {
+			schedule_work(&key_gc_work.work);
+			return;
+		}
 	}
+	gc->state &= ~KEY_GC_DESTROYING;
 
-	if (unlikely(gc_state & (KEY_GC_REAPING_DEAD_1 |
+	if (unlikely(gc->state & (KEY_GC_REAPING_DEAD_1 |
 				 KEY_GC_REAPING_DEAD_2))) {
-		if (!(gc_state & KEY_GC_FOUND_DEAD_KEY)) {
+		if (!(gc->state & KEY_GC_FOUND_DEAD_KEY)) {
 			/* No remaining dead keys: short circuit the remaining
 			 * keytype reap cycles.
 			 */
 			kdebug("dead short");
-			gc_state &= ~(KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2);
-			gc_state |= KEY_GC_REAPING_DEAD_3;
+			gc->state &= ~(KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2);
+			gc->state |= KEY_GC_REAPING_DEAD_3;
 		} else {
-			gc_state |= KEY_GC_REAP_AGAIN;
+			gc->state |= KEY_GC_REAP_AGAIN;
 		}
 	}
 
-	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
+	if (unlikely(gc->state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
 		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}
 
-	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
-	kleave(" [end %x]", gc_state);
+	if ((gc->state & KEY_GC_REAP_AGAIN) ||
+	    test_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags))
+		schedule_work(&key_gc_work.work);
+	kleave(" [end %x]", gc->state);
 	return;
 
 	/* We found an unreferenced key - once we've removed it from the tree,
@@ -335,7 +386,7 @@ static void key_garbage_collector(struct work_struct *work)
 	spin_unlock(&key_serial_lock);
 
 	list_add_tail(&key->graveyard_link, &graveyard);
-	gc_state |= KEY_GC_REAP_AGAIN;
+	gc->state |= KEY_GC_REAP_AGAIN;
 	goto maybe_resched;
 
 	/* We found a restricted keyring and need to update the restriction if
@@ -353,7 +404,7 @@ static void key_garbage_collector(struct work_struct *work)
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

