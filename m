Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1C39D6E9
	for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746594; cv=none; b=WLEvvoSjxOU1Nof+gyMu7EWws4FrM8mVuuoIveziSiw38d1+Pq4sUoaZyFFlaS7EM2Yp3lLBIHLb0VmLVT6f3aMNINnr87I8L7oVeQfNXVvRoG0F04cy5dHr4/fYtKKSHXeF207u/GZL8bmacZkRJln449U8MPVr1ZEIB01oJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746594; c=relaxed/simple;
	bh=007RVhNG3bzisB8QTh6oufkYCx+dZM4te2B2RVnhDkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stFDXtMldCNm1qwBXW7Yf9CchMJ0AiYinYevJ1+njB5ORKNKYbFY5ulOyIHpD/JvaY1J4KXTHge8gtEMsOKk26zcZtDNROyoHoGgfY+I6v8DhFWxYtUE4DWiUaeiVkVcXlqfYB5/nliw1pOPOzeELxoeMslhl3M4G8dGWrM/fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso2535033a12.3
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 15:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746591; x=1787351391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waG0BdNRrEs0bEN8xb/gjEyGJq6U6CRZNm5O6yGz0BQ=;
        b=gJqn7fI+Ra+CN4E3GnfLBbEGLkbXXzvgS1yN4aoqmSh5kM2vwC2Wr7uwRuM3YLiyKy
         aFQBsf2s2uxkythxUETZEWbooqFHmbYdk8seizx0tlObvhepJfW8NYetpB05B8q4tS7d
         acduGkr0aWwPG7Kvp8JCFH28u5Fbt4ikY1A7ifMj+2/442+La1o1+ev+RSBkdJeJQSXl
         zxeCSTF71tS4kaiOaQUpCr3opKEBsKEf8X2RZdiRj5qbeGD+K3C3uacHubNMoPw2bFmj
         vrIFJrruWJiBIqQaOM1ohArYmvqhC/s9FWVnB5zM1/tmrFEgKEg+eJY1nyUmEB1DqWBS
         ukxg==
X-Forwarded-Encrypted: i=1; AHgh+RrMTdMqjfERbXJUNTVARxlCfUdg+iEgB0WgyOUwTCsusHrpvgmOxlD/SWAGmQaf4poZ6+ph3I4rBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgvX27sbKzYSYc2mbzqNs1EWJyFNCFnLz+kyMnqq6FnnAKyN9
	jI8QMnQm0roi6r9GX3o0idNW/wZMmsTT934rSa8LFMVe9BswL1AZtoCvhBd2tcJoy8k=
X-Gm-Gg: AR+sD10uxpOj5NDzR/34epTr/cDqOvOsQ5dZ9ULEh9+DmgVEzcXzc72lgU9Onouxro7
	7+JEVkeUHXXK6Yf1kMHtMBWDBR9hokLeyCvc4EgK8qjunOkw4bfqS98xqy0nBSPN5XEw3mZv0yw
	jEj5TOF8YEFqUbim8j1CvdVH6dW1czw2VWXkIjhlGT2Po1nAM/bP1zd+pd2O+AUszqyblSWUPsc
	2GULs2VPHvz9+SaUhiFElS7TQ2bcuSwrpIxHHQj7ZbZ3ib0/E30gZZBpNk8e3Tabx/3dddub63e
	UDfPE0kl7SzwejnqnHy8v6X7AWAVMC8wFw8D3QiUnjPssgseJf8qs/ka8ML1EV6z4q0wiLXGxWt
	R3RkjGYu8o1ONWgYZn0lTl8rwLmDEAXqAisvlG5rZpLTbpU3ENBUK2Qwoo8D1cI9hkKyKICieDv
	V+KCsWMsnnV50cVOms2hVCGCmWEj28CZqO3WXtIGYkiomZcCMLUb9MWzrAy00Ht3b93Qu8fppyL
	UaSuBiTvI5cwiXSWd8HxZ40rx4T1EQ=
X-Received: by 2002:a05:6402:504a:b0:698:ad4b:abf4 with SMTP id 4fb4d7f45d1cf-6a38a8d7c48mr4066724a12.3.1786746590374;
        Fri, 14 Aug 2026 15:29:50 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d78c5e0sm1038329a12.28.2026.08.14.15.29.46
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 15:29:46 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197e7e4e94so275408166b.2
        for <keyrings@vger.kernel.org>; Fri, 14 Aug 2026 15:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrYiVTxQle/zj+ONxF9I7JKPA0CfIa2xh47Y9ocM/W/eLe8oVms2fyoaY7ccDTYcCopSdjY0DyLUg==@vger.kernel.org
X-Received: by 2002:a17:907:d1b:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c212a15b29bmr481986966b.12.1786746585644; Fri, 14 Aug 2026
 15:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
 <20260814220631.1101496-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260814220631.1101496-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 23:29:33 +0100
X-Gmail-Original-Message-ID: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
X-Gm-Features: AcwNN1Xw9h6GNj0ibMyw5rWypoAatSz6xjvorf8gf94rjiZOoVeFiOOzG0DX_sA
Message-ID: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 11:06=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_digest_pe_contents() hashes each PE section with
>
>         crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
>                             ctx->secs[i].raw_data_size);
>
> where both data_addr and raw_data_size come straight from the untrusted P=
E
> section table. pefile_parse_binary() bounds the section table's location
> but not the sections' data ranges, and nothing else on the path checks
> them. A section with data_addr and/or raw_data_size pointing outside the
> image therefore reads past the pelen-byte buffer (CWE-125); a large
> raw_data_size makes it read far past the end and fault.
>
> Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
> pefile_digest_pe_contents") recently fixed a sibling underflow in this sa=
me
> function (the hashed_bytes + certs_size trailer computation); the
> per-section read was left unchecked.
>
> The digest loop runs only after verify_pkcs7_signature() succeeds, so it
> requires a validly signed image -- but not an attacker signing key. The
> PKCS#7 signature covers the SpcIndirectDataContent (a self-contained dige=
st
> in the certificate table), not the live section bytes, so tampering
> data_addr in a publicly available signed image leaves the signature valid
> at that step while the out-of-bounds read fires when the digest is
> recomputed. It is thus reachable by a local CAP_SYS_BOOT user via
> kexec_file_load() with a tampered signed image; the access is an
> out-of-bounds read only, but a large raw_data_size faults, which is a
> denial of service when panic_on_oops is set.
>
> Validate each section's data range against the image when the section
> table is parsed, reusing the existing chkaddr() bounds macro. A malformed
> range is rejected with -ELIBBAD at parse time -- before signature
> verification and before any hashing -- so a bad image is never digested.
>
> Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKC=
S#7 data")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> v2:
>   - move the check into pefile_parse_binary() and reuse chkaddr(), per
>     Ignat Korchagin's review [1], so a malformed image is rejected at par=
se
>     time -- before signature verification and before hashing. v1 put the
>     check in the pefile_digest_pe_contents() section loop.
>   - because chkaddr() runs on every section, v2 also validates zero-size
>     (raw_data_size =3D=3D 0) sections, which v1 and the shipping digest l=
oop
>     skip. This only rejects a zero-size section whose data_addr points pa=
st
>     the image -- malformed input that real PEs never produce (.bss uses
>     PointerToRawData =3D 0, which passes) -- and matches the "don't start=
 on
>     malformed data" intent.
>
> [1] https://lore.kernel.org/all/CAOs+rJXZ++7_o4L6LuT567FjdYsa=3D6NEki3qcF=
SRX+ehJxpoVg@mail.gmail.com/
>
> Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
> calls verify_pefile_signature() on real images: a signed-then-tampered

Same as your other patch - any reason not to include this KUnit case?

> image (a section's data_addr set to pelen) is now rejected with -ELIBBAD =
in
> pefile_parse_binary(), before verify_pkcs7_signature() and with no KASAN
> splat, while an untampered signed image passes parse and reaches the
> signature check (-ENOKEY, as the test key is not trusted in this build).
> v1's KASAN repro -- a crafted context taken straight into the digest loop=
 --
> showed the slab-out-of-bounds this prevents.
>
>  crypto/asymmetric_keys/verify_pefile.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db14..c447597f7 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -30,6 +30,7 @@ static int pefile_parse_binary(const void *pebuf, unsig=
ned int pelen,
>         const struct data_dirent *dde;
>         const struct section_header *sec;
>         size_t cursor, datalen =3D pelen;
> +       unsigned int loop;
>
>         kenter("");
>
> @@ -112,6 +113,14 @@ static int pefile_parse_binary(const void *pebuf, un=
signed int pelen,
>                 return -ELIBBAD;
>         ctx->secs =3D pebuf + cursor;
>
> +       /* pefile_digest_pe_contents() hashes each section's raw data usi=
ng
> +        * these fields directly; reject a section whose data range falls
> +        * outside the image so hashing never reads past the buffer.
> +        */
> +       for (loop =3D 0; loop < ctx->n_sections; loop++)

Looking at the code again: seems ctx->n_sections is user-controlled.
What happens if it is 0?

> +               chkaddr(0, ctx->secs[loop].data_addr,
> +                       ctx->secs[loop].raw_data_size);
> +
>         return 0;
>  }
>
>
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> --
> 2.53.0
>
>

Ignat
