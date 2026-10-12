Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB7390C85
	for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774951; cv=none; b=hgRvphY5j2XBVFNARBFgHbx6DqJZlQlerBZYQqwGzDrIehWNqZ2kGeWG6hWV10X97X2Wlmybn6z1/AiGMDUhP90rYrzto2xxHUQw37n8n68jelNCoumv/oP5hMikysX0H2ObuqRkMWJPNg9PgdqF2nwTNnkWlZORnRHtbQkx0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774951; c=relaxed/simple;
	bh=/Pqk+MxYSM7qEqsc7/T6y58J6L1UCkNUahOnup9HLUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B8tVIahUw4Szn7I4/ImhI20x13VK+UGmePGTPLSyaa3C/jwNKwympIDqcsBl/x0BEgc2mELZPBluiXnpKIKkaOdwyqfnChWJkd8tj4coovI7DLX6BvjXfpj6t+egItPjmU1rvgKpvRquirhNfljOxwLqS2pvFdI5Kz93ochys8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpquA/re; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpquA/re"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd76b1361dso8126565ad.1
        for <keyrings@vger.kernel.org>; Sun, 11 Oct 2026 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791774949; x=1792379749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/g+XLRzJejSDXfAa7rR8UMy8PVmPcCGHEpvcLBzrYU=;
        b=lpquA/reFSggbteUwAZ6cq4Cjdk3sux/KhvZonNOoTtvbm6PXYBLw2ABGRJfL5Piu6
         xSNp1oR7WdfChTL3Yxm2vCppLvaXJvukChjpI5VU0CWPOcGPY9tpGEdv/ZibyK1kq4YG
         fWjhZ7hmcyt8RhLWHH9sMlfo1i+kxcKs371hRS7rmdB7eRqAoeTP0F6gwYH2kZPTfpWc
         H0yZTAQzXgc1ODdLoO1ZybSRxcJLbRUWUbX4+1dKJQYYhfBgtDAA9LoYw1WIBg6w34to
         1ADYxNA4EizVogK5USQ0TXxJMQgWhophVx2Cth1v9lN7LUsbrgDPwSPII/EMw5L0CakF
         PVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791774949; x=1792379749;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I/g+XLRzJejSDXfAa7rR8UMy8PVmPcCGHEpvcLBzrYU=;
        b=nitH0vIFZta37d1vVSa+Gaxj+37gIe1leDG6/jGyogfTk/VGOUNiDDb/PLoyBtOjHj
         gwecvMNeOoEiArNDTV6l3Qpcbc5EBd1o1k5xdYe2uKTUMDLBlkVDYCLcb1mzqwitiPrs
         7PEpF5j7PLR79iDWLQmJNMA8G8UCgYSRtxr1Khj8cGpfrAE6PsnpMY8cfvySxvVNBxnE
         RVTngZINZyAnjol+hN1SzAQqbM/ozHyPyeUpvT/pTmE+2TKmbHDXCzEDwJbK4gYOdD6Z
         mUX/J5+gxma9t2g+iNMZuSnDpn8gvlf/27r3LitD3OOmfZ2tES+jn3arpYcKXv95p50z
         iG6g==
X-Gm-Message-State: AFq9FYIPMwBOVu6ilV8n5HJLMy6qlkB6jCN+LkB2FTM6JEa+VGAuj56F
	0tjJrLDKci4o6dqgvozp/BGFvV0QDAVamAGFGze/Q9EfuWndwG2x0ECt
X-Gm-Gg: AYBFou2WUt+OeXVPUed1zvwVl9A46puAWaYTTGlxcxrkQilh0PSgBG4DFKcd1KNdyhd
	2pGxc3plETVa/Ggoacb1OiCqYAyTl4DNJaisoZrQQZn9q7XsiKiUOtuYsx2b4dtVKPB5ddY8adh
	PHb8rl/P4mK92q6HPVx1k5POi7bn2TO1AvhsTaG5kNQQD+tmvf1ntBMVQjymBX6LUt0SUxWJ0am
	ZGgUA+N47sKVev8f2zKylmoLLHudsazQTj3kG4qGZHHAsnLoEz1uVjcGnsQ6Xyi8CL5z37SL5ZD
	kvcBM3tDqcdxUxVWnyTRnPpZ0Zm8l4VgH10MObGcJ6/LOXnrbMYWcAhNlIPD5KndCXjnhvSfeIY
	S0bNgDqA+IlCXFFA8Yi52SDEoYBbH0v296fQJ/atf4A4T0cZWMr549Tva7fplbEVW3jXRDpK24Z
	WTCqxPizVnKUrBvK1KSk8y71pfwK02CDMr0cC6B9HHlP+ML1JjZY5kC5xaprrl6d0sfA==
X-Received: by 2002:a17:90a:1582:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3ab9f1a4af4mr2179005a91.4.1791774948977;
        Sun, 11 Oct 2026 20:15:48 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm14401913a91.5.2026.10.11.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 20:15:48 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	akpm@osdl.org
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] KEYS: Protect user key quota access during instantiation
Date: Mon, 12 Oct 2026 11:15:43 +0800
Message-Id: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The owner account must remain alive throughout payload quota
reservation. The user key type calls generic_key_instantiate(), which
dereferences key->user in key_payload_reserve(), without holding
key->sem. The construction mutex excludes other instantiators but does
not exclude keyctl_chown_key().

A kernel caller can allocate an in-quota user key, retain its reference
and instantiate it with a nonempty payload after publishing its serial.
A concurrent task with Setattr permission and CAP_SYS_ADMIN can chown
the still-uninstantiated key through KEY_LOOKUP_PARTIAL. If the key
holds the last reference to its non-root account, instantiation has no
authorization key, and the new owner has sufficient quota, this ordering
is possible:

  Instantiator                       Chown task
  key_instantiate_and_link()          keyctl_chown_key()
    lock key_construction_mutex        down_write(key->sem)
    generic_key_instantiate()
      key_payload_reserve()
        load old = key->user
                                       transfer quota to new owner
                                       replace key->user
                                       up_write(key->sem)
                                       key_put(key)
                                       key_user_put(old)
                                         kfree(old)
        read old->uid

Chown's final free falls between the old pointer load and the uid read.
The read can therefore access freed struct key_user storage despite the
caller retaining the key itself. Hold the read side of key->sem in a
local user instantiation callback across generic_key_instantiate().
Chown then cannot replace and release the account until the quota
accesses finish. If chown goes first, instantiation takes the semaphore
and uses the new account instead.

Keep locking out of the shared helper, which is also called by
big_key_update() with key->sem write-locked.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in key_payload_reserve+0x54d/0x560


Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---

diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f92791bd9569673c5d6534d76c58a978..b6e09921c11658c09eb7d7954b2abd5b2b7017c1 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 
 static int logon_vet_description(const char *desc);
+static int user_instantiate(struct key *key, struct key_preparsed_payload *prep);
 
 /*
  * user defined keys take an arbitrary string as the description and an
@@ -24,7 +25,7 @@ struct key_type key_type_user = {
 	.name			= "user",
 	.preparse		= user_preparse,
 	.free_preparse		= user_free_preparse,
-	.instantiate		= generic_key_instantiate,
+	.instantiate		= user_instantiate,
 	.update			= user_update,
 	.revoke			= user_revoke,
 	.destroy		= user_destroy,
@@ -86,6 +87,19 @@ void user_free_preparse(struct key_preparsed_payload *prep)
 }
 EXPORT_SYMBOL_GPL(user_free_preparse);
 
+/*
+ * Keep the owner account stable while reserving quota during instantiation.
+ */
+static int user_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	int ret;
+
+	down_read(&key->sem);
+	ret = generic_key_instantiate(key, prep);
+	up_read(&key->sem);
+	return ret;
+}
+
 static void user_free_payload_rcu(struct rcu_head *head)
 {
 	struct user_key_payload *payload;
