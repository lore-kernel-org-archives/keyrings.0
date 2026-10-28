Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204082;
	b=0VT9MiplH2d0k/FqlWg0M0MUi7x2nyiKqm94sAXqDHvr2op+8ZwxrjaYpKur+SnD93VY
	 RVxavFA2Z2zX4XKELXNtLjsr954wkc7VUYiK2lj60bLhV1EHU82N/nXs4kt+gdgs3UFxa
	 bM/0hQ9UkC8OTWc6dwd5UeMPfUQjrVhKgoaEpPW11qUuG8+heIo9GHwcj/yOYP2O+iLAg
	 nWXbtJnSwa0zP1aRWnLD1WzFmUSQGJ2sXIOlwYkKir0g3bOd611JertjhpTVlIUTKgcTR
	 JRgb81ZOp4E9g/OOrscqFyqqD5Z8WUXVTFieWGS6wOqgkQrOvXuTiEmTEpdgOVTlM0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204082;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YYN469XUr3WsmN5x2KXUL5+rlZdUndMwuovf69cmYrc=;
	b=fHHAK47eWW0z4G109HjLzqnI3lPVcC32uAJwoH6iR3tO4Mn6nY3J3KO4z4kNW6Aq4Aoq
	 8RHQS87nGSFTyMfg2ZRscTOdsULlC6f3u7feARiIC2dtGcH+c0t1tR8zdZAB5ygXfmznF
	 WxVyI3UQISZzD07NpRqd885cAfnjLFhDDD2+MfVNbFDcHTPeQwZM1wixcMxoxdbaz6IZA
	 T9KJF2OMIeT1XuofgE8AQwzcFWyvdiMopq+FuHIb4F2a5MT+4MVc6pNBIGweYtX3YTYEC
	 ljJnS+5GTRXr7QbOtJUbQNVpVTB0GOawLQpa2rjHgcmPA0lWuE5U8+aylW+S3pnCrQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=dA79TVtJ;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E4606A31A;
	Wed, 28 Oct 2026 16:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=dA79TVtJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1793204079;
	bh=xkNCyrbp2VQoHF7RtBIDSpBRgMATx6Bjbp1pXFN3NLA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=dA79TVtJcezeBVoqsgIaDXIGseAFMoEpedt1bMNl/7xTyQ6mgSoGTYOFs7QNnVuc+
	 p463ULvumshHtfI7xRDLZSFVjdxNanvcXsQGrLkcrLDw7I1rAfkJ9g5Zc0gdNuwnO/
	 yta1xzXpKzRXfX5+WNikZA158tPJZ4X1yp40LvgM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id EAA851C02C8;
	Wed, 28 Oct 2026 12:14:37 -0400 (EDT)
Message-ID: <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner
 <brauner@kernel.org>,  Fan Wu <wufan@kernel.org>, Manuel Huber
 <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, James Morris
 <jmorris@namei.org>,  "Serge E. Hallyn"	 <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, 	keyrings@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	kexec@lists.infradead.org, Mike Rapoport
 <rppt@kernel.org>, Pasha Tatashin	 <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Date: Wed, 28 Oct 2026 12:14:36 -0400
In-Reply-To: <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
	 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
	 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
	 <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
	 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
	 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
	 <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
	 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
	 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
	 <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
	 <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-28 at 14:26 +0000, Luca Boccassi wrote:
> On Wed, 28 Oct 2026 at 12:42, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >=20
> > On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > > I think there is one issue with the design pattern where
> > > > keyrings are set up in userspace, that I have mentioned a few
> > > > times already and I got documented in
> > > > https://www.freedesktop.org/software/systemd/man/latest/systemd-sys=
tem.conf.html#RestrictFileSystemAccess=3D
> > > > as well: they are trivially bypassable if the kernel has kexec
> > > > enabled and it is signed. The security model relies on the
> > > > "good" userspace running first, but if kexec is enabled,
> > > > there's no guarantee that will be the case, and as far as I can
> > > > tell it gives root trivial capability of overriding it and
> > > > extending the trust chain as the attacker wishes.
> >=20
> > The attack sounds doable, but it also seems to be exploiting a gap
> > in kexec policy: kexec is supposed to behave like a warm reboot so
> > if boot policy requires UKI only then so should kexec and that
> > sounds like the thing that should be fixed.
>=20
> I don't think that's the case though, even before KHO/LUO existed,
> kexec has never really behaved like a warm reboot, as for example
> boot services do not run again, so various chains of trusts are not
> reset  (eg: a bootloader might now be blocked so warm reboot would
> not work, but kexec would). And since KHO now exists, the difference
> is even greater, as more and more state is retained across the
> boundary.

But still, a lot of people are using it for servicing reboots so it
does sound as if it needs policy control.

> > What's the mechanism boot uses to ensure UKI only? So we can see if
> > it can be adopted to kexec.
>=20
> There isn't one, and I don't think there is correlation, as booting a
> UKI is not the only way to boot a system. Eg: this problem applies
> just as well to booting an arm system on uboot. So I really would not
> tie this to UKI or UEFI specifics, it's more generic.

Well here's the problem: I agree root could kexec to their own initrd,
but it looks like they could also properly install and reboot to it, so
it doesn't make that much sense to plug one hole without the other (and
when they both get plugged it does make sense to use a similar
mechanism).


Regards,

James
