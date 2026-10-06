Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136E282F05
	for <keyrings@vger.kernel.org>; Tue,  6 Oct 2026 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255843; cv=none; b=mznHZx5kbqYEwOpqLHbb70e/Jmn2OmKpiuGkkJ9Vr6admhHQdzsoZkdPZDQfWgVn8nrkNlz/9nUQaW4xf5JIQF1TYn6XKOMXnmrfkfKWbjLRz3AK8MyrlpM9GgvX0Supu/shSzIBzIgQBLH0en1UtESznwGFZSbZ0JKsu17sLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255843; c=relaxed/simple;
	bh=+iRtHVWesahzFEipR/js2nH5JPwfcMhBKYLMp7reF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAGmPBCbf7Gc5vP23sn9xCyj0J5c+OC5BqwrgWojBepo+BKY0a1K2hkhmtwTJHbZN/VyQamKm2BvwV6LL7z/m11Wz8ZOvCrReQhiwU15j8XrChFf8qLDQj7xQ/ZklA6kddlidqmU4TekstD0FFCnLi31XNtrEGXEzMKaKqHVojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dz4cfvw0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dz4cfvw0"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c315a445752so4527566b.3
        for <keyrings@vger.kernel.org>; Mon, 05 Oct 2026 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1791255839; x=1791860639; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkS28LzVsZhO5NSW9OoNXPMGjm1DC13xh2NDUcHdEi0=;
        b=Dz4cfvw0ltQkUoX8D9E8CMo9eS3fO0Vobp9YTfI8ZVqbg8rNOjhWoTcDC4XsDpbMKs
         ok3jRuN4MiGwNy/vuQcfJMy5feEtbJy6vK/C6kCyd1XNMMXoVYMBPFQx+du7yNM51Dr6
         ZGFcXNM7/QLFYJdV1VgyIEfd2DPemZNG46zyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791255839; x=1791860639;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UkS28LzVsZhO5NSW9OoNXPMGjm1DC13xh2NDUcHdEi0=;
        b=LEeoTiuqSMF5EVlYV6MZeiZZu8CcuNrozbz86bsY7zhkKG/f4E3BrXPJrlwu2QHLBG
         9xPmF3Te7LKFlacSm7LhuLEKeATigw1b4vGB6H6/V9xxzgWEfDso0Kp2ZtrcUJtoMA+V
         Xa0xoulcDDGyErus4vIXPnMW4mnvKiCAJ9ab5Almj7A9SeTmeYlmywXSsTRFIxGDBOMn
         b3OCmMhl4WOAn82n+zrwFgns5WRe2o9Ubepemvdh/vokiD6u8ZL8BHF5SWfrS/wq+hEs
         wkQw0owEDLWWOVpTW/iC4qYrdbRsIEccq8hvL+IQsid08bWShYWKZWAhZGSIeXucQGW6
         405Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxEKC2tI1BcVQD9wcvmBMlz/GS+7y+vliL+/IELhY9VXmPSEzW/yyRD2B4HUP0dSaycr26dF2IWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kgcA7SAvY2RFV86QPB7LV2m2L3rs/I+jIAgMA/JZ+Z7g7U0Onm
	1MF9Z8wdJsbnvPSojM11UfDjj2eHA7pNUQMuDbS/+dP522LOIXFFKaczIxOXTh2qadSJwEsqH6n
	9Bj/9ClA=
X-Gm-Gg: AYBFou02xrdXZAHTa6xGd+9+OkTLyMCAyVIOseagOo9A644d37wj+9OPuimbe7yedqa
	sNbEkVa/zh1Bzv0TPc4y02TiNI/33M7vJK9zveC/KUCWrdQm2oIXeT6VLfpbUxbXvVQDVenKZjr
	BKJzXuCXc/9ZIAQnivvID9QkMoKfjk9V69lNk5UIIXB9BEATRrDWFiYCfyEO5JVPFMbFVj1kaPM
	gCcOxF4xSOf0TxxX+8XUExS72EasCQpCVDU0J2gqHXAKqR5/MoXD64TYWIMrU5Rsby5aTamXB81
	vbD/67+aHScLi+4BJadRsXBEDcguk+Q3n0jHpAkGnP0Fs6NQNUVw7jvN1/cv3GJV8rv0iAK1/bT
	3pRqmS7OCPVlGS4VeRvrV5UxIMtrfJ2HO6/1OzcJeQlfl0SHSZGlu4PsvmS7w6Vw5Jognufy9Hb
	MKKNXMEdGaG5RrMCmqukerbofKLLwe3bI66PEyeomwetj0xelUf+qD7jC2eNVxEG0tf/PK7dsB5
	G5cV9UCets91NcXSwCWJyPGSky4beIhThcOKOzSPiVhGPqA
X-Received: by 2002:a17:906:dc91:b0:c25:5faf:b207 with SMTP id a640c23a62f3a-c3169ce727dmr12967666b.3.1791255839516;
        Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562da31esm152444066b.38.2026.10.05.20.03.59
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso285428a12.1
        for <keyrings@vger.kernel.org>; Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDvwy8zPV7ooCqArJCCtraIwwaVTLcOdCLKRy+3OUWOVRk19FVGa+dseurUvujKISIP5KvAhAAyg==@vger.kernel.org
X-Received: by 2002:a05:6402:510b:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6afe29be63dmr21481a12.11.1791255838871; Mon, 05 Oct 2026
 20:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asQo0Kb0SF0vZcHa@kernel.org>
In-Reply-To: <asQo0Kb0SF0vZcHa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Oct 2026 05:03:42 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>
X-Gm-Features: AclHuK_NZp_-mPHhcS8aNBup4i1rRUZq8vjroRbwWPtPYmjv6VfHjj3cm0et3aY
Message-ID: <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS changes for v7.3-rc7
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 00:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I've started to take steps towards better quality PRs.

Looks better.

It reads like an llm, but that's perfectly acceptable use of tooling.
If it was an llm, you can tell it to be a bit less verbose, and that
it should prefer imperative voice ("Fix it by" vs "The bug was fixed
by")

                Linus
