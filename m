Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793438254;
	b=qOr4PGKTaG/kf91uFsXyExEX49VyjQkaSzotB2woCrESsJVkBWch8Mp3Wj+O4zdvvWsX
	 z3MQxcYEKzB/U1Ai5/U6kaIputklMnMydJcjzmW7t4dHebiuwf09rQEbSqr2J7x2Kqshj
	 Pk9x05ZyTY0aWMLXBsIhti6goLPAxYcyLHGcZLomSs5nQCy8M3SPog1eYC53IoMa/PLco
	 aSSgbDyoo5vx1QE7tsMLTGK0UdT5pTwp5Kgqr/jjkuh1KiDEZPcpHXP3js1Afl3n92x+1
	 2IEAhnT7ZwYcV5qJmUUWVTAdibGLoM9OzV3Ze0VvuXX42wEFkuOChL/GRwnMbVpFLAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
	b=Qc+LpQ5Ye3e+mEq8QyQTsNUHkx0H+gx7joTuAtlunQwYh3P8IYZZRKzCty59O77ohYKQ
	 uFrbCH0yaxqZ3TkaY67GFlaoxPvL9QzUsLx39PfDwL8C5V+bxtnEszmTQacW10y4xZaUh
	 kI+0qJ0/c9VQGK+KEOaq1gp5AwQ+lQtZSZGFHRvgY1kyVR8GQuFq2qOW9E3aj2LcXKIwV
	 oQauUUlR88H9B3oW9qfZLVXXg2XphaTzqCa1lafVNoWCfnGsab5d71lM/7xIpNWaMgQXm
	 RRvhUlHYNFk0QM3ogX/wAZ4sthfF5JdB6rcvpEyZZ15tNw9O1mQRX2jZM1EhaVcP7xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHv1JGaS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CE606A31A
	for <keyrings@vger.kernel.org>; Sat, 31 Oct 2026 09:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHv1JGaS
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b10ac6ab7bso13024167b3.1
        for <keyrings@vger.kernel.org>; Sat, 31 Oct 2026 02:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438253; cv=none;
        d=google.com; s=arc-20260327;
        b=oNDr62oM4iq1D8h4FXNKBoRsg3XbONE+U8ur7hhDjZAGkwUrIq9+qGi00MOgZ+e75r
         5bep6ASZpuoC2BhdUQorX9naXEXtSokDIJgPfjAOFGgBVKOj6NyhNDoP0jsBDqOd59cx
         Ah+whu2BQUVjNsba3qNbOIo0dXLOrwfmCOJQYSMcqOHh4u/NdEExk/O3jgrBNDaJePdo
         oljB9kX8AndKjIl6MexZ7MQe2MGlbRPtULIqMHfmVbhn/00ICT3tXi0qhT0jV5Y0GsMc
         ve6oKLXX+UtaVvR7/pZY51oAHWzR9Dgm2VPtGaR/fwEn1srFiqUPE5WczS3vBtX/9ZU2
         OHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        fh=5r2y9JCQD1VoprhxtzrMwU66q8ahqQUyxmc1z6sEDD0=;
        b=P8eT06HzbDqH45gzwRS5S8MviocL33M/pD7yIFEDaJxkzK3Jn2qQjLnqno3R9XTZ1T
         Ezl/4Y6lKRtUb0FUV1llh/M6tyqumL8ER884sv9VVS9TRx0l0GegNU93OzDFfArN0WOS
         fL+UC5nJZFv1EetQF0y0NlM99gx0Cb9u/MOOgjygEGTS/YdUDrybDT3R76tckJsxhUAq
         z3Sfr4xygH+bOy8bPs6Ic4E0DWf2T62CU5rWIkXMDkLVtS8LVcsMIEj9jMxo2c+MGaRp
         1Iwga3G9vmQbAfbeEN7GYqdgjS7jNgCXvxmMeEi+olmOJc34x1wIIYr0MwA1uyVS5P6z
         ///g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793438253; x=1794043053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        b=dHv1JGaSJQ0lIjgjdsJQ/T+jwvdktCHG6pzfrydTGu5Xw9fFXwYB7t2cR/CqgbFJP/
         46QpD/MoK1pCb5xlIOo/2w70imGPVCOXyTBtplXUfP6Wcdcb5HH/4+FFqahkonTd2Vtj
         TqyGVSTUh9YLVxsuljIHR9a/CfIHXmtsD4XpKbnegtLvAK3kuOAwYg/jArqITOz/KvQs
         DX1W/NIj5Wmbs9CZ4fHweR1xtOqx63eWR/2XJt99+yjEZ2KVQMRizLOFtDwdtkCfeAKX
         YZMfsSAXJ420MlzbNBB9Z8xpHlTaTu/3VDtNcICnEHMCD8hotHC04Ri/faE8HQnZjkeI
         ffog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438253; x=1794043053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        b=dLRxOykLgEWQxHDKoL6b+epnu5OE7b+vgLTxKkP0xuzyUd2Ye76hn8chlYvo2c6Fb3
         0AodLflHcUXplM6koPwj78SHSdazBvnDoIFlxPP7s+fpLYfDtDRf9r/hV0CbinQrxpa1
         opXQRd7Jsj5fPwcq43Dwcqlrem3LqO2kRIkcMa4DiR/FFei7lmT1VoOjOY89f+/YyXuK
         CKCK5XxgDa29DFinsU3Y4lrEJB349EibTe4drnudh1b/115gSzhwo/J1QCVvhYODC8Tn
         xlOtPXQ9KExjNcuN75kWFEsKqR2d+GJ5CIZINJcsgQXka1xaGOXrxYI6BZ6OJU8L6Cud
         sfNA==
X-Forwarded-Encrypted: i=1; AKwUvByqEVjyXZXVjLFzt4tYIx0svQdXOFXqGSuqoVvozlx3AW55NYn5Q1W4wTbKuWw+qddXJCR/JXuTpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKqxkXsCK2u/HItC/rparfxhhntA6rRmNLGzi6XqrLO3smaO8qP
	QaQkGnR0S0zAw4/jeGNbVTTDuofPICtbMA+J7krgmiaGpj7rK+zS8cFzl9aliKzRQ2KpnUsxAtT
	JXBlTMLSoDiKHg4mYGHDUI9TzlGBlsUs=
X-Gm-Gg: AYBFou2mg56lDod6DQG0bM0H+OH2KLqU627Z9UszC76IHng+NLeiCCGFc591C3eBG5t
	DKQ4rvNluDblX4hH0Kj1FfyL9Sr10HdtQgC1PTKROGfHKxig5ESfzGgzS3M7+LqVszHXqwYvasc
	brioxUMf4tqG61H/BvFskumHGohl6ShMGWNy/sjmM0j+IF1+Yow5yLGvHTQjHkRA0i2TeXe44lz
	GS32mGAeQlPA1bYu45BKdm6aZ85rKXFlAh3dVddTuKLBCt+BxARC/HLr5suBNte8zIXGsVNdjM2
	OjodsniUMmqvkG2VUwZABRgiHmR3/NRCx4hiJFF2fEacmE9akM7E5kDymoRUDKr1tJakjKXFDWD
	Aa6dkkwzvL99Hy9CVGIhqCNt8RNE+4zFlUqODbNE=
X-Received: by 2002:a05:690c:a213:10b0:8b0:b1dd:c096 with SMTP id
 00721157ae682-8b2b6766de7mr18897487b3.45.1793438253362; Sat, 31 Oct 2026
 02:17:33 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
 <auOqlAt45H-tHL1m@kernel.org>
In-Reply-To: <auOqlAt45H-tHL1m@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 31 Oct 2026 17:17:22 +0800
X-Gm-Features: AclHuK9IbevS4ctSbg7rvkeuu6J_gRz-ZgCQTTiC4oQDoaBTux9vs9KH2tGOkyY
Message-ID: <CAFRLqsUy5LcD6CFnqCfjhG=SL_9T=n0LvMMBZnsJXHVxmnLheQ@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=94 04:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 30, 2026 at 12:07:08AM +0800, Cen Zhang wrote:
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
> >
> > For dns_resolver, which has no update method, key_update() returns at
> > the check, so doing the check with key->sem held would be enough. A
> > key type that is built as a module and has an update method, like
> > encrypted or trusted, gets past the check. If its module is unloaded
> > after the check and before key_update() takes key->sem, the GC has
> > already moved the key to key_type_dead, and key_update() calls the
> > update method of key_type_dead, which is NULL. So key->sem has to stay
> > held from the check until the update is done.
> >
> > Take key->sem before the first access to key->type and hold it until
> > the preparsed payload has been freed. Once a key exists, only the GC
> > changes key->type, and it does so with key->sem held for writing.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> > Changes in v2:
> > - Refine the commit message.
> > - Remove the code comment in key_update().
> > - Drop the Assisted-by tag.
> >
> > Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261=
029-v6-3d92b2f9693854230a02@gmail.com
> >
> >  security/keys/key.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index e88548f1a704..994a34a80c29 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -1101,9 +1101,12 @@ int key_update(key_ref_t key_ref, const void *pa=
yload, size_t plen)
> >       if (ret < 0)
> >               return ret;
> >
> > +     down_write(&key->sem);
> > +
> >       /* attempt to update it if supported */
> > +     ret =3D -EOPNOTSUPP;
> >       if (!key->type->update)
> > -             return -EOPNOTSUPP;
> > +             goto out;
> >
> >       memset(&prep, 0, sizeof(prep));
> >       prep.data =3D payload;
> > @@ -1116,8 +1119,6 @@ int key_update(key_ref_t key_ref, const void *pay=
load, size_t plen)
> >                       goto error;
> >       }
> >
> > -     down_write(&key->sem);
> > -
> >       ret =3D key->type->update(key, &prep);
> >       if (ret =3D=3D 0) {
> >               /* Updating a negative key positively instantiates it */
> > @@ -1125,11 +1126,11 @@ int key_update(key_ref_t key_ref, const void *p=
ayload, size_t plen)
> >               notify_key(key, NOTIFY_KEY_UPDATED, 0);
> >       }
> >
> > -     up_write(&key->sem);
> > -
> >  error:
> >       if (key->type->preparse)
> >               key->type->free_preparse(&prep);
>
> Hmm.. a nitpick but here should be empty line, or at is least common
> to have that before the next label.
>
> > +out:
> > +     up_write(&key->sem);
>
> And also these labels don't have coherency in naming. Not claiming
> there is overall but it would be good to start improving the
> situation.
>
> So I think this would add more clarity:
>
> out_free_preparse:
>         if (key->type->preparse)
>                 key->type->free_preparse(&prep);
>
> out:
>         up_write(&key->sem);
>         return ret;
> }
> EXPORT_SYMBOL(key_update);
>
> And is more aligned with our defacto conventions.
>

Thanks. I'll refine them in v3.

Best regards,
Cen Zhang
