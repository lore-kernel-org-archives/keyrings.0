Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794038586;
	b=deG5IYCjSqjAeB3RKCTsZw9Nd1tmjMdcc7F6T+bu1gCh1ASBQpqtMiavSyYAKGJNdriE
	 UIgeqwV+c0hNjn/kj9JlL21Ds4dS2G/fZsuKNpNdZIOh3OAc1B44MnnnCj3MUbIq4n93O
	 OeCk+STI9CvIkUf8ahpES1DKb4TckLmfWpzFMGZufiIw1BmOfE6YLO9p4Uzkz5ZUlmhti
	 VPUS0QWqIM8zkM4TwjmEoNjKasYuVmzqtdlcefK+15uDhS7iI3RYoVx3p543Hu5JeTisG
	 eH3t9vlRF3BDaAMHo6Dfj/TtdeBB3L63n5nl3EArD7litDV8pg0rC0/bLCUl3WH/P7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UBKjIJV0Jyc+FtrJEW7tHvzq9gV7uRShW+9B+nXoav0=;
	b=3rYm0MxvpJqUTPm2R28NNgmBUEpqX8DXrtJCWRf/x7hZWVTZ1LIAqgO2/q6TPmUGUugA
	 OYsVDH5kbWpuwubrPS2jpzesdYj2eH+ckIgEwJ649ytRNhQ/mv42x0VZv21TycFQPq2+/
	 5fR8WrXajC5IDNOfB6JEK/1Z0+WK2B3rRzCUCOSaan62UdSpJco51u5KsFCnxDirzvqGD
	 33wU/Ea1TZ3D2ZBO9X6JicZMP4D9GQd64zxTmlP4FU86VMNtyynSIPySCstdD3jKJC2jF
	 0jwtebUZoDoKkft+gzyLxXqX7OljJOuGuFQu/pi33/EoBbITdPY1ZkQr6GX4hvwqSgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wZGBE3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F606A32C
	for <keyrings@vger.kernel.org>; Sat,  7 Nov 2026 08:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA6F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wZGBE3p
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ac91f5aa89so10082271fa.1
        for <keyrings@vger.kernel.org>; Sat, 07 Nov 2026 00:03:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794038583; cv=none;
        d=google.com; s=arc-20260327;
        b=b3IVH5wF+G654X8QRf80SNrnmRxtSkzxwxiDr73vkGtLYrNbsl29UqyOlXOmyIeMRf
         9eqAVrJFRf/63JNp3RgnRQSddE6TEuYraH344fgwcYyRH8e/k729GwcC1CvEh1lXIBJv
         bMv/WUA+AOLxcbR9E4rzfpqt1z+K7tNHgC4/9buj6Jbx91U0jUGhy+yn7qLIJb1HqMfJ
         iDdDQRnrH/+bqwqRad1vKRo6BM90cWS3XhTS12NTzh0BiKteK38lDE8J/YgxWtwU8of4
         BgLVEZHh2I+uzhMtM4+BNaQk3CrB9KENwaxPS6MSwew8KB6tLh/dYpky6Y47B/8tbhxB
         7iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBKjIJV0Jyc+FtrJEW7tHvzq9gV7uRShW+9B+nXoav0=;
        fh=V/+r/vzkyKiQvN3G08DaoaGw2vqkU64R42GwcJ6Y2TU=;
        b=G/wuRVnaAERpiFgrpgvB/UbKSAcELWDd0P8uMi9XOOVQH3pybXbyjUOngzKAVZKV2Z
         9+G7I9418eyLQifYY8MLJQS5guz0aZuknA7ei2/8TaQWXYNiJcUlkHKZOgB3Dpb9J+ch
         ELrQlO2NbbJ+rxw6t8aJvaN9wF2exjWdgRNgwOCr9XLJCiRXUU7FbGpLQ/LxGaFZ84c+
         s16KEm32euoqZIjD92224hIuvpQuiG5GAdEFz/r8B0DFtPrJbDl1KEo7hH67xlKAObPq
         1N0eV7RQIUexE3hkSWSvSWGsrNZ3agcM0FIt7mrgbX4/pCbrYpsRqrbP5eI05T37939k
         GmoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794038583; x=1794643383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBKjIJV0Jyc+FtrJEW7tHvzq9gV7uRShW+9B+nXoav0=;
        b=0wZGBE3pi7rRQQLtiubDQsoUKYdeo6JB/h6gxTy2ypWXDwuov5jhpsm9/39Po1RNh7
         cmAU9zxqvRGIHi/P1V1t8v2adQTdSm5KtKmnrFs9mgGdZ6uEnfRUEC+9YD585t6IlyOC
         JM579bY6MFiiK4vrYx8r+etYaV64jQb75hfZGfLppJop0YU/cGIQPtS3IwKyuphfgBWJ
         6q9gifSthlnKhSUz2UVe3PPEM/nKFWeq/WJ4gYmOOaTXNktNREBnU+HrhQijBAR4Wwex
         u9WfGJ3oTkfpNhuAhpvCoV1CQf8c5fJmmRn2LXN93vrfhnNoAuNuXzaCcmsDLEVZdYVL
         7l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794038583; x=1794643383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBKjIJV0Jyc+FtrJEW7tHvzq9gV7uRShW+9B+nXoav0=;
        b=L/hNhx3DORxV2c1EGn6k2zAWWgB4z7hx6WJbtgZBmrP3F/VCpVtgMw2XVcjeqZ0aQz
         fr5LpWxwws+KqCU1IDhXhJDmtTWCiBo9R/1hhNT0qtm9RtQ1bGuQP2RnVzxW/ZQuh0lV
         SRimvb9NcxsTE1ef52j/ojLQ+yKWbuVc0/xCGS9wf/RSV7Y8xDuQOO5oVdz7MvVUF6dl
         xLv50JXeuBneYkj6VmXqt2PUdFTazIU9yJzrflwyeucbSkBeyjWAF9YmaoRGHFuS3GLD
         6iuzVB+9LOuuuYI3ixj8LEXCKI++i/Ac987PSQzfO3OBDHqTv0rl3t3ichTyvsV+3RcC
         WO4w==
X-Forwarded-Encrypted: i=1; AL+hErHU9rQe+8Ck/8rvmNKepXyomGy270eSk9QPzmmPuEgIwnZHx5JGae/BeeYNWIhkboDyeSmRcoA8mA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pEDyMs+M9iHiXh/TB8nxOAWBKDqZHbJhwV8WmQyJ95Rw1opAg
	rtxG3cqrI1VZwmWTlD+E/eCuGJ6rCx4P/yX8xTWDLsAPPCWN/g37vAGJQApzU1XYECHAKS+cCGC
	B9Qc8Bbku+juwS4lf2RJCy7y1w2hrSf0=
X-Gm-Gg: AYBFou3FCMTrcfvPLvOGLnpE+6+TeLFAUx/QT8wIb1rUBxTAJE8zYHYJvmqhQf/A6fF
	FrcyaXe2AgToatZgtlHPA7sCmL8VKVQOmMHvTa2oEJ7goq4GDyQzsEJTY7aNokp7yELLmXHlQ2D
	8JSrAyFyIl3UK1f9cKOXiUYxPLcwlcuiNeq77Jwrh81beCGJkcCszxBL7I6HOldCCpZ3ciuUbo7
	dsKi8E4BxUxdH8xTrGhg20HmuDAwFLE+f8bcpRBW9T/chGn2985TJtmJviZ1BeUr05QDZTDAl/6
	UDQJCxQsWquaZtz4elpdFPRPvQepGMSFlSlOtCzs6ov+XsP7B2Ay/kM/qT1mNs8qFOZIncAPAJp
	MCFdAu1rA+a1KSuzqJDK+yiR2ZOotWubKLAWL/R4=
X-Received: by 2002:a2e:bd07:0:b0:3a5:af50:bc99 with SMTP id
 38308e7fff4ca-3acf3b20711mr8857361fa.13.1794038583192; Sat, 07 Nov 2026
 00:03:03 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106200423.37769-1-ampr.mhd@gmail.com>
In-Reply-To: <20261106200423.37769-1-ampr.mhd@gmail.com>
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Date: Sat, 7 Nov 2026 11:32:51 +0330
X-Gm-Features: AclHuK8se3YTl-AisXd9olJNlKqNSemA9zYOj4Th4vrPgv6cDYoaaBCODDUwIsY
Message-ID: <CAB_t1-BWNRNOQaCh=qz3s1q2bQhS=njpt-v1u0JrT-Lyw21MRA@mail.gmail.com>
Subject: Re: [PATCH v2] pkcs7: Return -EOPNOTSUPP for data-taking algorithms
 in pkcs7_get_digest()
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>, 
	"David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note: ignat@cloudflare.com bounced; the correct address per
MAINTAINERS is ignat@linux.win. The patch is otherwise unchanged
and available at:

https://lore.kernel.org/all/20261106200423.37769-1-ampr.mhd@gmail.com/

Thanks,
Mahdi

On Fri, Nov 6, 2026 at 11:34=E2=80=AFPM Muhammad Mahdi Amirpour
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
> Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digest=
ion it wants itself")
> Cc: stable@vger.kernel.org # v7.0+
> Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
> ---
> v2:
>  - Add algorithm name to the pr_notice_once() message (Ignat)
>  - Add Fixes: and Cc: stable tags (Ignat)
>
>  crypto/asymmetric_keys/pkcs7_verify.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_ke=
ys/pkcs7_verify.c
> index 474e2c1ae21b..c2e0eda502e2 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -147,14 +147,15 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, c=
onst u8 **buf, u32 *len,
>         if (sinfo =3D=3D NULL || sinfo->next !=3D NULL)
>                 return -EBADMSG;
>
> +       if (sinfo->sig->algo_takes_data) {
> +               pr_notice_once("%s: No digest for data-taking algorithm (=
%s)\n",
> +                              __func__, sinfo->sig->pkey_algo);
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
