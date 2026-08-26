Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D183AD51C
	for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773870; cv=none; b=Upcbve44RNR/CsDeDnVVNVU8ZTWRv157mBemhTLn0J0etQ/L+VTRMDXnBd5D6/yjzZMm5COfMBz21NkXsl0EujrFmogPk/9M8q7wlhzeeocBCpqz4V3eMzEzzg0eJ/gYACsP4cCBMCvEKo4fQWkdmjUxW7tAEaolQM8eRnp4G1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773870; c=relaxed/simple;
	bh=M+TpnqIzx9YzVakWndAoYkuS3Ivh0lBQkdoao0Agnh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etqmGmEXCM/kJenB4S2sap99VfKIUh8p5xkAWt0LwJQMcNB9ogHcyqRE7v1I5P2Yo/Mf2XOuZkA4bdq7oxmTAfrvSmDZ7wZ8zC9hbzH2a0aLiK2c1ZbuU1ZKtJg78Ucm6ljj8l93ZQpvyn/2ntOujLZAAdbSb2I0fCWeBs0iCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1677c91969so155923066b.1
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 12:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787773864; x=1788378664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ffOGWLkNU0B5wefleM0f4kOcS8WHnfV6s3VJ7x4ll4=;
        b=npv8OhZIEnSEPHTVFcA4a37VSSOW8bvt25Ky8mycVEELiNDb8sUAjDQldSVoZ1GOPy
         CdG7BPKIUQmcn+oXDPPL6eHo5bOFkgC8PYpLp1i9KSvmeaFcDld+u4SU+XMPT6Zp3VhN
         ZdUTehVC8Z+bLJcuQHJkPQtNo4nJIayqcF6i0OD3mD4aVRUemooWe9r+CavcCMm9wFct
         OH+DEj0tyUHE35rI76WtYM2M8d+g8Agp6Mg1feEy1dFh9DYuYvJYZiEPnZJaEvwHEGmz
         c4Q3KBRv+3VwsLY1SxzR6gpUHgwfcB+M4zZM1g4kWg2DcVIkWYQuvENJQfstYceVxwjl
         InlA==
X-Forwarded-Encrypted: i=1; AHgh+RrzHiEgBuyBdANhD0QvVssW8ICr4lF/ycLk3QsJ51k8JUx2lxS0Z9b9kuhQhX3wP/hMVHm0kl89ig==@vger.kernel.org
X-Gm-Message-State: AFuF++kNAmXIMB+kei1CvOdCnji7+Ml8i+dGYjFRmi8Xz/rivWa/I0DK
	hlS4TU3Jw9sF7WT9lARgYbn/VQiTh+1mMqiRrVLB/DRLFBj2jKqU4+/QYx/d/qBK4kE=
X-Gm-Gg: AR+sD13Qt3sPrP8dJtCGbKDtBx5KMSWw7MhuJtB7/DRtbavGM/R/d7VSsye1tKw2Qmn
	qvRhlcGRoAmkscYl3XrP/Q62Ab8GnJx0VX5/0SOWbIs6xd8YMA6h2Yu4GAPcx+QZSC8Dc/35Ap1
	4Bb+6yTYBRXhMv9Ka+5kNGzHxx2l0+5ojG5E/lYrrCxDre9MeZfPN4yZLauBLgtRRuwsSayv1tE
	RWKmKcCqjlNkew+qAeFJKD+QHkB74AS//JoAAK+bNMexWr+1Cg3cIr/I4RCmCM+uErFF0YNMOy9
	UGza/9epH3PIz3Sxf71qhr5LqOPjkutwJ7P3mQkOIw+GcxNhFcCpGlUL4NEMWH7Au9mKFP3wIe+
	X+fBelLBWCVqFg0ZhoF7FDMUqXO1QXOXZzOFUCrtu+VT5Hie1NZHCSuHz39cr4gHOyVt7QQj1UU
	OKRg4Y9mKVsKhWkBCmopTezap9cRuN3rpgqD1lw7YvO7ZiJxz/RLZFz1bls4jDp296CCeSRkF+p
	EYDUSobb6lF8zOihqs=
X-Received: by 2002:a17:907:3ea8:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c250c32b5e2mr1141249666b.17.1787773864196;
        Wed, 26 Aug 2026 12:51:04 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25185b4d97sm503619366b.34.2026.08.26.12.51.03
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 12:51:03 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25344a8c6cso63476666b.0
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 12:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpOVzLV4O6rbiAz89/a8UVpO9lKdDeyv4xBw5bK15UoJjJ8Awnj8kLBYuClM3WMpSpeU/SNoT0Eow==@vger.kernel.org
X-Received: by 2002:a17:906:9fce:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c250bb50762mr1103314466b.1.1787773863104; Wed, 26 Aug 2026
 12:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
 <20260815114533.2171445-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260815114533.2171445-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Wed, 26 Aug 2026 20:50:49 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVggeq-Y4hysPRtpV0pQRBU8cZTm-iyQ4EpHM6-6eapkA@mail.gmail.com>
X-Gm-Features: AcwNN1W5DIcNWEcvlctI_OYJ194qPghIiHh-JbFunx3timWYfG5krkQObSF_4k4
Message-ID: <CAOs+rJVggeq-Y4hysPRtpV0pQRBU8cZTm-iyQ4EpHM6-6eapkA@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for delay on this,

On Sat, Aug 15, 2026 at 12:45=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> On Fri, Aug 14, 2026 at 11:29 PM Ignat Korchagin <ignat@linux.win> wrote:
> > > Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case t=
hat
> > > calls verify_pefile_signature() on real images: a signed-then-tampere=
d
> >
> > Same as your other patch - any reason not to include this KUnit case?
>
> The reason I am not including my tests is that I use real signed EFI
> binaries (a valid one and a tampered one), ~88 KB each via xxd -i, which =
is
> a lot of binary to carry in-tree. For upstream I'll write a self-containe=
d
> case that constructs a minimal PE in the test itself and asserts that
> pefile_parse_binary() rejects an out-of-range section, so there are no
> embedded blobs. I'll send it as a second patch in a v3 series, so the fix
> is not gated on the test.
>
> > > +       for (loop =3D 0; loop < ctx->n_sections; loop++)
> >
> > Looking at the code again: seems ctx->n_sections is user-controlled.
> > What happens if it is 0?
>
> For this loop, nothing: n_sections is unsigned, so "loop < 0" is false on
> the first test and the body never runs -- no chkaddr() call and no
> ctx->secs[] dereference. So the patch itself adds no hazard for
> n_sections =3D=3D 0.
>
> But you have pointed at a real pre-existing problem one step further on.
> n_sections =3D=3D 0 is not rejected anywhere -- pefile_parse_binary() onl=
y
> bounds it from above, against header_size -- and pefile_digest_pe_content=
s()
> then does:
>
>         canon =3D kcalloc(ctx->n_sections, sizeof(unsigned), GFP_KERNEL);
>         if (!canon)
>                 return -ENOMEM;
>         ...
>         canon[0] =3D 0;
>
> kcalloc(0, ...) returns ZERO_SIZE_PTR, which is non-NULL, so the !canon
> check passes and the unconditional "canon[0] =3D 0" writes through
> ZERO_SIZE_PTR. Because the digest runs only after verify_pkcs7_signature(=
)
> succeeds, this has the same reachability as the read this patch fixes: a
> validly signed image with n_sections tampered to 0 (the PKCS#7 is
> unaffected) reaches it via kexec_file_load().
>
> I confirmed it under KASAN. With a trusted key embedded, a signed image
> whose NumberOfSections I set to 0 (leaving the certificate table untouche=
d,
> so verify_pkcs7_signature() still returns 0) faults in the digest step,
> while the untampered image verifies:
>
>   control (trusted, 7 sections): verify_pefile_signature() =3D 0
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor write access in kernel mode
>   Oops: 0002 [#1] SMP KASAN NOPTI
>   RIP: 0010:verify_pefile_signature+0x5c3   (pefile_digest_pe_contents in=
lined)
>
> Address 0x10 is ZERO_SIZE_PTR and error_code 0x2 is a write -- the
> canon[0] =3D 0 store -- so it is a write fault, reachable the same way as=
 the
> out-of-bounds read this patch already addresses.
>
> Since we are now centralising section-table sanity in pefile_parse_binary=
(),
> the natural fix is to reject n_sections =3D=3D 0 there as well, e.g. by f=
olding
> it into the existing bound:
>
>         if (ctx->n_sections =3D=3D 0 ||
>             ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
>                 return -ELIBBAD;
>
> A PE with zero sections is malformed (a signed kernel/EFI image always ha=
s
> at least one), so rejecting it at parse is safe and closes the
> ZERO_SIZE_PTR write too. I will include that in v3 and cover it in the KU=
nit
> case.
>
> Do you prefer it folded into this patch, or kept as a separate fix for th=
e

Let's fold into this patch, since it is one place now.

> canon[0] write? Either way I will respin as v3 with the KUnit case once y=
ou
> let me know.

Thank you.

>
> Thanks for the careful review, Ignat.
>
> Fabrice
>
