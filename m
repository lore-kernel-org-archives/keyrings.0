Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1657343893
	for <keyrings@vger.kernel.org>; Sat, 12 Sep 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789206892; cv=none; b=Hh+Z6j10yrxPd+3+tejipL3vwER4sihJLRj/XiANW3V3/llok4/gqtQJEJpSSBy15RSoVz+YO0cE1ZUX4yhSgBapHDDHxw4dzE3zCu+yiIAXKUwOPIzfSGP/EJpjWYVf2kgCiDYWk1BCiBdU044HYQQn/+VomRw7g3WfZS++qdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789206892; c=relaxed/simple;
	bh=xLGZ6pfrGi7Y0P4Mp+UYTrV0Mv1NTPoX6SsMuAFVEFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZ4J4N5xzFnu72yzRNfl+afndSdidMGnILINGfaULQX546LlYVndxrhG6orreVShOZURy4da5KjvlrWQ4UKpr5UI1k8Z2u1WGCRjaBykZT5EXVz/ouBZMu/zt82JPIf6QRERLELrtKYigejR+8n7zUlxKUYFyBTD9RJ1xeMjiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQRcTUGR; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQRcTUGR"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso5708555e9.3
        for <keyrings@vger.kernel.org>; Sat, 12 Sep 2026 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789206889; x=1789811689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnNpw1WOa9p3MlCBG6ZZCFsfq25XNP5JJbLzPV5Kleo=;
        b=YQRcTUGRgJG63ylGSvwLq9lvUJSzb6MmR8xxznYtZHOZx2ydHGJlkrbEUtO/TEeM5X
         Y6P0hxK3/5Wj0k3xMfnZUdJdw9+Nk7FyuFy7PlWodrfGvX1zVBSwIBqA8gq/tD/viXI1
         Icy9Z19vkv/lB6FxfydG5l5A/HCS1gCGLT1bob3jaqpGAVonEIt6AHJ67mS/95VE+YZ0
         g3vNezzDlTcnJ4YydGXiWGxZRH3IzB4udOKuhce+jkSdveykWBS+FmBoK4f7wvrpLhVT
         QKWODaPEogClLGgHP3LCcNnr/LDsGraYo1ZX1rcCGAVKd8q6/BRxLmU8byMDt0uJZ25f
         dBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789206889; x=1789811689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnNpw1WOa9p3MlCBG6ZZCFsfq25XNP5JJbLzPV5Kleo=;
        b=XmOUHdusybWIQQ1R3WxqANqNsBsKEGCz4ht4RUqDc4iu4E57WKUXAbr8AhFSAiC4m6
         eSNQ55T4+IhJ07Xzud3qp2De07e2cYCyQi56Sjbhg5x1RvmD/soYkRaybwayjGw5QN2F
         m5X/2ihguRAjX5eSsOwpRr3lZMWizhjd4ZGKkZqCcDYVBoh7auXkKlKOIueXCquRqzBy
         ULmQmnY5362Pf0nRuCgA9l07AHnNiMAFrXXhJYhgUfE/x+nwwiCYkHuyCzAqBT/FmfXi
         Aj+phuzUGcT/YJJ4k5H9Hq4J4710K50vEbOHsp92TbZl13ylt+hNjOKn1712M/SFVpA4
         iZWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+nUuDcUzRLJMOKdSW8BND3X4r20jGDpf+x8+vMi5/COA7xbZNgCDX5uLj4Qp5QFFoaUtqmoHh8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l/eA9AVThAnv8UieMNhW7veMt9cef3oybOSbYlvGAeGnV+fN2e
	r+bSnK4QXwJimlp1KPP837KhbdfydayFtMPbXsAi1VQlBkKg5bN+aQLU
X-Gm-Gg: AYBFou3m2KZMw2VWd5aOWAahIP5YRWChVVK8zZeYNk7VJjITSiq89UHXnW6XnuUCvgZ
	lkmlqEiZ99Prm5cdXMknC+Cxtsqe13K9BafiB1HfGrgBZNinxUo18EGq5ZqOnL5s15dXMgyh2+F
	tdlEAT9WzyHA4ZmY+2kY1dFOLyi5YBCM0UIQucJJX1/496h/J1rvq872X0mcGYkHhEVYJH+mwW6
	zZRHdcbISTHKD5yN5ne4TUCCZCM3wOioTKIf6m94sFpDdCxHEsd2Mcijpa8BqYYHf/KOayGhP4O
	p5CJIDyLdk3+5JgZa0LAsjJLMylhoxyqsZ/GqMkjyi/61MxNNBOD3SGsefnVeLIgsUso0YVDBX3
	vTFp9j5RIdf0UAM3oOebCNYN/KWqP67w5/3gp+iXOJjSgWWKMsXCh3J8ipEPrnami+MGmqnI9yj
	yaNbNBl0Uky6035V8vhNIceg2nDYXCiFWmfiX6SzmscPsaBgxD3NDyCKk4w0Uq2Ksx5iNdYEI0k
	FGv/3dxQXgp7WGHcShbI2o3QcM71d/8Ui5pexhaG5fjAZy00d/xCVjvl1TiT1zrLvGdA6qurHBW
	pfYAoQjygRhl33yJ+lXd1YReiTpiopZqtwMGqz1r1DeWoTRo490yMzePbVvInQDo4fUDYJBy9yK
	fxg==
X-Received: by 2002:a05:600d:4452:20b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49e6198c2aemr67076425e9.11.1789206888615;
        Sat, 12 Sep 2026 02:54:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71adc2ecsm15179175e9.4.2026.09.12.02.54.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 02:54:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] keys: finalize persistent keyring timeout after link attempt
Date: Sat, 12 Sep 2026 11:54:40 +0200
Message-Id: <20260912095440.79864-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When no keyring exists for the requested UID, KEYCTL_GET_PERSISTENT
creates and registers one before linking it to the requested destination.
The configured timeout is set only after the destination link succeeds.

A destination restricted with KEYCTL_RESTRICT_KEYRING makes that link fail
with -EPERM. With persistent_keyring_expiry set to 60 seconds, /proc/keys
still reports the registered keyring's expiry as "perm".
The failed call therefore leaves a quota-exempt keyring in the namespace's
hidden register, where it may remain until namespace teardown.

Rename the write-locked helper to key_get_or_create_persistent() and return
the key reference through a result parameter. Return 0 when it creates a
keyring and 1 when the retry finds an existing one. Return a negative error
on failure. Another caller may create the keyring between the initial
read-locked lookup and the retry under the write lock.

Set the timeout after permission checking and linking. Do this on success,
or on failure if the call allocated the keyring. This leaves a new keyring
collectible after failure without starting its timeout while linking is
still in progress.

Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v4:
- tweak comment (Jarkko)

v3: https://lore.kernel.org/r/20260901191743.39210-1-kmehltretter@gmail.com/

Changes in v3:
- Return the persistent key reference through a result parameter (Jarkko).
- Keep lookup-or-create atomic inside the helper and use 0 for creation, 1
  for an existing keyring, and negative values only for errors.

v2: https://lore.kernel.org/r/20260901164323.35785-1-kmehltretter@gmail.com/

Changes in v2:
- Rewrite the commit message around the restricted-destination reproducer
  and trim the explanation (Jarkko).
- Track whether the persistent keyring was newly allocated and finalize its
  timeout after the permission and link checks. This preserves an existing
  keyring's timeout on failure and avoids expiry during linking.

Testing below was performed for v3; v4 changes only the comment.

Tested with QEMU 10.2.1 TCG on i386 and x86_64. With
persistent_keyring_expiry set to 60 seconds, KEYCTL_GET_PERSISTENT returned
-EPERM and /proc/keys reported "perm" before the fix and "1m" after it on
both architectures.

Also tested on x86_64 with persistent_keyring_expiry set to 1 second and
gc_delay set to 0. Successful calls reused the same serial, a newly created
keyring from a failed call expired, and a failed call using an existing
keyring left its timeout unchanged. A test-only two-second delay before
timeout finalization did not allow the keyring to be collected before link.

Two concurrent callers returned the same serial. A test-only 100 ms delay
after the read-locked miss forced both callers into the write-locked retry
and confirmed that the second caller took the 1 (existing) return path.

 security/keys/persistent.c | 55 ++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b22..bdab995393261 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -33,25 +33,31 @@ static int key_create_persistent_register(struct user_namespace *ns)
 }
 
 /*
- * Create the persistent keyring for the specified user.
+ * Get or create the persistent keyring for the specified user.
  *
  * Called with the namespace's sem locked for writing.
+ *
+ * Returns a boolean indicating whether the keyring already existed,
+ * or a negative error. On success, *persistent_ref holds a reference
+ * to the keyring.
  */
-static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
-				       struct keyring_index_key *index_key)
+static int key_get_or_create_persistent(struct user_namespace *ns, kuid_t uid,
+					struct keyring_index_key *index_key,
+					key_ref_t *persistent_ref)
 {
 	struct key *persistent;
-	key_ref_t reg_ref, persistent_ref;
+	key_ref_t reg_ref;
 
 	if (!ns->persistent_keyring_register) {
-		long err = key_create_persistent_register(ns);
+		int err = key_create_persistent_register(ns);
+
 		if (err < 0)
-			return ERR_PTR(err);
+			return err;
 	} else {
 		reg_ref = make_key_ref(ns->persistent_keyring_register, true);
-		persistent_ref = find_key_to_update(reg_ref, index_key);
-		if (persistent_ref)
-			return persistent_ref;
+		*persistent_ref = find_key_to_update(reg_ref, index_key);
+		if (*persistent_ref)
+			return 1;
 	}
 
 	persistent = keyring_alloc(index_key->description,
@@ -61,9 +67,10 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
 				   ns->persistent_keyring_register);
 	if (IS_ERR(persistent))
-		return ERR_CAST(persistent);
+		return PTR_ERR(persistent);
 
-	return make_key_ref(persistent, true);
+	*persistent_ref = make_key_ref(persistent, true);
+	return 0;
 }
 
 /*
@@ -78,6 +85,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	key_ref_t reg_ref, persistent_ref;
 	char buf[32];
 	long ret;
+	bool created = false;
 
 	/* Look in the register if it exists */
 	memset(&index_key, 0, sizeof(index_key));
@@ -100,23 +108,24 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	 * also need to create the register.
 	 */
 	down_write(&ns->keyring_sem);
-	persistent_ref = key_create_persistent(ns, uid, &index_key);
+	ret = key_get_or_create_persistent(ns, uid, &index_key,
+					   &persistent_ref);
 	up_write(&ns->keyring_sem);
-	if (!IS_ERR(persistent_ref))
-		goto found;
-
-	return PTR_ERR(persistent_ref);
+	if (ret < 0)
+		return ret;
+	created = ret == 0;
 
 found:
+	persistent = key_ref_to_ptr(persistent_ref);
 	ret = key_task_permission(persistent_ref, current_cred(), KEY_NEED_LINK);
-	if (ret == 0) {
-		persistent = key_ref_to_ptr(persistent_ref);
+	if (ret == 0)
 		ret = key_link(key_ref_to_ptr(dest_ref), persistent);
-		if (ret == 0) {
-			key_set_timeout(persistent, persistent_keyring_expiry);
-			ret = persistent->serial;
-		}
-	}
+
+	if (ret == 0 || created)
+		key_set_timeout(persistent, persistent_keyring_expiry);
+
+	if (ret == 0)
+		ret = persistent->serial;
 
 	key_ref_put(persistent_ref);
 	return ret;

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.53.0
