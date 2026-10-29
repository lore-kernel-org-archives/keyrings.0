Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282668;
	b=5fTHslBTMza4T7vz9jVCB6U+Ti4sHSFFzQeSfWErhNUJeDZ7d/Q+1QfsU2FEvnWx89gW
	 ryEAd5yEnxQrfxfwtyECu8FBlYzRv3cni+nqrScOoF0rW0qg7OJJR1w3fUv+2jmTnpe/a
	 t1IgvhDRwHtTe0tRJ+5XVhokZZCIDJohhA3Ew7EkWD3fF1hV8e9zkE9nQJTIffKSpL/s4
	 B4ZFnw1WBetDbD1EAMqjjXGSBimxTvxPD4prOsXS464lOINV/3kqAO/WsgO29O4diGQ6Y
	 +PQk0H8ilaGWsCSy6LEiS43nLe+lTsEb8x/wNhvLELVuJCMYRkynXhoL53ZOl84yvVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
	b=kR1J802efEUwQabRtgeBgusTrrRUYj2nbc2KkbKCiwFs9/F5twsiANOnqHN5tcS5Lnly
	 ReCizTP7ZkI7lVAhTAQTjYAbVM4kmo7eCcNWWIUFpgTqKeiDmDZu+C9jWfn9QyUgY/LZ6
	 JOGwqcJyXq6fvr4c/F7Qo6ScsxaYrpnSf1YjXzImVX8y56dYTZicHQecY4CIEZ3ouszTA
	 I8mPJmZN+MvvvgMp1E/a8QiZPfNzlrn3wOBnmEF5qxhRfkNyn5wrRq7YnKwe9+SXROjDB
	 sJwoF2qYVCFsGQuKvOrePs/c/WQNeOmdzqgDAV1DCpQfKgL0ktO3lqU0qZxu/Jevtrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5dc86bd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95946606A325
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95946606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5dc86bd
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ad98c3fb15so19715037b3.2
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 07:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282666; cv=none;
        d=google.com; s=arc-20260327;
        b=pe350IY9YpWgR7d1GuTPEuIHNjo8+G/ocIE/abrq+Y7olkD6TlJX9ZNSyCRFtJGTv5
         btCmR6k62IBG4xlkVQavM7EQoE5hG9Hk9rc8Rs2LdE4eb0Josu9+8sm25QidH1a9QGrP
         AEe0ExPCn/8B0shAlT8Q+v04q9PXOSZ4/fjXCbdu1as5AQQh3tJZ//a3+bZipPqZmRL8
         Iw/pxJCFxcU+rWdFWI0P1x1YOR0Kcq2vJlc3PNGhihn1jEJkFtQmJ8l3SdSZjMj0GWYt
         7LHHDQl0roMNIF5zec/0a+0nAlX+4Vq9TV9dnbHuYuKBY86DG/P9cclyokatwNQ41mbx
         V1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        fh=KxSsNTFhGZQIV/U28sHI7CYzck5GFXAarTOOA4tUCWg=;
        b=CgwmQWZCBxCZiD8jWloBSmgZnWux25GrcNOm/HAWKepyLkoja3aK4JvvserpT5thH9
         XfWxQqG1ZxP2sudws6m7mket2J+XNIYqKWDo9A6/ZL3J7yyeQania7f3VcgCD0YoakWK
         /tvsM1EGdowQ6FdwWMaucgQ4uQrr3+CZIrW5OFjbeFAb5E9lDxv781KcEivxs7r6sNmZ
         gSCZQjkuVkxdwz2wwjQc3JQSK6ilPR7Vus27QcGbnCw6zXEH5LwggI+D66bzdFZ/JbBd
         IEghGW2vStVGIdTfw84zvO8Sjl8BWIXi6bW6EjikVcrjQYcOzz8f8lPmGMr2ggsynLx8
         iB7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282666; x=1793887466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        b=Y5dc86bdmRKt0Fdg7JrcFIXb7pnxA/3b62rmNTk9808VnsIAhs6WArPEI0iUxgHrL2
         kNy2Fnr55h/+B/Kr3EyDMectt3PxMyAT3K6NK9vl3HIPrlieIYtTQWO/60Kg6q5Is/Ej
         3UbiDcVYy90YvayGElyL2fIMeR14BjKWxH41LL1ZIyPZIl9L4o6HstRg2XOMXaSe52te
         E6y7yXkvvfIVtBkGQAPaSjKdchUn+jH7oFvbepT6fRIx8X1COgHBXe38/kZyxR/XfzpX
         l6Rs9SFQBXi4HJcuM/cIkFAETr806GIfsvfTVdKQoOqmVYt2r6c7j0NYzQAFjH9AdAIs
         0KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282666; x=1793887466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        b=1vewYV2HMIx/QuqFxTUi05ws9TmIOi6NuZFkJsToYMHMMFNsBI0Y/Gsh7tMBLFuim6
         fHfCLs1xoCuqUvF6/NUEAAWEg7iiTzlnpStTk2jlP2OU/q3PLYiOIecYxR3CGVFzCPw+
         pndkYyqRsNEf56XNlxsubB9trpspoOhMk2snl3ryCwk4PG1iztXXt2If4jUJsuE37pYs
         +mHRLusvIhzsZS0erp99Wpq0XGhTC6Moed/HOImzIjxjTFa84ttYirQ/vUhhy0GCBQG9
         7Z1+WtOtE5yymtS1CzNjOC6CD4rFeWdSDYdZZa/r0oDFVccuNwNwT9EhEUolxQEXf/vU
         2UhA==
X-Forwarded-Encrypted: i=1; AKwUvBy/rvs9xeTPjde7KAU4Mh63ku3WeDmbEdUqiF1YUh3r8N8lZb7rMu49ePPXnsc6laRsAoqxs6YbGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLg+1A1ujyFFiJCjHJ1yoIjOFvjOzXSIEoNBZMVwoOeE5WgJSHI
	CoIXw/jwnXmaqEf7n3qki6vmr/Q5vdb6znYSPe6Y1CC5K0H4cqhllNKaDZyLUL1mPmuEfVOO+FK
	XgZcPUsHAzuJqh+6fdGHk3uWSGiFzb2Y=
X-Gm-Gg: AYBFou2UVFQ2tGEK/OlbsZD1rSHktD9bwJE0Oy5AdeMlD3kOF5gE536BlkZRmenmlIG
	pkKhuknLsMPNewjdqbj9Yzxfi3Ab2V08+EqndGZQkyFuKWgzWR4VjPgAGhUiwIhRL2mC5bHa0Kc
	hBcMk4ikzd6UQ/qDeJyLfXHHYoaXVPoaFx1Za2AVoDgS54rEQlOXhjZD4Nh0/+EQ0OeAU0bMTXT
	fwVXRr9fjgeiwEB/NLVbvgwnEy1heWko0jw04rd13yhmix4Sbml5wY8lEOVjY08IQby8wVw2oxh
	iZM8pT4q37yg0jKW45QCBInnHQCeEAUMXCS78XlgubHtI8GyzOFLzCppOec/e4/6qH640R2Fmbz
	X7mGm3Vt3z+vPe2yZR+A8304a/0baSWpZgtaFy2w=
X-Received: by 2002:a05:690c:94e:b0:8b1:2aff:1740 with SMTP id
 00721157ae682-8b1b5bbc547mr36572347b3.14.1793282666501; Thu, 29 Oct 2026
 07:04:26 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
 <auNGzJIWFt64IMWY@kernel.org>
In-Reply-To: <auNGzJIWFt64IMWY@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 29 Oct 2026 22:04:13 +0800
X-Gm-Features: AclHuK-fL_kIzHPwfOpnScrTRCdAOv9QyH89rdm7dSYyaUfxKyQ-LUn7ts43gAw
Message-ID: <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 29, 2026 at 07:58:06PM +0800, Cen Zhang wrote:
> > key_update() reads key->type->update, ->def_datalen and ->preparse
> > before it takes key->sem. A reference on the key does not pin the
> > module that provides its type, so KEYCTL_UPDATE can race with the
> > unloading of that module, for example dns_resolver:
> >
> >   KEYCTL_UPDATE task                  Module unload and key GC
> >   ------------------                  ------------------------
> >   keyctl_update_key()
> >     key_update()
> >       key_permission()
> >       load key->type
> >                                       exit_dns_resolver()
> >                                         unregister_key_type()
> >                                           GC: down_write(&key->sem)
> >                                           GC: retype to key_type_dead
> >                                           GC: up_write(&key->sem)
> >                                         unregister_key_type() returns
> >                                       free_module()
> >       read saved type's update member
> >
> > The final access reads freed module memory. With the updating task
> > held after the key->type load, it faults:
> >
> >   BUG: unable to handle page fault for address: fffffbfff804107f
> >   #PF: supervisor read access in kernel mode
> >   RIP: 0010:key_update+0x12d/0x550
> >   Call Trace:
> >    keyctl_update_key+0x6b/0x110
> >    __do_sys_keyctl+0x21d/0x4f0
> >
> > This is the same problem that commit 925c84e3cc21 ("keys: Protect the
> > read method check against type removal") fixed for KEYCTL_READ.
>
> This is useful bit, thanks.

Thanks for the review.

>
> >
> > The encrypted and trusted types can be built as modules and have an
> > update method. For them there is a second window: the GC can move the
>
> How is the second window related to the fact that encrypted and trusted
> can be built as LKMs and where is "there"?
>
> > key to key_type_dead after the method check and before key_update()
> > takes key->sem. key_update() then calls the NULL update method of
> > key_type_dead.
>
> I don't understand this paragrap overall. Needs a rewrite.

Sorry for that. Perhaps this wording would be better:

For dns_resolver, which has no update method, key_update() returns at
the check, so doing the check with key->sem held would be enough. A
key type that is built as a module and has an update method, like
encrypted or trusted, gets past the check. If its module is unloaded
after the check and before key_update() takes key->sem, the GC has
already moved the key to key_type_dead, and key_update() calls the
update method of key_type_dead, which is NULL. So key->sem has to stay
held from the check until the update is done.

> >
> > Assisted-by: LLM
>
> Please run checkpatch.pl --strict for the next version.

Thanks, I see that the Assisted-by tag has been removed from the
documentation and checkpatch. I will drop it in v2.

>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> >  security/keys/key.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index e88548f1a704..bac2333089fc 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -1101,9 +1101,13 @@ int key_update(key_ref_t key_ref, const void *pa=
yload, size_t plen)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* the GC cannot change the key's type while we hold the semaphor=
e */
>
> I don't understand this.

I will remove it in v2.

Best regards,
Cen Zhang
