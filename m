Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2436AB5A
	for <keyrings@vger.kernel.org>; Mon, 24 Aug 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571021; cv=none; b=fdUo/Ss+ZAyzSbJSokP3g7iXcfSnXgDMiPUfcZjXfBc+alefB0I39eowoERXqaLdov9u+mGtHOL7bI8945kQefSLmnRib1G7tKZ/LxuaInQwvVdwSGvuON7odXJhpLU8Ltf8lCXOcy9Va+biyxFZ26jbXKrPFFJMVjDQjacsxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571021; c=relaxed/simple;
	bh=eIiHDNpGuJvlr6XzJzVZse8EFDoB8HDy4sppT9wCi+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxTz5eznYjHtFDTvCduQ2+5Lzl+rb6NbSwiW/Co67XOTY5ofzMWWAn0BRNr5/qPNdue0/cE5tGiifaBHRhPpjqx7bDPGziTXh2xJeFP081ZXLO79yZkEqjLLp/L5LK/EGiZt3KuQUmyiuuVVcoojvS2UAM6PNmYmfbiPqhXymxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8x3jT9Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8x3jT9Y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a652535dcso1829146b3a.3
        for <keyrings@vger.kernel.org>; Mon, 24 Aug 2026 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571019; x=1788175819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Yqy+VWHRiQmqGDvTYaHpxheSZahwTkk9CcTJ304p/4=;
        b=V8x3jT9YvM2MrlOBRgaZmcHR4FXpMpUbyk9NcsUuyixF2LqeSZC+16kLsA4iMJmOcH
         LePSvI+wRfzIs+INpcWdtXh6V630fe1p/GVNRwdhYszG6WcSMVKmJYP8kvZP984ghHKM
         mc6SRHOTi6oIbPB0NnUjycLLI2DlbNQmUNlMHF4sFZd12Fuctk2il0obUsksYLUFbcxx
         xhPmeruxVEUXWFwEcm+Q2Q8mrq47t263BTqEdm3BEHe8IMpeMNOHUlJMZstBT3piabcO
         0V1dVLkepeuEsBnG6B7svLSGLlxEn/p1i6qLIHH72uO8aeDnoUa6z2jLXbnqnjWwozYs
         3rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571019; x=1788175819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Yqy+VWHRiQmqGDvTYaHpxheSZahwTkk9CcTJ304p/4=;
        b=Svp7Pb0rsVI2gSh3AiuKMgocJiM01a5a8/lmGdysOmm+r6/mqdOxzWbl5v1moubACj
         mKTtMo4Nutef9DlgqexhGuHM+XL0iapF7IcjqNRWm0BSjRod3Lxg1JcnP3FquwkYeCgK
         mma8R94anxrk0qXO7REg/so2vWdtEEOduekwsx1/9Q0MOe8SeJKC6i0+Ufp6b+ax105i
         NmUxnwWX3ZIiw6xRQ5oRhw//o5npbLEi+5sOP+YnyiTvnvaQvukvJLeQ26jSZChjdJG+
         qItMYYVK1N+BNIkp+g9LHzpJtMJcHfrxMAosigOg+OrbSMlTj/X23G4qzXXvRKGpcNIu
         CsfA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3vQskiRBWc49ZuSX/3DzwxvEo2A9/yzXgR3LqC5sED7++4BUq+NfPEllMVZqpWbvLVUbMu7i44Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kbCUBefvK84ueTJ2VmMkpuuSA8bRJmbcocJIebje/lTfnalH2h
	6uJskVBeE3NCI88BbSwsGbk5cR19eZORgQKA5J/cw4FTLTQ/gaIn1eigSGRNxzl6
X-Gm-Gg: AR+sD12jSOvmYsAzEYuiYuXCtCQqB4Qo2yEIQVrq9/XDnsVJH7EG6N089BIzt0Szz4P
	dasWAcQsCqVbUq6BrEZ4K4Qk4/2pYqKArbfqAE0Zj/Y2elUciqbNTwJ52kX0I81VZ8nIMNExCTq
	cWo+DlxvcyZ7MSqBueoiYueGYrJfZjeQTIzeWu9J0JG+pFyODkAcW4R5SOo57LUgT4vNwosN3sg
	fTy5VYORrZ9BQwhg4RXvQL7+1ocTP52QYFpvjGPvBHtkyNtyBr2+rs+HQK0HAw76KpYD/difP9r
	Y42p6SM0kvjtfxakhgw2id4kibqk4IGRnyogGGEUo4mg+5IskWtfVJtlSBV41BrKRNHo97E68li
	SdpSiyQ2fh9dyknTobe/7LNfAjVz0JR3eAtjhoMNETOZdOGENfWJBVVP6riyIBdBQQncziK23Je
	ASUT/dUBNLPv1scc2/H+Vjq5lvshQSxWw941/I+oF7Ee3+dXp7hjlTonDiP2S6ypvsDKzeoWKM
X-Received: by 2002:a05:6a00:3690:b0:84f:d7e4:3404 with SMTP id d2e1a72fcca58-8520be6fd22mr30209102b3a.11.1787571018912;
        Mon, 24 Aug 2026 04:30:18 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f149ef3sm1870661b3a.41.2026.08.24.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:30:18 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	lukas@wunner.de,
	ignat@linux.win
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH] keys: reject descriptions that exceed the index length
Date: Mon, 24 Aug 2026 20:30:04 +0900
Message-ID: <20260824113004.3755053-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct keyring_index_key::desc_len is a u16.  User-provided key
descriptions are limited to 4095 bytes, but a key type preparser can
generate a longer description when the caller passes NULL.

The X.509 parser forms a description from the certificate subject and
twice the raw serial length.  A certificate with a two-byte subject and a
32766-byte serial therefore produces a 65536-byte description.  Assigning
strlen() to desc_len wraps it to zero, after which __key_link_begin() hits:

    BUG_ON(index_key->desc_len == 0);

This is reachable through add_key() by an unprivileged user and can panic
the kernel when oopses are fatal.

Measure generated descriptions before narrowing the length and reject
values that cannot be represented.  The boundary input now returns EINVAL,
while the one-byte-short control still reaches the normal quota check.

Fixes: f771fde82051 ("keys: Simplify key description management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 security/keys/key.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47ab..f2f472b45f4eee 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <linux/limits.h>
 #include "internal.h"
 
 struct kmem_cache *key_jar;
@@ -820,6 +821,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	const struct cred *cred = current_cred();
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
+	size_t desc_len;
 	int ret;
 	struct key_restriction *restrict_link = NULL;
 
@@ -865,7 +867,12 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		if (!index_key.description)
 			goto error_free_prep;
 	}
-	index_key.desc_len = strlen(index_key.description);
+	desc_len = strlen(index_key.description);
+	if (desc_len > U16_MAX) {
+		key_ref = ERR_PTR(-EINVAL);
+		goto error_free_prep;
+	}
+	index_key.desc_len = desc_len;
 	key_set_index_key(&index_key);
 
 	ret = __key_link_lock(keyring, &index_key);

base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
