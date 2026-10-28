Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197578;
	b=lZk6FduMwGGYml7JGWkSOralx23+oI4nHfU/mM5T+po/oTdL2rBNzbuanaEzQnhctPSX
	 bMz29iRB4YxMspK+t5ydaxXuj/CoPWIMOpSTC8KkQZyFDQ3MqOEsEPB0ArNTtWbrRGrcA
	 LjjtfR39SjhFI62HwzbQxPOUuw9OUOwxr6+mv+sKM2Y9z2CUptPsh/vkptANV9DiIM+dJ
	 faM3JtbPcH3ZyVNzuhvGyFZ9liNo/umXKFI+Ad/WIY3hkznGHWr6u7/ImfVuG7OfW5dCN
	 bkfqXP0Hkpp+T93iXXyp5jny6Yu2oW6SCSXNngZLqOBL8Zzu3ChdW8HTecPVFKhJP7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
	b=hgzvXB0pNCNa4dCl+Z70ryKriemTWcaTfl2m3zNPQxv9PRw+UhbdvlSWLVyDkElBLauJ
	 vcQ1+Pgl5C8noecZP6czwB5lHT3SZKm0hpzrwwfQUvjUGvEKCnrq7kT1HolD8I3dTXc3N
	 Zx09XZ563qj8NETLeK7lHxPKe0i3KIri6Onacrf8aX8vHSwGEoZlPPpRC8p4kb7k5f4VW
	 gHl7afC0swRzpPpfaMx6yAKGlka3EZx6tbubwh7F2tbmSCZ9bKYaHqGMw2S8EWR6ql4/P
	 9Yj+tMSJQGIX0Z0Ub04/Pme0WeYTGJwjcgked5gVWFsks53sdL477ll76X67INJi/aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfRFAWrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63F606A31A
	for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD63F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfRFAWrm
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8565d77c277so9038357b3.0
        for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 07:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197577; cv=none;
        d=google.com; s=arc-20260327;
        b=YX7/GUTN4RCSRDIBIZAoYjL0q4rOJ8ZrSDVYlEOIqWsU8YUzUK/wnh4Kjz94xYbERz
         Nmd6efPh0HaPhlZKx0dDftZZn+FzRbvY9ndXFZiMp0XCFliTtMums9wry9PrIWWNKnF4
         Z9WXYv6XJ5q+f684CyCqFi1vRGWJtZGpjuWWGKQi3GVMecNeiIXt5p6LyugzgACW+Y44
         rkdYesGp45HH9248RJr24HRU2pajQz7cLswrBD/Xpkdv2+kixDNcwMV1rROQJxDmwBTp
         5EhPZsHwlKuQqZiJR/GAnHDDP7h1yHv7XUmumsn2BNRwzx+rAcq9me/CnENjuBROssNA
         yKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        fh=Ysp2ppTXAjXlY2KVQRTI4EHtXDrfaU7TeYrodVlQQkE=;
        b=GLhf2vIAQXujckZq5x1rkGNqcWeXWRa73QYSG7Z1M0PS3f9IN5ob4+7D/p+exZ5p00
         fLxXJfGotoQ0m1vGxeq5esPxqLdkOz3DXskSzDugIYKsnH1mnX6B+AR1a75rSycJ/zfF
         KjS1S0eIhJIZPynhY3xrN8H8gbGnF+kH2NuaOlDcXiGr/gVLwCwNzZI1ShhlFQxF6r1x
         C1e0hIXmxaoHS+KYXc/fJYqhJsQ+tWQYOSELBl03ju38XM/ZHfQjI13NELJdLb81nZBk
         qjWZKTzykL65NU823RQWS8ldtusHBYqLRebojtBgWZlIQvvxfhRShofNHTiURydP+0UX
         K5fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197577; x=1793802377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=DfRFAWrmO+/Bj131K7+MGGvRusTiq7Cc5X579DXdy+WsyQOlHXS84rhXCmVmsKOZC1
         jfuHEhsyE6S5Hv/g/4Ce6BjpcZobIYAK7e7SRGOKE2sQnrptMyZ/rcfRlucg4dR4ESXM
         2gkEM+ETeUkrfFJD5xphI1XdRbsTnl/m+NHm4YrmXbfagBxPULfxYRHU88tAoNYxU0fD
         Sk8MihQlJ6G7wkMm9i9Z8l/r1iyrvuPMo1oPpQz0ZlNwKWJeP4IMCT2IjKSoAP5RqzaI
         HDHSC06lEs0YPSK/mdKu+B4W4LgKQdZyBezNe4ZWTbOgw79zb6SISHpGLp8kXM1lynRT
         +z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197577; x=1793802377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=v/nTEI1dLyvCLrTOGLcmfNL63HbyVxGO2XifZW8/efJHgQwAgoKWcV0dZim8T+92S2
         rZfB+u5Bf0Q6XQ2lQvhw4tvVxfX7zqLlaFC224KdIWz1WZXh47kvt5qtVF1YMVtf/O0j
         l2jdlMPgbAxPAdUqfXaPwIse8EveYCcux79qm3LGp4lW9q8twlSyBP2V/pFlmIYUnA4K
         CunWov65sP0MXGKPm7N6UtSfxa5AN23Ei8THbGg2rPPJZBARRtiqvzGUjKRlWS2OM49B
         Bck0TWR/F9F8R5jG49odPamGZkt/Lj3awuk5Fk+ZwWVV9jGruiYrdQX7P1Y28CxZzH4F
         adSA==
X-Forwarded-Encrypted: i=1; AKwUvByYRuEN7gSU1iKgvsA5fD0wco0XityND/HpdglnVyO+mELRgDvl6/jJ5DMqySjUOLRJRlDZ9w88WA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbzveQ/gMLSRXYDfZQhkb3Ti882dOV1L8IQgQQv8N9qdWaE34n
	s/3h2/oBErnyFYD6IdzaT3Sy2sGScHvq15FxL39mHZcanXDgibsLdaw/T2ak0SwokLnaGMH/JeY
	st09qrQnl+ruvXeh7/Z0tBTeGRSui5Oc=
X-Gm-Gg: AYBFou0bYoh3vCBvl2rNspT/m/vJshzxiSqkywN4P5/TRmFFOuoOgfQ/dg6L78UeiIC
	EiYH35JIRMH5D9lNW89E61HVAznjHKP+WsJalS5yt5sC71yvSzBBXCVhiDgqXR7FTFwpvZzMDQ3
	DhSJse2sPsjCht9Pr7dMKyjP2GP+lN2fwWB6KzeZ7WsuvRNJFdEis+zaVCxJBJkteCvG6kZ9we7
	4d5g9RdLNl8Wy2oEkd9vWGEtI/HgCqM4szrRFEVP7BtK+dNR07/HXWTGF97RbWbr+UbUL/icBSg
	Qdts12Xoozq6cA00NlsgzOKp2Q7c4Bp+k3z0AoU42Sz6iaDDnNmZlT8qNbsBmbZImZY5/ACFfqb
	7GvPi40/8LIQW1ATWYCvMl6P0TnJUYlzubFZ/lRKMht9kMT/J9MolmywX3A0Q1GNGptsrZlc=
X-Received: by 2002:a05:690c:e90d:b0:8b0:d42c:54e9 with SMTP id
 00721157ae682-8b1b5c9953bmr12024777b3.34.1793197576747; Wed, 28 Oct 2026
 07:26:16 -0700 (PDT)
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
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com> <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
In-Reply-To: <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 14:26:05 +0000
X-Gm-Features: AclHuK_2pDead4oUBgww1V4NOQP7FrJJqtxPGmwYbVPNkoSmhvEEW-kSQFaRSpM
Message-ID: <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com>
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

On Wed, 28 Oct 2026 at 12:42, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > I think there is one issue with the design pattern where keyrings
> > > are set up in userspace, that I have mentioned a few times already
> > > and I got documented in
> > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > as well: they are trivially bypassable if the kernel has kexec
> > > enabled and it is signed. The security model relies on the "good"
> > > userspace running first, but if kexec is enabled, there's no
> > > guarantee that will be the case, and as far as I can tell it gives
> > > root trivial capability of overriding it and extending the trust
> > > chain as the attacker wishes.
>
> The attack sounds doable, but it also seems to be exploiting a gap in
> kexec policy: kexec is supposed to behave like a warm reboot so if boot
> policy requires UKI only then so should kexec and that sounds like the
> thing that should be fixed.

I don't think that's the case though, even before KHO/LUO existed,
kexec has never really behaved like a warm reboot, as for example boot
services do not run again, so various chains of trusts are not reset
(eg: a bootloader might now be blocked so warm reboot would not work,
but kexec would). And since KHO now exists, the difference is even
greater, as more and more state is retained across the boundary.

> What's the mechanism boot uses to ensure UKI only? So we can see if it
> can be adopted to kexec.

There isn't one, and I don't think there is correlation, as booting a
UKI is not the only way to boot a system. Eg: this problem applies
just as well to booting an arm system on uboot. So I really would not
tie this to UKI or UEFI specifics, it's more generic.

> > > This is of course not to say this new IPE keyring shouldn't be
> > > added. But perhaps it would be nicer if the default build flag was
> > > mutually exclusive with kexec being enabled? Not sure if that can
> > > be expressed in Kconfig though? default: yes-if-kexec-off, no-if-
> > > kexec-on
>
> I wouldn't do this because a) I don't think it's an IPE problem, I
> think it's a kexec one and b) distros get very tetchy about hard to
> solve feature anti dependencies.

Note that I wasn't suggesting an explicit conflict, but merely to
model the default values of the kconfigs with such a relationship,
allowing manually setting any combination the user wants. But it was
just an idea, maybe it's not worth it, dunno.

> > > At the very least IMHO this relationship should be documented
> > > explicitly in the kconfig blurb, as it seems to me it's a major
> > > footgun to leave laying around, and users might not necessarily be
> > > aware of it.
>
> I'd document the need for trusted userspace on kexec if it was a boot
> requirement, yes.
>
> > KHO/keyring folks, what would you think about preserving sealed
> > keyrings across kexec via KHO so that the chain of trust can't be
> > reset by userspace? Good idea/bad idea/yes send patches/no go
> > away/etc?
>
> Well, yes, we do have a similar problem with the trusted keyrings.
> They're actually initialized from the shim created ..RT variables
> (which are volatile, but don't die on kexec).  On first boot they're
> initialized before user space, so we know they came from shim (or
> another trusted component in the boot chain) but if root uses UEFI RT
> services to add to a ..RT keyring, the added key will appear trusted
> after kexec.

If it is possible to overwrite the RT variables then yeah it sounds
like we want to preserve the machine/platform keyrings too via KHO.
