Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7946AF2C
	for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712906; cv=none; b=NSLfBQZY2tnfVPdPMyLIEZ73h4ACmoCpp5vO02QbLkhpnly6Jdpoijw60u/fiYTAU+dGOoHJRuwRTstFdesjELF8szn25sX3jl2SKXzt/ygetHj0xzOv6n6t0qzzxQCd2kolgODu6Yn3BE49gQ8ZVjUqRuqy57SpOVKN3Qx2+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712906; c=relaxed/simple;
	bh=D+oA7XXUEwK8Vgcr5JtNxTy8Y5YNvhfR+mG8F/ppQbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja2/a8xkLE+e1igwkgOA6ZGnFA1+8F5Aow7D+iPWsZ5h05qtQS6C6bLEP+QcOyRgmYCWyjmQ/v3Cb+YjlBsehBilenx7gH4P3yngql4alBRpLahSSOldjEdBCEsotdxJo/Ot9picXH66BliA6rh6X2CT4zSQzTKhxPiMuj3wlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1408474a12.1
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786712903; x=1787317703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpKsPUcvfKXegQzg7KkqL+Bcp0KZtYbTU/PRYTZP8pU=;
        b=Bv/oCd1cZXRvOuWnU5zvH6OsxvS5SQcO4pKm4DwXwBkAMB9AHu5tXitIiI0wL4u6L0
         9nvW7m6nxwVBibMO247CmKjmspg9HtJaEwAKKxA4fGC31hS1BA+G8eSE8BmbFIeWyyCW
         YK8gjQnozRuny1sLqyJJnyRKTQ6t+LlFyh+lVKphuj4pDRxwPwBlCilIbPXyv7Y4Utr4
         NxXnom1C5Lg/+L5DopfqW5KbTtz6tI8SKnVgHb3mTbdamvND1BQLncRECqRUUNCpyOSG
         qvbfbBM/Nk5PKmQYdLkKcCmFiofUN0o3tXzIVqPf+/mXFf+8YgUtLWonIvFY46sFHoCb
         y5Qg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5/oaOggimS4ftH5+BlMnIXoYZnTpAP5esTwMmFoeunkKeWT7gNoQxlSUi9W/7znkgcOYyuMjwgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GBT5AtTSZKTVYHdcGDmPMGTT9rPpLPS9D+cgv4rxkth9F4/e
	vo16Zk01NvtoCuuhznoGaCwuEjMFsL833HxG/+KE4Qx+oq8GmvV3cUhb2e+gIGwytCc=
X-Gm-Gg: AR+sD13SNJ+GJrrfj2Uas8Qe/fOY9wkabPOJs4RrGoZWUqxVoIei1y2a/MHkWeCfioX
	MGo07riRmryE+b0TPstlD+lNUG0EbJkw/dgLGJQ6xaIV7fn0dNEp+cPHdVYjlwsQ4CQHJmtFwCK
	nuylHnPGftslIVPQsfOcf3Jryaf5M3WWEtf+7wHPUuxcdXZ+cR1i/qojBiRV3oQqRjRClXqpx7X
	V96xAjO+ISpUPso39QZwIwsgW/ou76slyInqeYIbGYmcv3OLIzyOn2feLyDH7E2UB6zJMcKkS0C
	V/jQZbvxhtNEIE07A5HGibLqxbnfOIlx/MgiIlfZ8mlvE2lqrNec24vAmgQbBqxWEYPvWNMMCto
	uDTFkDhsXwPRucY95c3QFesVTX9GY4KpDL/7BpMMZVHrVwA1RspSa+YH6vFd+rMl/avucEJ4AB5
	1qOzQR7KrmVb4U7nC37jC6iCvzVy9hJDFABUrXpquM4SZ3ocegWTOm/005MeKlMfjZEdGEUzPkE
	5UvrA6luvtsrKqeQDY=
X-Received: by 2002:a17:906:7950:b0:c12:764e:326 with SMTP id a640c23a62f3a-c212a385512mr253006066b.27.1786712902870;
        Fri, 14 Aug 2026 06:08:22 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21234c69b0sm101771166b.18.2026.08.14.06.08.22
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:08:22 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so1495883a12.0
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 06:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpMi0aAtZcnaVaDLlOGt4wFW1bGOiBkSTVde9xjk7jSOvbCDOw2AYmaxkFYKs9DLTBW6AKs57GTwQ==@vger.kernel.org
X-Received: by 2002:a17:907:980a:b0:c20:eea4:267c with SMTP id
 a640c23a62f3a-c212a8b725amr256899366b.30.1786712901999; Fri, 14 Aug 2026
 06:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813165654.36098-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260813165654.36098-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 14:08:10 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
X-Gm-Features: AUfX_mzBSOfXwtJ5pD6mo8sbrCNXyHrVNtlB2GQLFDuAwYnXUpBucQGGaS7Lzek
Message-ID: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:57=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_parse_binary() reads the size field of the certificate table's
> data-directory entry, which sits at fixed index 4 of the PE optional
> header's data directory:
>
>         ctx->certs_size =3D ddir->certs.size;
>
> but nothing ensures index 4 is present. n_data_dirents (the untrusted
> NumberOfRvaAndSizes) is only upper-bounded against header_size and may be
> 0, and header_size need only satisfy cursor < header_size < datalen. A
> crafted PE with n_data_dirents =3D 0 and a tiny header_size therefore cau=
ses
> the ddir->certs.size read to land past the end of the image (CWE-125). Th=
e
> chkaddr() that bounds the certificate blob runs only after this read.
>
> verify_pefile_signature() is reached from kexec_file_load() (the
> lockdown/secure-boot enforced PE-image signature path), and the image is
> parsed before its signature is checked. The trigger needs CAP_SYS_BOOT an=
d
> the access is out-of-bounds read only (no write).
>
> Require the certificate table's data-directory entry (index 4) to be
> present; the existing upper-bound check then keeps ddir->certs within
> [cursor, header_size).
>
> Fixes: 26d1164be37f ("pefile: Parse a PE binary to find a key and a signa=
ture contained therein")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case t=
hat

Any reason not to commit this as well?

> builds a crafted PE (valid MZ/PE/PE32 magics, data_dirs =3D 0, header_siz=
e just
> past the optional header) and calls verify_pefile_signature() with a NULL
> keyring -- the parse runs before any signature check. On an unpatched ker=
nel:
>
>     BUG: KASAN: slab-out-of-bounds in verify_pefile_signature+0x1d6/0x950
>     Read of size 4 ... in pefile_parse_binary() (inlined)
>
> With this patch the crafted image is rejected (-ELIBBAD) before the read =
and
> the case passes with no KASAN report. The test is not included here; happ=
y to
> submit it separately.
>
>  crypto/asymmetric_keys/verify_pefile.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db..e7f8bdb 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -87,6 +87,10 @@ static int pefile_parse_binary(const void *pebuf, unsi=
gned int pelen,
>         if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*d=
de))
>                 return -ELIBBAD;
>
> +       /* The certificate table entry is at fixed index 4 of the data di=
rectory. */
> +       if (ctx->n_data_dirents <=3D 4)

My agent suggested replacing 4 with offsetof(struct data_directory,
certs) / sizeof(*dde) to make it more obvious, however not married to
it.

> +               return -ELIBBAD;
> +
>         ddir =3D pebuf + cursor;
>         cursor +=3D sizeof(*dde) * ctx->n_data_dirents;
>
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> --
> 2.53.0
>
>

Ignat
