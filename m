Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018C37D118
	for <keyrings@vger.kernel.org>; Wed, 10 Jun 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074261; cv=none; b=Mjo2GA6oxZgfGBAGifm+GABOSRmFw9Lfnbuq7hSF/2+SDLTLu1IBzxsxo6JvQYJa8CDWKTqJIvKQr6I6MoZqjii/36c4sWByIbbAWeCuNRKi83MQseY73U1CxQqGR3uepunykAsPynYtSMTCbyBmI4OEyEeeUAQxgyYoKPJ67xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074261; c=relaxed/simple;
	bh=79DnwxJFzJS6ztuiCswAItKY/iEYoA/hB5xT9+mHBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Brt5t0XuN+1hbduRKfjBkCyyXBQxwVls1bfZ7Bs6fdpOJEYdlYJQyn5X2bjt1d4J+wcOWTL07tSDSRCCboad4hTlkodSel7iwcpfDo3Cok6JcNVgs7/1xou505qT80Ug12Otdy2JC7ANFIr8y62sohPIxDHR+O8BPIzDbsZ4CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frYluLQZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frYluLQZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45efa80e0afso4961388f8f.2
        for <keyrings@vger.kernel.org>; Tue, 09 Jun 2026 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781074257; x=1781679057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=frYluLQZzpCw9Qj/omMLQTkeKDWA4SMnJEtf5l215JOPpOQV2iTX0ieWjG5q/47url
         ZJu3UffCYf9M6rrmyvf8EYF2eQSCoWQbRZu2Y0AxZ7a8Lcc99Klty7BLxu87G2OgoewP
         huH8o+9oxy7HsDwtce46voYMOSpQOfqxcIt5XF0uBU4CXHKgvGe7B+NO9HvWhwcusbhx
         6mh/pyblwobPdgzpv4VuMWwTNQjMsRWTZT/1J8xeZbFq/+Bo1SSNFflXfKxk6GKgoEtW
         fC1CKednRHA3GaittscWbT37SY9hzqADCcDgNNmF1SqQu5+DiuNZuf6Hl9O0rX6xsR9H
         qs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074257; x=1781679057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=sxaxgpwUupnLDorg/voiFqFV7fBiHGbXLT9OjLfdtNacdLW6OUlBJ7e13Wi7pzsfQa
         gzGYvqqmNlG+q1k4jj9W44n/DgjHy1RIPzJz7qXPIj39B/lN1BuNak3NeMecjkz01cun
         JFeXnlJLDnHzByM64DkwzE+TvE9cgLlD7wJt+pjpi4ckDRqjXFRSoz5ITD9EICKmtlPx
         IWl9+rh+Swufo7Ze/V1hZr02G0gYt+4Q8zWn/JFWfoCdRNtazp+mzGtgdcJs1B5RzdsE
         LCAIOcKhOdtD6GriqdQ2F3YRKVpWZBCLmrQL7Znqyqy+4oY3I48U8mkUtu+1C7Sarfj1
         r1Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8irFqdpB6zrt1kxDlQ6oC2vYCcYauXBH+D0WCrcj6eA3neV+Zcco0EhMMqrwCi7IxRB08K7ttkAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63BEZjKwVZWNs6IXFx5NZ4LpQ9+eetWa9eBci1kjXSMxmeFgZ
	e1IrHOUoYeSX1Syv538vC+Bc53+tLlB/oivm1UHW/OjQJ0Z1NK8ttAE=
X-Gm-Gg: Acq92OGghSi7VChXl5gEi0NHgsdxFeuR2fjcjeUeptTgy38iK8z/B+OnGtW0vTJcq+P
	3d0qcH7Hg0zpHSRQ7Mgc09j9Ru8g2xD5u90dR7lotSLjQxTfslyyTsCl9XqQTpVXl/GjCzjFOyM
	SJfdG59YKNCQ2WbgAgD/eTkv0Yo6qqL5tbZ1OaJFk046S8VwGB87EuVHAoaFCMANtMIdLaFmL7B
	bz/U3BNd8X7i1qEla72KzhjkJp06TqXWS920gl/er0XGvePo49g3jyaNHw5el1sn4kv5MeOz3Fi
	0Wk8B8fVnfP4Q61pHaFe41Sdgs2Xm44qPVimrYzTMvqSCr8ucSq8xzf7i676NQWhmdGnU+x7hR1
	0BgZyBc2Elntf68JRLNwQZjCeokjsd3DjagnPT4BDiEUrVbbP9g1VNSX4zLQTREIp3kiEdLimUY
	kdkydD7zPPGZCzI3RPKR0hgGfOQ5IssYOJrEHYjepPc5HunJ2+iReZ46ecu0QBYUukFruFhOF/m
	xlN/6KDmVK1s1M9RO5hIlO9IRUyuZk78v0KrT0cC1w=
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id ffacd0b85a97d-46030652fcemr28960085f8f.26.1781074256955;
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
Received: from hp-ubuntu.. ([105.158.214.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm69539946f8f.9.2026.06.09.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	vbabka@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] keys: prevent slab cache merging for key_jar
Date: Wed, 10 Jun 2026 07:50:52 +0100
Message-ID: <20260610065052.9120-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SLAB_NO_MERGE to key_jar to prevent the allocator from merging it
with other similarly-sized caches. This hardens struct key isolation by
ensuring dedicated slab pages.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

