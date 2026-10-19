Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA05504588
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420433; cv=pass; b=H/o8XyhzOK3Lik6QfX+OJD9CcKWcTWnH5uE+GsMQyGIlbZ80A6CTCueyhIVUelcjS7VVs/QjFjBJfrN4SYJ+66ZvKaXfAB6s0qZp8jyKkFzDlVY0u7mTn+mjtDjHcPCjyjhXxjWMAKUlwAX7N7KP83NbRZf45W1BY+0Iep9xRJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420433; c=relaxed/simple;
	bh=NvMYER91I0ByJlC1PXbZsAccJ7mHl0SXPzTmOrRuRiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOPuZ2uIu6mPsCs3WsrwNUSBf4gdZUxUtnnxzRDUw7XYYDjQaAS2qQvAS1+MJyaxt1sJDKVk4GWfkNGku+MZx8sabddxEjvPc7kEG+6ioenM20hd8S98O7Sav9wGrQaPodueFvq+LUNT5BUPU0faVUy+TQd6zQz6UMnIhoN3cHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj5fggap; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj5fggap"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso296861066b.2
        for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 07:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792420430; cv=none;
        d=google.com; s=arc-20260327;
        b=RwInOTjpJiI01ROMBqCOjDciInlQI2EE/2kYFgCiiv0bApFmoYGDn7gOkCD99V06fe
         D6gYNtvC5tJp1zgOx4/WPoY7wjFvcuOvYWo4un3brdJFXQKBB/QmGEfq9GYWjTHOoC8U
         1uNzt0dHxI1NOskWAbc/2jOkre5BEHIyMkZqJUp8SDCuMH5gDIYXVlgUNqAostCVajO1
         iEqKyL2V+hKoHVTzbsqGJo2sZjeNey/AIcphyZ49KM1T1W7qHVxTA8oyJxLfpuDi9pNg
         srgL3Rf1CnmloCtY7u9CLj2Eb4nr7jr4lLHIA1kJVEdE9yA9GJdkSFQftBZUWDk8JP/y
         coXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        fh=LQyKY4PuhikKs6k1lZHqUIbYpMGkH9IiuEmf99G1Fqg=;
        b=qmiOSmMDmFIWnC9zFNFyfYRvkKivAIGVD1ybmI49uXpXJ+E8zNVd/DJ1uCys2Po0hW
         RR9eut/xhqActVucAYeX61fRdLEbyC1sPgQ+s44E8fYGBuDB4TxUF29osex5xE94ctK/
         kKJmIxqFvX+FPmRBZe+KcDUqHIdYV496K5KP/CZGBCokDkTdGBqhmCbJ3YjoK4I/0XYW
         18NQrWD78JBblIX1Y6dfirLkf8M/hLEJGqVdUo7OZtTfekAPwnQvME/VYNXixXlEU2fT
         VT0U4QmV42MO+t1gDYVKg62yD67UIKbmP8XY/hZXFQlO5zif28BY6AFCu0/6D54i2HzZ
         JUAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420430; x=1793025230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        b=Sj5fggapQS9TNHc2zKgz8HmWl5WcVSh9SnmukGnnYKmGjEVQlSpijJvwLGKrEk0iOP
         x2Mgalidcbj3TWWhAZkN2tsqhQvy4mC73HSyun6RnwOvZ4lF4deSswK92Ho/xLjL7lLd
         Ad9O3EB2s30xrD3iEtwmxd39IL2vuHKiRKWYRaGB3YCbpry5bSVGwVgOgD3M9II7hmtc
         ZV+Y5EkqKB/SJyx379yyjn+T3aNv7cBO4iHXHT/oxuorJEcd0I0ng1kjpR84umYONZ9v
         4L4cvrtNls4CQoiDSQRhd70UyBqas+JxyGj/2D8lpL+nkZsshPpL2ycZprj2SGjEewlV
         0A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420430; x=1793025230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        b=oILKIjnXTvB36jL3JUTAM58IpgIQSRWNUQF2e/toTsyq/S07Von5K/+ur39aMJ5wkn
         LPxg24+0EuQr2sjY/xN9XuLIOWh8EeK0j0+/7w8ailhewJRFIKS50EEReFiWRYhYkqRR
         Ejbl9hWzgSMiUS28ikWCOjEsHzc744h9icXpYqvbKtj7NEAjq8ftATnVklcUq3q4JinC
         SKB24RakeJ8ZNJoE+5FIzlx0Bp13Rwt+cw6Hb4xWkiQVJkDUk1tpfoOrU4mt1WjCyq3/
         QsMCb98ql84M3q0PBAjWED9dGTcJ3Oj/tpYgWlCrxb39B8FPhgm6UBSreDbbSu0Ec+Pv
         sG3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz5eno9nvjvlYGl/KtNhsWyqBnNeQSbHH02qV0F2czY6uJp6wVtoJR3yC+7IkcE8ULjxRqHC2TY+g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKSsNzPxyB78bdnKmF7ia+MZCEpCb/OioO2VoMDwEiJYiZLDqws
	kIt+VEnVtZ0zTZ/zKwglHnNthl3V/nJgceYoUW2HB0AAu4W1FTxHhmmbFBsS7bv9aS7SRbS3rQ9
	RmsBvxDBsu8YJ9N0O7v9v0EVTl9fgC4E=
X-Gm-Gg: AYBFou3mOgXFvBJxv+HEi9/B9oNQ8d2DCq2CnQVNy444a/TGWL6b2/j66abjJF5qIW6
	mASgk4H/O5WQ2KwnhXZxghQUSdT7sNFbP5kh+EyT7tn5R5FBfjtqrZrmp+UB0UrOzuYitTrb3MJ
	bvuxn8y6fEKan5jiPU/JpKqPexN213enaj8cXTEY3DRB9AlSJHmMCoO1p+LAjxPCCGkIZY+0mqd
	fvWfYTK4ZYX8JrZi7nz2noAHuvd46knZ9gRvaBkFtE9qpdizvl0X/DiPhyWSh8nvSXuWt92gQlg
	QyGKil5ThWufiGOuVyN7CnTVae/vzELRuQK9GNb0oxKkyKFFVClgknQiLsjgMPycpdYpFWMUY34
	DR0BmEiVlwA==
X-Received: by 2002:a17:907:3e15:b0:c41:4c20:5a80 with SMTP id
 a640c23a62f3a-c41a0bd5bc4mr588936366b.44.1792420429899; Mon, 19 Oct 2026
 07:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol> <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
 <atOiKzlHKH47SMNt@kernel.org> <atOi7jWhglgRZ0C4@kernel.org>
In-Reply-To: <atOi7jWhglgRZ0C4@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 19 Oct 2026 22:33:36 +0800
X-Gm-Features: AclHuK9OlBsEmWtkP_XTvi9GQcsF_fx5BP_zryLibZN9CiuCkz2in8tqjXVdgK4
Message-ID: <CAFRLqsWxNHz0xngwMaCbnkifRs=e3NTeGmvvTEmCRSLn4YeQhQ@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, sergeh@kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8818=E6=
=97=A5=E5=91=A8=E6=97=A5 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Oct 17, 2026 at 07:28:31PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 17, 2026 at 03:47:32PM +0800, Cen Zhang wrote:
> > > Hi Eric,
> > >
> > > Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=881=
7=E6=97=A5=E5=91=A8=E5=85=AD 11:51=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Don't key_serial_next() and find_ge_key() (used when reading from
> > > > /proc/keys) have the same bug?
> > > >
> > > > - Eric
> > >
> > > Thansk a lot for the reivew. You're right =E2=80=94 key_serial_next()=
 and
> > > find_ge_key() have
> > > the same issue.
> > >
> > > I'll send a follow-up patch to fix those as well.
> > >
> > > Thanks for the catch again.
> > >
> > > Best regards,
> > > Cen Zhang
> >
> > Yeah, please do.
> >
> > You put so much effort to scenario and you are nailing the bug
> > that way, and I do appreciate that, so here's what you should do
> > with the commit messages:
> >
> > 1. Do the first half like you always do. That's great. And I've
> >    also said that.
> > 2. Think just a moment. If you get anxiety from that something
> >    that should be mentioned e.g., something that you did not get
> >    immediately yourself at first, write remarks those down. I'm
> >    100% sure you know when it might be good tip on something
> >    non-obvious.
> > 3. Send that. If we feel it is lacking some info needed, let's
> >    iterate that. It's not a big deal.
> >
> > I'm just underlining this because so little would have to be
> > improved to make this right :-)
>
> And also: I would not complain about anything if I did not want
> you to send patches because it does not make sense to waste time
> like that. So take it this from that angle. And they bring value
> thanks to well described scenarios.
>
> Br, Jarkko

Thanks for taking the time to explain this, and for the encouragement.
This helps me a lot.
I'll keep the scenario descriptions and pay more attention to
explaining the non-obvious parts.
I really appreciate your patience and guidance.

Best regards,
Cen Zhang
