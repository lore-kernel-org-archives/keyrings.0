Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699638;
	b=enJ4r1YHOUIhfnQFX2qy2AD2ei3LV8rmFBTYddkkGLtuaBOB3or0lcmbCbshk+ewJStp
	 W0P5u5O9pZMvtja2t+0ZGb6+y40wgufwuMBSy1EV/k9CsMPYK23gHs9ksJEQW1uGtjmkW
	 hBwtc3EGOF5BrwyNAXYIAEKJgPGFzuGH5BBgyP+z3Z0ace+vG7jp/Jpg8borW0EYDAg/U
	 80QeuGffEPk5PzmM/uHEtATst4UBgfvHfcVeMG4pF63rz3MLdwv+LuHJCVLW1jJ3+e0HH
	 HArE9V37tGu3/Kb3mEW9sFkmWRjbJn8DKSmyBQytI3RhnhYfv0o3L9Nkvsbz/81/djw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
	b=1UJZBHtl73LhB0C2/AMbcw1CnsD3LAKUUF7MtfHWEGH0FJKoZ0aFvpdstbpJ9jqkHRCr
	 9jqLEIwCQ4xKexy0UVn8thgc1yIEi/q/TPu/aNV9rcGr4XdVnpOVb6RPJR9KrpQRN0g1f
	 xxwe9eXrEAMlH6mTr79lTB6tgZJ+ea7Vqg73a8+dJr8JeHPmNfeVX+oyyrDIrMhWaH/gA
	 ICaxCvqdsyqdH0ohNxspeqV7OkicAo+0r+e5arT7jtgt+wAgl0V+cUvB3w2gknF5tkZfJ
	 9xdcyAirLYX/nvQckQeNckmyPo762Pq+9UyiRXa/NXh/Mmk7G2Tl1k3ssTPLSrifE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Osb13x+5;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F8606A31F
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 20:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E41F8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Osb13x+5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20b122af8so1744445e9.0
        for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792699635; x=1793304435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=Osb13x+59CHE2TJjxc8hBoRM5VGQRODqLH8vySd15DcuQBJ5W71roeDUMhbnZdwiwp
         PNGsGUtaWmDw6R0Srx0NVFHSNWLzlWNCEkcEnOqE+n7wThzS9dVNDvtyReUM1VZz0Moc
         vdJSA+2D/y4+9om/8ycxv/4BZ9r/R6ef+zn/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699635; x=1793304435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=FADwmWD4gqSO6stnbMvM5VhaFzleN0NirwQtQ7ye0wIqqIUo0RZ5c2C/NVm9bZbK7q
         VtW6PqnyoSRnYOXcWajwOWGxRBnxeDCsoiXIO3XdSTDTCvGS6l9uMKr33iEP6ZWRJ4YR
         WkyPY8Vza6FyW43lORyZ2RCItL1wcqv6WVfo6MtjwnlKLhd3cMTOdvErXKRyhRHQ7Rui
         umKoohGn3Vz67cEPe4CnmakbFw0+XEqWtz4zTtf0d6F+dP67VgnjkthS7hXqM0K1jrk4
         v/FjVj3VirDbJpl3BzSKTnEvJh9+5errATLTWs1gIIgEvZ2nBBcblijF599+L5SE1uh/
         HFGg==
X-Forwarded-Encrypted: i=1; AKwUvBzq4G0q3rvE54589axIYmz5zWhOO+6SFct6L8N5724yLdJ/dp6QOE4kHNquzex4BSMxzZpmuIZVRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKxE+hUI1CbvTLSuXcwJfsE9szDTMv+1Se7/nDHneDQTfWouLlE
	Jv59VHv5I572sunCD+itTyVayjDaRkkSMucOK/OQtQPEcXoxFJMsSI6IDqBPQvywuliBjGKP9ys
	nby6FR3E=
X-Gm-Gg: AYBFou0uaxVGQyd5Tzp9lXuI1WE2N3AxPcZ++fe8Q2sJAcngAuwGlFYjFEtzGMdTYXn
	DDisd5mS6KrQfSmwSH4bkA/ACa8+fmVeZwYP9pSYQ6/PO1/W4tfqOijYO7YHQoNZ5StgY29WTdS
	aaGhkOm9B4BU+djzVDC1VguedK+mqChoy49P8GRcHCZM4BpGstTNP1+IfeKBscrtbMTgINxXLnR
	e2OUcOqyOPBqFNjUFif9pIGqYDC+AkJeVOP0wODzXfayGVGRGKS+oK2TKQ6BLhfYm0StykZX6m4
	HoQ7VZWek7CKp10flQhA0Fp7pKppc3YElSHIaZOGVByA0YyobAIJUHyGy3fxLwNEuUWIviSvnPK
	GmAXZgVo2d147aemE0Yh1IbA8vgDgrOAW4/WxIRVMnpuAUIsZCcH8+z+h+fjP/9xmhUq9XlQJos
	nWzvyxyjImM0d7BIT8cRSWVnHc39peoII8V6512ZvoMMLEuFsC7xQ4tE6t6W4PgZOvMAWBUrEO4
	6savHyrTEPVx25m7A/ySVBvFab+py5qqdD5DTbKkBGMUgYDUQK0m3MxadkEet7G8tOIHeAaS6TJ
	CXFtiUuRrspTRh7Wb7vz81wE5jkNRtA=
X-Received: by 2002:a05:600c:3507:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a211c787eemr2703645e9.1.1792699635299;
        Thu, 22 Oct 2026 13:07:15 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c96badsm167861a12.14.2026.10.22.13.07.12
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 13:07:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so168967a12.2
        for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 13:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvt2jH5u9WBrvh4ha0XFq+LGUtABKb79Y9Pb6+q3icZOdGAAhXHVveXRedDSm2Sr2B6j5UJ7qv+w==@vger.kernel.org
X-Received: by 2002:a17:906:dc93:b0:c42:a326:78a9 with SMTP id
 a640c23a62f3a-c46a940fb59mr32870866b.42.1792699632620; Thu, 22 Oct 2026
 13:07:12 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atjKs7PTN8CgndJg@kernel.org>
In-Reply-To: <atjKs7PTN8CgndJg@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2026 10:06:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
X-Gm-Features: AclHuK8nlFozT4sO2BQre7T2aT1PPMpnD_lYchNmr_bb0lScPlgwfBadd1Pr8mY
Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 04:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> A patch that Kyle Zeng submitted addresses a critical bug [..]

Note that breaking local KASLR is not a "critical bug". We just call
it "Thursday".

Breaking KASRL locally is trivial using just all the normal local CPU
timing attacks.

KASLR is there to make remote attacks harder.

               Linus
