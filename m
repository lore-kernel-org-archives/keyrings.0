Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F72342CB0
	for <keyrings@vger.kernel.org>; Fri,  1 May 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777613853; cv=none; b=U1uCxa81aF0TqXtRunSAO3j8HyvZOM3xUt8C9UvYcqvoPXIalFSVgVWIQh4YXv6YJA+jM4anuusd0mqa1G//x6qGWQPwQmTH7TgNSbuDfSAyq/th0boowq1sKHKRMa0npsyMLfGAaxZgVLU9iwMFGOCBvGteGX7C77L2bvk9kHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777613853; c=relaxed/simple;
	bh=WKPABIsseylb3RUsTw0xvE9Pmu+sljz/nKUYmu18KhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N76Gz74stBy4TsvI+5rB12Ei/kBy18l7k2mB27Hw7EpMGV0W4lpzJd/eIufOB/0lLK/UoEeAVGa0VTwlzAe89+31n+nKEDwDDfKR9yKXjvPWCCvOc1D0y/L3BP65WiH7CjL5jhO838t1oAYxlJag5DiTxX8HyN6innakahOzlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b93698bb57aso333586466b.0
        for <keyrings@vger.kernel.org>; Thu, 30 Apr 2026 22:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777613850; x=1778218650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXMXzeJoapUPYGltuEcVDIPcO3Wjov50Tx6Z9qKY0P4=;
        b=QUHZNTkjwIYTIx5+SVIuonvDhMASwlN3QR1j+2q4frrH+6p7FO49CEBnxubbDsh6mQ
         3IjCXevZPvA4hSohZIQLmltiRiuA/k9kJrwP6LKpeimrgqtbMXkEDhSYNNFkJ3Lk5k5K
         2FqPFLR/2e/d5tMNpL0SyPBEPkmdp4oVvW05KKtJIhKwU/0rkeM9fhtn8VjC1F3fkkWE
         Nty+bnav5T3Wlt49NoceZUi6NuYI1rOPfUTRRTCa+QQQxWDYml/TTe+b4HALq+TiArNU
         H3uL/iCnwDJaEDCRIFVgOWAO/vo8vKTMwr2AuLocVzYiT3+7Bgxl1JqsHQN7gnjsPlFP
         QOCQ==
X-Forwarded-Encrypted: i=1; AFNElJ80dmYmdC6rGX1bmnAR4b+jwPvV9wNzhRbVdXKmLAU5+Hm5Q3g1BD5iZLu0bnSOEl0QyVe6AF1O6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAP74MqPDff2WyVI1fGyCObKGrmNW6MIF0nWtxA7/qJImVvT5
	q9dg6nmCwbniyrfQDXKSdr1zaUoJOJi3zwOm//S7xCAv9hml284bT5ie6+GY+192svs=
X-Gm-Gg: AeBDieuL/0psiEPVU4TOfg2n8JBb0wu22X7ztqYwWcdJ46poI54sAlFJ00DmtT6UyAv
	Ed50Mz/vaGlHW0gO5+1cZvRzLNpcm/Et+BhXZkB6TsiDSa/BgzRF5R3szFy2WdzL4d7EHdxvMiv
	Jm3NcINwqJcg2b0YZNpPU5BqqPx9jJnMnbJuKwEuQmnva0Jj07IJJBR49MWileAMekSieA8IH88
	Fc3g0Pq4Rmr48M8HJTd8ISQ7IfG86trfQxYoX1u9zI1lCk9VPdnHjHZX8+gVuUbwzEUTKJ+GIke
	QID/pBtF7kvft5PAM9G4wekgL1nf6UKoAo9uVOEyCp8KGtN+EijNgFwpt9DIdwdZCOD9R9DD6j8
	IV5BNooIeG1+YB5ZXHbd2CR5VzX5tQSE0FySprlacT7aequx9BGewfFRAcJmt2SJ1pEOoM+cx6x
	Czlddk9qbkws47WIZihSkmB+Hjn4BYT/iB+W7ElnUE0B38xZ6sjtIZBT+mMLcgWyl1
X-Received: by 2002:a17:907:1c10:b0:ba3:5e81:7a88 with SMTP id a640c23a62f3a-bbb89001732mr266039966b.11.1777613849628;
        Thu, 30 Apr 2026 22:37:29 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d66a3e1sm71880566b.44.2026.04.30.22.37.28
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 22:37:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso4523452a12.0
        for <keyrings@vger.kernel.org>; Thu, 30 Apr 2026 22:37:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9YOvPpDh2gRDO829cG2O+ovbiz9MhAzqkwMT398+7ea5PxJY1TrxjFMqodtN0U432cYIhsuzYq7g==@vger.kernel.org
X-Received: by 2002:a05:6402:440a:b0:67b:7e67:7f5f with SMTP id
 4fb4d7f45d1cf-67b7e6780f9mr1738106a12.9.1777613848314; Thu, 30 Apr 2026
 22:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429181629.110802-2-bestswngs@gmail.com>
In-Reply-To: <20260429181629.110802-2-bestswngs@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 1 May 2026 06:37:16 +0100
X-Gmail-Original-Message-ID: <CAOs+rJUiup_B1ve7UztJH4crzE+98ZObRc3jLRsqkhLekpDmxA@mail.gmail.com>
X-Gm-Features: AVHnY4KFOllNfFhVUkq7YkiLdAqrH2_2sLf6kLFO07pHIa-YECyWylPj48Aai_M
Message-ID: <CAOs+rJUiup_B1ve7UztJH4crzE+98ZObRc3jLRsqkhLekpDmxA@mail.gmail.com>
Subject: Re: [PATCH] asymmetric_keys: check asymmetric_key_ids() for NULL
 before dereference
To: Weiming Shi <bestswngs@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Zaborowski <andrew.zaborowski@intel.com>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the report.

On Wed, Apr 29, 2026 at 7:17=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> asymmetric_key_ids() returns key->payload.data[asym_key_ids], which can
> be NULL for keys parsed by the PKCS#8 parser (pkcs8_parser.c explicitly
> stores NULL in prep->payload.data[asym_key_ids]).
>
> key_or_keyring_common() in restrict.c and find_asymmetric_key() in
> asymmetric_type.c both dereference this return value without checking
> for NULL. An unprivileged user can trigger a NULL pointer dereference
> in key_or_keyring_common() by creating a PKCS#8 key, restricting a
> keyring with key_or_keyring:<pkcs8_serial>, and adding an X.509 cert
> to the restricted keyring. CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dy is

Could you add a simple bash script for this to the commit message?

> required.
>
>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000000
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:key_or_keyring_common (crypto/asymmetric_keys/restrict.c:205 c=
rypto/asymmetric_keys/restrict.c:279)
>  Call Trace:
>   <TASK>
>   __key_create_or_update (security/keys/key.c:884)
>   key_create_or_update (security/keys/key.c:1021)
>   __do_sys_add_key (security/keys/keyctl.c:134)
>   do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>  Kernel panic - not syncing: Fatal exception
>
> Add a NULL check in find_asymmetric_key(), mirroring the existing
> pattern in asymmetric_match_key_ids() and asymmetric_key_describe().
> In key_or_keyring_common(), skip the trusted key matching when it
> has no key IDs and fall through to the check_dest path.
>
> Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup without AKID")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  crypto/asymmetric_keys/asymmetric_type.c | 2 ++
>  crypto/asymmetric_keys/restrict.c        | 9 ++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric=
_keys/asymmetric_type.c
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -109,6 +109,8 @@ struct key *find_asymmetric_key(struct key *keyring,
>         if (id_0 && id_1) {
>                 const struct asymmetric_key_ids *kids =3D asymmetric_key_=
ids(key);
>
> +               if (!kids)
> +                       goto reject;
>                 if (!kids->id[1]) {
>                         pr_debug("First ID matches, but second is missing=
\n");
>                         goto reject;
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -243,10 +243,14 @@ static int key_or_keyring_common(struct key *dest_k=
eyring,
>                         if (IS_ERR(key))
>                                 key =3D NULL;
>                 } else if (trusted->type =3D=3D &key_type_asymmetric) {
> +                       const struct asymmetric_key_ids *kids;
>                         const struct asymmetric_key_id **signer_ids;
>
> -                       signer_ids =3D (const struct asymmetric_key_id **=
)
> -                               asymmetric_key_ids(trusted)->id;
> +                       kids =3D asymmetric_key_ids(trusted);
> +                       if (!kids)
> +                               goto skip_trusted;
> +
> +                       signer_ids =3D (const struct asymmetric_key_id **=
)kids->id;
>
>                         /*
>                          * The auth_ids come from the candidate key (the
> @@ -290,6 +294,7 @@ static int key_or_keyring_common(struct key *dest_key=
ring,
>                 }
>         }
>
> +skip_trusted:
>         if (check_dest && !key) {
>                 /* See if the destination has a key that signed this one.=
 */
>                 key =3D find_asymmetric_key(dest_keyring, sig->auth_ids[0=
],
> --
> 2.39.0
>

Ignat
