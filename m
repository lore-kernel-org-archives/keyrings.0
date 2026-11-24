Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498396;
	b=Ki71ZKGeo9l2RvSrY1NgTQa9yWUvvGk84q6wDecv+np1BbdykBQ7J1TX3whj79YdsbcB
	 s01qiZui0v9jkDSpEM6PmDrBR+WBWg+yF3I2/HopRNWYKlnBwS/vy8OyS7+gnQ4zg3Rzj
	 pSy16yQFSyhFr0yPyetgWmw/RWYfHTq2RRCr6H9Ra0DELjTtzbl/yOwMmDaUr61JwtyLI
	 vv/ORrbX79ZWZg9w5doLdyEvMoPZcaSuYPOmJ8oJIIdYwTF28nLTm6Of68gyA3N2+MOFZ
	 uYaCNwrYclrSWQ2k7FvzE6a3heCPixNbaTsFbQEuPAzKV74f/GfNuoHuDsYiIHz/aBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498396;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CnFsYe8laaCsWo8gqpr+IQVdVBo4MQAceNgwRTBc9us=;
	b=dc0X3GlO6RMsqmjWArohDB621Mb0ZNkRotIFsv07vwhN9RCTSd0QrasM7ENF2B1+egVF
	 ulR4hjsQLaUfG3yFsk7vhHsaCJoPBNeciUCP8/kOxdQ7wJP2khQIL2oM8mMC26NDlNZCE
	 L9En4wLFJRKQi88wFLn7uTTTGZ7MteB4XsD188S84oSISOqld2a3N7sZzPvjYTX0RN53+
	 7/T7bUKJqN9dJE47j2agpTJZetQXt2lUs/N04bvlZijZ0rn20oouLN0UrqHBRHacsVHVh
	 Ic6F6MZeqKQ6XxJxeLjtx1Aq1EPJs0NJZ6ZWuC+gGjzOx1+O00/4m+4MV6DNNv33lXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA3606A31E;
	Tue, 24 Nov 2026 05:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BCA3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 868fcc1ae7c811f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8d96ac46-4457-4771-b2c4-4ef09193619a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:8d96ac46-4457-4771-b2c4-4ef09193619a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:3c603099da2a35e6db3e2fd92c955295,BulkI
	D:261124133309JDDKGXM7,BulkQuantity:0,SF:17|19|38|66|78|102|127|153|850|86
	5|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 868fcc1ae7c811f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 928427159; Tue, 24 Nov 2026 13:33:06 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Guicai Ma <maguicai@kylinos.cn>
Subject: [PATCH] KEYS: Protect the instantiate method against type removal
Date: Tue, 24 Nov 2026 00:33:03 -0500
Message-ID: <20261124053303.940216-1-maguicai@kylinos.cn>
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

key_instantiate_and_link() reads key->type->def_datalen and ->preparse
and calls ->instantiate without holding key->sem. A reference on the
key keeps it alive, but does not pin the module that provides its type.

unregister_key_type() waits for the key GC to process every remaining
key of the type. For each such key the GC takes key->sem for writing,
switches key->type to key_type_dead and destroys the payload. A key
that is still under construction is retyped as well: it stays in
KEY_IS_UNINSTANTIATED and its authorisation key remains valid, so
KEYCTL_INSTANTIATE from the upcall helper reaches
__key_instantiate_and_link() and calls key_type_dead.instantiate,
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

If the module is unloaded while ->preparse or ->instantiate is running,
execution can also return into freed module text, or skip
->free_preparse after the key is retyped and leak the preparsed
payload. While the request_key() syscall holds key_types_sem across the
upcall, in-kernel request_key() callers such as dns_query() do not, so
unregister_key_type() can run before KEYCTL_INSTANTIATE.

Hold key->sem for reading across key_instantiate_and_link() and return
-EOPNOTSUPP if the type has no ->instantiate method. Since
keyring_alloc() links a new keyring into a destination keyring with the
new keyring's semaphore held at subclass 0, take the destination
keyring's semaphore at subclass 1 in __key_link_lock(), matching the
0 -> 1 order in __key_move_lock().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
Tested on 7.4.0-rc3 arm64 in QEMU with KASAN and lockdep enabled by
unloading a test key-type module between an in-kernel request_key()
upcall and KEYCTL_INSTANTIATE. Unpatched Oopses at pc=0 on the first
round; patched returns -EOPNOTSUPP and passes 20 concurrent
instantiate-vs-unload rounds and nested keyring creation cleanly.

 security/keys/key.c     | 39 +++++++++++++++++++++++++++++----------
 security/keys/keyring.c |  9 ++++++++-
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc13710..12cbca31824c 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -422,9 +422,10 @@ static void mark_key_instantiated(struct key *key, int reject_error)
 
 /*
  * Instantiate a key and link it into the target keyring atomically.  Must be
- * called with the target keyring's semaphore writelocked.  The target key's
- * semaphore need not be locked as instantiation is serialised by
- * key_construction_mutex.
+ * called with the target keyring's semaphore writelocked.  Either the target
+ * key's semaphore or key_types_sem must be held for reading so that the
+ * garbage collector cannot retype the key to key_type_dead while the type's
+ * methods are in use.
  */
 static int __key_instantiate_and_link(struct key *key,
 				      struct key_preparsed_payload *prep,
@@ -496,7 +497,8 @@ static int __key_instantiate_and_link(struct key *key,
  *
  * If successful, 0 is returned, the authorisation token is revoked and anyone
  * waiting for the key is woken up.  If the key was already instantiated,
- * -EBUSY will be returned.
+ * -EBUSY will be returned.  If the key type no longer provides an instantiate
+ * method, -EOPNOTSUPP will be returned.
  */
 int key_instantiate_and_link(struct key *key,
 			     const void *data,
@@ -509,6 +511,20 @@ int key_instantiate_and_link(struct key *key,
 	int ret;
 
 	memset(&prep, 0, sizeof(prep));
+
+	/*
+	 * A reference on the key does not pin the module that provides its
+	 * type.  unregister_key_type() waits for the garbage collector to
+	 * retype every remaining key of the type to key_type_dead, whose
+	 * ->instantiate is NULL, so the type must not change from here to the
+	 * instantiate call.
+	 */
+	down_read(&key->sem);
+
+	ret = -EOPNOTSUPP;
+	if (!key->type->instantiate)
+		goto out;
+
 	prep.orig_description = key->description;
 	prep.data = data;
 	prep.datalen = datalen;
@@ -517,17 +533,17 @@ int key_instantiate_and_link(struct key *key,
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
@@ -535,19 +551,22 @@ int key_instantiate_and_link(struct key *key,
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
+	up_read(&key->sem);
 	return ret;
 }
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 357f56360810..f545f56c84e7 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1262,7 +1262,14 @@ int __key_link_lock(struct key *keyring,
 	if (keyring->type != &key_type_keyring)
 		return -ENOTDIR;
 
-	down_write(&keyring->sem);
+	/*
+	 * key_instantiate_and_link() links a newly allocated keyring into this
+	 * one while holding the new keyring's semaphore for reading as
+	 * subclass 0, so take the destination keyring at subclass 1 to keep
+	 * the same 0 -> 1 order that __key_move_lock() uses.  None of the
+	 * other callers of this function hold a key semaphore.
+	 */
+	down_write_nested(&keyring->sem, 1);
 
 	/* Serialise link/link calls to prevent parallel calls causing a cycle
 	 * when linking two keyring in opposite orders.
-- 
2.47.3

