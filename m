Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D543563CD
	for <keyrings@vger.kernel.org>; Sun, 23 Aug 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504705; cv=none; b=CeaUVCQys1xf0uuHTpb34I3VNlamyXDkL1PNINEOwQCFEW8i3YTuCDYNSQnd2ZPloIt3+a81ckmwO219diFkalEQS12U9o+chA5CYUKuvUN0AxFpIFxkT+pdQQt812HfVoR+q65avFrLIjcl5Je+yyZHcCOoJlts9BRuDoEH1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504705; c=relaxed/simple;
	bh=gWZEjagFLSEHCLiuRXV3m9OHpXG30kNMA/tQzzHkKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNNHYKe1KkzrDPqM0F/SzAt31/YcZ5hCsyF+UDpBoQ8409JEpeaWvUs3+48v+5Qf13QfpkH7IkvklvUEKIizHXDj2mlsdo+FMAlSot6wJv3B6ngkwSWlY/g01x59yzY4nsd2IHusQFvAVYuN33w6y7z7/vT8Abd9duB0fDZE364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYlMljNb; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYlMljNb"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c70f41417so329968d50.1
        for <keyrings@vger.kernel.org>; Sun, 23 Aug 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787504700; x=1788109500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fp7SzY66XTj6zmh2H/e3A8N/ODfvtqZLUkZGsmrEbw=;
        b=IYlMljNbEZfglzy3U83D6qQhWDLHPfAZnO5R+b4emBXjS+xLb3prctm7I36iFvPIo1
         595QCypQs4qwPrZJOdi2eSglflZfby8gLBMhjQBFDArjhF5wB9cxsnhET1Qg+iYStBH9
         sqUduKs4wl6vsjP1y5lhphZlryQu5YusJvaUr7hcQeeQwRPt1o1pfsnwaFhnBif8PW17
         +GRunEsh8XL9PFwKP0Ql9wTkhUhz28qblVr78G5SLVksNPfyYSSTGwHWEvcDKKmN+m2C
         EePXAa/7RX3ogc4Sql7v38RDYTkirAjZ6/A/Mx5s5NzzhjPfDw5gIo9wkeqTajB643Es
         lF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787504700; x=1788109500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fp7SzY66XTj6zmh2H/e3A8N/ODfvtqZLUkZGsmrEbw=;
        b=EJVbE+tdKIjjcKIiHtJ2u3nY+qibr3NwFgkkiboHRugD5IEQNldIi5lv4DAnQrx1zk
         4E4RgjYL//x/udsxvtRYPGjx0bWJ+P//x/2OKHKjfwYWVgk4E1u3jRKN0h+/y/NwNmYw
         gLf7dthRI1ZrAbbyE21b62xDlUdh1mItHI4t6dTsj5sORLxaUodtNGXC9p6VPUCs2yA9
         a2eGOsSV9XgvYqdlhShILJxRM4bMQu99IyZc8bjPZyyIa7JE3Mb1hH9i2+qWetxpZIWX
         G32HqjU5fpvUZjpn175gkwaz4cFsxp9ah4opYVX25/piMtQBMICMmLCC0XTkiIitsL+j
         i1AA==
X-Gm-Message-State: AFuF++ksR7DLLpdUI05Bxh6wDvIGxsBl895PSEXcVD2GB27YOOpJgmgO
	0zVn48likqZVWnQTlpzLeM6VJoA+a7+Gf1RjJS3grXB8qFoMZmh5iuf9
X-Gm-Gg: AR+sD12zzrrmI67yKLrEsFZudE/I8/h0pLKS3We2/ZUXKaFp7gy49EomBF2xjyAUoMW
	h1mX+XcCT0FDl8iigmR9WbpXEjPoMyropBkrJNBiLxxWIAq86XCaR4Tzu+h0Sl+m2vsCwsaVsGm
	5M33kBqiAnnjAHx5JA+o7C1NjpYNE9+Tlg48cAjX8/JWnVx1E6e8E+nsk4Rph/yENCXksOQU+K9
	sHxEG6QNtW2zk3FV+eALpOI212WLrHVvDHyrzUUpY26DchRRE4Col6J//jQwCSIA3HR11mTaqXJ
	sAr/BixLBH/FHr8yD3OiP4Ssn09pDrs5Wl5XSkon/BrMqatFgylPJ58SJ7FqQDhFfIsX1BE63TZ
	VA2nusfxxKf32vaqZmQnoKkumlmUT3H0lJXVgiqx+tk1O31AI3Nq1hgOXzSjUy9ORl/m/HnUL6f
	34ytV6uLYtfPLAMxRFGSM9OAc2o16eVzvzO+E/79NRIxTPBnDXIkZ3KgVIktdpNqkuzof4DFBOk
	K+edBLACe8OLRSnwVYvnqMGjjwjAxLEkhN5/+bHWXREkrL9EImqztk=
X-Received: by 2002:a05:690c:e013:20b0:81f:49e1:1f15 with SMTP id 00721157ae682-849ea01a334mr58148687b3.0.1787504699844;
        Sun, 23 Aug 2026 10:04:59 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c25aasm22529197b3.22.2026.08.23.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:04:58 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH] keys: Fix key_user use-after-free during ownership changes
Date: Mon, 24 Aug 2026 01:04:48 +0800
Message-ID: <20260823170448.3856516-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_chown_key() replaces key->user while holding key->sem and drops
the old key_user reference after releasing the semaphore. The /proc/keys
iterators and find_keyring_by_name() instead dereference key->user while
holding unrelated locks.

This allows the following interleaving:

  CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
  load old key->user
                                replace key->user
                                key_user_put(old)
                                  kfree(old)
  read old->uid

Serialize the namespace-mapping reads and the pointer replacement with
key_user_lock. This lock already protects final key_user removal, so the
old object cannot be freed while its uid is being read. Keep reading the
quota-owner UID rather than key->uid because those values can legitimately
differ for thread keyrings.

Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 security/keys/internal.h | 10 ++++++++++
 security/keys/keyctl.c   |  2 ++
 security/keys/keyring.c  |  2 +-
 security/keys/proc.c     |  4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..741d547ba5c4 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -70,6 +70,16 @@ extern struct key_user	root_key_user;
 extern struct key_user *key_user_lookup(kuid_t uid);
 extern void key_user_put(struct key_user *user);
 
+static inline kuid_t key_user_uid(const struct key *key)
+{
+	kuid_t uid;
+
+	spin_lock(&key_user_lock);
+	uid = key->user->uid;
+	spin_unlock(&key_user_lock);
+	return uid;
+}
+
 /*
  * Key quota limits.
  * - root has its own separate limits to everyone else
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529..c17924609317 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1036,8 +1036,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 			atomic_inc(&newowner->nikeys);
 		}
 
+		spin_lock(&key_user_lock);
 		zapowner = key->user;
 		key->user = newowner;
+		spin_unlock(&key_user_lock);
 		key->uid = uid;
 	}
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f282..49f4be934525 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, key_user_uid(keyring)))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..8d6d26652aab 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		if (kuid_has_mapping(user_ns, key_user_uid(key)))
 			break;
 		n = rb_next(n);
 	}
@@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		if (kuid_has_mapping(user_ns, key_user_uid(minkey)))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)
-- 
2.43.0

