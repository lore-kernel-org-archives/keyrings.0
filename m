Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260566;
	b=NnUKl+bfEpy73Y75FQv7ROFBzaKZGj1st5WS5oxrQK7qTXUWuuzgJrG4RDkBrfZ5vxzd
	 yrXlPYLbvX/neuEA9VK1Yph4cVx6f+l7ij8+tUKxVlSQFSSS7nf1wriEMUFU7dKzFJmZT
	 wiYm7JIeps4wKJ0XbArYqMN9FB6Szz0XbzPwsY94oZmCI/n5Rb+kzZxEBXnAGNR3kGZdg
	 AMY7zEUhHue8BuXmjtrybLhkv8dcubTcHBirFGl6imaSFj0GWEE0t7H2hH9CY2CY0qIBK
	 2qu0ebmuOTwW/s9FLWdW//dkyrXdHL5I5RF+2oSea9aaiTXlAcgV62e0HTPkCuCyDzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
	b=3BsjhRPqlILEigBmSfL6VM9anJ/tnQGZXCgg39AGOUqHFCV53WGdxjPmzl/3atpzcQlQ
	 OpS6ELSl5+ThsDKvLJv8XI66I2AUUWpZztAUXwUGDWhUBb8KGRma4km5ZyHSAP9Jr3tkc
	 t9QqCV1jLxDgXYXL+vYUMIIvgm15tzahRja0QRU3dD6CZ1nZFhrqHskV9L9gHi7R1IJj7
	 N78jvAJ0FfTyPsNVIY6CQk1xfdoD4IP602AFgpCpE72AT1Ll6BKVFCndfUix5aCfOGnP3
	 02fTZwlD8/FjwCn/Uiq3tbOiVO9wC+e4q462Fg2Ofq6h6xW2LiCeMhRINHIYUdH3wuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05619606A32C
	for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 11:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05619606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4aa5833c263so1629202f8f.2
        for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260564; x=1795865364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=Wndv97v0xNPaFveqPJE73z2hBy2mVbS4EQLfhSu3Qr/NEtlcenEomJW44MLGRSN0NK
         4ebXbUWqFYFshtpdLkIu4G+V+8BBmM4hyxvT3t8kA+Oxvm2IVXPxSvGwwul3fcxE0VQq
         HIs2yWfKLdXI7nxF4IPMSF/TR+8a3cnWWtx2k85gPjqLFLunNFD8vv9NlusF/pG0iaq7
         +VRUjMsc2SpfichnmWjWT5E+IL35HOomym2W//nn2utskrI50B/79Ztt9kmhc4C+HvIe
         4sGG3nqOPrBEJuFMaS80zwwswZrzMx4Wr0D9XlEh+IYg6SwXxZju8DRH6xr/BPT7Vemr
         9ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260564; x=1795865364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=qRQwTtIF2VUN6ok2rX/v34uu8atBVGzs2RbyRZsexChAwM/zDnjxhBfr2LIafpCmAT
         BxOrxakKKAmuBB4QuQ86WcV+a7pPJneu5BiBUHZq/dPMHO3KpdbeTHrgHRb5qS3Vj/1m
         9ZsVpSrXLjcbsAEMKqVLpJ2mcolfx9DsSDsFCAopG45S8f+sJ0LHFZhFd4PoGF3+U9qy
         U3IfT5xYQ/K13rTKaDOAkBAiCI0hOW2MBeJH8vbrOfvlNM0qnaQU2xd1LrFRcu2Fq300
         4De2TZlya/9W9gn6t5jdVECCRL1VFR6HHVWxEs4YYUka8RC1uA+Qc2FP5PyHJzisXcqw
         q2FQ==
X-Forwarded-Encrypted: i=1; AL+hErHO1AwyfLAIFlbjHWwOtKZURloI/8W10chpx67x6g4P3S0p7ITGe7MEwl3dIvNTM7DAWpU8MSSodw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/oMWawbQbpDLaLHtsDbuqpmnk8QZgEb1gPJaq3u83rIgYxwI8K
	857myxfZ6wpj7fikQaoXbODqFbGtI68AUMAxy8KJXlvIduQ4KDuM2mE=
X-Gm-Gg: AZFdTZdJMBD+owu28NpuUFWf6vwlbpP9QzG5x7F4bGkc4zG11Q+5cY3y9FMIkG2HTrX
	ZMnavD50clcwXI5kF+tVWkOHlNm6XdzdxmWNhTsMCICcyBVw3bEUcW/eCAkg5MUyoGQwvRBP22P
	CQs6cRc5l0Dz9LI+VOmDXB218bWwDhv4v9b51zFOvfzR7ZyeA4FZnlVZa2RvVqg908glJoJrAgL
	AZoTDjhqEX5W2ZQTl8ygCbHFxJKaFBFpAXzq/oo+TzFqL1bZV8WVLnvv9JEnRsJSI34H3Ts14un
	PhG10LHNLQ6QiAhLmQ7oK4wZ62Nw7VQQPJ7urnepZQKhUjz7SNzOjNjXXNd+DuZ4sN2q/DK7KVO
	B9ohmM2Bdp6aIT2iRb++g6E7UtHKGJSdd2fU0e3Wa3vEnDeRs7Rf1ShXav9fFjz6pmRR703iebi
	ttimeK4uUAxsfELo00AMiqqiLIst0AjfgPqOujCE0DZrG2NQAPnpdrQsldEYx8AIEPJLzD/KKmK
	CBHEucQfw9CuCCKBdwq7Z8geV4OqVdE9005oYLMIXWXl6wKvcdLPD9T8XsCQSWtKQkHimBc8hIy
	qTdRnb492TNqpzcmSUdAPasxDRxiaZr9uxv3iA==
X-Received: by 2002:a05:600c:3511:b0:4ba:73f:ef5 with SMTP id 5b1f17b1804b1-4bb88828304mr137787085e9.34.1795260564182;
        Sat, 21 Nov 2026 03:29:24 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm37210385e9.3.2026.11.21.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:29:23 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 11:28:53 +0000
Message-ID: <20261121112853.2175119-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem.
A key reference keeps the key alive but does not pin the module that
provides its type. If the module is unloaded concurrently, the key GC
retypes the key to key_type_dead under key->sem, and the module text is
freed. Without the lock, construct_key can read a stale type pointer
after the method has been unmapped.

This is the same class of issue fixed for other key type methods in
commits 925c84e3cc21 ("KEYS: Protect the read method check against type
removal"), 51bcd09b9ffca ("KEYS: Protect the update method check against
type removal"), and bab48a1044475 ("KEYS: Protect the pkey method checks
against type removal"). construct_key was missed because request_key is
less commonly used than read/update/asym operations.

Take key->sem for reading around the key->type->request_key access to
prevent the type from changing while the method pointer is read.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..eff67c5fb9015 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

