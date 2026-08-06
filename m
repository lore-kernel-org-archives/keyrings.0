Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418343A2E2E;
	Thu,  6 Aug 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024600; cv=none; b=bhD7h/GSefw9fIN635U/hLFnNyolg5AtZZWHi3ecm4xtohpNbVTmVDUJMGYBTLX/AEDyORwmzuJ9nwU72iehJsgjqj/Yn1T4Me8xDzUpmu6rv9S3R4Uj9udWsT0r3cNQTbaw12XeEoftE4yMU6Wf2EmUIxcMZJ0oXz/aFLud9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024600; c=relaxed/simple;
	bh=Vy2w8cC5bK0oRApDiki2ndgTJRnwoAqhrO1EgdaQ+Ew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6t8FC7fPhVMShLfxh71peP9BHHbQ5k4T7hDehWVlWpNqSyD9akVosIEkBW2W+5WXEAKKf4JuigE/Vq5vAR/p7RP4nr2WqnZhJUHwKo9WXD1VNHZWVe2yJK0hgrWcNA8MFB6TKQjsTKQqxU6Qqrr4gxpOw2mUcz01rC6xwhwe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=J7gWgQkJ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="J7gWgQkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1786024228;
	bh=8L7udBp8a9ngID9OyAXZaJi65QmpRWTdBTwoGZK5XD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J7gWgQkJmB9tx2OjOTbulRcw+1tUdMddTJMQLqtNgmLl1CAIuss91C8cSs8JA5J/L
	 UH0gKVcRUN0L9H2qqOXJPNiPIHRbCne55/jxoHGRXy4nDmtdy/1kvcREI/jMhBEza4
	 1AeZYGcChatSujrjkUZ29LdSRLKGMy1n3iMsam2M=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DCB6F65983;
	Thu,  6 Aug 2026 09:50:25 -0400 (EDT)
Message-ID: <b7fdaedd9166b06133d35a254600131b7b9e5698.camel@xry111.site>
Subject: Re: [PATCH v2] certs: specify byte alignment
From: Xi Ruoyao <xry111@xry111.site>
To: Will Deacon <will@kernel.org>, Giuliano Procida <gprocida@google.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, gregkh@linuxfoundation.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Kexy Biscuit
	 <kexybiscuit@aosc.io>
Date: Thu, 06 Aug 2026 21:50:19 +0800
In-Reply-To: <aNJjdzrkvfDm2SsK@willie-the-truck>
References: <20250912100015.1267643-1-gprocida@google.com>
	 <20250923081344.1657783-1-gprocida@google.com>
	 <aNJjdzrkvfDm2SsK@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 10:08 +0100, Will Deacon wrote:
> On Tue, Sep 23, 2025 at 09:13:42AM +0100, Giuliano Procida wrote:
> > The alignments specified in system_certificates.S and
> > revocation_certificates.S are intended to be byte quantities.
> >=20
> > However, the .align macro is architecture dependent and on arm64 it
> > behaves as .p2align. So use the .balign macro to avoid unnecessary
> > padding due to over-alignment.
> >=20
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> > =C2=A0certs/revocation_certificates.S | 4 ++--
> > =C2=A0certs/system_certificates.S=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> > =C2=A02 files changed, 6 insertions(+), 6 deletions(-)
>=20
> Acked-by: Will Deacon <will@kernel.org>
>=20
> Will

Hi,

It seems this patch somehow got lost?

Kexy found MIPS is specifically affected by the .align directive: on
MIPS it not only behaves as p2align and introduces a lot of extra
padding, but also moved before the __revocation_list_end label in the
case of

__revocation_list_end:

    .align 8

in revocation_certificates.S.  It seems the GNU assembler moves the
.align earlier to mimic the IRIX assembler behavior described at page
110 of https://irix7.com/techpubs/007-2418-006.pdf:


    Labels immediately preceding an automatic or explicit
    alignment are also realigned. For example, foo:
    .align 3; .word 0 is the same as .align 3;
    foo: .word 0.

Kexy's AI proposed the same fix as this patch.  So maybe we should apply
it now?

--=20
Xi Ruoyao <xry111@xry111.site>
