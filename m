Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EF4508EB;
	Fri, 31 Jul 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515282; cv=none; b=LO4qwcugr+M12JzFyBEtfEeeKbHybjQ83hIk1tuqtSILsUUm4LpgRMJE38dw7VWkxoaapUyAUm04iduGCOUYBiXqBSxiLTyYx9NxAJ6f2Zska8pb0A3yV+2uWbTBOL066YtIG9JSN2IbBcMYk8pidAFVXzANZb3l2R2NLR7zFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515282; c=relaxed/simple;
	bh=79WnKnmlwUieqZ8sU7dL38///FPa2eNTv6xm5BkH4gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blEBQzTE7HBDJsrICeAzrBVtV3eNV461lF42TgdOrAguWuH4A384iIQNPehqM64cyGfZDVABAflHjLgNPXShgSYoGdT56z5Qt6DqqtuDzb13jW0JnSXJ4F+cvgaly5amQGIKl5A3OSMGzy2Vowop29a/bipVltTMMY3E4QXSbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=YUz5MR51; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cE7SOqoa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="YUz5MR51";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cE7SOqoa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 230AA7A0112;
	Fri, 31 Jul 2026 12:27:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jul 2026 12:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785515274;
	 x=1785601674; bh=6RJPYbBdKyVevokLLvrFaLY6IOxzeT8FvabNtZpBPjM=; b=
	YUz5MR510i+WmXGI7a4kC5uqawHagcWlThX/znOeuRjkIJrcn2zxv0EsYGbM20lb
	i5yjscraNBNQfufT3LtYFRxnI0PCj5X76beHrvcmSIEU1d2fHZrUWO6XIAi7OWDU
	rpE2w0joPx55gGeemOiiqSM0bOSu6EgZj9K2NvJ0uJI8fg0aS8KZhGS1sXhk9EeU
	Xn3a0nNO7LYe5vFb9ipY8TccSzGCc1jNGae7Ncb+VoA+eEMurDBLCM1RyDXi/jwi
	Bl1clFSRw9/MyZyGuTc3fleqXsSSmVHhcMZQUkkwkNP7Myvg7pMS4n7PX8M9XHTS
	KeJ2d49aUOJSd3kt7vIPeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515274; x=
	1785601674; bh=6RJPYbBdKyVevokLLvrFaLY6IOxzeT8FvabNtZpBPjM=; b=c
	E7SOqoa3Otd7WsGDI1EXvQLZ5uj79zcwLoXFNNZ3ZhmOiWo8vcAxHQw5MA8dqUYd
	7DQvxudJBbVDkploQoBg1qu3X/W/4umdXLFrwfFlzY9Gf//CeCIvl0yiml7ROhqK
	Qb2QCGMeNGxi351dOwLvEtDB3+vChBbKO2cVaF4xTLljSb95UrLr61C3cvwvbfaq
	yV2E5czozC/kxvDeddrTSmn9PJhduC5uBwqKjjcfB0L8sEZ5+HD/gFVbI7SZmjQd
	HKX+jX74c1FBv7HDt74zfE5RrnOw/PFTwFKQ6yAlkc64gKUEGtkzrLebYsnfwT0l
	HKxWtXy94CSDS2JuLZp7A==
X-ME-Sender: <xms:Cs1satSBbfOd5V4gUyUINnwX63sniqRsL39wsvZbMSb8ReT1uXuZjA>
    <xme:Cs1sanN1VqGgZOIupESPczHmDCi9ELzVTDg_oyfjOkAt8OrUn1Qdm_XDDpdmHmA5P
    94VhUC5fDOq_Iub07-oNk7ukA63xCj8BGCxiruX9M4v8oEEsw>
X-ME-Received: <xmr:Cs1sajhQYCi0Mnkba_3eGu5hrPNFMNXz0awEOQDqEtx1YIG7kB5AUgvQ-_poB9Jn1Xk1jMz5h2k3Qa8VAQ>
X-ME-Proxy-Cause: dmFkZTFK/nfZ71g8ktujuuoyrF9Ty3Awc1kurrPu2o1v6nhgMM6NL3zj5ESd/fiJ+lq6Fq
    Z3OuJgsO9Fs2GPtTwEyFZyDKihsNiiEsnOWMvsOfBTFOP9roQM0mTP8MtpTOtxDCDWThhp
    R6cquw+SMl49Oku+QQXCkKW+TrFunMbAzDZTMwRiMkrGaoNe0GLi6W90Q6fubhxR5onr5q
    JMP4yfob1UtqZ4XCQdoJfvSelSRy/3zTBtxj7H4AUAz0Xtt/lL1/4chym5iL4gRXLFaWSQ
    TqzwgVHkZuxaKP3mHZdHzlPw99hzi3gU4xKCX1rRjxCDxKjnlHRIs9asJOBHpx9Xtx82Wu
    KfYE0fXzVTV12FAmSzQyjawktIBVNf4pTw9FSHRBmhVSjR/DfddoxPl4utqYB4lxLjouzt
    oXC5NAFahcYIV6iVTmqO7YcRb0qN1Q5SAf4H5gLw4tfLgIBe6suNECZv0viYMaX8RmL/Z0
    mWD0jSZEDPOu6r2LNzYFAaUhaglPqA+u4ArkGHwvjPud20jbUikr0ul60+KyV5NudeSHon
    KHKewFBLzNSRafof6rP0ltLpAIe7339yDePtxqrF1sw2mIchka9xTpJ9ZDEige5ZTrIo+b
    18pexHS4+MVejnDnuk3GvyPN1lshEFrhRooCzfsWwDeVqxpuffogHi3ECxTA
X-ME-Proxy: <xmx:Cs1saslegLST0-gsTkB5-p18Ku1qz0IyhLW-wYMdgGyJ7XjG9lhAGw>
    <xmx:Cs1sangqw1JoL-Ck0bsQC6_eSKmfdimsb0W_NzX-6EjHN9RLoQB6tA>
    <xmx:Cs1sanHmVfwlldNF4dU0ggflyCSnThJ2uNwuBWQcJ6ZpzB5WRv2RnA>
    <xmx:Cs1saht85mcRortAW_wQRTuOsbRlvA_i2e5JLpnogrdyosGQie9K0g>
    <xmx:Cs1satiZNxv4hfCDXMPVhjHZo0p_fv3_qL751cUjqulMQmct8Ey4o9i3>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:53 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 4/4] security/keys: zeroize key payloads before kdump
Date: Fri, 31 Jul 2026 18:27:39 +0200
Message-ID: <20260731162739.158320-5-linux@jaseg.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731162739.158320-1-linux@jaseg.de>
References: <20260731162739.158320-1-linux@jaseg.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_CRASH_ZEROIZE is set, try to erase key payloads on panic
before jumping to the kdump kernel.

CRASH_ZEROIZE notifiers run during panic() with other CPUs stopped and
preemption disabled. In this state, we can't rely on free()'ing being
safe, so we define a new zeroize key op.

Implement the zeroize op for the user/logon, encrypted, trusted, and
big_key types.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 include/linux/key-type.h                  |  9 +++++
 security/keys/big_key.c                   | 15 ++++++++
 security/keys/encrypted-keys/encrypted.c  | 12 +++++++
 security/keys/key.c                       | 44 +++++++++++++++++++++++
 security/keys/trusted-keys/trusted_core.c | 14 ++++++++
 security/keys/user_defined.c              | 11 ++++++
 6 files changed, 105 insertions(+)

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index bb97bd3e5af4..ff0944ce368f 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -122,6 +122,15 @@ struct key_type {
 	/* clear the data from a key (optional) */
 	void (*destroy)(struct key *key);
 
+	/* scrub the key material without free'ing (optional)
+	 * - used from CONFIG_CRASH_ZEROIZE during panic to keep keys out of
+	 *   crash dumps
+	 * - called from the panic path with other CPUs stopped and preemption
+	 *   disabled
+	 * - must not sleep, allocate, free or take locks
+	 */
+	void (*zeroize)(struct key *key);
+
 	/* describe a key */
 	void (*describe)(const struct key *key, struct seq_file *p);
 
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380..ad8537dda70f 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -35,6 +35,8 @@ struct big_key_payload {
  */
 #define BIG_KEY_FILE_THRESHOLD (sizeof(struct inode) + sizeof(struct dentry))
 
+static void big_key_zeroize(struct key *key);
+
 /*
  * big_key defined keys take an arbitrary string as the description and an
  * arbitrary blob of data as the payload
@@ -46,6 +48,7 @@ struct key_type key_type_big_key = {
 	.instantiate		= generic_key_instantiate,
 	.revoke			= big_key_revoke,
 	.destroy		= big_key_destroy,
+	.zeroize		= big_key_zeroize,
 	.describe		= big_key_describe,
 	.read			= big_key_read,
 	.update			= big_key_update,
@@ -279,6 +282,18 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 	return ret;
 }
 
+static void big_key_zeroize(struct key *key)
+{
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
+
+	if (payload->data) {
+		if (payload->length > BIG_KEY_FILE_THRESHOLD)
+			memzero_explicit(payload->data, CHACHA20POLY1305_KEY_SIZE);
+		else
+			memzero_explicit(payload->data, payload->length);
+	}
+}
+
 /*
  * Register key type
  */
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 59cb77b237b3..9f56fa9b4aaf 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -970,11 +970,23 @@ static void encrypted_destroy(struct key *key)
 	kfree_sensitive(key->payload.data[0]);
 }
 
+static void encrypted_zeroize(struct key *key)
+{
+	struct encrypted_key_payload *epayload = key->payload.data[0];
+
+	if (!epayload)
+		return;
+
+	memzero_explicit(epayload->payload_data,
+			 epayload->payload_datalen + epayload->datablob_len);
+}
+
 struct key_type key_type_encrypted = {
 	.name = "encrypted",
 	.instantiate = encrypted_instantiate,
 	.update = encrypted_update,
 	.destroy = encrypted_destroy,
+	.zeroize = encrypted_zeroize,
 	.describe = user_describe,
 	.read = encrypted_read,
 };
diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47..5673dcc8c5d2 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/crash_core.h>
 #include <linux/random.h>
 #include <linux/err.h>
 #include "internal.h"
@@ -1268,6 +1269,44 @@ void unregister_key_type(struct key_type *ktype)
 }
 EXPORT_SYMBOL(unregister_key_type);
 
+#ifdef CONFIG_CRASH_ZEROIZE
+/* Called far into vpanic from crash_core.c with other CPUs stopped and
+ * preemption disabled
+ */
+static int key_crash_zeroize(struct notifier_block *nb, unsigned long action,
+		void *data)
+{
+	struct rb_node *node;
+
+	/* If we can't acquire the lock, the rbtree might be in an inconsistent
+	 * state. That's all we can do then, as there's no point to waiting
+	 * at this stage.
+	 */
+	if (!spin_trylock(&key_serial_lock)) {
+		pr_crit("crash_zeroize: can't acquire key_serial_lock. skipping keyrings.\n");
+		return NOTIFY_DONE;
+	}
+
+	for (node = rb_first(&key_serial_tree); node; node = rb_next(node)) {
+		struct key *key = rb_entry(node, struct key, serial_node);
+
+		if (key->type == &key_type_keyring ||
+		    key->state == KEY_IS_UNINSTANTIATED)
+			continue;
+
+		/* custom zeroize since free'ing isn't safe at this point */
+		if (key->type->zeroize)
+			key->type->zeroize(key);
+	}
+	/* off to kexec()! */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block key_crash_zeroize_nb = {
+	.notifier_call = key_crash_zeroize
+};
+#endif /* CONFIG_CRASH_ZEROIZE */
+
 /*
  * Initialise the key management state.
  */
@@ -1290,4 +1329,9 @@ void __init key_init(void)
 
 	rb_insert_color(&root_key_user.node,
 			&key_user_tree);
+
+#ifdef CONFIG_CRASH_ZEROIZE
+	atomic_notifier_chain_register(&crash_zeroize_notifier_list,
+			&key_crash_zeroize_nb);
+#endif
 }
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 0509d9955f2a..f159faeafe23 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -325,11 +325,25 @@ static void trusted_destroy(struct key *key)
 	kfree_sensitive(key->payload.data[0]);
 }
 
+static void trusted_zeroize(struct key *key)
+{
+	struct trusted_key_payload *p = key->payload.data[0];
+
+	if (!p)
+		return;
+
+	memzero_explicit(p->key, sizeof(p->key));
+	memzero_explicit(p->blob, sizeof(p->blob));
+	p->key_len = 0;
+	p->blob_len = 0;
+}
+
 struct key_type key_type_trusted = {
 	.name = "trusted",
 	.instantiate = trusted_instantiate,
 	.update = trusted_update,
 	.destroy = trusted_destroy,
+	.zeroize = trusted_zeroize,
 	.describe = user_describe,
 	.read = trusted_read,
 };
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f927..ade95dc2481d 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 
 static int logon_vet_description(const char *desc);
+static void user_zeroize(struct key *key);
 
 /*
  * user defined keys take an arbitrary string as the description and an
@@ -28,6 +29,7 @@ struct key_type key_type_user = {
 	.update			= user_update,
 	.revoke			= user_revoke,
 	.destroy		= user_destroy,
+	.zeroize		= user_zeroize,
 	.describe		= user_describe,
 	.read			= user_read,
 };
@@ -48,6 +50,7 @@ struct key_type key_type_logon = {
 	.update			= user_update,
 	.revoke			= user_revoke,
 	.destroy		= user_destroy,
+	.zeroize		= user_zeroize,
 	.describe		= user_describe,
 	.vet_description	= logon_vet_description,
 };
@@ -152,6 +155,14 @@ void user_destroy(struct key *key)
 
 EXPORT_SYMBOL_GPL(user_destroy);
 
+static void user_zeroize(struct key *key)
+{
+	struct user_key_payload *upayload = key->payload.data[0];
+
+	if (upayload)
+		memzero_explicit(upayload->data, upayload->datalen);
+}
+
 /*
  * describe the user key
  */
-- 
2.53.0

