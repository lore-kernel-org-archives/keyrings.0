Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC25568530
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001066; cv=pass; b=e5tgEyoDKKL5TwkzXM4ayjWx2sPnI0bp61OkF2bYCrHO4U15Sse3vqNQTwZNB5Vba0fgmdjxiHoXx1emUD9XawjaUB4gjM9LKRglDoGtksSNk6nXOlxF4lqbK3zzAq55p6KrN7YkFxgphPu4yDnN4j/j4aU2Vz2kY7mIfIvHhJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001066; c=relaxed/simple;
	bh=J+h7YdXElMiQCzhKnhtIRfCdNxjHv6XhdIMjoVUG7O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td9GdZAe0+vbvz0qEHt7S4L22l2JKMbZvwPeGK76QzFaKeJcgUaikn/vdJksKo5JWocWTKZJt3s+aK+W+ZkyeC0hzwr2xN7VoyB+1U5xXfXvMs29SNFrjFHiqTK4MapVhosga0qPyp26+3JGSZ5I4tqyla1ahTuuIlLvHIY2DNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io6KRGbR; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6KRGbR"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c31632c0dd4so54740266b.0
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 11:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792001063; cv=none;
        d=google.com; s=arc-20260327;
        b=C8fz9bTVxQE/aQw2pkDAcpynZKgHFAMnKN3GvSFz01Qx77eg/8D32UJdDFp1WK1L+A
         iY6NeVMpOS8RSdIINNopnqfcaj30z12ysy+gRQ1jGGw/1kofIkIsgLd04qFGpwG9bpSZ
         h2LrXDmu24l5MTJk1P9gi7D7HxedHVaGupT5AVoTB2nnvqBQPa1t8+QO4Scs68y5ekJs
         htgNE0W8XbHBWACllgogqxR4FHX6f2co6MSnCXpuwd4OdEy4I0qhOIgpDhxOIQevwDWB
         ht2NqwF1U2oOjxxLT6Cg27t+nZgatnMW7aFyzVDX7j0a3318CnRta3S7jHmjFc7r3j+I
         BOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        fh=/0Y+C2dJ6RysHYgCnV9m5zoqd3JfEYCKKJ1+KrPUHmA=;
        b=QGn4h9CaOCzBaWfcQyiDtgRQ9/lhYjLkUgR3lG+QCD120d1Wf9y6UJPtyg5OeP+T4K
         81PCt/Gsis7knlY9sz5Ube2o8FScvFfpRk/0jIYfpIHNQHBUx52im3urxU9/S23JtO8/
         BLaN0hTewBtf5Asz92L8a7JBgFTQhUkJPu3jEblGn9pvZqoHtFJtSuvo1rdyxojdLQGA
         KwbwHp8gNLlVePSjdShJNUU1IDMozWGnbWiVcCEeUQjwPS0oFcc295KHDZuxh5l6U4RM
         FK87gY32gCKTywUhD6DbMtP5aABMKZwsUuqXT2taWsE2qZHVr4kDwKdusPC0w2K7VLqy
         Ykug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001063; x=1792605863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=io6KRGbRqryTPXxUULFruYi3qjlA3Yh1FG+eCsD4nJwwGXDLL+Zc20XvdOXT2AyQV5
         E+irR1wuMn5uZ3OzEBxwMSHVFe6mo3kyhj0gqSCu0Q7OW7J3VH2w03AKei1N61mMihB4
         BisMGU//2Rf1SmpxFo38/aKQf89ekpE4VBL0Cor4qG7igucLNSDfuOL5bZLLfw5wXrho
         U0nU1r5/bbSFLYaqT+r36/qsRmDm5YF3e6vhDDgYNlBdL5/pZdWdnvvqMGOsTMuEfnXP
         HQVqk34YudBmKF0YSw8rL5yXYeHjtkx+LXZMxLK3zlqmKsBFe4hkmMVzqeN9c7DXh7lx
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001063; x=1792605863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=VW86us7VZz3LIemhmhLEl/jOVPGk00O7V362rmBElZS/S7OfGxApNoomvRiRTmJcht
         varo/T/elwOfvaQSNX6kqbw18KmuVQwD4PVkvz5RJI30mzVzIWFwpbipxJZlP7HtmU5Z
         VVP6a7MMhKRJDgxHc9cuv77PhUdFs/8XfrLCg7sFCtWjvXXXh5hC9QOPYxFxQCuMvt+R
         Oai6/4e/t4WI/c1p522ZTRC+cd+cCSQhVEux7XrBN8bwJ+P+i2amGyEo4A5M2TseMLaA
         ixzs0PCgYgbSd7roLXnTTArIV0EcrdyhO13glfPPCFF0mi5e8QEtW+7JGM91iXg0XI14
         SB7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7z6vN/PRLUGsT5ZRINurTV6Z+16te/aCaHTLiPWFFavYKRDuddb3VCPL6t+cE++9N6eOH9f9XZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4aHfDJYQa6RHWR7qq0nMi7iCOmdIA8UYh7u1HUu7468uL3r7z
	/vUw7gyHMIHBIqbRtCkUolidR1TL/uRIJErS6hQG11vNvdE6l9H1Od9bIym5+7f5u2ZQK/7ArLy
	6W+yX/X50nZgbu26n+qkFQsMy7gufiPk=
X-Gm-Gg: AYBFou3e/1978m12rJe6qnhJ+BwxwaBz67onSu0Z+Y88GqJQNUpfkXM7aEb/G61Q6xM
	AdVfryrEC8VkcLPeoaL1kF0dQl48Hy+gJ7TQN1pY0IaOu9WbKl2St0gwrsX1Erymn15YkjxDTSz
	ycvsUku92ZkKWK46wADJyPMu97T48xdvJnrrpb22OrhNiozv16gs4dtU00EHvEq0pWDFMEcg5jK
	Xs9Cxshliq1mmry4XHE8gl4F79iMqEREfYH37pP6dEgHCpRZNLxXr4AMkBSErS5G/dOB5V1zHNE
	K1Xw2XMEegpyUwNu3CnuTaFHAr0tbUcl7W/Smsm76d0OxMyt4GA2fD6lTT9PI+4Q3rhNrN1oYJR
	2DvI32lyT3FHXMgvYAhk=
X-Received: by 2002:a17:907:9720:b0:c2e:e3c:ddf3 with SMTP id
 a640c23a62f3a-c31a9a2d73dmr1892027666b.1.1792001063289; Wed, 14 Oct 2026
 11:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com> <as9pUYoOmLI2l5oB@kernel.org>
 <as9rFtolVVn0NVD1@kernel.org>
In-Reply-To: <as9rFtolVVn0NVD1@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 02:04:12 +0800
X-Gm-Features: AclHuK-SQplAHNwQy93oHnQprXs6MEsIoHX8-ERaJcQyBiXLt0uOAaw9EhmmAzA
Message-ID: <CAAo+4rVHykh4cvw=wvcZ+6MqehsOi-Foq6f+DjN536pbjj_P0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key accounting
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:44=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Oct 14, 2026 at 02:36:53PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 13, 2026 at 05:03:58PM +0800, Chengfeng Ye wrote:
> > > Protecting individual accesses to key->user does not make ownership
> > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > key->sem, but instantiation is serialized by key_construction_mutex a=
nd
> > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown o=
f
> > > an uninstantiated key.
> > >
> > > The instantiated-key count can therefore be charged to the wrong owne=
r:
> > >
> > >   instantiate                       keyctl_chown_key()
> > >   increment old->nikeys
> > >                                     observe KEY_IS_UNINSTANTIATED
> > >                                     skip the nikeys transfer
> > >                                     replace key->user
> > >   mark key instantiated
> >
> >
> > Same here there's another below.
>
> This was also asked last time. Actually last time (since I missed the
> spurious comment), this was the only thing that wask from you.
>
> Br, Jarkko

I'll also try to address the same changelog clarity problem in 2/2 (so
as the spurious comment). Apologies again for the messy changelog.

Best regards,
Chengfeng
