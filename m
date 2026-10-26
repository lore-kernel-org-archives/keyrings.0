Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019433;
	b=0P1KjrFhZNvBEPVOTphn6vJq571KiE2Q12w/vE7xSuj1GK60ah5zhkYEAB0wE/l/Wd92
	 gtKN5VfnXOiBGqCxXsa5E3G2kRV9lujQaXIF4KLQ1rZ18WWQYgAmYDXsuRWvGiV9jyR89
	 HOpz5kx5HrDREnvBBbTaF2PYrrNGdnRX4HNmypuzLsNBo9MSoUQm7mn8Q2XBbfNVc1EuE
	 NgBhTdOgkhkaZSsQ1P/Onsbpl7vBX721uCe6RiasR6A15HEce7q3luP9M7Me9+nYXgGrx
	 qpgTDhNrxalHpQiISgMhKONN2KYH0Fxm2HYn5YVdWd4/PqMVeo/9wQ01PxfUf6YOocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
	b=Q4+RGVU8lkJhjM1B4+GY+dbIcOoLxFzXMrirmTzETAQ2LhhhombOEAm54tvmwt6k/6Z3
	 8vqhBSTsmmrbACHjEUquylgWPU192owkdrb7hW207BGXYrq6MSiMif69l2V4i3Plp+CvA
	 mMtZkiyIdFjv80DnvDlt6K43Jj9p7Wvba8b+XkYPLCdp2uvX1Qy6jnICPqwuG4gBVULza
	 zF+iSZt24FUDn+ugvLhKc5MeymdcXUHAzhV1N5/GdAJcBWZZEWERt399HKP5gzLpsDFaK
	 6YRO05pTrfG+SRjdqX1UWLdiTR+ihngHu3GYClTs35RR5K+XPZw7YlMBUhHZ1epGsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OySLaZNF;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DB606A327
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 12:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA1DB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OySLaZNF
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c45111bebso1327727f8f.0
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019431; x=1793624231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
        b=OySLaZNFF81ia0rVA94JSJ0z0WWlnlSpQlXbPYNdoz2t/Nvpk6+ph3yDPXdpqVsIPM
         wlDP7Z4AIMnFkaFzfTP/ie024+qWkH3xCX/k2MygTiVPAHv2EwRAm2+g536+oaCHuvLF
         KUSANP7ZxtIEbwbx79hEVEUmF0XUQQQgg0TuLbwHHTsGA50mgIh3AsV19T/ttHs6D88u
         4QNMSqBoQ8eyMeXr/+QjpcCERneb+jyIcQ6CzY8Far/ic/F2lSlx2+jBHqRl0t4QTVv2
         zDvlAinx5/+hrJf6TpZifS9F83hNDfxL8wDuKOS885dochDajAMj/tOH33lR2H/sTbBK
         ytRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019431; x=1793624231;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMpLhaD5BcYLKQl7lpJj058Uv5YztYi1lTCdU27HcY4=;
        b=zIYMoHNX6SAwqxHKmclysSLzckhOiOkPcHAdxrFq0avZeovYANzQVS+bG8Lgt9VrfZ
         EtOnFgwSgMdo+Wvx7uV/+bI8QN18wTVCjPkWK18sTAGhU2V19dAjdWChejndrm8xz03Z
         XgbrMbESjZhNSkynNOHnlUxHiTOsTh/6gCl008EEBsAbtcnG+a8n+W3b6Z8H5MmPSKpm
         QwaEeADTfNKePAkYT9AJMb6gBGV1wN/uJKP/50ANiOB8WxE58ItOXCARPi4XtpFlSsig
         GWBIbINfRMo6U3XxJpZL/3EvKhkBf2kjayavl5a9ndpO/0+Jykc64I8PWuR9ZyOVskWp
         ZtvA==
X-Forwarded-Encrypted: i=1; AKwUvBzW4Sat5tnUt2Sy4ZFZy3kUZwcm7CQREYbKsKySLejG/lTf3EW9ROV+K0SiyCYhjRS3C6jntTbpaw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ46l6hyIFtcJpxizNTorkMmY0mUmMbsG/O5neKMnqpCpbcpiB+
	oEEXbqGX7o50CdbOKWjcpk+QuoN1gLcwXrUIWGWqXbPcIJZSXisXocQj
X-Gm-Gg: AYBFou3+AGaZCUZLHCflcLFkjriDSsov1n1rIBmYF3CePM677N1hUK3XZdZHGxXong1
	4DgYP2Dx937acNPp1CMo/vVYDIiwguGiCfjxtsYH2CLPFX5Dd+KbXByMqgVPCCtecHVwGtlkXZH
	jSznmH7bFNV32lUreBKxi2BToKpoBdFdaVM+ycrEkX+drXCXO8ti8j1dW9HJjCZKJUe1cSHZhDu
	twU1/EWZ7MGgb/ZIbVi9300ewQxFrN4Tn1FzkmujIkgdoyTcXa50qNCQqoGl4CJzygiGnQ79osh
	+A6UPD6tf/XP8qBBCIRr16pi9hP8ZmA79YLtW5WiLVY54fOymo8BsXXeS8TcmpT8A2GiINJ5C4f
	uiwx7IG1YIU+lqxUjIiWr2SEiRzn2XrAML3njEX0xrP25Cjun1kD8/yp+QwcSyXHRtvpeR56pCB
	Yi4NRjNQyGiZ3FJ4H+8OLNyTXwJ3JpFK+3q2oNwdEuWk7NxyLqghNVcCFdz+xoxn9M7f/TbmMAZ
	q954hAifMnvIZxGutk0gtDFOTeeG5XqIGr1FcC1Mu8pjCzxFEDrwwfX5Rm54xzFsOjPvrSUe2PP
	K5cja1NZ0+dRejgn9HRNsWveOJzUyG9Iqw==
X-Received: by 2002:a05:6000:4a0a:b0:48d:de0f:b79 with SMTP id ffacd0b85a97d-48e3eac8e4bmr13027887f8f.0.1793019430839;
        Mon, 26 Oct 2026 05:57:10 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:d036:ae00:fa6b:a9a8:1f5a:6fcb? ([2a01:4b00:d036:ae00:fa6b:a9a8:1f5a:6fcb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm16561378f8f.1.2026.10.26.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:57:10 -0700 (PDT)
Message-ID: <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
From: luca.boccassi@gmail.com
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, David
 Howells	 <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Andrew
 Halaney	 <andrew@amutable.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn"	 <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:57:09 +0000
In-Reply-To: <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
	 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
	 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
	 <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
	 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
	 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
	 <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 13:18 -0400, Paul Moore wrote:
> On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner
> <brauner@kernel.org> wrote:
> > On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> >=20
>=20
> ...
>=20
> >=20
> > > Of course, fitting in with existing norms is important,
> > > but if it causes IPE or existing IPE uses a lot of pain, that can
> > > a
> > > good reason to diverge from those solutions.
> >=20
> > Which pain?
>=20
> As I said before, (emphasis now added for claification) "... *if* it
> causes IPE or existing IPE uses a lot of pain ...".=C2=A0 I intentionally
> did not make a claim either way.=C2=A0 Once again, I wanted to provide Fa=
n
> some support in case there was an issue and he found himself in a
> position where he had to push back to preserve IPE's model.

I think there is one issue with the design pattern where keyrings are
set up in userspace, that I have mentioned a few times already and I
got documented in
https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf=
.html#RestrictFileSystemAccess=3D
as well: they are trivially bypassable if the kernel has kexec enabled
and it is signed. The security model relies on the "good" userspace
running first, but if kexec is enabled, there's no guarantee that will
be the case, and as far as I can tell it gives root trivial capability
of overriding it and extending the trust chain as the attacker wishes.

IPE specifically was designed to avoid exactly that, and ensure
userspace could not execute untrusted code, even with root privileges.
With this enabled by default, userspace can just load the same signed
kernel image, passing in compromised initrd and command line, and gain
arbitrary code execution on the host, since only the kernel binary
itself is verified, and anything goes for the rest of the kexec
parameters.

This is of course not to say this new IPE keyring shouldn't be added.
But perhaps it would be nicer if the default build flag was mutually
exclusive with kexec being enabled? Not sure if that can be expressed
in Kconfig though? default: yes-if-kexec-off, no-if-kexec-on

At the very least IMHO this relationship should be documented
explicitly in the kconfig blurb, as it seems to me it's a major footgun
to leave laying around, and users might not necessarily be aware of it.
