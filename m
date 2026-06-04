Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131647CC63
	for <keyrings@vger.kernel.org>; Thu,  4 Jun 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577448; cv=none; b=DuYI7T8ISW/nSfNFxSrZNJGlOhOPxJWFEL9aCpcftz85eJbtM2OJL8oOO3MxK/+bcaiVR/eHAtRKRNaPJhAgOI7BZDwDWeQDABtj0g+X6phUOIcosDvakQCWy+vFl9AeGCDnrCUHwVFQlDpLnC6c4eCKB/pM4wt/JRKr0STjLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577448; c=relaxed/simple;
	bh=lbWaJXCgqnU/VgUH+gDEW7qnj7gIAwhY6UiysV4cJx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKO55ZF0SNOEdSNSTKPfqDCCKnXytJ+vks5m8WZX9uL35WAYN+0GYYlLnauxE7j6yEBwFcy5+3EH/za7SZ3CHFG7QnjVx+o9qu/06G0rgHUnbQtOMGsEHjUazAU3BeB+JxE3dG6LU4Ck1nNNYbeY3jFZCf07pkhPUhLWTIXNGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSt/cjYD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSt/cjYD"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef4223be7so419286f8f.2
        for <keyrings@vger.kernel.org>; Thu, 04 Jun 2026 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577439; x=1781182239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJUnjTUV8BBZlgR8+Wodn126IIs4cN704iHM3h+CNdk=;
        b=hSt/cjYDrt0VUY0x8IFugiSHQesyJJpVAl1T18S5ylZRJj3qjV5UU9oRYfBFxBvX+3
         Qog0d8Ft6nXAh5nPnUf9515yyNySi3ZJOE6AJx7/ko8KZH7DzP2FsqX6Dlu9EJ0mGx+Y
         1qeQk/vB/0C0mtIXx2uorWG9q6Bfuc/1rkKzzVzC4I8RESGqfqUNYj1v/e5Zsqn2q0fB
         B2iN9qcR00JS0iSAuRsk/kpn6Sp8C9aBP/HwLyzdhXePrB/bYYZAtT4JLpRza7C8KiEz
         TdKPwfuxg1bimXLoBmibiksQegVNLLEVgAwXb97rOcYK7N2C9ycRlNacOhBtZG6DVQrw
         n/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577439; x=1781182239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJUnjTUV8BBZlgR8+Wodn126IIs4cN704iHM3h+CNdk=;
        b=aSSv6718sGrqh2JNYBA/SzI22QQmNntKfK5fcLh0kEF9Y9Jrosu8qkIdbgapYG2cWw
         yD/ZuY5q/7VinJhanzGcQG9TlPbmUYqBGhRieNcBudKC9N6PyNRi/TyEZF7Xnr/lY2Zh
         sjiMV3c97ASO6w2oyhSCXiniK5UEWN7YBErrGvneI8PiqGC/CQ1XuexJ7TTxdcqc3A5g
         TOMR1OjoB5APgzB0gHwJ2e/8mnfLqFXdcQrM0Q1OG7l3BlTGDLIHpP5jxKQB8wHQuRnP
         PFMb0x1Ze5C9eViFNQv+yupIypjiAj4tLBEQNx938Ky9Tme+genAI/m2TxzaCWYiQk4Z
         685w==
X-Forwarded-Encrypted: i=1; AFNElJ+GOodnGtKEQQbHslGWAQLNdLmmkb7I7q2bhpIXj4Yc1Wydkh8F3EI3K7OVPwsLjzlSKNLf7YFGGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwxUQ7k5GXO5TqaBqsaP/v6JF764kMdK7X6xdEr16WizCOJAz
	79xpfHWL0RXr7aOzmRW+GMhqfjnGIOBHcMXWo0l0crUdDTgpHNPj/PU=
X-Gm-Gg: Acq92OFVBZK4E/XbhDt1UbkiaA2lA9GU7ZzmJdgK0SbqSfXYKJDWRLTtCZWQ8CzOt16
	o3CinZc5E5OXhylxRGtrKueTThfnCxOxGC4MgUkcQVQOjXPlLShXzIGG8UgWu4TAcCVpct2ABhU
	HY4I4MqWG0D4ARI9+7Jf2RWqf+FUNuFkKgF57y6RY5kcIjGwloQO5AIvvMkmC4YEP2tnIZE9O3B
	I5Z8F4WMcDYqhMuvUhnnqfo881VOGSPo05ENXQpKyzpak83/kjl62lWlmzIYE6CnqkDjEazwBpo
	TdzUdtq51rAScLBu/phBVSb4Gp7vAeWZxTiwSoiIpyxrB2imHA5hJJOSycPexNjuZqoARhPvgr6
	cvlRb3l+Mmfna7axvk5ecmtn7snRaZP0Ahm4MZGg5a9C0Moomthon4qz0/gcRyfn3xTJe8GkSXw
	79rmlS/X3+CGbZLIGun13nGU+lu1wHygOBix+lQdIfGeOC061TJIsXrbrk4l3q1VZ4ZJw/cKUsr
	q+BLb1Ucw2UEd0mRxs3RXuHzLwTFzkY9hXLuMNSsw==
X-Received: by 2002:a05:600c:3487:b0:490:b6a4:9f43 with SMTP id 5b1f17b1804b1-490b6a4a040mr116278425e9.7.1780577439015;
        Thu, 04 Jun 2026 05:50:39 -0700 (PDT)
Received: from hp-ubuntu.. ([196.119.187.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm79430055e9.2.2026.06.04.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:50:38 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] keys: prevent slab cache merging for key_jar
Date: Thu,  4 Jun 2026 13:50:34 +0100
Message-ID: <20260604125034.13757-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The key_jar slab cache holds struct key objects containing cryptographic
keys, authentication tokens, and keyring linkage. This cache currently
lacks merge prevention, allowing the SLUB allocator to merge it with
other similarly-sized caches.

On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
meaning 5 unrelated object types share its slab pages. struct key is
224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
ip6_dst_cache, task_delay_info, and kmalloc-256 users.

Cross-cache heap exploitation is a well-documented attack class
(CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
merging enables type confusion between unrelated kernel objects. A
use-after-free in any subsystem sharing slab pages with key_jar could
allow an attacker to reclaim a freed slot as a struct key, or corrupt
an existing key through a dangling pointer to a different type.

Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
eliminating cross-cache attacks targeting struct key. The memory
overhead is minimal: with 32 objects per slab page and typical key
usage bounded by system keyring size, the cost of dedicated pages is
negligible. There is zero performance impact on the allocation hot
path.

This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
which uses SLAB_NO_MERGE for similar isolation requirements.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3bbdde778631..592b65cf8539 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1275,7 +1275,7 @@ void __init key_init(void)
 {
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
-- 
2.43.0

