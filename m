Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577186;
	b=c1XOxCPZdc6CqYA6wT9f1RhJlD5xphmJ77N6SRU193g4FzT2mNJ4jVZhQZ7PBElSPb0Z
	 lL8wNIupNSG39yOZAsrCFCdnTV4nrebitCs8RRpqqFpPOmri+HIL6Gr6UmI94OIR8Hgk1
	 RyrGhisE29rEp91Igksj05OzC9mO7bel0Al1QA5rLccGKMjtwQ5pR7LFC6a3BjPbmVtfY
	 X/o8oTl9DXrXteQ4aVvNKcmwjqnzQYFTeyJ/dn6agfcHX6UjbPBp7QniA9qPMsrbZjszT
	 hP5+nVGFSObXO3Did9JISUuk7RWyfchlVJJ7CP7Pc7qy7yMnJbGvGmCNgzGk5SWOzdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577186;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XCGjfp5dgoiI6yIH13ma0+Hno0mR7CNbFKfLr5y4Y5U=;
	b=R7nQPfy4uL/gVROICHJhbNYGX+EWzCCn5MxP8CVSxco2bRTItKK1zPM4tPJoBL73N2nZ
	 YDjk9hOMMxw0RiFfTGlUGuzedgAVHQ+kZLU184jX5NaoGwDLJVChCmii7ODGT9hG9qbj1
	 aByJNx2vL21k3UDKHOgcwEt7+7fLPJ3OcagEjdLB6EeXx8Qcr7irFjGmU9HRfoo6F1Woz
	 wl6oiINT4n5mSPjuyhrQIRokTIee/g4X4Z4LZ1KKSBYA4NdRHErcYNUJ+bEPYJaWZqi8o
	 6MzocNQBIteG3HyT+hGo02knIpAlQTMlab2EAcgrF/GEDjboq7czu7I1ry++Lc5Y8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFA606A31E;
	Wed, 25 Nov 2026 03:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBFA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f45bf95ae87f11f19a56ed5b684f684d-20261125
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:29fe9cba-aa1a-4729-a214-0851c6e1aa28,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:29fe9cba-aa1a-4729-a214-0851c6e1aa28,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:a612ab6a869d8df162672369fd20a6c7,BulkI
	D:2611251126129DDO4PJL,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|153|
	850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,1,J
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f45bf95ae87f11f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1171750551; Wed, 25 Nov 2026 11:26:08 +0800
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
Subject: [PATCH v3] KEYS: Protect key instantiation and rejection against type removal
Date: Tue, 24 Nov 2026 22:26:05 -0500
Message-ID: <20261125032605.1327954-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124091243.1019217-1-maguicai@kylinos.cn>
References: <20261124091243.1019217-1-maguicai@kylinos.cn>
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

key_instantiate_and_link() and key_reject_and_link() access key->type
and link keys without synchronizing against unregister_key_type(). If
the type is removed while a key is under construction, GC retypes it to
key_type_dead (where ->instantiate is NULL) or links a dead key before
pass 3 rewrites key->type.

key->sem cannot be used here because it inverts lock order against
encrypted_instantiate() and references a freed lockdep class after a
modular type unloads, while callers may already hold key_types_sem and
->preparse() or ->instantiate() may sleep. Guard both paths with
key_type_srcu and a KEY_FLAG_DEAD check, and wait for in-flight calls
with synchronize_srcu(&key_type_srcu) at the end of GC pass 1.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Cc: stable@vger.kernel.org
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
v3:
- Shorten the commit message and focus on why SRCU is used.
- Change Fixes tag to 0c061b5707ab.
- No code changes.

v2:
- Switch from key->sem to key_type_srcu and check KEY_FLAG_DEAD in
  key_instantiate_and_link() and key_reject_and_link().

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
index 3f1f0fc13710..d923ddf457e9 100644
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

