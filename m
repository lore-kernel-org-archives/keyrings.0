Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845485;
	b=yHjk/vhi0uEfe3T7tzNsuFadn6n2Un0CJA06jK0EOfXxv8uT/QjB0fs7r7D7ui1lFMgG
	 IG9/UDC0A7g/M2xEHjmKFPHvGBRp/uaqv+yh1fuLdLMxqvU1i4a3R+JMaEyPODZYPvjnU
	 aqFHslFXZrJ1l5PVjz4e5tgdegJnVMpmXrHe5W7yZnsZcXTpcuVAgcuVDRf2HtvbQEKCi
	 BZCf+Of3Fy8OMIJjEN8zSP4i0Ahs/btDgxei822NrbNaLh9CEY5KHYCI7i3xKBoRdfzXk
	 yd8alJ40HJvnqbM2Uqr08wayURb9g6dxdjVM5YL+B43huMxj88EablCEU/tFUrdKrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
	b=z6lm6b5bDcElsZuqON5AKAzUBNK9V5S3unwgljqyEIvLx9so+AACT7IPd1MyWkkMuOU7
	 pN471FO17PhLKrF+b2061rhR03khQgqufm+7Pkwq5ca3ptJfYKda4VisxTrs2DMRDdIv+
	 C0fsjnOkysfUu8seQYWEnhZYEMGU0950CHxU+AvFE9VZnCJHvmLVupks2JOXeShavamf2
	 p7fEDf4qwHoMh55fKYq83IK5/vPyVTmrnGTHlKYXFOtMwbk7/YXJFIbMG6THWavZTPJ1e
	 qnuni27WpX9GWsPg0/q265YzfQjXm5WHlConvZJsnRWGBU95yuD4G4zFx4t+F3+vCQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kooy8NWJ;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B138606A326
	for <keyrings@vger.kernel.org>; Thu,  5 Nov 2026 02:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B138606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kooy8NWJ
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso889426a12.0
        for <keyrings@vger.kernel.org>; Wed, 04 Nov 2026 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845485; x=1794450285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
        b=Kooy8NWJcFmw3Z8AeCPgH+MoCRF1OjxPp9Pmw31LD32CQgMJIuqljx0i72RopmbDqI
         JiiqvLAJFk0EwLa94SAv+JUznGaBJCnLizW7lTFSx5lNRJiLDCEDGSvhRNDDnWTuI95b
         GvgFcbeBDxyfYEVPx/pYwppXEjoIy/TcKPXs5QK+pL6s6RTwZxd7l+3p+n9vQmvyoAa7
         qkrsTZYBdwifySuGJFkPUq7S8LJtljSrkVp5KA7pECrLsY2bNztY3uCr8qTsIaWbZsaa
         70veFGunrWXxMV+K/V5uMW14o4irHArOhs5Dx50SPkuT1Q0g3Z4Ltr6aD7w2xgD2cybw
         1SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845485; x=1794450285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
        b=UWc/pCksta7ZzC/SzHE3hCi1WR3iCzRfjAu8tcPWEut0DuViq4vIANMdIK6l/rfVyy
         9x3ziHsYLpwPqekSRgWzzZxEtgw7TbqKoT/7XZFgfyMsLoaRkSeQCtjnDP2Wal17KoeF
         C/Q28EUcxBPtaYQyChPGj8aT4X8HnnF+QGVQ4agdAzzQy03vMSbjF3jdIEK24YKnqRUd
         iSKTqY3fQzF6Q7EEu4yEdXfm2S5uU05QI4ViducS5TCMipNY36WzBoKWOwultzia4Fjc
         IoYYLiC76yi8IDD379/Q2bAQZ9vmU/Xxt4sY4z3RD6X+gcC7IRvURtkafrUQGonqj1ie
         vHuw==
X-Forwarded-Encrypted: i=1; AKwUvBz0AYRRRZfu59gYJINEH6J+2p+slMSFWpXzDe0/kBM94TBDJOnIhgfommfHm7cYLrAR8HwIWNPtEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DN85D0pge18Gyrpq70ZyKepwMeJKsTErDu3LmFXhV14ns1E8S
	CwXKDLpTWudFOBxpvCFbuvAdF9YZOjJL0gPmTUzoDbdVzJwQtQljAy6FgDhzBiYjHFA=
X-Gm-Gg: AYBFou2KpJ4WBjLI3lKjwpDjwPZQXjf+O57XpKXNO2XgWL9q6UVB1JsFxxdwcFwfGCx
	obvhfmsPMOHOY1C5NxMLs9zFuC2kOHFQg1/FXo1quRkf2E5LhOOya0VJxNQhYIDbdixwKJUBWiu
	3nSi8f17fYkfEtjWj8vcFFRaaGlWWFvQ/LMMBdQJg3A4LoKqHiS2zXl8FOdEzAK8V5ZSRVHF3fp
	UOBf1Mk3YudTCPGvvMEMytSuKx1iU2iqNEH2GFUG/TI5IwhV6t3udA1CuTHbeHFye8P/b4nS6vp
	M6EykwUN1xsMPVRG7HPnrhdlwnrs7TKElRT3AKfPQVVXHBRCsEH4P+w0oYqLlPJSLTNjZH/Ukmg
	e2n6LMP1IESBggx9CyFBztcr7l/UgMe22kS14mZKZj9EBwAiTtGcPI+AAKN6l5dyU8vnoYmCLI9
	KBEsdtzN9AC9u0LZevNU9zv52CLDsgpoX2d4Nz2SHPFnHstrTcqrNSGYVut+im/dmxFOeTc/vjH
	XYL2Uzef65ICDE4/PCZLE21e+dk6qeEXuePvlLX9mFEaMXUU7gRNeMztRZgZCkHwUiI2jAHAIWO
	mTeOgbzudHo8WpC48pUdMxu3hQ7EMNdw+JYvjKOWWjpoBRY=
X-Received: by 2002:a05:6a21:f11a:b0:3e9:24ea:64fb with SMTP id adf61e73a8af0-3e9289d8f84mr12476900637.41.1793845484456;
        Wed, 04 Nov 2026 18:24:44 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46981369sm1577747a12.25.2026.11.04.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:24:44 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type removal
Date: Thu,  5 Nov 2026 10:24:39 +0800
Message-ID: <20261105022439.11846-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auvG1wGifSsoCuaQ@kernel.org>
References: <aun7J2NGn57RGS5J@kernel.org> <20261104021414.50696-1-0xbeac@gmail.com> <auvG1wGifSsoCuaQ@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 01:59:19AM +0200, Jarkko Sakkinen wrote:
> Please respond to any questions *before* sending a follow-up patch by
> properly using email client and quoting etc.

Sorry. I'll answer the review before sending another revision.

> > +	if (!params->key->type->asym_query) {
> 		ret -EOPNOTSUPP;

I'll move the assignment inside the if block, here and in the other
method checks.

> There should be an empty line prepending the label.

Will fix throughout.

> >  	if (copy_to_user(_res, &res, sizeof(res)) == 0 &&
> >  	    clear_user(_res->__spare, sizeof(_res->__spare)) == 0)
> >  		ret = 0;
>
> Why up_read is not here?

To avoid holding key->sem across user memory faults. After asym_query(),
res is a local copy. Copying it out no longer needs the lock.

> Please figure this part out it does not do a great job minimizing the diff.
>
> There were similar repeating issues that I did not specifically point
> out.

Agreed. I'll keep the switch, allocations and error handling in place.
I'll move the method checks next to the callbacks under key->sem and use
shared unlock points. I'll check the other paths for the same issues.

Thanks,
Yuansheng Yang
