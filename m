Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995627BF7C
	for <keyrings@vger.kernel.org>; Tue, 26 May 2026 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763740; cv=none; b=K069iFhz4emPG+Anh4wo5BM2dBLHxU3TYcwSEbdno4FEmD45IEFSPIWyda5zutxPa4+5VMgm/mellFIEfPl6BgTXYpnG0HUGptJBkgq5nyZGd6Xh0qJFieZwJ1Zo9xcpM8eNXZjl5x98I6bjvOcLoOxlKbgeMrG/Zyni2w9suRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763740; c=relaxed/simple;
	bh=saJVcll0Fh8M/y0WbTryiZRy3NgEFSzD4VO3x9LoqEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B37Nj3Lh7UV3HoS8mC87QdQSZviv6HFpVSXy6KYf5Olb5uyF97jYl0LQ4bHQ0+oVlwZy+1oRFAE1cS7h1E23INwm6PGHdHGHX4mDAAW7ZkFhHf3vO74kjOzikjzp2pUD8n5LeKX7IttHuxWQl5kG5hfzbrimjQSmwBfV4F55SyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmOBljky; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmOBljky"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13721dfd471so259535c88.1
        for <keyrings@vger.kernel.org>; Mon, 25 May 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779763737; x=1780368537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SciWLg3wzcud7J8i5XeFD4dn/8ICJfCrpXZP4khWrC0=;
        b=EmOBljkyKxelXrPDjI+MQMYG4PQDe+UVF0T0FMhkdT4MGjY+BGJ2BWXD5K6zzn80Dw
         iVYAbwPq1V//kCIonEiNFmTy0vcba9GtFTFtcWfyGe/teP/OBz7D+u+U5gnhmbpwX/2j
         cFmJ6Nx3oIhJPEd3iQBReAG7jlI4RF3kMvtKQaExS4OE03b0Kz+X+V9h170p5ro5UC4O
         cFSGjHn5phGhstbn2d+aEUAKWIOVpOFzz0gCocwfZ2hfoVbpwqop8FS6c58zCM9/ea4K
         BhfS0LF/usWr8X66gegyuIawhtL+ME28U0w1wHmjC8X37GExyYfI0Qa2b2F0lZj5JhdJ
         zJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779763737; x=1780368537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SciWLg3wzcud7J8i5XeFD4dn/8ICJfCrpXZP4khWrC0=;
        b=AZD5I1rwfSSOvSVk/uJfaT05gaGAcRh3dHm8z3/y4cIQzUgUsB1iHOv8SzXcxhaSvx
         8iqLWFoiJtcS/VQHc2PofXkMsB5cUN0SDtWJVX2bc1raW+xrOasY5DHK2dr3TF+mktXx
         4R6xfRSjPAoNI1JAemy6cXuyGzzkBd+9Xc8OFu2rPGhK3pUqHZy6A5YbzLcA/TZQYtov
         Y9gOpejkVXBZv3sBQjx+R4O97etTqDShd6dRL5vvl6DCrNTpTHaq8lbY4dyAdWq8LcsO
         083MrcwxBvNmscBQcYpqTXddaZ9mbs6g83F5+RIFRUJIvWOTK62HeopYmjVrY6JYXDw1
         1byA==
X-Gm-Message-State: AOJu0Yw1hZe9bo0u9x0HWX8aer0T7WX65Cfh5bxmZ8dhL2kggN2r8JRU
	98fWNbojEJo3JJDh5rm8Yx5Gk1IXxEMZYjS3rzzwO6pzNF369PSUk8Qo9OkUMQ==
X-Gm-Gg: Acq92OEr6xOUaPKNi5e/9OvoPQpO8XHmSPtQyWg/UHD3RUTXXorBe5EKUbbrXSE8ooX
	cjHwrfjDS4I02oYQgyNPenU+9zjnvIoykru984iZLNL7jnKR8HCTU9t06k8B8z3i+JNhZzT8fto
	vM8iQRA+IG2EAlvfJP2bm8gzuLsjBejzawByy2m/BPSgr2nfirWavpaGYiYNqY9SS0AdkbeWg/2
	Nm/jY0IX+ZiqwhZL4fcIlQiRkk1ViYQ41nyoZCNgZvJK9fteXbSFqxGBVtB34h8LeoA22gvKSVR
	QIgWpYzGXHvwDj2rxF9twVYjR3HcHNG2N3YaVjJ5H6oBM63jofxIWT0EJe3hmJr0jPrQ/5iajHW
	4BF8AbLN9h5+ng/a2ssE/FUFO1x0q6GroYZKEM3Mfq4+LzJ5E23PEMFZKthVYer5Y6d6bv9J/yk
	AIN//faGbsARkkhG2PIL0jQuZzlkxHWvc1V5mZ1g==
X-Received: by 2002:a05:7022:f401:b0:12d:de3f:f3d9 with SMTP id a92af1059eb24-1365fb62422mr5967399c88.35.1779763737313;
        Mon, 25 May 2026 19:48:57 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa9a8b2sm8652900c88.12.2026.05.25.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:48:56 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Date: Tue, 26 May 2026 10:48:38 +0800
Message-ID: <20260526024838.3368409-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_instantiate_key_common() reads request_key_auth from the assumed
auth key before copying an instantiation payload from userspace.  The copy
can fault and sleep.  If the request completes and revokes the auth key in
that window, the auth payload can be detached and freed before the
instantiate path uses it again.

A request-key helper reproducer can trigger this race.  One helper child
blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
requested key and returns.  KASAN then reports a use-after-free from the
stale request_key_auth payload in keyctl_instantiate_key_common().

Give request_key_auth payloads a refcount.  Take a payload reference while
authkey->sem stabilizes the payload and revocation state.  Hold that
reference across the instantiate and reject paths.  Drop the auth key
owning reference from revoke and destroy.

Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
---
 include/keys/request_key_auth-type.h |  2 ++
 security/keys/internal.h             |  2 ++
 security/keys/keyctl.c               | 24 +++++++++++++++-----
 security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index 36b89a933310..01e42ee5f409 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -9,12 +9,14 @@
 #define _KEYS_REQUEST_KEY_AUTH_TYPE_H
 
 #include <linux/key.h>
+#include <linux/refcount.h>
 
 /*
  * Authorisation record for request_key().
  */
 struct request_key_auth {
 	struct rcu_head		rcu;
+	refcount_t		usage;
 	struct key		*target_key;
 	struct key		*dest_keyring;
 	const struct cred	*cred;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 2cffa6dc8255..b7b622bc36a1 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -208,6 +208,8 @@ extern struct key *request_key_auth_new(struct key *target,
 					const void *callout_info,
 					size_t callout_len,
 					struct key *dest_keyring);
+struct request_key_auth *request_key_auth_get(struct key *authkey);
+void request_key_auth_put(struct request_key_auth *rka);
 
 extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ef855d69c97a..d14ace88e529 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1197,9 +1197,13 @@ static long keyctl_instantiate_key_common(key_serial_t id,
 	if (!instkey)
 		goto error;
 
-	rka = instkey->payload.data[0];
-	if (rka->target_key->serial != id)
+	rka = request_key_auth_get(instkey);
+	if (!rka) {
+		ret = -EKEYREVOKED;
 		goto error;
+	}
+	if (rka->target_key->serial != id)
+		goto error_put_rka;
 
 	/* pull the payload in if one was supplied */
 	payload = NULL;
@@ -1208,7 +1212,7 @@ static long keyctl_instantiate_key_common(key_serial_t id,
 		ret = -ENOMEM;
 		payload = kvmalloc(plen, GFP_KERNEL);
 		if (!payload)
-			goto error;
+			goto error_put_rka;
 
 		ret = -EFAULT;
 		if (!copy_from_iter_full(payload, plen, from))
@@ -1234,6 +1238,8 @@ static long keyctl_instantiate_key_common(key_serial_t id,
 
 error2:
 	kvfree_sensitive(payload, plen);
+error_put_rka:
+	request_key_auth_put(rka);
 error:
 	return ret;
 }
@@ -1358,15 +1364,19 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
 	if (!instkey)
 		goto error;
 
-	rka = instkey->payload.data[0];
-	if (rka->target_key->serial != id)
+	rka = request_key_auth_get(instkey);
+	if (!rka) {
+		ret = -EKEYREVOKED;
 		goto error;
+	}
+	if (rka->target_key->serial != id)
+		goto error_put_rka;
 
 	/* find the destination keyring if present (which must also be
 	 * writable) */
 	ret = get_instantiation_keyring(ringid, rka, &dest_keyring);
 	if (ret < 0)
-		goto error;
+		goto error_put_rka;
 
 	/* instantiate the key and link it into a keyring */
 	ret = key_reject_and_link(rka->target_key, timeout, error,
@@ -1379,6 +1389,8 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
 	if (ret == 0)
 		keyctl_change_reqkey_auth(NULL);
 
+error_put_rka:
+	request_key_auth_put(rka);
 error:
 	return ret;
 }
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index a7d7538c1f70..282e09d8fa46 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -23,6 +23,7 @@ static void request_key_auth_describe(const struct key *, struct seq_file *);
 static void request_key_auth_revoke(struct key *);
 static void request_key_auth_destroy(struct key *);
 static long request_key_auth_read(const struct key *, char *, size_t);
+static void request_key_auth_rcu_disposal(struct rcu_head *);
 
 /*
  * The request-key authorisation key type definition.
@@ -115,6 +116,31 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	kfree(rka);
 }
 
+/*
+ * Take a reference to the request-key authorisation payload so callers can
+ * drop authkey->sem before doing operations that may sleep.
+ */
+struct request_key_auth *request_key_auth_get(struct key *authkey)
+{
+	struct request_key_auth *rka;
+
+	down_read(&authkey->sem);
+	rka = dereference_key_locked(authkey);
+	if (rka && !test_bit(KEY_FLAG_REVOKED, &authkey->flags))
+		refcount_inc(&rka->usage);
+	else
+		rka = NULL;
+	up_read(&authkey->sem);
+
+	return rka;
+}
+
+void request_key_auth_put(struct request_key_auth *rka)
+{
+	if (rka && refcount_dec_and_test(&rka->usage))
+		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
+}
+
 /*
  * Dispose of the request_key_auth record under RCU conditions
  */
@@ -136,8 +162,10 @@ static void request_key_auth_revoke(struct key *key)
 	struct request_key_auth *rka = dereference_key_locked(key);
 
 	kenter("{%d}", key->serial);
+	if (!rka)
+		return;
 	rcu_assign_keypointer(key, NULL);
-	call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
+	request_key_auth_put(rka);
 }
 
 /*
@@ -150,7 +178,7 @@ static void request_key_auth_destroy(struct key *key)
 	kenter("{%d}", key->serial);
 	if (rka) {
 		rcu_assign_keypointer(key, NULL);
-		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
+		request_key_auth_put(rka);
 	}
 }
 
@@ -174,6 +202,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 	rka = kzalloc_obj(*rka);
 	if (!rka)
 		goto error;
+	refcount_set(&rka->usage, 1);
 	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
 	if (!rka->callout_info)
 		goto error_free_rka;
-- 
2.47.3
