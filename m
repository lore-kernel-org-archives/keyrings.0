Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FB25A642
	for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715645; cv=none; b=b9YcHyq1eIYyIPJt9FoQ8qT1+u11WvSaqznrqc9RblXVthdi0Xnjuq2tu7q3APM/bFx+6KsHGMAhxbliXQDvw8tRhuGK7guouhatbws/8ZbrIkqbUIvjJ/wgCUiH/1QJXfFCotJPEy4ltJ81m5iHxM4/JzsERtHjqKHasvYDAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715645; c=relaxed/simple;
	bh=HW4yLSvoZYZvQWXm5wsfQ6gd3IabSYpAM3gCA+OgMSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9sfmUpjcu+bH76G42j1qqKoJq8KXFkJKXbT+qpmAl0TiMIWUolWB948zigWxPh84Vl0J/ElO4CWfYag63mytXXBdzKptkpMkYsB5t1lWttWuP6vzqsf4GSQ25bErWk9bFsufEgGR+9z0fWZkcMTEjKOe5Ry/8DkVJ+xmYd+VzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so1751519a12.1
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 06:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786715641; x=1787320441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32UXxjqR1VKYvNK68Dz7f7JjofaG/JzH3ImA8OxnCM0=;
        b=ZqGQjAniU4WnXgPsOHsXMuyLGIo36DdGSOgE7ltuecpvv7m1vaDVLz+R/JhqwC7Mqr
         +Zo16lPNEXKOGwSUevgU7Ut6N/lYkPdHCcSKu6ppvrGGhJ5TkLIHgW0x0JwvRmXrzDrX
         M/9HF5OqN4h0QIXQ9uyQFMQQ54oNk8aerBwnCLraIYGT8CNFa4uuWKbgjJ6KyDlUGTQG
         RNO1nkAM4mCJ88wT/5r2duqm2BlosnMVBl8e68DNa/D9zo69KCG7pQGbf1PRygCmylq+
         21hkLYy8vaL/RUKapH1gj9phPFqcvE87oYGNSg+pC8zufR8vI/pVTbRVHGZTVgvTSnq2
         OsvA==
X-Forwarded-Encrypted: i=1; AHgh+RrspAXEDXL2BZ+k52rKGU/jDlOQOhZHswFxxuJBSJvXYQ8akUyCciqKs5yuUh7nLQOHHvcE3iClZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7XZQR7Ccz2XFJPnjltGNAK0YE2/g0ai6vlH5LaBnbi8HRoFU
	4SrfY+ZtfESZC9muSNtBN/MTxZi6YQTcKQQEpWYL8mQ2r12FwoXOck+wD0+bocdDl8o=
X-Gm-Gg: AR+sD12OShnogEhNcEUUfcrCnTCs+42ots2QZpf7EaxeaDUlV0u9W5V+VEac1guoP+D
	2Xz+W0WgkCPpnDxNfhvIPZB0gYXWnL3jGESrayIBD9c466iqZYQVNCT+fDxDAJ7YS2kihHechLO
	ay8StMx1jlqgr1hPUTeMFPCPDv+1qqWChA5Yr76Htw2la2UXUsYe0fTc0x5sBJR3ROZ3aSDbyS2
	LCMkMlzfLmnjEwlVtD7Bb9x/TiFHKuNSzLmPQkQBkyqOI3Oo1DKzbRl3Y3i2thGxg4TYhIJXSNI
	SJyPbpgqUJ5ckwLhMBteQmUlypq/jE03BRvhud4GlO+AWJGwPKCnOueNMP5boAHIERydJ4aOXum
	iR81fGxlpJ3wI+U1qu1dwEqfsqkEizQwl/evZM4UdHRXztj+7QT59oWTAK85rbb3liUW2LAFWaP
	Wh360gxGn6jG69cCR1kKxkPOwcEYRJY/roUNZx/TCv8VjnE5ESMH1xiDsn+2SU2KvVntX0YeASy
	Ea9ZuM67mSN4ZODtOXb9CUm
X-Received: by 2002:a05:6402:505a:b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a38a948f1bmr2661062a12.12.1786715640306;
        Fri, 14 Aug 2026 06:54:00 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d77d37csm783486a12.23.2026.08.14.06.53.59
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:53:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c16794450aeso140047166b.2
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 06:53:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozKyMwg8R2BIKt2yNzvrShEpc2CZWPuOBEjwvm/FJJpxM4PRk8w0sAHx99tUsREUDMJplFmfJslg==@vger.kernel.org
X-Received: by 2002:a17:906:730f:b0:c12:aaec:342a with SMTP id
 a640c23a62f3a-c212a113efdmr280357366b.16.1786715639417; Fri, 14 Aug 2026
 06:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813182546.138705-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260813182546.138705-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 14:53:48 +0100
X-Gmail-Original-Message-ID: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
X-Gm-Features: AUfX_mwuLx2aJR43wVpuS27IhjyS7MfpE6qQTDN1bU1nAQBlqaS068ZzBhfmWrg
Message-ID: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
Subject: Re: [PATCH] crypto: asymmetric_keys - bound section data range in pefile_digest_pe_contents
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:26=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_digest_pe_contents() hashes each PE section with
>
>         crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
>                             ctx->secs[i].raw_data_size);
>
> where both data_addr and raw_data_size come straight from the untrusted P=
E
> section table. pefile_parse_binary() bounds only the section table's
> location, never the sections' data ranges, and nothing else on the path
> checks them. A section with data_addr and/or raw_data_size pointing outsi=
de
> the image therefore reads past the pelen-byte buffer (CWE-125); a large
> raw_data_size makes it read far past the end and fault.
>
> Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
> pefile_digest_pe_contents") recently fixed a sibling underflow in this sa=
me
> function (the hashed_bytes + certs_size trailer computation); the
> per-section read below was left unchecked.
>
> This loop runs only after verify_pkcs7_signature() succeeds, so it requir=
es
> a validly signed image -- but not an attacker signing key. The PKCS#7
> signature covers the SpcIndirectDataContent (a self-contained digest in t=
he
> certificate table), not the live section bytes, so tampering data_addr in=
 a
> publicly available signed image leaves the signature valid at that step
> while the out-of-bounds read fires when this function recomputes the
> digest. It is thus reachable by a local CAP_SYS_BOOT user via
> kexec_file_load() with a tampered signed image; the access is an
> out-of-bounds read only, but a large raw_data_size faults, which is a
> denial of service when panic_on_oops is set.
>
> Reject a section whose data range does not lie within the image before
> hashing it.
>
> Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKC=
S#7 data")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Note: f7dd32c5179d, which fixed the sibling underflow in this function, w=
as
> assigned CVE-2026-64544; this closes the per-section read it did not cove=
r.
>
> Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64). Two things were sh=
own:
>
>   1. The defect + fix: a KUnit case calls pefile_digest_pe_contents() wit=
h a
>      crafted context whose section has data_addr =3D pelen. Unpatched:
>      slab-out-of-bounds read; patched: -ELIBBAD before the hash.
>
>   2. The reachability, end-to-end against a real trusted keyring: a real =
EFI
>      binary was signed with a test key embedded via CONFIG_SYSTEM_TRUSTED=
_KEYS,
>      then its section data_addr was tampered (leaving the PKCS#7 byte-ide=
ntical).
>      Results from verify_pefile_signature(): the untampered image verifie=
s (0),
>      one signed by an untrusted key is rejected at verify_pkcs7_signature=
()
>      (-ENOKEY), and the tampered-but-trusted image passes that step and t=
akes
>      the OOB read in pefile_digest_pe_contents(). So no signing key is re=
quired.
>
> The KUnit case (item 1) is easy to package and I can submit it separately=
; the
> end-to-end setup (item 2) needs an embedded trusted key and signed images=
, so
> it is harder to ship standalone. Neither is included here.
>
>  crypto/asymmetric_keys/verify_pefile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db..4e84fcf 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -292,6 +292,11 @@ static int pefile_digest_pe_contents(const void *peb=
uf, unsigned int pelen,
>                 i =3D canon[loop];
>                 if (ctx->secs[i].raw_data_size =3D=3D 0)
>                         continue;
> +               if (ctx->secs[i].data_addr > pelen ||
> +                   ctx->secs[i].raw_data_size > pelen - ctx->secs[i].dat=
a_addr) {

Can we do this validation earlier? Perhaps in pefile_parse_binary()?
The idea is that if the data is malformed we should probably not start
hashing at all. You could also reuse chaddr() macro for the check.

> +                       kfree(canon);
> +                       return -ELIBBAD;
> +               }
>                 ret =3D crypto_shash_update(desc,
>                                           pebuf + ctx->secs[i].data_addr,
>                                           ctx->secs[i].raw_data_size);
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> --
> 2.53.0
>
>

Ignat
