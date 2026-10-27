Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793099251;
	b=I2NROgrt/0DhGPfNoDBGVD4YLUVm6uLR0+sV5uC3wnm6jYzKN3cRZuiCVyBSJEhY3N7i
	 kV5Ja0z0E4XSTc1fZDIl29h0hc0Kb4f497SzSxuxSXgknff3KFAfY/4oQWrE+dZSdQHXR
	 soQiq39cTTIsbVh+OImMP9gppB/6wDfpdIgZ/86F3pkH3Pl9YDBc198S/7Zaj8iDLKn3V
	 HOPVQkFpym+e8lrPYVg7iPdcjguBEld2QyfQxYscSdYdVbKMhzz2Ym5b18JZwi0B3euwz
	 RucU/ZHuxcgSydZav1g4usMxFPzqfla2rRrhmkm87t2dcpvXpm2ZZIYIPAK1OLUaqQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
	b=Ow9kZbLGpLTUvVY8yzl5lJ0fov/iOfRQ0SSJTChnHVthGk5JC/WDOjGsBp1Sz//j7bqi
	 7Wz25npR3vX31Tv/ztp5AKAqOXatwRTIfBG2e67RtpNc4TwKI6eWSjc2fR68satox39KT
	 vA0FZkVM2q81RcITjky14Ursfrr2DywPWYO6d+n65wRQh25OKPYdGWUmsbmg21Gu3lThL
	 8gPuXznxr7o/4EFqanNpnJk594x33WhWOS25S5HnM85zUQ1LXSxGqtn82mDbNVar99XZz
	 HBmTWNVFASwyvSdeY3Sq+UnxF81SY41k9Rje3+rdmfTjY9spLcmXFkpWUCxWCvhRCMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rafMftuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD4606E7FA
	for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 11:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BD4606E7FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rafMftuQ
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab3d3c5761so34659877b3.1
        for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 04:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793099250; cv=none;
        d=google.com; s=arc-20260327;
        b=Eedu5XDzQDNzw/u7Cxv1IWulWfDWLlB0s+QarCod5oEEPG7HryR6EteF44Shb7zrDt
         8BTWH3I0xp2OiHeDsUMKmYxhKaAjHmwvOpcYrtHIKKub9UF/WFNUqTV6dUuXSdYzgoZm
         1SpD6p51wa77MnjOdnWZYMAPSaXexWnDmnWX7KJT3NBWWA4AYy4KN0xVvzG9OOzDvToQ
         NxdU67bscWJ+J8IA7M95HHUy5pW7E36dpI+iqb7fpr0WVT0LvunJXrpuE6UPMhttR+pu
         DTXLexHPTMYfuhHlEmDup8V2eGLt2ELXEC3VTSWtGGImQB/zyxc3wosEa94JsXN4VrHk
         uKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        fh=yiXZaE1t7Rc7KLt+12/cZYpBwu4udyYv03XQnXw9rGo=;
        b=fK21No6Uv6psj+UzHmnZ8iUv1itd+kmqtLB3H1AFjXJ4jj4HaE/KvJB3HI4TGHr3PK
         MxCaKrp6LqXsZ4+7deCJknT5Ey0W8qZHvE/ElSMNn6fEZxfdlg664GZpUxrpKxWIZd4I
         vW1zf62U2RrPyZe4KXVQK7bvvxBShz0aUZLF+2XnjC6XigOPRLFzu8N5kSwu83e092zz
         dreoBx9DNgsUciRA8WrIzSeZhByYcbHK3eyFqWDiEIRd0qTXvzXJgIPckRknRR6RerAC
         YtMXP1TfaSLCKBtKFVktu2qhBCGVFBATBmxYFgFvNhX6rmZIOWiL1k3gn2jebRgMTS9p
         exRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099250; x=1793704050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=rafMftuQv37CSy2M2Z/LH0hT/6DD0vGHUViVQ6T/2pBqq0vwGrX2YGcRoIcmcOv4s6
         SMcJucaaNjmzzPrXps1BoaeD8Cl6C9H2GHiJCPeyGCtwNwb88BNppyXDjselR1KNPCku
         8F35G64svydgJL8Y/oG0I0Ucgn2ku0SfagELKzWrvQtZM/dVV8oUvSypYn96tZr2V5V/
         3TljiEX37a9dMSR/+QJ/osJ3pzIq0OE7Aa4U8yEdUP4KFEDbACZ1edh8+h7BRtQcV5Yi
         NA3T3nYJOW1nd74KFGe7Iq5HRuo3ehWFKE73CRZdFIFfna9/Oz/9q2rknT61GvRgoycl
         +dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099250; x=1793704050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=OG5ZedQIRtS2LU+5UDXdZnSDD+Yyy97RBrRJS/BbAsjmIEogSRBM/eC88u2fHU7ZZu
         K0YDizkEVRacnylVxvRFVMmNoRts5/5i0hUSjM7oISCHYpD9xfXAg06NaVGnEJcBT+ps
         S7CRJS5r5lpzczjWP42m3QyU+JQkBK7WTrajRwIp/i0/AjDO5AqJfrY4VRYRaBYQ7mNU
         8o3cRBiRT55cSlKE2d8SWlXCYyRiNelcFUmLDdrpAnFo9fvmXzsAQsE9Dc1iyD01WF8E
         VRuxjdS2HYMf+Uy1scAwmx8wpo3DJv0l2BLeXrKo5TC0jb/ZxFhOkcnJe5/s9waRPm6k
         GPfg==
X-Forwarded-Encrypted: i=1; AKwUvByHI3OvvdIlr7JgZDVUdxPZ21i5Q214Tjy9djcqhj3r/zilkULi7119DEQUHxkGerttt6IavujasA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL066eDRF/tDznS1qnqIBFSTAoAaHFjO5NYWkWuJXcTvye2w4vu
	a6vArZzBW6bJNOtkfTAkGvK/T5aapyMvgwAv2vY08ZjfnpiunO3FsDrkjC1f2+a61AavMq3acI6
	kCLNJcyeCg7wMknB7BTBTq8dfE5QXExA=
X-Gm-Gg: AYBFou2E/sz23XUGqXVzawBIfG3WWUmVsExsE5lcyACBd7TF1asw74p8FjSkNX1gRFt
	jRyp+UZkfr8CLQBQXHRWFDYf4ndJmXIPQ4gh2hBYXKljrj+A+64JcseST/jxMO1MmMrb6yCHPZd
	hPXD+wQ9pBvdZmQmS8Fdg/K7qO7BWL95m8aodulEWS3oaxHnPhL8unpvFhqLnTQbwZhoIRe1buN
	gje60nC3cm/S81MMdglBJ6GViH0AhQnOCv2r9m2QH2FA4ebXOs+juw1hlionq1hDmfJ2weW61eL
	Ym04ey0yuStP3yi+MK9IFB+Q6vi/6dXShU4wH7lzlAiwWsYGqLEJ0zDBiR7JFeq6EBqfGkFU1sT
	FiB30xHreTYEBcIeReSH3xzR5+7FXk8mf720GSrdwNRpX26OeDqzHmizH1u1a2qqkyBoqYw==
X-Received: by 2002:a05:690c:89:b0:8b0:e13c:2854 with SMTP id
 00721157ae682-8b1669e55a4mr81209407b3.5.1793099249996; Tue, 27 Oct 2026
 04:07:29 -0700 (PDT)
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
In-Reply-To: <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 27 Oct 2026 11:07:17 +0000
X-Gm-Features: AclHuK-M6AykdLUZqQa3ChCCBvY0LYTQ7GR53YsAPnqddFlyo8iJeyhlphI-4Do
Message-ID: <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
>
> On Thu, 2026-10-22 at 13:18 -0400, Paul Moore wrote:
> > On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner
> > <brauner@kernel.org> wrote:
> > > On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> > >
> >
> > ...
> >
> > >
> > > > Of course, fitting in with existing norms is important,
> > > > but if it causes IPE or existing IPE uses a lot of pain, that can
> > > > a
> > > > good reason to diverge from those solutions.
> > >
> > > Which pain?
> >
> > As I said before, (emphasis now added for claification) "... *if* it
> > causes IPE or existing IPE uses a lot of pain ...".  I intentionally
> > did not make a claim either way.  Once again, I wanted to provide Fan
> > some support in case there was an issue and he found himself in a
> > position where he had to push back to preserve IPE's model.
>
> I think there is one issue with the design pattern where keyrings are
> set up in userspace, that I have mentioned a few times already and I
> got documented in
> https://www.freedesktop.org/software/systemd/man/latest/systemd-system.co=
nf.html#RestrictFileSystemAccess=3D
> as well: they are trivially bypassable if the kernel has kexec enabled
> and it is signed. The security model relies on the "good" userspace
> running first, but if kexec is enabled, there's no guarantee that will
> be the case, and as far as I can tell it gives root trivial capability
> of overriding it and extending the trust chain as the attacker wishes.
>
> IPE specifically was designed to avoid exactly that, and ensure
> userspace could not execute untrusted code, even with root privileges.
> With this enabled by default, userspace can just load the same signed
> kernel image, passing in compromised initrd and command line, and gain
> arbitrary code execution on the host, since only the kernel binary
> itself is verified, and anything goes for the rest of the kexec
> parameters.
>
> This is of course not to say this new IPE keyring shouldn't be added.
> But perhaps it would be nicer if the default build flag was mutually
> exclusive with kexec being enabled? Not sure if that can be expressed
> in Kconfig though? default: yes-if-kexec-off, no-if-kexec-on
>
> At the very least IMHO this relationship should be documented
> explicitly in the kconfig blurb, as it seems to me it's a major footgun
> to leave laying around, and users might not necessarily be aware of it.

KHO/keyring folks, what would you think about preserving sealed
keyrings across kexec via KHO so that the chain of trust can't be
reset by userspace? Good idea/bad idea/yes send patches/no go
away/etc?
