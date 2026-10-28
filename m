Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793214240;
	b=S0qNarayl/ApO/J9LXHFvVbI6IRjU+VpNaind2DM/93Zt3YVt796WZalkth9OYRfyVJ0
	 hmqpR0iRE7cpHgZ2GUfJKAZrb12OKb/pvamUP14hV7vXbGRTqvqEBAH1zwvgFYkxxJFW9
	 Pi+t8QdQDQ1n/AYEh+mjSDb86eR1fp65WsGBssPaDPiED9wEgBunjGzVLGoToQD9uJfHV
	 qSSkMaWh05SDfmN/uksfKzwyDz262wyOJTGF0nz7EJ2yGQZxZtOvifzal3bJ6uvtD32r0
	 y268t9PtmsSw1PLDDAZ5QO+puZGu5vIJu6sB99Gy6xGm4INUy+QnTssYcMODh93ODLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
	b=nfFCGSyzP5Q0D33DiBdWaZ6/whpS6Dczji13jigHC9rGJOzvnFS4ip+7Bp/GWk2VdOPl
	 jYflfJwNT7VH+65vSVmdPwibR0K4WqeXFPjGj8QCw/jKZ/AKV2lCogjxXVOFnMLdh/ZzX
	 yajODNQYrfHI7fv3OtgrU8vJxmwSdO4F9dH52j4wnSOwvRwZ/fNJO5Ot51meGE6VIbn6N
	 jHu34dCP8wBwM6HuhOD8pMN33uS4YUaCsguRJf3UJq2KJwRjwK/cibaEAbAgIP0WsKcLp
	 F1W3X1OE8IhatiO030WnAWXCfvcTc4tNJLoKmaXN2wEnim/whmBa9fgsdEODe65C6XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmTJlIj9;
	arc=fail smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D2606A329
	for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 19:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B9D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmTJlIj9
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab3d3c5761so12926787b3.1
        for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 12:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214239; cv=none;
        d=google.com; s=arc-20260327;
        b=kIao82lsMacREQ+oMRLdsu4qp4ro6ISmBQFMYJdY5vMZUIW95zSC4SSZLho5yIGqNN
         SbYvSzGeUw29fkySHlNi1P0MSffXNkQblkWLttYvomg5mIDHCvRrUcegAnlx4oySqdoM
         nlfSuBHQ5zTE5VDoRCHXeVrIEP3SBvAd8qoqZEiiVNw+BwS3OrnwCgOSpzy/TfQZWnSV
         t9aRONKj1bI4PkmZnu6OD5WFNWTTs/YVrUocPJDO6jHU1beu5VjmDczwtTNDVmz/Vbbk
         Q5DziPb1InBV22Y+z9RDS0t5R82pxiylZmgT3gdo/TN8X12r/cl5RIFVPaZImhq1+Fno
         D8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        fh=Ex44wpqN8GKHChjCZB8sas0SozkUvDDDG4LObcijJSA=;
        b=GmLUnlecJoAEkYD/snlK331TEV1P78ExbUIl1pBZt8GIHmAEYU8CFj/NI3p8I8r7Xu
         Z3ciY9+WZTpeUAOeiWL621jVP1k+A+Ei8ZCQm5vf26dUA6pUqz44RACgW9Nx3Z02qhCS
         ZA/+l9kK/Z8Sx0RwLPOmP1Lbph4txL6W1TJQwjzmxQcv5nDMRWaZhCnuAB4o4hDNDAC9
         DzWtJSAcVxNrr9V6aUuA6YRj0S8q3J7hBIlTDr0H1f87JNG5KP1erbYiEjeBl+o45dLW
         tIht5e6+sZ749J4AwWVoy1++1rTyoCuk4wsBbl56lJeECTtrYtpIyno4lo+p4qLz+DRw
         a6eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214239; x=1793819039; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=PmTJlIj9BJE+hyWdYFmRhJ+3tw2R4WUGUDZVYILng+0oxJHUDaC9pvgOJiP+/g/GVW
         Jhv3CgGsVhdXnLp5zNe69oj87R+yWv+rh7zb7Y7JFFlsmzoaHUUcLELpNaSyTSWM+RM1
         CxOE7zT308P9cR7jJhSUPhFXrtf9VRYI1qzSrK8Erdbw1plM+UylP/yPlUnQ/iwNiDPS
         tMxkJB02aqb3L0+NIqZEMzTz4uh1g00BKOmZvi2KbGuZzsEFaRK9qrK1oyiJ6zvi/pV0
         qfRo9mnyvnaWsLQh5HGoviBGccm9j1jWwaedGCLja2JC/qO7HIz9SDEH6U+Fnwg/+d7+
         lscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214239; x=1793819039;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=aBYDgtlWBRpUlp5Diz4SyfGuyHO1gCCEPy6bh8BKz1sRuwSOTnQb2oJZXaXqbo9fVO
         fEnE3Ykge4peXoVLj2uWep9jcLrpKORTvb7hr2OOfMh3l+KNDfZqu/achqhLfbL2N/4W
         /qZKJEb7816+Yx0WldPZktz9lb/crQI6AHTisszTC/hQLk5cFyJBLj/k0eb7V8iU6KZh
         D3R91P6k0A9GyZQM9VhfkdHyQqJYGyTa81A6BZijJgI1Cs4mJF+sNE65YOZG4V8NCKN0
         HcmnMmBlj80tCgHniYaacjVczA2C7FtqaubSS6focuceRjjgb4SRrhdtHwtm5ERBkpuQ
         Ivbg==
X-Forwarded-Encrypted: i=1; AKwUvBwVLKiW3OdKYrd6gTI1bt82yYxk40y1TfJxGtymTbTY++Sb3FoLuq/GdwvkdX/kIqmFIs6kBtHP7g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkDf/c6mjkyoRpu8hGYVMfTacI9LYRfp5d5M+tsF8MBvi2AOHz
	21iWEofmOJwKDGNm0S5wSIi1NYZKSKxKQdGrsX3l0nrFM0SKTTIxL20qS9OJtBrky+ysTTQcBYu
	+LpYpl4PWWC9/srQJ0XlBRUwsJomBsRw=
X-Gm-Gg: AYBFou0X62PmZXpMmsL/itTAEuMrUIX8ckpFizTl+hzHyfhL4W0efNiDgZeq7g5Ag2l
	AE45yq882owbARalh1jdLu0irXcCGODKxmHU32xym8c9Q7Y4Gy44JBZAGLAT0z1hH0nl/cqfM4h
	lEFzN4/D7rJOXxLS+Q0YoTCiiEcE8wz8DyeJzLTSU5kGk0qF6pHJokMaTvfGNbIi5FDAR8lcSyA
	PwKGO7vYoY05BM8BaYAx6sjbWOVWnnRdUpphdn4i8mgmK/7Ke0KFyZj0a/QwAV3wWpqqQYTQ3QW
	PxGUXEyQEOQ4bA1hywFPB0DTgPQHmlst0cmZIBmOdbbRheSoti57AEcuJPs8xZ40KjJ79MLhSzD
	cTvVnwrKOiBu5XKIkzxl2ec0fiz+gUfEbBW+RZRv2rUhDp/p9AKugibtuT/KcCRfYSw3Y3Ps=
X-Received: by 2002:a05:690c:dd4:b0:8b1:60a1:cd3b with SMTP id
 00721157ae682-8b1b5c17da0mr25103967b3.24.1793214239135; Wed, 28 Oct 2026
 12:03:59 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
 <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
 <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com> <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
In-Reply-To: <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 19:03:47 +0000
X-Gm-Features: AclHuK_dsl-iiTAA_RkgI0lW_me3PKlvDAD9Xjk5WqhnflULesXoa7TLNE1dmyA
Message-ID: <CAMw=ZnQA8nZnF-khYkKfY9L4dtB2hmmbzHyKQrf_Vf1scVNM8A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, Fan Wu <wufan@kernel.org>, 
	Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 16:14, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2026-10-28 at 14:26 +0000, Luca Boccassi wrote:
> > On Wed, 28 Oct 2026 at 12:42, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > > > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > > > I think there is one issue with the design pattern where
> > > > > keyrings are set up in userspace, that I have mentioned a few
> > > > > times already and I got documented in
> > > > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > > > as well: they are trivially bypassable if the kernel has kexec
> > > > > enabled and it is signed. The security model relies on the
> > > > > "good" userspace running first, but if kexec is enabled,
> > > > > there's no guarantee that will be the case, and as far as I can
> > > > > tell it gives root trivial capability of overriding it and
> > > > > extending the trust chain as the attacker wishes.
> > >
> > > The attack sounds doable, but it also seems to be exploiting a gap
> > > in kexec policy: kexec is supposed to behave like a warm reboot so
> > > if boot policy requires UKI only then so should kexec and that
> > > sounds like the thing that should be fixed.
> >
> > I don't think that's the case though, even before KHO/LUO existed,
> > kexec has never really behaved like a warm reboot, as for example
> > boot services do not run again, so various chains of trusts are not
> > reset  (eg: a bootloader might now be blocked so warm reboot would
> > not work, but kexec would). And since KHO now exists, the difference
> > is even greater, as more and more state is retained across the
> > boundary.
>
> But still, a lot of people are using it for servicing reboots so it
> does sound as if it needs policy control.

And what policy would that be, given there are dozens of different
ways to boot a system, each with their own particular methods of
establishing trust? Even the most common one (UKI) was tried several
times over the years to be tied into kexec, but to the best of my
knowledge nothing was ever actually merged, as in practice it's really
difficult to do, there are dozens of ways of doing it and no apparent
agreement on which way to go, and so on and so forth.

> > > What's the mechanism boot uses to ensure UKI only? So we can see if
> > > it can be adopted to kexec.
> >
> > There isn't one, and I don't think there is correlation, as booting a
> > UKI is not the only way to boot a system. Eg: this problem applies
> > just as well to booting an arm system on uboot. So I really would not
> > tie this to UKI or UEFI specifics, it's more generic.
>
> Well here's the problem: I agree root could kexec to their own initrd,
> but it looks like they could also properly install and reboot to it, so
> it doesn't make that much sense to plug one hole without the other (and
> when they both get plugged it does make sense to use a similar
> mechanism).

That depends on the firmware and bootloaders involved. It is true in
some cases, but not in others (again, setups using uboot for example),
and in the latter cases the hole exists only at kexec time.
