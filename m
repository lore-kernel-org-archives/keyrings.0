Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD403D75C8
	for <keyrings@vger.kernel.org>; Thu, 14 May 2026 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743227; cv=none; b=idsdp1vzZ3tnYUvc0hirkhcU2nQFiPTOxeaa/xKK4h8eaK05tFH6gGXUrHPLX4fMDt9nUUjl7mfSkQroiqiePwoO+utErdHEZnfsEpnk0SQizI7DstK2Bgegw637CKy38XJT+hTVTNTSvLC9pBNP0svi25pq52oRNqLT64Z/99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743227; c=relaxed/simple;
	bh=E6RssBBmAqBzFjzTCkj4CSOEJNkyV8OLPtr7KQ6b734=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEXgvranJKjQwFp1131FPrdWA8CPpnrwGoORr01Vo3fpp/JQ3BQMf3dsXbNOJ1xCG0udFEAZUTzo2f5d77CK0Jvx7Rqi6iQN5lWifgPPeUuOh2/vYG5gG7MiyxShLKcZgO4CsHO4nE3mrigaV1ixu1MBrFDVm7IEaN8LdoP5qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so503571966b.0
        for <keyrings@vger.kernel.org>; Thu, 14 May 2026 00:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778743224; x=1779348024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7B5MWKMFLrmoGLirIc8b2/MwxqSJztL07xc8VW1aWxo=;
        b=Kf720XlZ3IiaK3PBlIx1lV7LWgFu3jZQpWAed77xe6HnoXxn5l6MQ9um3f76eT37XK
         2sIitsz8ytQZfQwRylBFus7a3tfLsBmxo9UJfjOVF9lWvzrpgiKcIfjDyM+xzxzLnE2v
         4Yt//ZLUzkagi5DBmWjftT+C0A7B3IukF7i+CxAVcJM0VlQj7ILTNe8zeS+M5lfEXDK9
         nWfYNfFisIpGDPLV8O8RKSW6+hzlcxppZib/5d/YxkzkSpgkp5u+bXPJoysqmPrzmwv9
         5ZBfQQ15ooOcFMlQyJoAbrU7rDZtS/38J0u6uq9B9v0TwJmx2H0Qj7AkA3pQmDcw6g9t
         CDBA==
X-Forwarded-Encrypted: i=1; AFNElJ+yBXdk99DEDOOiURK9YFtJC+I/vOiAFhvrCX6fk3NqFZ/dVWMHB3saXouZHVXd5/4yU/ZCx13TKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+BzVmoT0MJkrrfvzTcyHKdsK0PffDHQgerdjIKU040omEA5Mq
	TUDlCL+3KL14rAdLOJ0pcd/G2GqCtysGYO+zfGjUcRt2AEyuXe9WURbPByYtpkbrqfw=
X-Gm-Gg: Acq92OE0qE0EzYkNydelLgES5li9IleqSfpkR4eMiQgmzeO7CVcQeo40FJAUEpxZY6G
	BY1mbHCd0jJ79WGOugbT+5Xdno3tVa1Xu+c4RAFdl4KShaqOaFaBibLHDuDI3lHcYwB85qepWJV
	kacOi5B7vN34AhxBO7ZmgbvEbuJmW2JxipENEkHgKpZ5yfrDk5UiSXB8IT0fCW+83jLY03TN6td
	RFUeA700f+E8qtXK+8Xl1Duy7mLT+IOhSFaMmLKS5CuQEtMewg2YUPbQeY97G9Xd/KNIvy3Hr6D
	PyVyG2AgfSMbvEq6b35dBL/8JieOSBlHvQdK09E+Aygz44xJIEPg5XojJb24aAfz+UpZSru3XcQ
	q9cJj51BMJYovefQ6r6ryHsYS9C571lu4dBwg/zh9jPk7C0+btg+Ign/QNQXBO6bexe+L6uOyvu
	Q0V5NtZ0R0Aewsn8tbzkj9osF1zRFAxxAjx1CUVnz6nlwOAHCkmT+8Rw==
X-Received: by 2002:a17:907:2683:b0:bb9:2893:6a45 with SMTP id a640c23a62f3a-bd3e2ebe831mr409832666b.44.1778743223501;
        Thu, 14 May 2026 00:20:23 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4969850sm59959966b.0.2026.05.14.00.20.22
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 00:20:22 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9d9971d059so1115738866b.2
        for <keyrings@vger.kernel.org>; Thu, 14 May 2026 00:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/OJm9pMzpQWS62z44OOYtHo9CYvpGvaUWVReTCBazImqNTXEl06K1gj5+sLQyo5osocM52eihwVw==@vger.kernel.org
X-Received: by 2002:a17:906:dc8a:b0:bd1:e2db:f0d6 with SMTP id
 a640c23a62f3a-bd3df57e0b3mr363059766b.5.1778743222610; Thu, 14 May 2026
 00:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <782bc59d5939aa69b58cad42f71946f1c0a6dccb.1778741457.git.lukas@wunner.de>
In-Reply-To: <782bc59d5939aa69b58cad42f71946f1c0a6dccb.1778741457.git.lukas@wunner.de>
From: Ignat Korchagin <ignat@linux.win>
Date: Thu, 14 May 2026 08:20:11 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVQj=dyEwPM8ujD8pjRwufwLRjZtq7nPVyw4q9e-ryC0A@mail.gmail.com>
X-Gm-Features: AVHnY4L2fQW0KVM2kvDv2OdU52Z0W7UgO7CoJj1AAZsBE1bEz9lIfLFwU_zoRZM
Message-ID: <CAOs+rJVQj=dyEwPM8ujD8pjRwufwLRjZtq7nPVyw4q9e-ryC0A@mail.gmail.com>
Subject: Re: [PATCH] X.509: Fix validation of ASN.1 certificate header
To: Lukas Wunner <lukas@wunner.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:55=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
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

Reviewed-by: Ignat Korchagin <ignat@linux.win>

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

Whoa! Nice catch...

>                     p[1] !=3D 0x82)
>                         goto dodgy_cert;
>                 plen =3D (p[2] << 8) | p[3];
> --
> 2.51.0
>
>
