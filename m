Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988772;
	b=LfbcSGmXwYqLNXSzjlCOqZpPdJsU7PuiRtwAGMtpR+Z3obMgfInYhKU+vE0rxtzWqE1F
	 0xuYwAbkQeImPMfPHDCyYYf30W1wamiD1KNUYOANWsZ+osRsvQTSh0wVAlbY3R6LBCYpb
	 e6kps6LghPJ3fkmvdaObcKmo+qnot9mka3jfSCGwlmsoUg/i3Su3vQdpxCPwTOYvJM2WZ
	 THdm4YU+Lwa/oX/aXAQC2cqZfIEMRKr8uvoB8zAk8aQRjrE8LDR926psWQmV+AOm0W7Q9
	 1CoRpPGxzV0lrjudAnvjAGkGJIeM3tNZG2UWX4taEcqjdnHNFFS4037e/BSmo8/b1bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988772;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xABCAQ/j3mpYe9Wdms85794hL2vRznEt57kS2ozzMLM=;
	b=jS9H1KrJVm3Yh6mojXrohqzmexeAQBAFpGKAlZm2zs5IM2Ek8zwq0+Fiz87SmqcHe4TX
	 KInSoX0OEu/RgjWg2YCzHcQzriKgQJ297Xh2uvcgINdviWxo7zHHb7k7oP99zX/VoGq/d
	 e37beIxQvulis2N841Hgkc8uW2mvkARYeg++Ysdm4ed358QAsN0WafVDvlgaQ6fJAjXBp
	 StCAvX5Oa5fmdXBwp2jvfl2c1GHKxfLmpk9r+4tSBKwHePDztBh1hwPx/jSJEyktgHtTC
	 4ZXz8GAk6liAY6fMDjwK9myLLzoXbygVIlhEOmlN9N9IR7//yUXlHu343c5iqr9GP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07743606D802
	for <keyrings@vger.kernel.org>; Fri,  6 Nov 2026 18:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07743606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d1b35dc42so178647566b.0
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988770; x=1794593570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xABCAQ/j3mpYe9Wdms85794hL2vRznEt57kS2ozzMLM=;
        b=QSuLzWG0NzOB1sb4ySeMA34o7SRnK4GscZYroNOf+zbf0JjiQnwHiuW/r3i6Ki5aVX
         vDj4Zp884qoAgNy2M+LzQ+B4PpgqOktNfieW/Ku+HuAyXLYE6BnW1NhBU4nSxHfqEf9Z
         lMfUu2E9zdvsuJDmL+u0spNbz3v2PgF6tkYCzlvSohPEvMed8WCdmlhZUvfcK302nEwi
         0XwzFNvVFQcNGcgqe2oqZSTVvhUrsrCM127Jkow9PjwAhOrjoOwsq2CNXbf6wo/XrGxt
         4+8/3q+8hM4IcNzFJRcs+kiCJojQKTF8FDY5Z1elautpqcyTLYiRgyeD7RPScvRyNlSt
         hlsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGpAj8zGO6RIj39EEoMS7QWRCnan26v36wPcnNA7I5cq58LGpzOVKbjzCSu5Dn7l4BpggW3ZWGTQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qnmTNLMirTLJK9DHJY9kBAsNcXhpY/6OVazcHXrfRTykc36o1
	6dG9WW9PDiw473xtxhvLyPe9H4RuxqpxPb6IDiRB7jScQdL/NFVfH83glinIas44MZg=
X-Gm-Gg: AYBFou3y4lGidU2cflAqAcdv1nUvWjd/nos+cS0bc+j5TQg0md/AzgKs1A7x+0OmBEi
	2B0si7G2uyCC2QqQmLfima9U3XJX1kJq5CyZj0m6V2DvJwYY7AwdLjxNwXfyhWAwJeKnqsONMs1
	F1tuDN8t6TTx7MNVTamGO12/tPd17/6VaFb0uNBG6e2gRfIJaAzdqPBoq2JLDP97mFt2dQcS5om
	iBfDERxgwvcBzVDEXvvxzV3eQposBHxBFMhJpwGAZpzCWITXfjSeB7/rDKhuD5bNTDC6Xnxksve
	Q579uf0Etq7c/rRzyFGHY7+Evql8mh11ODQvOH86mk0bD9q1+Lenbp6XwGhkeqPdTCNu4eGxFYs
	2t27nwedvz1aiF6HWaYeNQJa8wEyQWheJI99TrgMUR24FYdVWi324mRXuHDrLusiOC3PudDNbcT
	m6xmRrmuJDnsE1p7LcqAuJ/2PVrfhmdc6z7Q+idkgPQ56EqXF26a/ZqVgYvg7WRhp9gZ3QCux2L
	OiYxsHKY0bwPBjBISA8yBKFJbt0QrfzuUby32Aruh4Y7oNrtFxl6mWycYKg7aQ1MPmPFtwl+PaM
	ewseS01qXHA6pcO4r4o8kIx9VdlBoC0FIF0VIyzmmI0wQJPI3mOnuy1goP0=
X-Received: by 2002:a17:906:dc95:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c4d2014fcc7mr550987566b.1.1793988770369;
        Fri, 06 Nov 2026 10:12:50 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356ea58esm98361766b.81.2026.11.06.10.12.44
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:12:46 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so349369666b.1
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:12:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxyNWsk16mtawn2R/dGHkWuxy+M7a4aPzOUECA3xtR/H+q33udUgb5zax+Z4fcuBb/146pvSxq78A==@vger.kernel.org
X-Received: by 2002:a17:907:7285:b0:c3e:2224:1b86 with SMTP id
 a640c23a62f3a-c4d3525a428mr313145766b.2.1793988764396; Fri, 06 Nov 2026
 10:12:44 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015110826.126621-1-ampr.mhd@gmail.com>
In-Reply-To: <20261015110826.126621-1-ampr.mhd@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:12:31 +0000
X-Gmail-Original-Message-ID: <CAOs+rJW8nMAAT3BHghtS+V=Pwz6bTg679ND41gsKWHtdsLsksw@mail.gmail.com>
X-Gm-Features: AclHuK-B8qlW9POQL_jz_S8L2JcDrY1HJuCgVxk7uflmFEZo1Scl9EmB4edwCMI
Message-ID: <CAOs+rJW8nMAAT3BHghtS+V=Pwz6bTg679ND41gsKWHtdsLsksw@mail.gmail.com>
Subject: Re: [PATCH] crypto: pkcs7: Return no-digest for data-taking algorithms
To: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:08=E2=80=AFPM Muhammad Mahdi Amirpour
<ampr.mhd@gmail.com> wrote:
>
> pkcs7_get_digest() is documented to return a digest for IMA to use
> when verifying a modsig.  For signature algorithms where the public
> key algorithm consumes the raw data rather than a precomputed hash
> (algo_takes_data, currently ML-DSA), pkcs7_digest() does not produce
> an intermediate digest.
>
> When such a signature has no authenticated attributes, sig->m points
> at the raw data and m_free is false, so the existing check rejects it.
> But when the signature does have authenticated attributes, sig->m is
> an allocated buffer containing a modified copy of the AuthAttrs and
> m_free is true.  The existing check therefore returns that buffer to
> the caller as if it were a digest.
>
> Test for algo_takes_data directly and report that no digest is
> available, before attempting to call pkcs7_digest().  This covers
> both ML-DSA cases consistently and removes the now-dead m_free check.
>
> The only in-tree caller, ima_collect_modsig(), does not check the
> return value of pkcs7_get_digest(); for a data-taking algorithm it
> will now leave the digest fields unset and fall through with no
> digest, which is the correct outcome for an algorithm that does not
> produce an intermediate digest.  Callers that do care can detect the
> new -EOPNOTSUPP return.
>
> Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>

Would be nice to include "Fixes: " and "Cc: stable.."

> ---
>  crypto/asymmetric_keys/pkcs7_verify.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_ke=
ys/pkcs7_verify.c
> index 474e2c1ae21..7939b08b603 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -147,14 +147,15 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, c=
onst u8 **buf, u32 *len,
>         if (sinfo =3D=3D NULL || sinfo->next !=3D NULL)
>                 return -EBADMSG;
>
> +       if (sinfo->sig->algo_takes_data) {
> +               pr_notice_once("%s: No digest for data-taking algorithm\n=
",

We should actually include what the algorithm is here probably for
easier debugging

> +                              __func__);
> +               return -EOPNOTSUPP;
> +       }
> +
>         ret =3D pkcs7_digest(pkcs7, sinfo);
>         if (ret)
>                 return ret;
> -       if (!sinfo->sig->m_free) {
> -               pr_notice_once("%s: No digest available\n", __func__);
> -               return -EINVAL; /* TODO: MLDSA doesn't necessarily calcul=
ate an
> -                                * intermediate digest. */
> -       }
>
>         *buf =3D sinfo->sig->m;
>         *len =3D sinfo->sig->m_size;
> --
> 2.55.0
>
>

Ignat
