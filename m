Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99215B0EC
	for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613257; cv=none; b=N8lOdPJKZLRjy/fpld3jp5iQEVbe+q7lUZmRIIAOQj6Uy3XXLCkI/1g+lyIdPjlWBZoC8bNv+bwdjDlvt8rmUiImqgbkcTqbQOoENIQGTxQAk9Hdu5F+IK0uTZLYoyU1wk9ges7A2fzVipjkMAhB9QFpBmRzydK1LQgU/hvPd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613257; c=relaxed/simple;
	bh=QL7KPy4odOKc1bH97bE6jdTF5sS1FJVzuPNk/j3Emh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALMSkjGf4YxsqC6ez/KxyEGqRNk8g2l0rY33edUfySrHkgpOH8Dv5IBuoV0yT5cfHaSbmXCCAgYgeBfSjGW8YEk7e7xQm2ehp5PGOfEEUhG7EW56VdwYTPEAGyXC1zoekHK/CarqPOr77i4N0ZYmaZ6SFpcAAHQwo3cJi92epqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYr0/ZI7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYr0/ZI7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c9d03524cso325528666b.3
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776613254; x=1777218054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DQpHRzG2dpj1+h3dh5/1xl0f5jDtHEF4mQnKjswjWI=;
        b=EYr0/ZI7zg58FmkLl5geT+6x/iBxYUrVv4WaAli6HPqELoQtC5jFA4xkdPsq5yQ0zV
         nuVLAXIGpVqLhbMgjDEIjF1ReI6ZboKzCUyE5GZIlQt8Nc5LEEYuzCaCJfOwcQRX0dvc
         gBcfdtQIQ80sh08Fv+xcUlpaXYYfQCzf6Tg+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776613254; x=1777218054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DQpHRzG2dpj1+h3dh5/1xl0f5jDtHEF4mQnKjswjWI=;
        b=Lc8/pkRhu2MZzakN5wWWH03Xu2pE08KhtIqXl4FLYdT5M6AOFLdU9yQ8uzNTqCSmw8
         dULDKBty7JQTc6qPif4sxZM9inMRvqyvR6vnfTvYb4+Zop6Qzzlqmswj3qJAjp4jXrdX
         D6n7oKv6rOn/XwzMZ8yq39KctYicJniZEJfSiIItZAeH66LvQyXbVZ6Jnl30h3yU5rb0
         zQwUB6/uAIgC+zutwX4eS+XlSQAMTfscjKVQztjont9mFHBgeJLyq6UklZuQRPYOOgXq
         +Zchhtvh4daSc4ot6qRJDrQVb3CSWrjbOo2v5aoKk4bAmFVNCuCfhoL94i2Zbbohe0ai
         ZdgA==
X-Forwarded-Encrypted: i=1; AFNElJ/Vz6JLhmDFZO4qhwL3pZRPgq4HE20qAUaH0Q0zgDxrptgJO+bDenFBNBW5N6KmHhx6vLkgXoBYEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl39niz2esAU9mwFEKbgAXmsl89M7WCeiY6BisLSmIYKWQa1hn
	XAUs0z4JJZ0+ZpiUAUpZ5IEMYzc6cbwNSn88SpXWwBSQbcUf5BI4tIkeXUQujsA79NJkB4nOU/1
	KVqykKEQ=
X-Gm-Gg: AeBDievbITqiId+de5SnUnehtaBG5nbvRX9Tep9lmFHVMtSS+ajvuQnu8ntz7EK/OI2
	FQ9M2puIG8DlMbdMYx9i05K1RfCCh55etajaJ+6tGVgFIJj3Hpq5qB4Jlf9Iz1Z/EZQlHv5KkYK
	kB94Jr8WdXSgi6zQVk7Sq6h08jjgMf6KPjsUVqQvzCR9zIfIig2tKvwsOj+D7mIXfKuEtGWDOLo
	c+EmQQgAwEt/7iSWUML+3Q3OE1Mvfyo8wi9KRxqLh9gTPi3G9s6tD9LuBgKVfAcXWOmoCCm6w9v
	sKUy+CTXvLvOow0de+k2j+dBIf+loafndRbli99USaVjaOlZEM/PfUjWxY4fIRo114T8+UxgwSE
	A9L0VpQ/zTgg2/WYFS8Mh94C/y0+MqmMi/W4u8xe6YO5+LId7uldnFK69eQVP1QsC7AClUvZFw3
	oEvgEngmGOUGwUTFOlVunWeGSE7NfZg7T+YmCMZYIfPLyDnG1bHb5vZsECCKZvwxNZnr7iag9DI
	F+kPZEe4xm4LPOZDxiEaA==
X-Received: by 2002:a17:907:3d09:b0:ba4:afcc:4a9 with SMTP id a640c23a62f3a-ba4afdb4b75mr400730066b.45.1776613253526;
        Sun, 19 Apr 2026 08:40:53 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455045652sm261742366b.51.2026.04.19.08.40.52
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 08:40:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-674b1b1d29cso838564a12.3
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 08:40:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+pioJIq9RnUijiS4dJSfh22IWAJ370nAqsLuZHsnEIvU3utMCscu9Uh73q0shzyB4WUtzR6trEpA==@vger.kernel.org
X-Received: by 2002:aa7:cb49:0:b0:672:75b2:e8dc with SMTP id
 4fb4d7f45d1cf-672bfde2481mr3319839a12.24.1776613252524; Sun, 19 Apr 2026
 08:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTM2CO_mlNYViFU@kernel.org>
In-Reply-To: <aeTM2CO_mlNYViFU@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 08:40:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
X-Gm-Features: AQROBzBbPG47JCZ2rrBAeE1uhqsels3vK-f4rGGurHRaQ72-6a4DiEdzOsg2MtQ
Message-ID: <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 05:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains accumulated bug fixes for TPM driver.

This is all very recent, not all of it has been in linux-next at all,
and stuff that appears to have been there has been rebased.

Why?

            Linus
