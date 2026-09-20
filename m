Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8D250BF2
	for <keyrings@vger.kernel.org>; Sun, 20 Sep 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867333; cv=pass; b=XP+iqOg8+XVWfr1RUnfv0zEyJSLlF/tmsYXhG3awJHygnBklHiLz7JTHG7MTvL6eCFfui8J1Bs7dBXY4nPoO64eKjGHiPuOf89LCrTNlmw2y8QmjCxYnMDbCzYGx6hd63rhrGiOLRhtcf3YC7WLPm9c3g8q6QGqhLTZcISJ4qbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867333; c=relaxed/simple;
	bh=2VEm69UeAdHkIwbBU0Ergf1rGXkHAkJuOFSQAiSO0p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8HkYgLZ0uUbywZ9r3qVk7lEdc7Ox9ZOok+vexY2J3k8PJGwlrTWSDQOYRJQzVCDBBAxgvUPbwZFvZ6vRbQHtcmW3+6t9L+aWHMIbC/pS+joZEiy5gWSWEk+HLBPVrtvZ06m/HQWuxkKHnAJwq0owU7vVfwG+CqXmrKIrGfTlnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L6O+ve67; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L6O+ve67"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1283485a12.3
        for <keyrings@vger.kernel.org>; Sat, 19 Sep 2026 18:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867330; cv=none;
        d=google.com; s=arc-20260327;
        b=CVEraAHKH2S+jCEIPKfdoCHGxikdgFNGHfvIlGen5nTKX0w4uVVuBsxikbT1NQio/u
         +a662CkCi4vKe4Xb7wIV1G1Ql2MnWjuHLYqutLP+y2N5LWt2hodwmMbvrk7g5vcqAhsf
         +US+Om5/X82nnYfTdPI4lQhIVAexPCOd0y5uqbzAQjjaxAN/gJA+rYzwU5UeUNR6icnb
         30JywqhtEUQEG1cTf3jPx7Vw/2FzS9UK4XiaPkG78fTgizU/w1cgFEJAxr4li+bhEdfD
         sBkKksMXz45zV2QgoE4w9lr2WQj1znsQAQUTy8NIpk0LSGB9Ah0FV5Em9U45yckd4YuD
         zQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        fh=3caLlGc6Zl/cOFmrlsXfT6AEUfrCPMedGWpNhqqWE/I=;
        b=Pdvj/9nycXAaIvHHFbnoShL7z1fv+LU1WDkKf+DYftmXutQOXhQGHSRciS8B9qEDsP
         R1XOyhwyMNFptXPkwh+U8q3/E34N7iBAfa5pR1ww4MoNrmVSWcX0X5YSu6jmPy/+uq5Z
         HgwPrpap5KnFudncUNwOCiTZ6LhbDelNuIQue/Zv/xqctb27l5clg8H2W3ikNb5tufZ9
         t0q+yUlHljZBaRfgSiZRStyCWZgzTYVssVsfZ0rHZfzNNOJRyih/uSxvpovFGAN7xfJm
         k+1NugifGASFLVYQtdYHDq7LaXCa3g1OzHR09gNnvA7+6xOI4tXUbRB2Ew55QZ/ggpD/
         f87w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867330; x=1790472130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=L6O+ve675fqEPtcUxqXtqgUQOpms6zlKaUIVzibB6dwlz8UfhHs18NE2LQUD0Itsbq
         AmXaRpmqj59ev0o94mh3ukN0p/YT3QVdvoOrUJ1MdZT9J/lGPqVNQkvOsxD5rhN+A9eL
         LSsfQ6qJGaQTDNhZ2QQWWEBDV889TT7n/YsnabMngyUxuZlKl/P1C3y/n3UyrpfAOlcN
         MOBAOUOJScs7eRYBD8xg0ICP/+2B7tz/TIyD6q5N1RhFcabKg9Gkct3n4hjEokIhjm3X
         69PzVQcrIsgtUubhk1bGHZETjXsz2Or2LbKOUnyrb7IK1ddnqQG3J9tdZG88507MKWLH
         P/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867330; x=1790472130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=EUlUm2zE5VNztuZE+ZMM8wwJEvMGpTD8di0y7ekkKIncbEKKcI6nVj1oGHkGlGqOLH
         BmtA8vmUiA3uV2OFEZRkCiwxdQy27mEJKDcgt4LTbviNuB4uZsYiKT6cntIIoppnD3oG
         8Cx4p4KzGkqMhDZUZmXKPhdXMpmoj3v1qNniHwmELmsQbLy9LKw312TEhdoskufjEO55
         mDDno7bgi8GEZ+Mn+70r2m1BFZOTCtYKjpwurvhmiBUUp52028U8xS0RAj2azgYykBiH
         vpAp6x+zxlK1Zr4k/5ybXhZDbX4lcGOKUOBwn+X+DuEIP++2Q/ixl9+NTU/m1GhirLY5
         4OZA==
X-Forwarded-Encrypted: i=1; AKwUvBx0bp56Ai2Cm5LgA7WXtlrYrJqquKBRl+5hd0mRwja8Pf6J4GRwCb8ZtQ9jvnG/HCEPDbe/MSvmIg==@vger.kernel.org
X-Gm-Message-State: AFuF++k9K7bui3Aek7a8QC/gyS0/T++PpKB6Ttzar7h+y5RKQiD6LFGQ
	Vp3ySGtmrFSYluNvRIWBbs2Km8lGa9oUutDcblNRvsKPlj/k+IivjSAt5OfHwGPDOGrmHOXruBi
	zIwhVNsiCAKssq7rw6nFadWESTDprqhmalEk5knPB
X-Gm-Gg: AYBFou2gBeAhhYRpzKfRPdVbEDvVZRjwXlxX/GcU/feaZ2TKLyWqJBg+paNbpaQdK3W
	Z5/oVHpwR1TsiUiKE90k72CDhEiHAhDS9FHMHeG/IdtMAwbMs9VhGJSbw+V2cezR/m+uHG3jR+Y
	RlWU8B+fvBR4JDEVuEmxFZbrgJUQqe9LJK1YAcC0s9/5gFm/g8brB8/8dr2XNOn+dYLIKVCSHN+
	bgehlsqXOA9Nu84CTevS+Y26g4er0vMZ6jEALPvvGMjNMIkHwL9Oz7+t9Lnf6VTo7ouNQKzt486
	uWwubVZHbnSohEXC9qTfMHX9qYYB0itANwo9wKfoAyPN01NXhHi20nZ5GNd2xCJbpK+XrWhBhzk
	APF10mu8t5/M=
X-Received: by 2002:a05:6a20:144d:b0:3dd:a008:dc39 with SMTP id
 adf61e73a8af0-3dda008e131mr6498106637.39.1789867330527; Sat, 19 Sep 2026
 18:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919223438.3883567-1-benquike@gmail.com>
In-Reply-To: <20260919223438.3883567-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:21:58 -0400
X-Gm-Features: AcwNN1XYIQ_wBn8i5ggt4CeI5Ch8V6l0HMTPG10aIvqe5hBWEiugJPjmk6GI8NQ
Message-ID: <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
Subject: Re: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI
 removal and check AKID len
To: Hui Peng <benquike@gmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:34=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Fix two issues in netlabel CALIPSO and X.509 key parsing:
>
> 1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
>    inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
>    mappings referencing a removed CALIPSO DOI are removed.
> 2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
>    length signature/AKID fields before key matching.
>
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Thank you for your patch, but as NetLabel and the kernel key code are
in two very different subsystems, please split this into two patches
so they can be properly reviewed and potentially merged.

> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..5c9165a83f91 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
>
>         if (sig->algo_takes_data) {
>                 /* The signature algorithm does whatever passes for hashi=
ng. */
> -               sig->m =3D (u8 *)cert->tbs;
> +               sig->m =3D kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL)=
;
> +               if (!sig->m)
> +                       return -ENOMEM;
>                 sig->m_size =3D cert->tbs_size;
> -               sig->m_free =3D false;
> +               sig->m_free =3D true;
>                 goto out;
>         }
>
> diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_cali=
pso.c
> index e1efd888b4a2..3756193b1c49 100644
> --- a/net/netlabel/netlabel_calipso.c
> +++ b/net/netlabel/netlabel_calipso.c
> @@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *s=
kb,
>  static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *=
arg)
>  {
>         struct netlbl_domhsh_walk_arg *cb_arg =3D arg;
> +       struct netlbl_af6list *iter6;
> +       struct netlbl_domaddr6_map *map6;
>
>         if (entry->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &&
>             entry->def.calipso->doi =3D=3D cb_arg->doi)
>                 return netlbl_domhsh_remove_entry(entry, cb_arg->audit_in=
fo);
> +       else if (entry->def.type =3D=3D NETLBL_NLTYPE_ADDRSELECT) {
> +               netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->li=
st6) {
> +                       map6 =3D netlbl_domhsh_addr6_entry(iter6);
> +                       if (map6->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &=
&
> +                           map6->def.calipso->doi =3D=3D cb_arg->doi)
> +                               return netlbl_domhsh_remove_entry(entry,
> +                                                                 cb_arg-=
>audit_info);
> +               }
> +       }
>
>         return 0;
>  }



--=20
paul-moore.com
