Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511577;
	b=kqTwzu65KWyiQOse7Pq8zOaXiHtiHbWEVu2ZDQMvR8UxYRaY/WaynbzX+cErsFfHIO6m
	 onvWNtUCxHH9M9++KB8P8P2YLf7M5U+/7su+p5q7TDfnDHY3JE5apsP/+6xzhDLny16na
	 q/ZOjeP5neOieN4g9+9+cyJFmZvsSJvbA5PVkDERz+wmeHtxd4mOLvWTuaiuSQdiDpsUM
	 D2Oz1qDQ7dDB0pEqE9ZremUEMBi19qvNxOQrCWhuORAJYB1TSh7xoF4kSZXZbkAktjqZQ
	 bKdyWeKium8bCVITDjriRx0XWlss44KXHBTMH3u7fNjaMK3ePstoqaUYtrd3K9SC4Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511577;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GJneH8WUjBY5s9CodC4bPCZpe8JECIqQOCGbt8Uh/xI=;
	b=dT73VfT5c+BozQx/bRIdofaAfD1+BE6EXS4iudEppvLjMOXzD6o0dfPUIaYt9h0OCkDI
	 TB7fb6qGtVx6n03qJi5HMFkS0U5+B1wpSlAgOtn1G/dqm20OyR7NMVVnZdf5DF/gjjaCd
	 KHEx79tE9dtTP0ybbVgWeSc/xPVy/cJ0EtXollIMrX5lI63OLE+Up6klxQ5n3KhIQv+yB
	 R+CqqOnGlAMLReCgtvEqv5VONwx5kDLNeX+LTAhfA0Vy9lpGuilJwRCApWhWEOjUuvq9x
	 w5Wt1GMp8kkXWW4E7W2SLng0NMpwh/ce7FQ1upSg8PCV60GUAqCfKvGoP2bPvwYHAFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B3606A31E;
	Tue, 24 Nov 2026 09:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 367e1d3ee7e711f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4618be1b-9be4-436e-957c-fb218c8e3194,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:4618be1b-9be4-436e-957c-fb218c8e3194,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:be6408c1bbafe87a0f16f7bc689fee3f,BulkI
	D:261124171249ZIC22BAL,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|153|
	850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 367e1d3ee7e711f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1444677330; Tue, 24 Nov 2026 17:12:46 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: [PATCH v2] KEYS: Protect key instantiation and rejection against type removal
Date: Tue, 24 Nov 2026 04:12:43 -0500
Message-ID: <20261124091243.1019217-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124053303.940216-1-maguicai@kylinos.cn>
References: <20261124053303.940216-1-maguicai@kylinos.cn>
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

key_instantiate_and_link() reads key->type->def_datalen and ->preparse,
passes key->type to restrict_link->check(), and invokes ->instantiate()
and ->free_preparse() without synchronizing against key type removal.
A reference on the key keeps the key object alive, but does not pin the
module that provides its type.

unregister_key_type() removes the type from key_types_list and waits for
key_garbage_collector() to run three passes: pass 1 sets KEY_FLAG_DEAD
and clears key->perm, pass 2 unlinks dead keys from keyrings, and pass 3
takes key->sem for writing, retypes key->type to &key_type_dead, and
destroys the payload. A key still under construction stays in
KEY_IS_UNINSTANTIATED with a valid authorisation key, so an upcall
helper calling KEYCTL_INSTANTIATE after pass 3 reaches
__key_instantiate_and_link() and jumps to key_type_dead.instantiate,
which is NULL:

  Unable to handle kernel NULL pointer dereference at
  virtual address 0000000000000000
  Internal error: Oops: 0000000086000006 [#1] SMP
  pc : 0x0
  lr : __key_instantiate_and_link+0xb8/0x2f8
  Call trace:
   0x0 (P)
   key_instantiate_and_link+0x2e8/0x36c
   keyctl_instantiate_key_common+0x1cc/0x338
   keyctl_instantiate_key+0xbc/0x120
   __arm64_sys_keyctl+0x218/0x3f0

If the module unloads while ->preparse() or ->instantiate() is running,
execution can also return into freed module text or skip
->free_preparse(). While the request_key() syscall holds key_types_sem
across the upcall, in-kernel request_key() callers do not, so
unregister_key_type() can run before KEYCTL_INSTANTIATE or
KEYCTL_REJECT.

key_reject_and_link() shares the same window: it links the key into
@keyring and calls key_set_expiry() (which reads key->type->flags)
without checking KEY_FLAG_DEAD. Linking a dead key between GC pass 2 and
pass 3 leaves it in the keyring's assoc_array while pass 3 overwrites
key->type (which aliases key->index_key.type) in place.

Neither key->sem nor key_types_sem can be taken here: holding key->sem
across __key_link_lock() and __key_instantiate_and_link() inverts lock
order against encrypted_instantiate() (which locks the master key's
semaphore under keyring->sem and key_construction_mutex), and
key_instantiate_and_link() is already called with key_types_sem held for
reading (e.g. from request_key_auth_new()).

Add key_type_srcu and call synchronize_srcu(&key_type_srcu) at the end
of GC pass 1 (KEY_GC_REAPING_DEAD_1) whenever dead keys were marked.
SRCU rather than RCU because ->preparse() and ->instantiate() may sleep.
Hold key_type_srcu across the full body of key_instantiate_and_link()
and key_reject_and_link() and check KEY_FLAG_DEAD:

- Callers that observe !KEY_FLAG_DEAD finish all key->type accesses and
  any keyring linking before pass 2 unlinks dead keys and pass 3 retypes
  them to key_type_dead.
- Callers entering after synchronize_srcu() observe KEY_FLAG_DEAD:
  key_instantiate_and_link() returns -EKEYREVOKED (matching
  key_validate()), and key_reject_and_link() skips linking (returning
  -EKEYREVOKED if @keyring was given) and key_set_expiry() while still
  completing negative instantiation so waiters wake up and @authkey is
  invalidated.

Also return -EOPNOTSUPP in key_instantiate_and_link() if a live key type
does not provide ->instantiate().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
Changes since v1:
- Replace down_read(&key->sem) with a dedicated SRCU (key_type_srcu)
  synchronized at the end of GC pass 1, avoiding the ABBA lock inversion
  with encrypted_instantiate() and avoiding locking key->sem on dead
  modular keys whose lockdep class was freed on module unload.
- Revert the down_write_nested(&keyring->sem, 1) change in
  security/keys/keyring.c, which is no longer needed.
- Check KEY_FLAG_DEAD (returning -EKEYREVOKED) in
  key_instantiate_and_link() and protect key_reject_and_link() under the
  same SRCU so dead keys are not linked between GC pass 2 and pass 3 and
  key_set_expiry() does not race with type removal.

Testing (7.4.0-rc3 arm64 KVM, KASAN + lockdep + CONFIG_ENCRYPTED_KEYS=y):
- Deterministic rmmod before KEYCTL_INSTANTIATE (ringid=0 and session
  keyring): returns -EKEYREVOKED with 0 lockdep unlock-imbalance or
  KASAN warnings (unpatched Oopses at pc=0).
- KEYCTL_REJECT on a dead key: ringid=0 returns 0, ringid=session
  returns -EKEYREVOKED without linking into the keyring; request_key()
  waiter wakes up with -ENOKEY and no WARN_ON.
- Instantiating a user key via request_key() upcall followed by
  add_key("encrypted", ..., "load ..."): passes with 0 lockdep warnings.
- Nested keyring creation and 200 concurrent instantiate/reject vs rmmod
  rounds with jitter: 0 errors, debug_locks remains 1.

 security/keys/gc.c       |  13 +++++
 security/keys/internal.h |   2 +
 security/keys/key.c      | 108 +++++++++++++++++++++++++++++----------
 3 files changed, 95 insertions(+), 28 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d4..61cb2b9a7aaf 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -35,6 +35,8 @@ static unsigned long key_gc_flags;
 #define KEY_GC_REAP_KEYTYPE	1	/* A keytype is being unregistered */
 #define KEY_GC_REAPING_KEYTYPE	2	/* Cleared when keytype reaped */
 
+DEFINE_SRCU(key_type_srcu);
+
 
 /*
  * Any key whose type gets unregistered will be re-typed to this if it can't be
@@ -286,6 +288,17 @@ static void key_garbage_collector(struct work_struct *work)
 		key_schedule_gc(new_timer);
 	}
 
+	if (unlikely((gc_state & KEY_GC_REAPING_DEAD_1) &&
+		     (gc_state & KEY_GC_FOUND_DEAD_KEY))) {
+		/* Wait for any in-flight key_instantiate_and_link() or
+		 * key_reject_and_link() calls that did not observe
+		 * KEY_FLAG_DEAD before pass 2 unlinks dead keys from keyrings
+		 * and pass 3 retypes them to key_type_dead.
+		 */
+		kdebug("gc dead type sync");
+		synchronize_srcu(&key_type_srcu);
+	}
+
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
 	    !list_empty(&graveyard)) {
 		/* Make sure that all pending keyring payload destructions are
diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..73d71de274c2 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -19,6 +19,7 @@
 #include <linux/compat.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/srcu.h>
 
 struct iovec;
 
@@ -86,6 +87,7 @@ extern struct kmem_cache *key_jar;
 extern struct rb_root key_serial_tree;
 extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
+extern struct srcu_struct key_type_srcu;
 extern wait_queue_head_t request_key_conswq;
 
 extern void key_set_index_key(struct keyring_index_key *index_key);
diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc13710..9e51cb2b1d34 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -422,9 +422,10 @@ static void mark_key_instantiated(struct key *key, int reject_error)
 
 /*
  * Instantiate a key and link it into the target keyring atomically.  Must be
- * called with the target keyring's semaphore writelocked.  The target key's
- * semaphore need not be locked as instantiation is serialised by
- * key_construction_mutex.
+ * called with the target keyring's semaphore writelocked.  The caller must
+ * hold key_type_srcu (after checking !KEY_FLAG_DEAD) or key_types_sem for
+ * reading via key_type_lookup(), so the type cannot be retyped to
+ * key_type_dead or its module unloaded while its methods run.
  */
 static int __key_instantiate_and_link(struct key *key,
 				      struct key_preparsed_payload *prep,
@@ -496,7 +497,9 @@ static int __key_instantiate_and_link(struct key *key,
  *
  * If successful, 0 is returned, the authorisation token is revoked and anyone
  * waiting for the key is woken up.  If the key was already instantiated,
- * -EBUSY will be returned.
+ * -EBUSY will be returned.  If the key's type has been removed, -EKEYREVOKED
+ * will be returned.  If the key type does not provide an instantiate method,
+ * -EOPNOTSUPP will be returned.
  */
 int key_instantiate_and_link(struct key *key,
 			     const void *data,
@@ -506,7 +509,28 @@ int key_instantiate_and_link(struct key *key,
 {
 	struct key_preparsed_payload prep;
 	struct assoc_array_edit *edit = NULL;
-	int ret;
+	int ret, srcu_idx;
+
+	/*
+	 * A reference on the key does not pin the module that provides its
+	 * type.  Hold key_type_srcu across every use of key->type
+	 * (def_datalen, preparse, restrict_link->check, instantiate and
+	 * free_preparse) and across linking into @keyring.  Pass 1 of
+	 * key_garbage_collector() sets KEY_FLAG_DEAD and waits for
+	 * synchronize_srcu(&key_type_srcu) before pass 2 unlinks dead keys
+	 * and pass 3 retypes them to key_type_dead.
+	 */
+	srcu_idx = srcu_read_lock(&key_type_srcu);
+
+	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
+		ret = -EKEYREVOKED;
+		goto out;
+	}
+
+	if (!key->type->instantiate) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	memset(&prep, 0, sizeof(prep));
 	prep.orig_description = key->description;
@@ -517,17 +541,17 @@ int key_instantiate_and_link(struct key *key,
 	if (key->type->preparse) {
 		ret = key->type->preparse(&prep);
 		if (ret < 0)
-			goto error;
+			goto out_free_preparse;
 	}
 
 	if (keyring) {
 		ret = __key_link_lock(keyring, &key->index_key);
 		if (ret < 0)
-			goto error;
+			goto out_free_preparse;
 
 		ret = __key_link_begin(keyring, &key->index_key, &edit);
 		if (ret < 0)
-			goto error_link_end;
+			goto out_link_end;
 
 		if (keyring->restrict_link && keyring->restrict_link->check) {
 			struct key_restriction *keyres = keyring->restrict_link;
@@ -535,19 +559,22 @@ int key_instantiate_and_link(struct key *key,
 			ret = keyres->check(keyring, key->type, &prep.payload,
 					    keyres->key);
 			if (ret < 0)
-				goto error_link_end;
+				goto out_link_end;
 		}
 	}
 
 	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
 
-error_link_end:
+out_link_end:
 	if (keyring)
 		__key_link_end(keyring, &key->index_key, edit);
 
-error:
+out_free_preparse:
 	if (key->type->preparse)
 		key->type->free_preparse(&prep);
+
+out:
+	srcu_read_unlock(&key_type_srcu, srcu_idx);
 	return ret;
 }
 
@@ -581,7 +608,8 @@ int key_reject_and_link(struct key *key,
 			struct key *authkey)
 {
 	struct assoc_array_edit *edit = NULL;
-	int ret, awaken, link_ret = 0;
+	int ret, awaken, link_ret = 0, srcu_idx;
+	bool dead;
 
 	key_check(key);
 	key_check(keyring);
@@ -589,22 +617,42 @@ int key_reject_and_link(struct key *key,
 	awaken = 0;
 	ret = -EBUSY;
 
+	/*
+	 * Hold key_type_srcu across linking into @keyring and
+	 * key_set_expiry() (which reads key->type->flags).  If the key is
+	 * already marked dead, skip linking and expiry but still complete
+	 * negative instantiation so waiters are woken and @authkey is
+	 * invalidated.
+	 */
+	srcu_idx = srcu_read_lock(&key_type_srcu);
+	dead = test_bit(KEY_FLAG_DEAD, &key->flags);
+
 	if (keyring) {
-		link_ret = __key_link_lock(keyring, &key->index_key);
-		if (link_ret == 0) {
-			/*
-			 * Check the restriction under the keyring semaphore.
-			 * keyring_restrict() installs it while holding the
-			 * semaphore, so testing it beforehand races with a
-			 * concurrent restriction install.
-			 */
-			if (keyring->restrict_link) {
-				__key_link_end(keyring, &key->index_key, edit);
-				return -EPERM;
+		if (dead) {
+			link_ret = -EKEYREVOKED;
+		} else {
+			link_ret = __key_link_lock(keyring, &key->index_key);
+			if (link_ret == 0) {
+				/*
+				 * Check the restriction under the keyring
+				 * semaphore. keyring_restrict() installs it
+				 * while holding the semaphore, so testing it
+				 * beforehand races with a concurrent
+				 * restriction install.
+				 */
+				if (keyring->restrict_link) {
+					__key_link_end(keyring, &key->index_key,
+						       edit);
+					ret = -EPERM;
+					goto out;
+				}
+				link_ret = __key_link_begin(keyring,
+							    &key->index_key,
+							    &edit);
+				if (link_ret < 0)
+					__key_link_end(keyring, &key->index_key,
+						       edit);
 			}
-			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
-			if (link_ret < 0)
-				__key_link_end(keyring, &key->index_key, edit);
 		}
 	}
 
@@ -616,7 +664,8 @@ int key_reject_and_link(struct key *key,
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
-		key_set_expiry(key, ktime_get_real_seconds() + timeout);
+		if (!dead)
+			key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
 		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 			awaken = 1;
@@ -641,7 +690,10 @@ int key_reject_and_link(struct key *key,
 	if (awaken)
 		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
 
-	return ret == 0 ? link_ret : ret;
+	ret = ret == 0 ? link_ret : ret;
+out:
+	srcu_read_unlock(&key_type_srcu, srcu_idx);
+	return ret;
 }
 EXPORT_SYMBOL(key_reject_and_link);
 
-- 
2.47.3

