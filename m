Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965B238C36
	for <keyrings@vger.kernel.org>; Sun, 12 Jul 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820721; cv=none; b=hzH3g/xbgSFtloaZp5JfkwXplBCBIRrbmKp0pmLLmWDuAWnpmJQjAg/P/t18K/1ewFHgUfq5ym5Czk3eJf5mba/7skDp0mpJf99baFXvJAalmn4B1PLb0kaQ+btMqWT1WOTqG1re9/l3GhuCgOaGP6XIOpX4v5IlPUN9wpSiLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820721; c=relaxed/simple;
	bh=8zs0bohkqz5AHgWLOAdTFJ4eY64BQy7weh3GYB3lFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=admfxjNQ9GDd3b93PNEtKmEiRgD0tN76p8tHBWuXHFQPk+EJBbKbj9Zc3zoZZNMXg/ZiWUsDCjwossKH9DUojAVqjo7o5dgHIS/s/+HdNOqw86+P5Sc/Dx4BnIm3GsAqFjPj/Psn0lA/Pi8fzN1TdVfVIQ9uLK31gKOV3/GEXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3H94r7v; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3H94r7v"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so9035285a.2
        for <keyrings@vger.kernel.org>; Sat, 11 Jul 2026 18:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783820718; x=1784425518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=U3H94r7vnEmaKwLo1R4SbOPWfwT7K8s1QX79QW9iMTUGT33vLdoYWQS8iMT8uJPKmC
         wI77md2l6uRBFI7+e2F4xEeBnffxSrdDWwe1neRp0MmG1/bJboBVXl7m+fO/8QJmEbIl
         o9YtTqdL8/fnzJReH5xgV2IpEFPx72MFT4ROAs21VOUgJkFOadaVUxxs8IktSWcEepVE
         +bMxJLYY7Sy0G/5sZW2iS1QlF7aEbav494PnoNVkgISiZQnKhSGkWN7t3SoaomQU3lgT
         pHqJ31Nt1fm5H1B/SPclzNf8sZxRpTADI4AztcMi5GhpmjMG3dZEbmazso97S5A/qG1w
         FNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783820718; x=1784425518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=jFGwj0GMx0CpJvyRF+2hEvOungWR84FhuftMn47qPvrvz02iEbf5aqhs03kHH5jbPW
         Ws1yRx5vW0Y0t16syHYQMrRTbfG7Czo8LdqeCtoNml5CQMMCHh8C3/IHOJMgV5skbT7G
         DaWGCJgHowIaud9suavhHThqcxozu/LuqUDQz+pODevBm5mVZRAI/kwbobFCZj/G43gP
         R5chFo/xexXCd3R3enzgFtLbYzf4K0B1Q3m8HFo5GaEpLKYSgz5kQVo1ZjcKYI34je9T
         CVV7NyTUAHK91PR6MMT/qIehHIykEx3mEqGLnb27KdEcTK0AnudhAO4Q6pM6KwRHURnv
         nnjA==
X-Forwarded-Encrypted: i=1; AHgh+RpaWWlhuA1ajZ8ZTb3LXFYWbTyrbmgLriiIJgFUxO/PeBCQy6EBrBYOvdz7iA6JX0sPzgy9tDdwRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5y/FgNqDNwn4wTZSktuYC+KdDZrfqJKgd4cOkgvmoRD3kBWLi
	Ez/ShHM7s3mQNTNDRf3IRJsiNZSH5iTbGd6Z3iIw7oro+tJjiX8ldovj
X-Gm-Gg: AfdE7ckqnh486nhcPSXePZjIWQxEyhLcQNHNvrdNPCIXBq6PrnFFoAAAd7nQ3pBkT9x
	QGD25eGZ2B+LIIgasAhLnnQi9+/CkdKHFRgCHpUDbef8RBzlSgJtmQ9AnRCV7hHdyt/HLsvbPLH
	RqxoR+4oBlMhiaTn+4pxJqAKxDFnIPYnfLCasyRTv5j2DlXmEaj/DoSZ51dnkAlSbYj9qxWS2wD
	ba8A9bX72/4Jgb9Tslad2DortQRwH7Ngmpr0lWqrrYnIATjZpJZnXtteDKdSFeFkTvrhNQCsr9y
	cTZPhANK6cfkgAecqv2IS3IZsaRZNvVvtWF86aCCu3aoLzpReQgMM8eEtKRXOmmQph1CciTOFsV
	4kNJVMBBr98jVMNkAjgksK/2Gg18yKc3vy2TAes52SbaS4toWQPWyxemR9wrsfV/oiFwL9AN1Vb
	QlXrmsiEnuiAa0hlHk5CIGhfdHmTE31uOJ3zUTbomRZZq7W2OKIOfUJkONZC9MBIztm1jL0qLCZ
	ObywlJ9zg==
X-Received: by 2002:a05:620a:6ccd:b0:92b:980b:e0a9 with SMTP id af79cd13be357-92ef29d2cc4mr535620885a.0.1783820718342;
        Sat, 11 Jul 2026 18:45:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm624902185a.9.2026.07.11.18.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 18:45:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] keys: fix out-of-bounds read in keyring_get_key_chunk()
Date: Sat, 11 Jul 2026 21:44:58 -0400
Message-ID: <20260712014500.480410-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

For description-level chunks keyring_get_key_chunk() advances the read
pointer by level * sizeof(long) past the inline prefix but only
bounds-checks the prefix, so a long enough key description is read past
its kmemdup(desc, desc_len + 1) allocation.  Compute the full byte
offset and bounds-check the description against it before reading.

The walk only reaches a description-level chunk when two keys collide
through the hash, x, type and domain_tag chunks, so this is reached from
an unprivileged add_key(2) with a crafted pair of same-type keys whose
index hashes collide; KASAN reports a slab-out-of-bounds read.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

KASAN, x86_64: add_key(2) of a crafted hash-colliding "user"-key pair
(~63-byte descriptions) reports

  BUG: KASAN: slab-out-of-bounds in keyring_get_key_chunk
  keyring_get_key_chunk <- assoc_array_insert <- __key_link_begin
    <- __do_sys_add_key

reading one byte past the description allocation; the same trigger is
KASAN-clean with this patch.  On a kernel built without init-on-alloc,
reading the colliding keyring back with KEYCTL_READ returns
uninitialized slab until patches 2 and 3 are applied too.  Trigger
available off-list.

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7a2ee0ded7c93..1739373172ad5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -270,7 +270,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	const struct keyring_index_key *index_key = data;
 	unsigned long chunk = 0;
 	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int desc_len = index_key->desc_len, n = sizeof(chunk), offset;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -284,12 +284,12 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return (unsigned long)index_key->domain_tag;
 	default:
 		level -= 4;
-		if (desc_len <= sizeof(index_key->desc))
+		offset = sizeof(index_key->desc) + level * sizeof(long);
+		if (desc_len <= offset)
 			return 0;
 
-		d = index_key->description + sizeof(index_key->desc);
-		d += level * sizeof(long);
-		desc_len -= sizeof(index_key->desc);
+		d = index_key->description + offset;
+		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
 		do {
-- 
2.53.0

