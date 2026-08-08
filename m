Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989C2848A7;
	Sat,  8 Aug 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215013; cv=none; b=MvzckSicYjdTV4vw7G+2szbCt2lNLqgvO8Bp6rDx7yOfdX2unmuSHqX73lfECvKojPijzIfOG/7lCtUu/UYY+y5nzymX3fakXBoftWcauIM9eoJsvo0Ded3vtumgKC7w2DHd2I5FC7tFGIKGcr56FEP2g+NCvuLSzDRCXyLXmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215013; c=relaxed/simple;
	bh=UQsdRLoFXqVd/iVvqfna96CbZTh3ttUtYk701j6I2kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkTcyJ/H6gCQOs0INhi03VWNPhbJnqTLN0u5oNIKX2iRGgDD99izmcqEESotMtY4RsRorbmzcIwbghpO3jm/cDKmXZjLorI9GjmvFVyp9FIbIQ5AoSmQE5Tf/RmtXfDORAVbG+pk8Uv4NmYJW/er6hbgC4XVxHAWyTbLi4hKwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=P3lmmchK; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="P3lmmchK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1786215003;
	bh=julX4w9WvO3qJYA7oEBSZmrqq5UsDWhkpWHN4yGURhc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P3lmmchK7qzK9oRS35CgHk+lumSKodn9A91knUWRVGGu5oRNbw1BauwjQQTSb8iNB
	 OuuuqffqZgGR1Tvfvtdsr9q+5nBvnv260aBbbW7Pe8X1//qBCDrj6eRjRApCZvNdI0
	 SY6J7RDYRMHDDkJldJCErMR+JwbHB+99LJ4UZBxo=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1F82565983;
	Sat,  8 Aug 2026 14:50:00 -0400 (EDT)
Message-ID: <8932791855928d9f12b7356648e2ebacfc126bee.camel@xry111.site>
Subject: Re: [PATCH v2] certs: specify byte alignment
From: Xi Ruoyao <xry111@xry111.site>
To: Giuliano Procida <gprocida@google.com>
Cc: Will Deacon <will@kernel.org>, dhowells@redhat.com, dwmw2@infradead.org,
 	gregkh@linuxfoundation.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
Date: Sun, 09 Aug 2026 02:49:58 +0800
In-Reply-To: <CAGvU0Hmxr3VSrfRCCZYjy4qKM+MkuRkXehGvKRwudZzUPX4UWQ@mail.gmail.com>
References: <20250912100015.1267643-1-gprocida@google.com>
	 <20250923081344.1657783-1-gprocida@google.com>
	 <aNJjdzrkvfDm2SsK@willie-the-truck>
	 <b7fdaedd9166b06133d35a254600131b7b9e5698.camel@xry111.site>
	 <CAGvU0Hmxr3VSrfRCCZYjy4qKM+MkuRkXehGvKRwudZzUPX4UWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 15:32 +0100, Giuliano Procida wrote:
> Hi.
>=20
> On Thu, 6 Aug 2026 at 14:51, Xi Ruoyao <xry111@xry111.site> wrote:
> >=20
> > On Tue, 2025-09-23 at 10:08 +0100, Will Deacon wrote:
> > > On Tue, Sep 23, 2025 at 09:13:42AM +0100, Giuliano Procida wrote:
> > > > The alignments specified in system_certificates.S and
> > > > revocation_certificates.S are intended to be byte quantities.
> > > >=20
> > > > However, the .align macro is architecture dependent and on arm64 it
> > > > behaves as .p2align. So use the .balign macro to avoid unnecessary
> > > > padding due to over-alignment.
> > > >=20
> > > > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > > ---
> > > > =C2=A0certs/revocation_certificates.S | 4 ++--
> > > > =C2=A0certs/system_certificates.S=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++-=
---
> > > > =C2=A02 files changed, 6 insertions(+), 6 deletions(-)
> > >=20
> > > Acked-by: Will Deacon <will@kernel.org>
> > >=20
> > > Will
> >=20
> > Hi,
> >=20
> > It seems this patch somehow got lost?
> >=20
> > Kexy found MIPS is specifically affected by the .align directive: on
> > MIPS it not only behaves as p2align and introduces a lot of extra
> > padding, but also moved before the __revocation_list_end label in the
> > case of
> >=20
> > __revocation_list_end:
> >=20
> > =C2=A0=C2=A0=C2=A0 .align 8
> >=20
> > in revocation_certificates.S.=C2=A0 It seems the GNU assembler moves th=
e
> > .align earlier to mimic the IRIX assembler behavior described at page
> > 110 of https://irix7.com/techpubs/007-2418-006.pdf:
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0 Labels immediately preceding an automatic or explici=
t
> > =C2=A0=C2=A0=C2=A0 alignment are also realigned. For example, foo:
> > =C2=A0=C2=A0=C2=A0 .align 3; .word 0 is the same as .align 3;
> > =C2=A0=C2=A0=C2=A0 foo: .word 0.
> >=20
> > Kexy's AI proposed the same fix as this patch.=C2=A0 So maybe we should=
 apply
> > it now?
>=20
> That seems like a good idea. A colleague raised it again this week.
> We were considering just applying it to ACK and forgetting about upstream=
.
> I'm glad there's other interest though.
>=20
> Could you raise this with the relevant maintainer?

Hmm, get_maintainers.pl shows David Howells and David Woodhouse are the
relevant maintainers and they are already CC'ed.  Or is the
get_maintainers.pl output inaccurate?


--=20
Xi Ruoyao <xry111@xry111.site>
