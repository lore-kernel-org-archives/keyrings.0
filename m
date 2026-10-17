Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449523B531A
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224992; cv=none; b=jGpOn+TRVXEZHpw66VwBe5pTvC41q6P0RuW639XVhInM+VReORkar9PPxamr2X3i1VEi0mNb6as2zB/bwdDSeQdh7/Tj9uk5+Dye9eHIf79xcGr6w8EfcHbjCosIXnO6/M+AJmrcgoiExmUsMvKFhYZgHxyCOK4EqKuQRgLuf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224992; c=relaxed/simple;
	bh=KOss2RXNEsYXOLGcex6zn2KON6+z01gxh5ch8cLaMJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHTHshxtPcu5lZc5WsMo2KgWZDhFxbPD+3pmuJMrZ36IC0GKF1rLvhWByipFyz9P2BYEEgFzBCRxPYsD6Ss3kg3f22KftKzAHzAn69awnfqUBjAgBfSs81tNl6uhDsUwIQm16g9pit5oboyvWC5yty89W9XyzpOIv3K5nJX4aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxvn0DrB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxvn0DrB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso462734a91.3
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792224991; x=1792829791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Rvkgh3Vtn4gb/N875529l68oF+mXegyVxx4uqGo40A=;
        b=rxvn0DrBGA4lUspUCoMRnhQoLszSi69RyZVnC97bvR5v++ZzYwPFMWx8o3uQ0O6ZqU
         J0Y36YYqGq43zUk+1GugNgHhflWfd3vAKJITCTkpYPjxoJZ1HAUGhx4YUQkgA8g+9yz0
         joTqo9B8chmNRu3cY/PXnkOskC2xxitsrRg54Kh7tJXm38sbC2juv2T1mmR0rhhyajZf
         KWclV2A4WiVZvPfS9wnB/3I5gJCJVToNiyT6YtIYhz024vsu7gq79fE5khitzfcaKEqd
         rzRdaD+a65oBybA3b+jBSXYxFpG5iRVp1ZN6JUR22o0XPLwQe60Jwcog6quxl3bBBSrQ
         h6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792224991; x=1792829791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Rvkgh3Vtn4gb/N875529l68oF+mXegyVxx4uqGo40A=;
        b=qcA8RiR+WvvYGNCu9LVCJi6kruDfI4e9gdY3Gm6e9qP74T8THbAprNLSfw35JT/VIo
         U8ZiiJr2aSGnHTFUYUtKJt1Yy29p/R7DC2bFWaTZ6PQ7D2D4J2ApXwkI7/Vt3nKaczrn
         p7VFbPIHFMeqTjadz2GH1/gFBo1TosCFCQCZq/hKjUimk/4F2fvaVfmYrT5sB8Ij2VSW
         rLwYvuTrh3RvpP78Iw6mwYetcAeLO5QF4nYKwCo/ETru3TH+AW19JajKzmyyavD+5/Um
         gyMBKpREwP+bD/JxbagHiZYmLucr1g7jn+stSuPfg+i4qtTAU1HmIuClTYWh0R9n7Jse
         Q24w==
X-Gm-Message-State: AFq9FYIvfiD6MqfObmUE70UayGYDWuXvAEeUaMjCOb/G78fn65Y9WlbX
	lwuRGOyBmBdK+1XxVMdTAFOauZcWHvgE15ZCyf+YVh95mqr83X/mNvrI
X-Gm-Gg: AYBFou3fYfXqE38c3JHtds4hMbWz3bSBbFM8bKq5wXkA88D/enI7CWxdVSQoi7swSh7
	kLOoCRKEQwdvMncNzMxkI2QO7RHFVctVF16cXXjnWkiYzNViyJSq0f7DdsX/cTB36/ithHLUzpy
	DMuRZw62zRfA3EtE57CPbmBD1d0xrdFaiHww3tfD3MHbsrULmpuEM+iBCqu0KG0WBmB7ZZRi1Cz
	v16Y2xcjMj9eOCAtsK4YmJksSefSWsS+wFQlVIOWWZ3lA3laL4Aujo5IGt5VYG0vPvRz3aJJkdj
	J0PUcbP6oByKIgkpp3F5JzPKuQ3K+nCjKUSiOyD1bnt2zIkG70w1GM15RyjzaXsLZzfHoMwGmag
	EeTOanJprRiyO4XfHHXZtu9DXtJgTTP8IMEhRX1CGI8Tie4zKIRznZ/TGTrA+BC6Et9dyBmutfQ
	huVEX94rXhQBfUUGJNj6L2jROex8jMbeReWjHmTsGF/i2L3LdmW5C2iLtJTT2SagJc+Q==
X-Received: by 2002:a17:90a:e7ca:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3acef14859dmr1938332a91.32.1792224990592;
        Sat, 17 Oct 2026 01:16:30 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc980a548sm3607125a91.0.2026.10.17.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 01:16:30 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] keys: Avoid owner account dereferences in /proc/keys
Date: Sat, 17 Oct 2026 16:16:22 +0800
Message-Id: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The namespace filters in find_ge_key() and key_serial_next() read
key->user->uid while traversing the serial tree under key_serial_lock.
That lock keeps the key allocated, but it does not protect the separate
key_user from ownership changes.

A /proc/keys read reaches find_ge_key() through proc_keys_start(), and
key_serial_next() through proc_keys_next(). The lock stays held until
proc_keys_stop().

A successful privileged KEYCTL_CHOWN on the same key replaces key->user
under key->sem and drops the old owner's reference after releasing the
semaphore. If that was the old dynamic key_user's last reference, a
/proc/keys reader can access freed memory:

    /proc/keys reader                   KEYCTL_CHOWN
    proc_keys_start()                    keyctl_chown_key()
      spin_lock(key_serial_lock)          down_write(key->sem)
      find_ge_key()
        old = minkey->user
                                          zapowner = key->user
                                          key->user = newowner
                                          key->uid = uid
                                          up_write(key->sem)
                                          key_put(key)
                                          key_user_put(zapowner)
                                            kfree(zapowner)
        read old->uid -> use-after-free
    proc_keys_stop()
      spin_unlock(key_serial_lock)

Use the inline key->uid in both filters, following the approach already
used by find_keyring_by_name(). The serial-tree lock keeps the containing
key alive, so filtering no longer depends on the quota owner's lifetime.
This also uses the same owner UID as proc_keys_show() and the permission
check.

For thread keyrings, key_fsuid_changed() can update key->uid without
changing the quota owner. The filters now follow that current owner UID,
including when its namespace mapping differs from the quota owner's.

Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
 security/keys/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..aea06a74d0fe 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		if (kuid_has_mapping(user_ns, key->uid))
 			break;
 		n = rb_next(n);
 	}
@@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		if (kuid_has_mapping(user_ns, minkey->uid))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)

base-commit: a626e44fd64c456d373ae8c28b939197b9446a02
