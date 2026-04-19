Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F11D5146
	for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613422; cv=none; b=ThdR4JIOhifMgwKIpN3sLYbTD+v2DNwRHCuJ4EGrxEpGaXMDUZo9xTkPyAyziBonRPGtoyM8qLM4x2rOXP/msHfVml5dPNEHoV5RNjFSr47hiBLMPU0c4mpCbH8EhyBWswP0KNDiDL8v40H/WrfvGX7ejfVsbri61DR4yBk2Y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613422; c=relaxed/simple;
	bh=ghZiPcVncZXyb4N9ERFqMStHV3mzq4Bshv+I6uXEDpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoLfWqc6WkpmW7MOQN16ZG73shV6lvSEUiM8wwEihD8Hry93Zr1CzlU2kSpxlEcQB9plT8OZhAolBcVcrXmEbYuHseBFzTirmWxZ1FoNACTBU0JHcrqU+UQLpDYrBsNvJKv7zFcGb/vk8ipvkEIp7i57xjvi8pwCX9Avazcn7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HRsg4CDL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HRsg4CDL"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba6838e76f2so78487966b.2
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776613419; x=1777218219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/oRXVFRurK/1hSlacPxQ2tT4pqKl2JDBMWth3dthQ0=;
        b=HRsg4CDLm3mP0NGDPZhlNxBReCoEhI+zOKV/G/UDTyqLB7/FbBMbUaVwyC8Fopzmel
         oEu36wmUC0AmkNoQUvQEHaWFndnT/VyHzCdgOHDaCSmtGnE3BJtdRMqPUKN7K90i6ibw
         8hqCPkhMGs/GdaGEMqfKFq7vCRLzPXQGf+HzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776613419; x=1777218219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/oRXVFRurK/1hSlacPxQ2tT4pqKl2JDBMWth3dthQ0=;
        b=KsvywR2LGx5HRzYStYVvCjlf+SgOjwqnfp3JCasTr9f4BiO4OzMqlrbCzE6hZmm1b/
         q+P23vuAVOPsOdsiQbAKZ62+QtUnC6G+mGRIfsiG4LVK9dx+zUoA3a/vHMXoVh0Bx+wQ
         ZvE2JmQLx7E/UN47hpBh3T+ShrHuyK3PdMiubiCRx2IFhAF/KJZjRbW+RKQw6JEgo/Tz
         L4hrTvu94XErGp2YkVrUPy6dYgyq5+bT4TUXx5KSJGw93psgtIw8e1B7hzwyTrpyVsCt
         qLHq3uSU/BERNyPrdt9d51SGfhAlmCV2a0Cu4XABwbnokBURP2n27GoFJfOQuni2Ziru
         X8Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9XXWneZy8uGq+Vm29J8IKsEA7ObaynTLvPNpoi4072uRt56jfboEuEozNjAG5zYwLFX5JRJ202tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyczB+fwnfvHQ4sye3GlSvy1skc6k/oeI6vJGrtLuRPIvLmcO6S
	rCF8p/33M+zxcx2fB8dEebShUy4/U4+lh9oZ4mLmQzo67WeJw2tQVYCy+sFTZBIGDiaSnlVyGNa
	3tJnGbFE=
X-Gm-Gg: AeBDievj6AnILAAJdrG8wPs0YiS+G5UfZmuQ4woD1etPWkv3vrue/998rbXQYlRu5Ap
	Hy03N/30qdYo4qy2g4VHqhFgD2r1wTWq5nJs4ModylsGDO+Wg7mhO5+OxzhN2eTms5hid9bRVIP
	AeSbXxsDpnVQF9E+Zb9oaPWxiAAG7tjsTqqfM/kGwGMFiqU7sj9lkUKtJ7AAs3zUr01HLxbX/A2
	ToqgcjBL7RuW0Hy70jVXwMXQFGBcyJYQgK8GK4V9i/q/5lw8rgz16JT3eqkrugXKPkOsLFJwQ1T
	ekLfhof9Y2TVAnEz4thOKA7+k0ycZogHgJGWz0eDd0VIam+fPRh+yAfm5FDnzoY/yOrDYJdHxJu
	UJiYicfmoNsmISEkUp8IG8azsKy8IyCw7Q53foGIrDUwsZCoJdk3zZb9HiJYM9fa/S682+zo2Km
	mG0uOj8MZ1vqKv4smwsY965lITbD5W8quNVAcnhybm/l6JCz9eUbt0dXn0JWAo0iN9rtmUrAbbO
	c8z8XO/nf4=
X-Received: by 2002:a17:907:cb0a:b0:b9d:4301:be37 with SMTP id a640c23a62f3a-ba419077368mr352043566b.5.1776613418953;
        Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451cd8205sm267355366b.24.2026.04.19.08.43.38
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so3443668a12.2
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+oV0wwp8QvXU0PbaW+N+RPFuPvlIxSeiB9hvUnVM2dBHJs6rL3Zm/MuBqs00G+aVBJsRNLYsDkfw==@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:672:6419:8c23 with SMTP id
 4fb4d7f45d1cf-672bfdc3813mr4829148a12.14.1776613417846; Sun, 19 Apr 2026
 08:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTLzOgblMZRnDvF@kernel.org>
In-Reply-To: <aeTLzOgblMZRnDvF@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 08:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
X-Gm-Features: AQROBzD-MuYoon2JCfj2oa26fofPfJsB3Yf3SnKXc5ssgIBczbMthS2Y7Dg_eHo
Message-ID: <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This too appears to have been rebased just minutes before sending the email

No.

That counts as "zero testing" when you don't even explain why it happened.

                Linus
