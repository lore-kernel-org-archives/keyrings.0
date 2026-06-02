Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC93C5850
	for <keyrings@vger.kernel.org>; Tue,  2 Jun 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393357; cv=pass; b=CBky7VEEQMvDfHwt9mTFeWPEMtiQ9TFfYt2K+VgsianHmlOPd9fQXzb0WockdQFwINyBLOr3rv9VKYl6mBMhEiF/F2ICt01eoNPr4CHDnveRewZJmUKbkoObRH496TtE5aKphEDSlEHu76aEhi6wXuttaXRwDhDG0d+6HpkX3aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393357; c=relaxed/simple;
	bh=AhL326c1YdAwbi5q6PvrTRQ6TefqA6HxsocAsD+zo5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lp077cKj0Uyz7ZTqimFCOU1LZxuawzU0/V8yR2Ea0HZz1zevBDq5o0NySREtNGuRVP26FBhIHPQZ4AmNsvSXHMPO8WXGPqnmKeRp8PHttXisp87ueztDMWffQwaVAF7BcpdoDwnjgQO68bZhRJE5fsg9mkoc4KBE79CGpllfQvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctWka/32; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctWka/32"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4863cd41330so635280b6e.1
        for <keyrings@vger.kernel.org>; Tue, 02 Jun 2026 02:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780393354; cv=none;
        d=google.com; s=arc-20240605;
        b=hjJo0+NTPVhigcVx2NehSSG0emsiKuLOYSpvql3TxzhmApFVThyCDmwr/UT2FS5+Ab
         SGUeMiIBTEhU1kMkI6GWChiHyY2UZmACqqhNsYPktfWyo5B+J6l6evwTQm69gtwv3wKT
         t3v72de91VLGB7UTZJONjysKI9dOdkoc7OBuQ4z2g+WcDkypKSAmJ3QOmrYhI/dn02jg
         hdUJMXIIP/jW+bdwd/k2wgbYqcxAlb/Tw9a4L9V7/VDwB/wO/U2xFbe3M0Oi+02JX78U
         ShIFMWFiIN7uit2HKLVoFvYTToHiC17FpFBzzhyc7wQ8mul1r/18shLbuuhaZBCQlIzV
         5niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        fh=x0Avp0yHKkWbYaLpKySTs7JdRaCmjd9Uk78hwJO4J+Y=;
        b=fNcf5rTQjfx/voroP0tgav9QbNHr93O1uIMF3Lu6t9SaRmIpV+ZoX2Lbg+PAfUrVOc
         +PHunND/MhVK3czQJpJFCG4ghMyFQSv8fTwkBBgwB9Mop9TZSnudTVpVKvYV8+UVq6ED
         1hYZNs89UyiW7iDTtBAXoPiWGtihCiTbeO0li1C3M8GRI3X1IIhpwHm2HC2xflrYkyIO
         +H1/5qoNSVFWMd68mdC6l5M1xEjeFIfpgyn721qGPvs2nzgalKS8sbLCtI8fohu4Ynb/
         XkHU9Kh9+mpvFwjm0VAdYXpj6VI32sR4nza5WsH1mOq0Cn5AVR6qPvWrZkYsOMqfWJRi
         nxug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393354; x=1780998154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        b=ctWka/32L0p9k9rRF89Abbcq4eFeaMTFfzDIYlQ1ye1U7jMF80LqjJqMFlFUf2Esaf
         7bA02vZfCW0AkXNgJMGBzlbmv2Z4i1bXrhWR8jbjd9WQv1JKE1w2XJk06P3xuWB1zR2v
         JoaGqOrwEJuTrFPJLXAe1tG7tb2ircWgiRdqqDFS7MkE3z65hAzJMIPab4B5JMzCe/QH
         tKYdCeX4aWK904g0qxJuoic5LwlHDAJvsEgTguYTHqhqEcfOsmXTFLoZw2N0er8d9THx
         ZzrXfzojP4kiTcLMRquOIuytExLNseKC5zX6JOQXuEv2+kJ5LA7AjLI8mLAFiS8EiHQH
         0P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393354; x=1780998154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        b=OZFJEKlM0i6kyQPsBGKPexdZRtjq4aRMRbDo02rk+UHiyhHMbZ7lvgBE/xzsEeBxQW
         X5wrlXEJO9vRH3og1mZFtL4/xyazIze+AvOLUSyuLPcP202wJynlhGg1d7lDiM7WzJzZ
         CY5XOR2Il+YagsciLly9TxucjI6SFxQHYNPu2YanJdk7Tky7geW/IfvAQCazC3wOWTwk
         88C2WOoQv2LQIOrys5Q38KM7qZQ4Q7rbiYzqWaeybtGu9tg7/oAMNXmk/yzOMo4w9kBL
         RHxsZ/KC8kiWxsVWdCrojbx3MaLQel1UsNTg96IamgZtKNYVjyPvDLt/rEKlXV6khLDu
         w4mg==
X-Forwarded-Encrypted: i=1; AFNElJ/Py6y3lxn2V708hUANgpC7PZyRWyLQNNfTq+gXV+ZxdenNYFI98+sgx7CUvO8y93sL/Ju3v3Iz6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjXqPFHg+FurL7ekxCdVpE2r7EcMsYzRH0L2cSdvgLQYL5y9O
	5CmPFI/+ZfQblYhUj5nVSbJra44aeyqDqClsP8QIpHke1ur8Gbm4x3sld3qUBXsHm68HTnXdP8w
	81eVgHhdvQK7AyFchHEsgO47uIR9wPG0=
X-Gm-Gg: Acq92OFZXsxtmV8zimMVd9ilMoc/tZGDer8v7MocCPb07Wn/lAt7PE4Z21ORZKCmuF5
	TkhD+HmHqG9wgk2KTd2u95kdsNdmj7UiabarVddEU6kVCMnGpme71CW5JCuzMAepC7uEOmFbSxW
	2F4GLIHFUxQK8P5YWEUV932H2SIwNtlm0mseS4/BsydUUawtuDVH2KL+GRUAJXnrE3o49IxaF68
	IKgIIlZeh4Ti8/uRnQRFoqECGRZaw16u2TMq6xNZPMXxabxy8vzDvpacbsFsuuxMCPmDJr1rhSR
	Nu9skwrMkKraNP2wE0OHA8Xrd7sZN4Ci4RYILseu2++WHo3Y3VFCkB3E1DquA99eddih1YldpDO
	7lnNAXi2ZCm51vI65Lecs3FE9A6+i1CI=
X-Received: by 2002:a05:6808:e86:b0:46a:17b8:bd7f with SMTP id
 5614622812f47-4863e7c2d94mr1611036b6e.19.1780393354616; Tue, 02 Jun 2026
 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529033406.20673-1-hanguidong02@gmail.com> <aho3CYdv8lQd2s85@kernel.org>
In-Reply-To: <aho3CYdv8lQd2s85@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 2 Jun 2026 17:42:26 +0800
X-Gm-Features: AVHnY4J3U44_QK8F7qYis9j67ueNmOkF5BG_lTDT6BBkwq5FJDnvTbsRP1vkKJE
Message-ID: <CALbr=LYaca4+=hTsZJORQfrtzyUAGo8c+4ZEgkzgkFWQDWNJBA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Use acquire when reading state in keyring search
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, ebiggers@google.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 9:02=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri, May 29, 2026 at 11:34:06AM +0800, Gui-Dong Han wrote:
> > The negative-key race fix added release/acquire ordering for key use.
> >
> > Publish payload before state; read state before payload.
> >
> > keyring_search_iterator() still uses READ_ONCE() before match callbacks=
.
> > An asymmetric match callback calls asymmetric_key_ids(), which reads
> > key->payload.data[asym_key_ids].
> >
> > Use key_read_state() there to complete that ordering.
>
> OK, so... I'm having a bit trouble understanding the exact concurrency
> scenario you're trying to describe despite I think I get the fix itself
> i.e. it is not pairing with mark_key_instantiated?

Yes, it is intended to pair with mark_key_instantiated().

>
> I'm a bit puzzled too why this was not done already in the original
> commit despite introducing all the primitives.

The original commit added the right primitives, but this site was easy to
miss because the payload access is hidden behind ctx->match_data.cmp().
For example, the asymmetric match callbacks call asymmetric_key_ids(),
which reads key->payload.data[asym_key_ids].

I also checked the two pre-existing issues reported by Sashiko [1].
The uninitialized-read case does not look possible from the code, but the
cached-error issue is real and was dynamically reproduced.  I can send a
separate patch for that if useful.

Thanks.

[1] https://sashiko.dev/#/patchset/20260529033406.20673-1-hanguidong02%40gm=
ail.com

>
> >
> > Fixes: 363b02dab09b ("KEYS: Fix race between updating and finding a neg=
ative key")
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> > Found by auditing READ_ONCE() used for synchronization.
> > A similar fix can be found in 8df672bfe3ec.
> > ---
> >  security/keys/keyring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index b39038f7dd31..243fb1636f10 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -576,7 +576,7 @@ static int keyring_search_iterator(const void *obje=
ct, void *iterator_data)
> >       struct keyring_search_context *ctx =3D iterator_data;
> >       const struct key *key =3D keyring_ptr_to_key(object);
> >       unsigned long kflags =3D READ_ONCE(key->flags);
> > -     short state =3D READ_ONCE(key->state);
> > +     short state =3D key_read_state(key);
> >
> >       kenter("{%d}", key->serial);
> >
> > --
> > 2.34.1
> >
>
> BR, Jarkko
