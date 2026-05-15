Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAE44102C
	for <keyrings@vger.kernel.org>; Fri, 15 May 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841480; cv=pass; b=TcWmp7NRZA8g/KmXce3iPHwOOg/fHlJI6MQ27AY0lnqBoB7GTrwVBosq9DOrGYBdbUp5Yjt2rZZMLKs80bi8gwwOxJfeHiBh06zTVEpBguWdRQWp2nbMlC3OHXrZ+VLVrYHILpAxfoXaPA9vXHw27G466OqZD+zBiq6QpUgYde4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841480; c=relaxed/simple;
	bh=Mg37Wy3KRnUM1ONATbgQfacA9HiWz4ji3AcGoZ9aFz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7OQYpRRf6LxkkPgUIW10+1DC+FXV3p+QrkLEDYbYgUmZXLdJjQ63R/ZHFtY0wgjeWZikin8U/9mEhil+Dio5P01Y19OHZQZ0nsXZNb2hYhjsijcJLWTRgL5U6dzOTNjFM3Xefo2uSfTwcnEBgf/KtZq4Ltki7m5zy/2eTdcCZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtOjj7YD; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtOjj7YD"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9358dd7f79so1449601066b.1
        for <keyrings@vger.kernel.org>; Fri, 15 May 2026 03:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778841478; cv=none;
        d=google.com; s=arc-20240605;
        b=XjZtdF41/jillvdrUTVHdfOqNMoWsuXhhXzHM76hZIAHzew4++2oagdaOHAfhqI8ho
         92fKVGKM7GFtRhSfB0DOFV9EumLto2PAhMI2sCe5Ck00c4ejBTGNBFG/ng5eUjMpZrvY
         aAhz1sFHBqAsujDGLEbMn5myZZa7pXLy31OH8Q06OMbjf5lckdroFtwu0QSuAO/oMPo8
         MpQzybxVz5BU6SEihbXw43W7pE9svoWaQWGtIZyLNzoE+O9LdYbXCTWwpn4joAi2ZFvU
         Iv53lKfo2glScadOIpqi5bSwE+Dh8RA5GUHYq5fLUI+/uAwDUQVjADdvMqvb6R0MaIeR
         YZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2Yl47ee8MtjXEIcxqYtsCZZAToZXmE/PsXL+BkUBMc=;
        fh=JxkzF6YF6VohfWbLHlms+tJd6OcW48D5/NqmNKET3mw=;
        b=UaHm2AoEjGpHYWNiLVtHRoKqyk67Dx5DMxRLMbw3Gb6sOFzft4Bvyb0Sl9zrbsM8e/
         YVqPGvi6fD7deOiL0mPSYxVRkrkEehpONFF6DyIamArrvEBPrI9aDfbT+03qaf0s5lpB
         SFRfeiEVFyepxT7GWX5n33wbHtvoA4oIHPWAgURmj/Pte+aC3VoO3KIwVPANspD9oaQG
         MdIUNg64XNMxs04RT/yN8Utyxjzjtuz6/YwnSZ+EfJlRudrJZZ1XyFQOo/LhOFzd/bVX
         m6u5oy03OenRxkkU+L24rak3xcYzxPQ6732Zt5IuJWORvct1Uq1qgGxIYJLnyqC8M65/
         kniQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778841478; x=1779446278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2Yl47ee8MtjXEIcxqYtsCZZAToZXmE/PsXL+BkUBMc=;
        b=QtOjj7YDHKJ71LWW+HRX01pb/fw1kJ/REbbmui3Ew7YYeR5NOqun8NP8GPgCc+er37
         8SlfEgB0mPjU4liUknohOzApFEoVQv6s8tK48oGg0475lHWBsa0mrJYqZDfgSHZPZ9B9
         BhwjSyKQ/xE1dF/4K1HHTZAR2gAlBpTL0r/DSvf6TXGLatLPQOUnNPYoLpNNXhZXwNV3
         ovki0YEwo+Yin0nZKSmFq5qHd6uq8kyQr+1RiE4OE7dQbnc3UnXNOE6TByJmYde6Fz6t
         Ag6sA38HE7uvw1SyB+m3Lw2+eLTQc37wU4gvtyaWwSvuopDpbIjty617mscGnP/goD+W
         015w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841478; x=1779446278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2Yl47ee8MtjXEIcxqYtsCZZAToZXmE/PsXL+BkUBMc=;
        b=ffpwlMbYIZ1KlrdWyv8lo4o/HqAHfUpF96GXFiTKFWQt7x8BHlw4aaktg4RzlB2Ukq
         mAz4OFaqIh1F9028/YzyKtVhnwaxO30LCKuZwpaFTKCMQMimLw9MkqISz+Qfw6p9kcyh
         MkzDyMtZfdmWXOP0wT8AwYzomArU1niy1fOfEvcNrUHzF4IXl86A8W4K/KqKlfy4rovy
         5l0sU7C7DZi3oqmoS3GUplxBvyPrRIqutDyXfaWn9ep5sy9Eb/9McZINu90dmOui1a/n
         XUQKFskpAgRSmU1gwU5kB3NmFVwPRIcs80pqiJ9vnb5QC4eP2b7XE7knHz1oIpPD2Zyv
         3DgA==
X-Forwarded-Encrypted: i=1; AFNElJ9osX4wdNs1J7Vqa+TsX57qToyD425FuU3hMBdB4jvRfRE3zXS51eS5ncNeYToAmBcymE5kWH+tuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze96NxT9vxLI/LirIh/xJ8hcWDfH305rcomB/7KRjqBrSWguvy
	C9hPlGXZKDoD/ZBhy6bpcyHsOEmlRreLZQ2k/DSGSYq8PxvFIwGOL/sOgLGCf2UBKIH++4Zv+VZ
	jf48z97r3+dMspVCIfLLFLdeAOxNay/A=
X-Gm-Gg: Acq92OF4E/V3MaBx5EYLSUDbcVQ5QkML8/CTG6SEWJdVkhIFUwLXl1yRqiZHHsJZzOc
	X5sG3E9MGMiVqjwc9MvwEO67pHluLRRxXAGjelcDvtyT6OPpHxDeo0irOZS04WQRVT/lvjAMM4x
	SC7BCcnSIQ5FR2IcVucawDFz0bI1ckMi4T6AeSXPg4rcSf9zU5cfOrQGvn7ZS9IUtP6ck29Nrbd
	sONjlsCbv0wUDw50YgrOFOka4PYR+0j3aRFc4IWgeySg/nf6IzOOp5SI38UnxGp/DLWhJ/caNQG
	LWE6m+rg
X-Received: by 2002:a17:907:c486:b0:bd5:7a3:a590 with SMTP id
 a640c23a62f3a-bd51797a605mr162534266b.47.1778841477716; Fri, 15 May 2026
 03:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <782bc59d5939aa69b58cad42f71946f1c0a6dccb.1778741457.git.lukas@wunner.de>
In-Reply-To: <782bc59d5939aa69b58cad42f71946f1c0a6dccb.1778741457.git.lukas@wunner.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 May 2026 20:37:29 +1000
X-Gm-Features: AVHnY4J6Fk9yBInmPYPIDVgxM9398Q03MJN3uwc9o-hhnM1187xvX0jLlEj4EeM
Message-ID: <CAKmqyKP=UuH4LGZC+HwDa8C9178b3345xo6GECxQw-dx8CUphg@mail.gmail.com>
Subject: Re: [PATCH] X.509: Fix validation of ASN.1 certificate header
To: Lukas Wunner <lukas@wunner.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, Ignat Korchagin <ignat@linux.win>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:57=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> x509_load_certificate_list() seeks to enforce that a certificate starts
> with 0x30 0x82 (ASN.1 SEQUENCE tag followed by a length of more than 256
> and less than 65535 bytes).
>
> But it only enforces that *either* of those two byte values are present,
> instead of checking for the *conjunction* of the two values.  Fix it.
>
> Fixes: 631cc66eb9ea ("MODSIGN: Provide module signing public keys to the =
kernel")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260508033917.B5873C2BCB0@smtp.kernel.=
org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v3.7+

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  crypto/asymmetric_keys/x509_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_key=
s/x509_loader.c
> index a417413..0d516c7 100644
> --- a/crypto/asymmetric_keys/x509_loader.c
> +++ b/crypto/asymmetric_keys/x509_loader.c
> @@ -20,7 +20,7 @@ int x509_load_certificate_list(const u8 cert_list[],
>                  */
>                 if (end - p < 4)
>                         goto dodgy_cert;
> -               if (p[0] !=3D 0x30 &&
> +               if (p[0] !=3D 0x30 ||
>                     p[1] !=3D 0x82)
>                         goto dodgy_cert;
>                 plen =3D (p[2] << 8) | p[3];
> --
> 2.51.0
>
