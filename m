Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E57353ED9
	for <keyrings@vger.kernel.org>; Thu,  6 Aug 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026810; cv=pass; b=c5P+OoK8OcQ0y3VnIMS2EH9y5jgqYflYj3nLoJCu/2HxXIhPBNYHGN4O54kOzkADmsxOrxhLF6fpBYYrVBp6p58dEvghttXq/JjevKyFlaj5io5Mn61PrQfzKJdeYCH3hy2rxAU2A4cVcGCFMAu9yAI6HclW4kLON4mcAQz4ROU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026810; c=relaxed/simple;
	bh=Tg5aS73J4gFPrAqg5S3gb8NJ/GZdTYDT54+P+eXXnnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4ki//3kVISMNQG2geK37i6miJf9VBidOz6KirjnDka/eOjSDb08OaLR+RzhZYQ49dfGqRxGSDSJrwd5dCWBTHFJAI9RjTw8vyGNk/2aV4lv5M88sSJ4edjF204tA5dUiAq5kVXD1jubdDfAiTLdWiWPRGDZ+WpT+UGYMKMGghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMggf6to; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMggf6to"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15a5b265so324221cf.0
        for <keyrings@vger.kernel.org>; Thu, 06 Aug 2026 07:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786026808; cv=none;
        d=google.com; s=arc-20260327;
        b=SBnObd23Kug6Am6pY1ksuZA3ziLXywnY1WLtfl4YM1Q7xeXFgKYO4tBJfOliHzsbgG
         9wQUtRksrsk6eM/WSi1R1s0IMsPe25UG0veHtlbPJG5mLtND2HeSt9T96RCupWyUeNll
         SZiT48bSRGNa8xzo3CODx+FcPMx7HzAoV+vdQaFv0Aidza229CF+A9rpkNXjDdfBNldI
         2Gvwq5496gTzPIQZZEv5gA5UPyGrNIm+PAe0oqLFeYRHzw3bKGNWOtglKkD60OrkiFkf
         S8eWSaxWEaJxnyCJZkYSYfLIlQknbWG+pY5Bm64Q3J+EAYnOsy1iPGlox5A1EB2EJB1J
         lOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sSE4t5mDYJiGRD2YQPP/vFdfHtmeF8nhZsqMNnPDHd4=;
        fh=RhN2xL+/57Z561UTS17K3Dd6gxwRNiJjCyvdAs05Gu4=;
        b=Ata+AYaxKuHeKmOmrdVxIMGtcsUXaJEcEUNpJiZmNMGkFM6UKS8fx36qkTUzEImMaD
         FYP1jOCgFDKemTsc0D3czsc5XPunzdE+abU7ICeQmAsVZ5xpwN5FDVcqxWOUY24qrJln
         ppBZjwwsX5EAP1Vd3zZKhabeswyACbB8wws5AxmDMwwRT8njprRsEJR4Otnb/oftBUju
         pA2J1KxT9J9YHMHGBT8+YsMe832EUIJXZ1wvWxo55AsqjwuuPK7rRIOKNExgmu0fFsyw
         EeiJPUNyHMr87geL7yTHkPneINteE/iG/HlHm+MeQsuwLECwaWR4ceDyr226jQEbdPaL
         ixOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786026808; x=1786631608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSE4t5mDYJiGRD2YQPP/vFdfHtmeF8nhZsqMNnPDHd4=;
        b=NMggf6toGV8y2z9INpr8sF5isc1MXpmhvagCY3OJwOdOkfscSZJ3ejcDnQaBzL/F/Y
         SYrLKHwApK5SsINEhdF1u1bmvs2qKFdrEKSTVDqA/R7uxXLDcF9cgoQhbKg4VVfWvSXc
         FF3dzFhX5xN8EpRyxToNAYGwGCn1/q1GnK+gjjylKGkbtGUP92GlPOlmOEqxifs99lgz
         cPYd+Kl1MEKWK1UxIm+LU6Whkt28JmzM25dtXu9U+qILci6oGquemhdRvkA07tmA+vav
         6JeYfb2g06yrPgujcS3MCRLaLGccJVIU+Vloger3hpGkGboCN0DaF+8icGnlh6GbsWMb
         rxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026808; x=1786631608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sSE4t5mDYJiGRD2YQPP/vFdfHtmeF8nhZsqMNnPDHd4=;
        b=nH+Q5RVQ6z/yx2Eb6dNguXLs3gno8uylPnkTWxyV3lhFpR9hUzoeif/5+R298FnSZ0
         aN3i46IrCmqzNU9EbkoKyAgM8exVqiooroPxuEPZvdorxA5jAPIM6ihnnYaBSnlx/CTe
         mrVVZ0MtDHqzYIQRxjphfs/yQdpoXsA4t87DLslnISxzopVd12bKPtxEfqgN2kwsF4fS
         RNe0UdZiwErbuP3VZKpcfFuDTXcvEF6CoW+qy5+aRZgJJT0NiscPVst5uIsPLpg3hNHh
         7EYOvxGh0tYyRe80CJqo1I24+L1vAeG+l1WLJnaMsWaprVPamat7dbk2QLbr/1Esspie
         wPSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPSY520lBkN23OLPfhi9EWqulfXpZidYhZCEclgHTEshG7ZGj7/w2zDc7pE68qQAgPrxJh9Iu4/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gpH7+c57PgsIDQI5fLBIOGB+7JdtTI8w8Nh1QKj3vgI9FzZ2
	pJqvOu6rwAyecXryG1eqrmuX2C7KLZN10kNIyvTw7r8px8gusdJec0xMr9tvhvb0X2x9xl8q383
	542ANZ8+ugjrGxXLzvkYDk9a3dbL7d8lJCq3jPaz4
X-Gm-Gg: AR+sD11E+M7Hq7V0VEWqi8TvQK6ZpjRL37E4/SV52Bf0Q85z04xyJEZoe/aXqmm3k9q
	iRnKOCZ2xLX43l3coaDP+7s8qC+bHeQcGEZElsG5roWZvfxI9zkPFNq8WewmDZQqZ5t3KLTbEdr
	HfkuuoZ6B656JfyS+Wj0kDuY1N3ckL+rjcWWENRKJe8zHVU/4UOJdElETKITSo9elVq4YSmKZAG
	usGVGf4LXz+nyEgP4KKp/zaOuSLm7cVx7nbYG3DGTe9FZ20C4xb4yt70/MRrKgYPjrc7doVNfzW
	qKFRJ74fAAL5Ue8gUZkIgMpEl1cUWys+EQHPrph8Oi4k9+IAnIGpdYAdww==
X-Received: by 2002:a05:622a:4c8d:b0:519:b655:235 with SMTP id
 d75a77b69052e-52cfea045dcmr17409301cf.3.1786026804773; Thu, 06 Aug 2026
 07:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912100015.1267643-1-gprocida@google.com> <20250923081344.1657783-1-gprocida@google.com>
 <aNJjdzrkvfDm2SsK@willie-the-truck> <b7fdaedd9166b06133d35a254600131b7b9e5698.camel@xry111.site>
In-Reply-To: <b7fdaedd9166b06133d35a254600131b7b9e5698.camel@xry111.site>
From: Giuliano Procida <gprocida@google.com>
Date: Thu, 6 Aug 2026 15:32:48 +0100
X-Gm-Features: AUfX_mw5HyYj37mygLEVpMyUJdybJryOFf9lO9TsMBTjKHGCSWwkGEA9_nRHDa0
Message-ID: <CAGvU0Hmxr3VSrfRCCZYjy4qKM+MkuRkXehGvKRwudZzUPX4UWQ@mail.gmail.com>
Subject: Re: [PATCH v2] certs: specify byte alignment
To: Xi Ruoyao <xry111@xry111.site>
Cc: Will Deacon <will@kernel.org>, dhowells@redhat.com, dwmw2@infradead.org, 
	gregkh@linuxfoundation.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"

Hi.

On Thu, 6 Aug 2026 at 14:51, Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2025-09-23 at 10:08 +0100, Will Deacon wrote:
> > On Tue, Sep 23, 2025 at 09:13:42AM +0100, Giuliano Procida wrote:
> > > The alignments specified in system_certificates.S and
> > > revocation_certificates.S are intended to be byte quantities.
> > >
> > > However, the .align macro is architecture dependent and on arm64 it
> > > behaves as .p2align. So use the .balign macro to avoid unnecessary
> > > padding due to over-alignment.
> > >
> > > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > ---
> > >  certs/revocation_certificates.S | 4 ++--
> > >  certs/system_certificates.S     | 8 ++++----
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Will
>
> Hi,
>
> It seems this patch somehow got lost?
>
> Kexy found MIPS is specifically affected by the .align directive: on
> MIPS it not only behaves as p2align and introduces a lot of extra
> padding, but also moved before the __revocation_list_end label in the
> case of
>
> __revocation_list_end:
>
>     .align 8
>
> in revocation_certificates.S.  It seems the GNU assembler moves the
> .align earlier to mimic the IRIX assembler behavior described at page
> 110 of https://irix7.com/techpubs/007-2418-006.pdf:
>
>
>     Labels immediately preceding an automatic or explicit
>     alignment are also realigned. For example, foo:
>     .align 3; .word 0 is the same as .align 3;
>     foo: .word 0.
>
> Kexy's AI proposed the same fix as this patch.  So maybe we should apply
> it now?

That seems like a good idea. A colleague raised it again this week.
We were considering just applying it to ACK and forgetting about upstream.
I'm glad there's other interest though.

Could you raise this with the relevant maintainer?

> --
> Xi Ruoyao <xry111@xry111.site>

Thanks,
Giuliano.
