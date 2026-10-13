Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3803D34BB
	for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882252; cv=none; b=REU4KrbOCUUypsYTOSjzQrdgKC8Kb4+mAm0n/EuUS1o0sBs/w/HkLuBALTKDSD7FQbX4R/s4YB1kK54rkULuePGQtodIdjYigbC/3dmMwPUaHKiAbmPFaCui0w9YjAPpSqWUlQjxENOSAY7wzCnKu6II/Ku7jYelTZ4LdaLsQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882252; c=relaxed/simple;
	bh=/nK5IKQC21UoPbNXSYgntVq7qevvTsm2IPtKkOtsXd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NonGK12he8OHeAQxLfA6NsptFz4ieoBw98Es40nO3DXE3W/Mw//iF6kWlN3PUHuLsUa+wM16+R0cAVZ0UGl0exXr9JzUep6oIdIhY3F+Gir4SbOFwlWjklvAiprVY15dMYGlLgI+drIZ4zFgLURhR4dZUM9f7hEHBEWuRWqgTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioBl8FXz; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioBl8FXz"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-142eed7df08so228031c88.1
        for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882250; x=1792487050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fa9vZBayEtyLCk+UCPP6j3yznT2w8lB21Q+YTXQARCw=;
        b=ioBl8FXz8736U1/rcja4KWj7IvRUxJYH0o4+QpETEIfZCYCDdwjtCCTq4UMfJwIvE4
         Z1+ISCoO59miUBax1HZ10FVzPWDzzX4T93YL/mNibLr6lnicujIv5+grRtm3Laa+dg8E
         4aCYaZyKCvsv9/ZglTEW6faYTgRlzjTuGVqIVpBTYsAJRIp6ywQbqz03Z+6LWvPoxxBN
         r4ZdBLMNeQ5vpaWB+Y4RCuAxAxUyTYG91okU5PHSCAjEUBrT4VZF/ZdvPuBd84Bve4V0
         AtSg7DaPRtFn9Q8rTkqpzevQV6PpIldi5QbSr5kL3j7XkPp8i8qw9V1bFNW4NiM0fQs2
         5Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882250; x=1792487050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fa9vZBayEtyLCk+UCPP6j3yznT2w8lB21Q+YTXQARCw=;
        b=BL7ewQ7xHan3KUvXZW5rupLzImTUlM5kEFm9CWLM4uSyLStsxwR/1u6ffcmSij48ag
         taBPalFH/Rz4zMh9GnbN7wDVF3rP4JoRHMJaqhKMaIA/I+YWorfKcJo6/peHLHWMyRRI
         NZEHX8dcNlkoLO8wud/+ktySRy5lbEoaKM+0EXPMa+bvnvR1tmHRqEsGSra4XCZ+S4zc
         lzk+axewqCSPA/bRCj3qNFEcQfRXhXIWFi6iXHkh/X77XPfEmFfi73/TSMPGTbvkU2jZ
         lv2lCH2SKsmA7ZvAffcah13+W+dJLBy7lJmSZy7CKjAEX2lCrF+1sf+Lz5PMKVmJZMZE
         I6Iw==
X-Forwarded-Encrypted: i=1; AKwUvBwqRNp9s6trjyhRgiUQkjfRDgWx0cRgbh5Cu+ZWaOVw+GAB8b7Et8JlWb4Pgt8ufrmyIp6qZvMLhQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+qx4dfqoC4P945mTxLXYSG2PMtI+bJlSPThB/Askc+YuvqMMa
	pwgGVunJFYyHHP6as1a5XRCmlf6QaFxlD0b4HlkJVpR4q5VVtAeFn+yN
X-Gm-Gg: AYBFou1kOBSQPGj7eWmPMQKeTrk455zKYzeoxaz4sS7KxF14if1hKg8iKD11udmQC32
	dRbyQ523y6Pkk7b8HaXoOHAGSwgORO5xSgdqVjrRhJl5XJ7R8yMhWV4bhbdINH1DstbOB6qnFiw
	n8sDxaML9EiOJKqSYULO6CW4j80++U/dEq6yQfCENfzB4Ggb8XtvrR2mQPhaQQ2S1uGDVfIUnOy
	qzIsDWNwnjjCSwhiZjQPjdk6ykVMUvgqnWSaCUyI4RPWXNQg9emqWWKUpbI0OPm6enNCdoAwpBZ
	22Yl8mGUxpdlNPMSKpa4krzFkHYdlI7QKONqhp6RiOrYAIzOfWBw3jetyACpdSHUKjbHapzqe6Y
	phrVLfACSoLr46w1IdBcPYcPC9GaKxTqffvOb4Lw8HiAuMRAbAJroogHNsEgi3TJMaA0NjsapPQ
	kk+C192QjRoyegfhWK4k++io4pWOq5atQIkpB44gWGxcxoE7Q2nVEgYzxiSeTy/0ZAM/xmuZRn0
	xhGyqymCX/cluFkSV/hihOehkoTW8dt4BHfytuEz9b33jmgo18oY6Yr/WrMn2vVnbOnh615/Xs=
X-Received: by 2002:a05:701b:4515:20b0:144:fd17:3b21 with SMTP id a92af1059eb24-16a4e2f6033mr24392643c88.0.1791882250034;
        Tue, 13 Oct 2026 02:04:10 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm36281803c88.11.2026.10.13.02.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:04:09 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v4 2/2] keys: Serialize ownership transfers with key accounting
Date: Tue, 13 Oct 2026 17:03:58 +0800
Message-ID: <20261013090358.1178367-2-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protecting individual accesses to key->user does not make ownership
transfers atomic with accounting updates. keyctl_chown_key() holds
key->sem, but instantiation is serialized by key_construction_mutex and
need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
an uninstantiated key.

The instantiated-key count can therefore be charged to the wrong owner:

  instantiate                       keyctl_chown_key()
  increment old->nikeys
                                    observe KEY_IS_UNINSTANTIATED
                                    skip the nikeys transfer
                                    replace key->user
  mark key instantiated

The key becomes instantiated under the new owner while the increment
remains with the old owner. Negative instantiation has the same race.

Quota reservation can likewise run between charging the new owner and
replacing key->user. It then adjusts the old owner's quota and changes
key->quotalen while chown is transferring that quota burden.
key_payload_reserve() can run during instantiation without key->sem,
so it needs the same exclusion against chown.

Hold key_user_lock in keyctl_chown_key() across the quota and key-count
transfers, state check, and owner replacement; locking only the pointer
store leaves the preceding accounting exposed. In
__key_instantiate_and_link() and key_reject_and_link(), hold it across
the instantiated-key count increment and state update, so chown observes
both together. Atomic counter operations alone do not stabilize the
owner or couple the increment with state publication.

Hold the same lock in key_payload_reserve() from owner selection through
updating qnbytes and key->quotalen. The per-user quota lock cannot
stabilize key->user during a transfer. Retain the existing per-user locks
to serialize quota changes against other keys owned by the same user.

Keep allocations, notifications and reference release outside
key_user_lock, and release it on the quota-overrun path.

Normal updates through key_update() and __key_update() already hold
key->sem and exclude chown. key_alloc() charges a referenced owner before
publishing the key. Final key_put() and key_gc_unused_keys() cannot race
with chown, which requires a key reference. Their existing per-user locks
and atomic counters still protect totals shared with other keys.
key_user_lookup()/key_user_put() already protect owner creation and final
removal with key_user_lock. These sites need no new ownership lock.

This accounting race was identified by source inspection.

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v4:
- Include the reservation and instantiation scopes formerly in v3 1/2;
  retain the same combined lock coverage while making this fix complete.
- Keep accounting serialization as patch 2/2, matching v3. Include the
  full lock/count/state/unlock scope at both instantiation sites.
- Include quota reservation and the entire chown accounting transaction;
  this patch can be applied without the namespace-reader fix.

v3: https://lore.kernel.org/r/20260927162528.943886-3-nicoyip.dev@gmail.com/
v3 1/2: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail.com/
v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/

 security/keys/key.c    | 15 +++++++++++++--
 security/keys/keyctl.c |  4 ++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index a438c4508595d..61dd991cee543 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -21,6 +21,9 @@ struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
 struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
+/*
+ * Protects key_user_tree and serializes ownership changes with key accounting.
+ */
 DEFINE_SPINLOCK(key_user_lock);
 
 unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
@@ -380,9 +383,12 @@ int key_payload_reserve(struct key *key, size_t datalen)
 
 	/* contemplate the quota adjustment */
 	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
-		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
-			key_quota_root_maxbytes : key_quota_maxbytes;
 		unsigned long flags;
+		unsigned int maxbytes;
+
+		spin_lock(&key_user_lock);
+		maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
+			key_quota_root_maxbytes : key_quota_maxbytes;
 
 		spin_lock_irqsave(&key->user->lock, flags);
 
@@ -396,6 +402,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
 			key->quotalen += delta;
 		}
 		spin_unlock_irqrestore(&key->user->lock, flags);
+		spin_unlock(&key_user_lock);
 	}
 
 	/* change the recorded data length if that didn't generate an error */
@@ -447,8 +454,10 @@ static int __key_instantiate_and_link(struct key *key,
 
 		if (ret == 0) {
 			/* mark the key as being instantiated */
+			spin_lock(&key_user_lock);
 			atomic_inc(&key->user->nikeys);
 			mark_key_instantiated(key, 0);
+			spin_unlock(&key_user_lock);
 			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
 
 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
@@ -604,8 +613,10 @@ int key_reject_and_link(struct key *key,
 	/* can't instantiate twice */
 	if (key->state == KEY_IS_UNINSTANTIATED) {
 		/* mark the key as being negatively instantiated */
+		spin_lock(&key_user_lock);
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
+		spin_unlock(&key_user_lock);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index c89a4d6efed40..e74fa0076ee0b 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1006,2 +1006,4 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 
+		spin_lock(&key_user_lock);
+
 		/* transfer the quota burden to the new user */
@@ -1041,2 +1043,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		key->uid = uid;
+		spin_unlock(&key_user_lock);
 	}
@@ -1060,2 +1063,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	spin_unlock_irqrestore(&newowner->lock, flags);
+	spin_unlock(&key_user_lock);
 	zapowner = newowner;
-- 
2.43.0

