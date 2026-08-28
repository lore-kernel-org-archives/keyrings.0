Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1335A397
	for <keyrings@vger.kernel.org>; Fri, 28 Aug 2026 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895500; cv=none; b=IYZl9g2MVLaR+hRho4NP6pHUlHcI5MZs2iKieaz2Zhbasaq8Sl9oMuZEXtJDmTwAhbvdGdoraJDopJ1yMUC+wYQoy1QaJpxbwp7C6zqc1VucHd6B8HOMTCmakUnKM6onBZFDTOaqiReHbiC00MTJsbz7Jjklf4U69ACnbsH7SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895500; c=relaxed/simple;
	bh=ze4/KJ3EuAm6NIWKJY+q2AbsfJkY72VQHW9dSMtVRjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZM8HU7w1T6upQEHskS+9Y/X6jM2JT3FtKgBSRrIQhxbgljS2eSXqJK9FeMiP8SZGdmvfRZEUdjh63A8OeRhGJ7/iuzB8p01aNapNYGhuJaeauT66CiFoY4iZib0D4o6qQVtQpwduzLrx76RkbF7fJ0tzo0slXWqIpXT1vhuOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMwzSt+V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMwzSt+V"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-85339ed040aso664574b3a.1
        for <keyrings@vger.kernel.org>; Thu, 27 Aug 2026 22:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787895499; x=1788500299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOMy5UhVHi5zUg4dOHf2EhT83jF167GqUxIegg/QvOA=;
        b=rMwzSt+VhVNSMkX/YQ4dR+OJB0iEEiaQjqg30UnmniH5XnqShSMNiWdMakjtmLvgtv
         OfYZdUnLb4mefiN+PaDAjdA+q1I3Y/LLbc/+VU8v5/2wcMGAV1h1FShP/XQFadPV2U4m
         ZSMI79hqqYOXjp0CDElBc9dXq2t7n/mL6fwhySeAVfW+X52DhDnhOpDNGTaQVR+9Hndr
         k83cqAzDlcUEtUlw4KyV70wmx9/ElPn499J3Nbwste5kJLsnz4uSdhKA+iEtoVX8t0JP
         OTniwtLV3tg9+mA3NRiqT0enfrsnhjrTvjdipy6o8c/Es9pb2mnkixCcnOR06e+rj6SL
         Sgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895499; x=1788500299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yOMy5UhVHi5zUg4dOHf2EhT83jF167GqUxIegg/QvOA=;
        b=JtlzQ4MX6808PCEokhA8iwG/oO0cqeuHR3PNFNiaVK/u05n18tseMZk8MkT8Z4rrSk
         lkN3Pk9ZUX7Numpp7q/s1VtLzQ+gKvGuqxdxJNsoTK4n5NI5DnmPojBpECErpLWJRkwO
         Vn14DsGwr7tPxlqsMOi0Q8L/SxHvFBWS4KYVrGG/nBynupiIWqzNNKTLejgVQNC7ohFo
         x6rN6A03YgtBW1WSscO0NSNu6DVieXwQi6tV0uUXbrK1NxuPAZgdX5ChUM1cAHQGDRc0
         1o+1dOCUjAbE53X5j0aG6i82EDDu0hCRSH7F3q4X0NKTiEVZhP7UC8ucuVDlwTMwryDx
         SeIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7BreM+rPgTO2gplHYyZG1NaaKk7vAopPROi6CjiLWOCBc1Ys2udc1vuLZNJ4fvixSbS1O0YIR6g==@vger.kernel.org
X-Gm-Message-State: AFuF++mcMNf902KoS/INWW734hTwUFdbZVp8k2DqDB7zEvFsd+MtrkW9
	KMNkW+SAaRpCTtJNw3sCQDMQFryHNvkiSXRjtY+gGXydDgEzQUvkgzaU
X-Gm-Gg: AR+sD137LbTqxoenelUjt3wICR0uFsZHkJOjskTbN557xwfDKhSvlvU25MsXzpRI7JK
	RwCXNnJDCy0Pycga4F4Kta7kIU1e54wfMzK+CAh/R/jWMYNf7arSDOIFWIY4GEALfOkfn4t2+wW
	BlyBXD0ytwSyG1Z9vfBIvn06/t9bK/Snty62apP9mC17aSWJsiJP8tz+9FgFEH5L22YaI1sNM7l
	UOlC7Ertfp02VSSRLV9tdC4bJfHPZvtojSy4fcvlFbBxMqYbKYDVh0ZEpFsAUmH+pfyvHfcxcMm
	IaIWhQyfQ2v8hCco3C7VOjeeDOR17k8yei2OQPE9zVYLniDkkbIg5myKQJGCESOyP9+72fYTsNf
	6hTOjTT/rzOX1CRHCh3+8dSavBf5uzJNYIb5UgqcTLQK1c0EtMGE41kBgvZiJ3K6cD1veB8KgRx
	bnswENuqxNqVjAAypoktZuxdmM/vIOHPK0SznrRNUzBYMOmCAW72HPXvF2m7s+zxybvCBeZf66n
	9i9zTIM76te
X-Received: by 2002:a05:6a00:3316:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-8562b19ef19mr10115832b3a.14.1787895498970;
        Thu, 27 Aug 2026 22:38:18 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a2ea6fbbsm219433b3a.38.2026.08.27.22.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:38:18 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	lukas@wunner.de,
	ignat@linux.win,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: reject descriptions that exceed the index length
Date: Fri, 28 Aug 2026 14:38:04 +0900
Message-ID: <20260828053805.1410721-1-4ncienth@gmail.com>
In-Reply-To: <apEWZUFe8NmwgPDb@kernel.org>
References: <20260824113004.3755053-1-4ncienth@gmail.com> <apEWZUFe8NmwgPDb@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jarkko,

Thanks.  You are right that the commit message should have included the
observed runtime evidence.  I had tested the bug, but omitting that evidence
made the report unnecessarily hard to assess.  Sorry about that.

No, the exact command above does not crash in my test.  I ran it as uid 1000
with no capabilities on the vulnerable v6.12.105 kernel, and it returned
ENOPKG.  There are three relevant details:

  1. The in-tree X.509 parser does not support an Ed25519 public-key OID.

  2. keyctl passes "%:s" as a literal non-empty description.  It does not
     request a generated description in that argument position.  An empty
     string is needed; add_key() normalizes that to NULL.

  3. On my system, the default OpenSSL configuration adds a Subject Key
     Identifier.  x509_key_preparse() prefers the SKID over the raw serial, so
     that also keeps the generated description short.

I repeated the test with a supported RSA certificate, no SKID, the same
32766-byte positive serial and two-byte subject, and an empty keyctl
description.  The keyctl process recorded uid 1000 and zero inheritable,
permitted and effective capabilities, then hit:

  kernel BUG at security/keys/keyring.c:1308
  __key_link_begin
  __key_create_or_update
  key_create_or_update
  __do_sys_add_key
  Kernel panic - not syncing: Fatal exception

For comparison, the same RSA/no-SKID certificate with "%:s" as the explicit
description created the key normally and produced no splat.  An RSA
certificate generated with the default SKID also created the key normally,
even with an empty description.

The original source reproducer, which constructs the DER without a SKID,
already produced the registered BUG and panic on 3/3 fresh v6.12.105 KASAN
boots as uid 1000.  The 32765-byte-serial control returned EDQUOT without a
splat.  With the patch, the boundary returned EINVAL and the control continued
to return EDQUOT on 3/3 fresh boots.

I will send a v2 with this observed trace and the before/after results in the
commit message.  The code change is unchanged.  I can also provide the source
reproducer privately if useful.

Thanks,
Daehyeon
