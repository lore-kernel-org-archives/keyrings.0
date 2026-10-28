Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191380;
	b=R7XaodXmRfvWZvJUkCWQxp3tNtx4zKO8JXhGtjdUou3bLsVvtUc0hg4HVvzFbKu9VDJv
	 zjQU3eliPMQfJgF1v1NRj38zxG0Gq1tE/eJrtGSegR0uO4m/T03jjf52DSffnT/ktUrgF
	 LbARbcodev5hi1tor6zU44jobZesIyYsqojJFe/x/p5YcAfxEIckjC2tZx5rqvMpURogw
	 aPeBgqHWGNZVJlbIjvolGWunRGhkydaaw3LUkdEJRXurO65cFj/dpncAeyqD4XHa9sDgk
	 N8hSTjYhvdng1FY8jnRzTFSX0g2ql2eO1oL9GJ8YEbnnaIKu1cSqIytQ5KLGuDyCxtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191380;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=bMwDHB+3ddcFQ1aKjPTDttqfXggRKYnNB2Il1VmUkbE=;
	b=xWsXEbQrDG8F52t12aLYWZoMlWb/6bwGfYUEQOk3oTDxDCasoKYPojecxETg2GhgcdS8
	 DZDmodNLEgpb9MoSRjLZYnI251/ia4tdrGq832NrhEBqA7eAf/iDDXbM6DjvgW3J94vw5
	 4083Tz/N/VjvNghwknkoJqa2IOHmOyym/ACpWdleN77RjBPKUtjgPc658CgsL+IdXKmNZ
	 6u5mj37wEvAD0f2EoHhC2qfQnQT6o4s0xjlme6FT5K0BTew7Xl3eFZnyvULE2rOOz4Qdx
	 gD9VRxt78xsSqbd7KZ91Psvw/kNmB+Y2L+X99IAHbgEi3KniCoPgNxAIb7uRuqFrJzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=OZtKrVBj;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AC606A31A;
	Wed, 28 Oct 2026 12:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 439AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=OZtKrVBj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1793191377;
	bh=fOpHXwlwUlS4qieCt/lH6UJKlWGZ1ep1hs8jgE78xrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OZtKrVBjbSBB+nGPoP2tKR9rJfuuXNoMVW3RQajFz2ChnghhL0uV/rbRJdFPw3qkn
	 PGNDiiuCTfTIjxnFi30x3KUnY1Gnn6jxABeXB9vpDN8WiVkX7yiKWpM0mGefImF3X9
	 +R6vg2QuZz2/37NEHLX3GY44U40Dyz8zICyMuQVk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 2E90E1C012B;
	Wed, 28 Oct 2026 08:42:57 -0400 (EDT)
Message-ID: <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Luca Boccassi <luca.boccassi@gmail.com>, Paul Moore
 <paul@paul-moore.com>,  Christian Brauner	 <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, David
 Howells	 <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Andrew
 Halaney	 <andrew@amutable.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn"	 <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin	
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 Alexander Graf <graf@amazon.com>
Date: Wed, 28 Oct 2026 08:42:56 -0400
In-Reply-To: <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
		 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
		 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
		 <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
		 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
		 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
		 <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
		 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
		 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
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

On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > I think there is one issue with the design pattern where keyrings
> > are set up in userspace, that I have mentioned a few times already
> > and I got documented in
> > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.=
conf.html#RestrictFileSystemAccess=3D
> > as well: they are trivially bypassable if the kernel has kexec
> > enabled and it is signed. The security model relies on the "good"
> > userspace running first, but if kexec is enabled, there's no
> > guarantee that will be the case, and as far as I can tell it gives
> > root trivial capability of overriding it and extending the trust
> > chain as the attacker wishes.

The attack sounds doable, but it also seems to be exploiting a gap in
kexec policy: kexec is supposed to behave like a warm reboot so if boot
policy requires UKI only then so should kexec and that sounds like the
thing that should be fixed.

What's the mechanism boot uses to ensure UKI only? So we can see if it
can be adopted to kexec.

> > IPE specifically was designed to avoid exactly that, and ensure
> > userspace could not execute untrusted code, even with root
> > privileges. With this enabled by default, userspace can just load
> > the same signedkernel image, passing in compromised initrd and
> > command line, and gain arbitrary code execution on the host, since
> > only the kernel binary itself is verified, and anything goes for
> > the rest of the kexec parameters.

Yes, but, it the above kexec policy problem were solved, IPE would just
work as expected, wouldn't it?  So this seems like a work around for a
kexec issue rather than a fundamental IPE need.

> > This is of course not to say this new IPE keyring shouldn't be
> > added. But perhaps it would be nicer if the default build flag was
> > mutually exclusive with kexec being enabled? Not sure if that can
> > be expressed in Kconfig though? default: yes-if-kexec-off, no-if-
> > kexec-on

I wouldn't do this because a) I don't think it's an IPE problem, I
think it's a kexec one and b) distros get very tetchy about hard to
solve feature anti dependencies.

> > At the very least IMHO this relationship should be documented
> > explicitly in the kconfig blurb, as it seems to me it's a major
> > footgun to leave laying around, and users might not necessarily be
> > aware of it.

I'd document the need for trusted userspace on kexec if it was a boot
requirement, yes.

> KHO/keyring folks, what would you think about preserving sealed
> keyrings across kexec via KHO so that the chain of trust can't be
> reset by userspace? Good idea/bad idea/yes send patches/no go
> away/etc?

Well, yes, we do have a similar problem with the trusted keyrings.=20
They're actually initialized from the shim created ..RT variables
(which are volatile, but don't die on kexec).  On first boot they're
initialized before user space, so we know they came from shim (or
another trusted component in the boot chain) but if root uses UEFI RT
services to add to a ..RT keyring, the added key will appear trusted
after kexec.

Regards,

James
