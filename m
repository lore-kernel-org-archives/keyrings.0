Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652609;
	b=wALIQJUMQNW+HZHUDeuxl+ankFgNz1CpCGts41koXRerNZOgyGVuA4Q5JI8YDNB29Qn9
	 Y/c1m8aFq82I4/FVC4MUGrXVHj9KCxvt5ZFS17G+EfAymNjFZSCsJ0ecFwUqfTYRFGIWb
	 AoFe7cYKhs9uph0Vo7gqqRRp5/DwpKHXQyTiFt2xYnAa4oLJ5zuvi/LbrJCDvJzQxY063
	 VDQIhHGHutfG6qxkCIitkhitN8xdd5nFrO8nMFl6jTPfD4MikQWbIPkjmk3EfcHlX3fNR
	 IfaRbuPAR6+lO0R85ch2S+Fzj7XA7MaPvziz23ALiKIxVhR69UwH6mE0ky8GHGTV8IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652609;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=;
	b=BvHFEVMmfdMZRRzHRKu+x+eCzmxFHMXHU/pFVPKWYllWfN+dlCXAAloPZ+pFik8BCkSa
	 MRPULuxFLKx1dqGFbvD2A+ebRcs4Guy84LgUGYAAuhmVfTfxyBhhDmTk8zqFaGrwA5/1T
	 OGHNLbpxeKjsLUg+Pe8tHcEGCzJcs8jy3mBzsPi0jOn2fExgp2cuq0lBVlA8kWLQVaBfY
	 yy0v4IaPBd3nUGiOZRE4YNciSvh8b1nc6giN+xbzGGxC9xDGZc/utScPCKvI/4VuaRkHr
	 zhRsB2HzDMpGdoIyql8tXkUHPaP9ISL2jvdFbyy3N5cWYkkS7Uhrx+tGkrPTaIFOlJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B557606A329
	for <keyrings@vger.kernel.org>; Mon,  2 Nov 2026 20:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B557606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so2554913a12.0
        for <keyrings@vger.kernel.org>; Mon, 02 Nov 2026 12:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652608; x=1794257408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=;
        b=SHsoKmxIEUZ/ploS00YKkdboCzeZFNr0lHxoYCnOYCJY+WVU3BKRNJKhubYRFXo2rb
         0KaIS/EJ9Bh6zaO91pS9jniOMRnKKGdKiE3xN3mcKLc6NDrDUEdn7Y6WJe8ryPfUJ+ZW
         tmwNirWTThQb9/uaPLuhX9cST6ZGFSvoDA1yWXFDS/OPcLO5MKuBnfVKkH2QiLroh1y6
         11vohb8tdQ9WLpT4suqqY0gG0WLSsk+T4hwISIPhpkUPDmtkoNytom5d+O2ge9Gb09JX
         W4gUcwzQvnpFErM8ZY6YFoj5GkS0NKCMvV4Nkde3uRH0pMHmkUAS29H/flR1HTfADH6e
         tvZg==
X-Forwarded-Encrypted: i=1; AKwUvBwiCeqPnVNLWGK4wUhuKBwLdSfmOn2wHE5FWDAQV5Q2qJoHcjBPN+id3RnbNjMFOEuA3iKs4ctY5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8eM780BHsRyP9zIMd3aFZLbFoeJVhlbQ4rHMqtjxfgrUIms9mC
	ZL+qu/rzXn98yDEebQ6OfpjvzyFczUPVe5mY3fSZ9xsoCyOBCiYpwUh9yoYCLP33Z9I=
X-Gm-Gg: AYBFou0V1rUqBb8RkrsZTFcbJlOlc1bDdWKMJVPkVcE0po42sZyCVrSQNN+9PUlxib8
	Jbc5T4/kZ2yaL9xoGi5lWBv6FD0rCaNKXrPPoP9VAwBKXpL94GhzUTwHrgnj7shwXKscf07rPFJ
	7Ok4eYHTmKycgxWJoMmpfBPF+lWfbeXtsrYVHt4VuSjLA6ssStDTBcqStIzzAHhf3qiCX5gZPcG
	TrH8sjRLrPZ6aLGG83yf+vJ7C4qf51ShEHKt6t3TjWbnkKqkqLuVBKatxMfv2DFH10Sgc6lWrSY
	wdWsbQifJXSYyjohQw8enXNXnvSVK52RiI2zWYIZ3wioHDA8P4/+4rELLr4H4gaB7EITVS8IIW5
	xBAJzdz524pcTRpNR6sKve+G7n7Za3H/9akxG5WitLfvzrfeMT11wVTsDPF6SZr1zSqVg4UhUnT
	tT4nZOL0Bvc3s2o686sDOqUJBJoD0N58mtlyFJpVpTQuwK3BoSpDZ7G6Fhx1OSiTzsr/BKuLLmE
	+Wo2StpH+5oZBR8XwbpRki75IOm6MeVRCFoJ8hUW2rx+hbQU4nrmcKKHZIOuJ+Kpczk8+4V5w1g
	W3sOAHkH28wtPR8qdnSX01+zCu+Hc/7G+rJ9t4ssx8PpzQmvz4rCKLgUmhE=
X-Received: by 2002:a05:6402:c50d:20b0:6b1:b5b8:b691 with SMTP id 4fb4d7f45d1cf-6b4d4c7353emr5551221a12.21.1793652607921;
        Mon, 02 Nov 2026 12:50:07 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee537sm3554951a12.10.2026.11.02.12.50.07
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 12:50:07 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c45551fa84eso506361966b.3
        for <keyrings@vger.kernel.org>; Mon, 02 Nov 2026 12:50:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw+J50GMiruHnDpZYwU7kNxG736tbYeVSaNDHGWCWDL9XzEPQzndeWaWdq0FXh3h3mL1XVbVUWQRg==@vger.kernel.org
X-Received: by 2002:a17:907:930d:b0:c46:9ee5:eeee with SMTP id
 a640c23a62f3a-c4ca79357a1mr947048866b.6.1793652606765; Mon, 02 Nov 2026
 12:50:06 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102074934.2925339-1-gubowen5@huawei.com>
In-Reply-To: <20261102074934.2925339-1-gubowen5@huawei.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 2 Nov 2026 20:49:55 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
X-Gm-Features: AclHuK9uKtGwMBZoHntdWHPm90lnYY-0KuyQanxDFP3TVplvFnPCOByhCba7eNE
Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: asymmetric_keys: verify_pefile: fix integer
 underflow in pefile_strip_sig_wrapper
To: Gu Bowen <gubowen5@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:32=E2=80=AFAM Gu Bowen <gubowen5@huawei.com> wrote=
:

nit: the subject line looks malformed: weird "-next" suffix pointing
nowhere. Otherwise:

> The pefile_strip_sig_wrapper() function validates the win_certificate
> wrapper that precedes the PKCS#7 signature in a PE binary.  It checks
> that the wrapper length does not exceed the certificate table size
> (``wrapper.length > ctx->sig_len``) but fails to verify that the
> wrapper length is at least ``sizeof(struct win_certificate)`` (8 bytes).
>
> When a crafted PE image supplies a wrapper with ``length`` in the range
> [1, 7], the subsequent arithmetic::
>
>     ctx->sig_len =3D wrapper.length;      /* e.g. 1 */
>     ctx->sig_offset +=3D sizeof(wrapper);
>     ctx->sig_len -=3D sizeof(wrapper);    /* 1 - 8 =3D 0xFFFFFFF9 (unsign=
ed) */
>
> underflows the unsigned ``ctx->sig_len`` to a value near UINT_MAX.  The
> following ``sig_len < 4`` sanity check is bypassed because 0xFFFFFFF9 is
> greater than 4.
>
> The underflowed ``sig_len`` is then passed to verify_pkcs7_signature()
> and onwards to asn1_ber_decoder().  The ASN.1 decoder's own
> ``datalen > 65535`` entry guard can be satisfied by constructing a
> PKCS#7 length field of exactly 65535 (e.g. ``30 82 ff fb``), allowing
> the decoder to proceed and attempt to read OID octets beyond the
> allocated vmalloc buffer, triggering a page fault in look_up_OID()::
>
>   BUG: unable to handle page fault for address: ffffd1e986cb2000
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:look_up_OID+0x14/0x100
>   Call Trace:
>    pkcs7_note_OID+0x33/0xa0
>    asn1_ber_decoder+0x363/0xbd0
>    pkcs7_parse_message+0xd9/0x1b0
>    verify_pkcs7_signature+0x24/0x80
>    verify_pefile_signature+0x7b/0xf0
>    kexec_kernel_verify_pe_sig+0x1b/0x40
>    kimage_file_alloc_init+0x1d8/0x3f0
>    __se_sys_kexec_file_load+0xc6/0x270
>
> This is reachable through the kexec_file_load syscall on architectures
> that verify PE signatures (x86 bzImage with
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG, arm64 Image with
> CONFIG_KEXEC_IMAGE_VERIFY_SIG), requiring CAP_SYS_BOOT.
>
> The oops occurs while the caller holds kexec_lock; if the faulting task
> is killed, the lock is never released, leaving all subsequent kexec and
> kdump operations permanently returning -EBUSY until reboot.
>
> Add a lower-bound check on wrapper.length before the subtraction to
> prevent the underflow.
>
> Fixes: 09dacbbda935 ("pefile: Strip the wrapper off of the cert data bloc=
k")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  crypto/asymmetric_keys/verify_pefile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db14129..cfa85ccb1cf7 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -146,6 +146,11 @@ static int pefile_strip_sig_wrapper(const void *pebu=
f,
>                         ctx->sig_len, wrapper.length);
>                 return -ELIBBAD;
>         }
> +       if (wrapper.length < sizeof(wrapper)) {
> +               pr_warn("Signature wrapper too small (%x < %zx)\n",
> +                       wrapper.length, sizeof(wrapper));
> +               return -ELIBBAD;
> +       }
>         if (wrapper.revision !=3D WIN_CERT_REVISION_2_0) {
>                 pr_warn("Signature is not revision 2.0\n");
>                 return -ENOTSUPP;
> --
> 2.43.0
>
>
