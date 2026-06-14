Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A1846A
	for <keyrings@vger.kernel.org>; Sun, 14 Jun 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781449249; cv=none; b=blVYR0uU7jFZXX7JcnV0Tmj727HiHBFpOm6kg91ewVNLNpsxELXuSbDETR2Q60ZOZDYYxIDV+cNBzn5WznJZ+XF9kbahnJOMuKGeeP1pTaxX0idVzmmkkhnkUIqf4N+CcViMWang+NhSB9BJWdAImtbXY0lxa0iXzLBpxmgsar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781449249; c=relaxed/simple;
	bh=2npXpHQkXqKbu9W/ajkzv5o/gKk6GeI+UO27XdxLb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0pSouzqEHVwpHON1ifpiSefz7RR5VWExjkARAMfmt15E//3k/dAQMikzETieRaVXK7hziTNEKwq2NLccEJpoXmr9bxqKEwpzExm14K/foqRhEZTpieQmQUMKhJRH3gqHafh7grQWj0lubYqwqaZw1lfuujEbpBCmyZjoMZc9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyNMNTb4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyNMNTb4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a76757e5so17419635e9.2
        for <keyrings@vger.kernel.org>; Sun, 14 Jun 2026 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781449247; x=1782054047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=HyNMNTb4JGX/CxJwc/0aheo0/NzEnu/M8ngz3H9G5mRhBUdAEL4uoCL0Suk+Edu2yN
         d5ZF+WKOLnzwUq+BsajzmqHZ4Q525SBelsZ0FyRK+JfXmSePiYPzFkWIaZYLVeYoXu1m
         cRa6RQR1dXzpDDAC16tNSyZ7g7HCyfQSTjvckfrXY9T/76E9S4Ekk8O/lO8lC9gOQRR+
         ouMNpXZjYVmKi9DLZkUdcHu/hzqI0dHFbwztGx70SJBIAC2KNgbzGWjWKxSR1Le5gJmE
         sgdZRBrPmXeyk8YN6Mmvm8c1ykQmHdPvM121SiaK4FBeP/QL4DKZCekyA+onuMg0rolh
         Cr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781449247; x=1782054047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=bgSTh4ZwoAuM81iryZONpdrWPjXBwA8OaVhFmay5sppblnMdvSDp0xFsG6lCD0oYBB
         ThwX8O9G6qxhbZ+CYM7m3LixkPeWgFzhOR7agZ3TvJrM5lKzJ4+gDpkuEpfc+owuvqYb
         6BVJcLs55LA9r24O/AC+OsN3HMVodoj4j2qT+YvaeDZrpYGa0RSgWlnrh1kEEjaY/9MX
         00KEavKCQ7wjnp2EKYeWFr53kcCxdgV3JTV0T8PN013yS0LcmAykaFqYqGtgMILv8R8K
         l3uV1CHkT0kIeS2LKL/QuyFGT4DBjHyI75T1gKAi0gWp0oOJ5bbfuy/NUSYfmxquMA/Z
         kVkg==
X-Forwarded-Encrypted: i=1; AFNElJ/osOiEa1f0waM8FT0lHES/O9+9L4QVNoZlgFzuJL2nOjOwxBlU9NYAonWE/bcBu+VwQ3hX0QFV+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4p1ZltlnyCXmTi287jLwqQ+WWWFS0op2Q6f1/TvhjebVrwm2O
	m53UvFnvjiU3bKwIRH+KZD0E9XA6D5HyP7jfT65SVySjx13uHlf7ULJFKBjT
X-Gm-Gg: Acq92OGm101SDBItTuSugr/O9bFG26HoyTiktDqZSdg9SH2h1wqnGQtaMA5NROhz4ZD
	RDaFTgqRvaP8ct0usgLDY/cyS6addwDRBHiWqVQZsb/iAewRPsry/xy6YOXGhQQlUx32zMC8KnS
	1w5kpwj9Z1x0TYYkxLBZoUEHfc3ai7dlwvNOnbP/RtPDcFHcEUWGrIKNIZW0r2R+VH30M/qk7AG
	AovBXKIVvV2We2dVD4yWRwSbRMoro2pr5G1XI/0jpMXwjVDzYZI9+bJe205p1rJJOlhMf+qEISO
	kUP9o4Ln35FGg8vd4ok+5/0Gm8JLrDgEmXvlsXDe9KVNlWlq/ovGE/X05NTSbZih5YNnzmktQHS
	lgFxWZ4P75GayPOfQ1UK25yl6m/9fJhaZOmtkwZto/AVR+VqYijE3L7/dGtN8Nqd5vIx/usKW65
	Rd05iI31RUkZ7sqfsrcUi658PWJSBFvYNVZKnX4iV9mxRQtWo0/rpibYONK25OMJaf7HeTANbW7
	i/Pj2wBWmfWhmUo45H8BqZ9o8N1vkhSJd0y4EoMGQ==
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-4922006283cmr59149455e9.14.1781449246441;
        Sun, 14 Jun 2026 08:00:46 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.127.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922032ae56sm165261205e9.7.2026.06.14.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:00:45 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	ebiggers@google.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Subject: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Date: Sun, 14 Jun 2026 16:00:41 +0100
Message-ID: <20260614150041.21172-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__key_link_begin() runs with keyring->sem held and calls
assoc_array_insert(), which does GFP_KERNEL allocations.  Those
allocations may enter filesystem reclaim, evict an fscrypt-protected
inode, and reach keyring_clear() via fscrypt_put_master_key() --
taking a keyring semaphore of the same lockdep class and closing a
keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.

Wrap the assoc_array_insert() call with memalloc_nofs_save() /
memalloc_nofs_restore() so reclaim cannot recurse into the keys
subsystem while keyring->sem is held.

Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..21bb2e7e7cca 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/sched/mm.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <keys/keyring-type.h>
@@ -1298,6 +1299,7 @@ int __key_link_begin(struct key *keyring,
 		     struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	unsigned int nofs_flags;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1315,10 +1317,12 @@ int __key_link_begin(struct key *keyring,
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
 	 */
+	nofs_flags = memalloc_nofs_save();
 	edit = assoc_array_insert(&keyring->keys,
 				  &keyring_assoc_array_ops,
 				  index_key,
 				  NULL);
+	memalloc_nofs_restore(nofs_flags);
 	if (IS_ERR(edit)) {
 		ret = PTR_ERR(edit);
 		goto error;
-- 
2.43.0

