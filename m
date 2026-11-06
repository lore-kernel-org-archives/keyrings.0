Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989423;
	b=KZG0cs2ZSjXhLuKlgOcIe0+x65ve7SMZ4kfzNRVZ8zdgIuTnxEZES1Gl356ts78msGqk
	 krWagJJMVaiSDXz5GQk34Vx0IZvDXBz1sy6RInAhWFIUnTS2TCoWd/euDScNW1CGMQoj3
	 xKI0APFDNZ5yfEKU0o1dWgYcKsCG1rC5+CfTSU8vqEYRXakXYUs5uezRav5jwOYP1Wg+C
	 wLxa73pRMUaDAfGLcmeZp0G5FjCcMWlRNUuXlNTqA5/YHAxgXfE4VHwVa6v47AbIPPWvZ
	 6hhQ7mvxrrnxStwcMb538o1qYZb4Y1c980fyshAg/Ew5gwLtzHUV+MhTPndyv2CRaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989423;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aNrxcQ3EqzspHqBIrIiO9tnG/RBY6rmNXDWaz9X6PEg=;
	b=NUvLdhGXLSZn8pS6KZCFU4LPA5kzoCP1Epk1lolbgeTQ1upjyy92U83tkXHbaQ6L39Ih
	 bRUIiYSNtRzy0eI4zafYY2uojSJ6voXU1bp7Gpkx8KZ1pGgIF3TOSUP8MGNzPSfS6vkMn
	 SsEpywUJpnSddOXdFEpopPJ+mOlu0AvtGKLcnFmbn8USzMgg+xgF+ewckY3uhXT1aggO1
	 xVDFvcpEHgzNqxJG0LYHfA2c2pMoyIsQ3VFMH47xFd2UN1Xo8zsi1QA8WVsyOlllj7+0+
	 XO6qt0eaCgKkUC7NMjuep23sfx6aZR/AcMGqecNdxLBHDWLXuisC39crrn/ZU1zqmJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00613606A326
	for <keyrings@vger.kernel.org>; Fri,  6 Nov 2026 18:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00613606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso150405666b.1
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989421; x=1794594221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNrxcQ3EqzspHqBIrIiO9tnG/RBY6rmNXDWaz9X6PEg=;
        b=s7QOE/gDfkeozryyiYmtDCtdLmsb8kv9tSR8Z3MZTMVfz/kNeodVPE/2TWF3pNAUer
         +OgBxBQaPHDsfPJlO9AgrxlM84AG+5MLTuSleF5AG471QfAQWaTtK6br3cL/8a1zTeX3
         6FP0gageVMnUJYgvs2KdhENja3T5yRRujbpKDjrDYYGsM0T2qLYEHgNlUOKQ8FVy6XEc
         2x5FiIvIiF/YlRjtRImaB0+WOmnu3jZMMJdn+jRkSonXpsnhuVcup+Z/t5BHokYrsz8g
         ljXp9MrvZxaYuPDGZ+zpTjPM8S4YI/HwLrNr8RmI9AaqRnN2czlIBknrQNnZBd/Z8ZpL
         2IrA==
X-Forwarded-Encrypted: i=1; AKwUvBym2zxs+4OlyP4Iv5y6DkfcTI7/HTbFJwnC3XbIYnHf1f4b63qQqN0R8xmharUL1cKIi+endvfdtw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nBdd+oRiHtS2tAj+cWpUXDx8Sro42H/tsvLFypFIUU8eEQM4z
	q2I8zZAmzntbKIzMePlo+TO2QLOTU0hKjcwJgVw6HvlJqu+qThABT5IodwegMe7YZIw=
X-Gm-Gg: AYBFou3BOYm4ZvPc6xuek3ap6ZzCjtCuuy2FWjgcBFdGJnFW6fFm2DnnLjLr4m2jGDP
	UNzmKhxw5nPn8/+xQqWcxJXFYtU7Cic9XKm/U82P5mlc9Gu8Bc+IW8ELdsBXAniJceDpNQmTGn/
	2ihkl0zm5yxlyurlLOkJb0JQ/te8ahS2k5dyJSxyGV6ROJydjqp1SOOT+msDfNREm8fz+tFEgpm
	ZbipYPJtdf1hbzi9NuBVoLHCZARm6p8PypopMKppf4je1AajIu0KwMr+VX/f17/QO2g9D8rDI0A
	vLWp0PIDIsU/hI7bzHKi0WaQTwofHf0bYztiNBqq551+++acl+4Rxkl9pVIXYgocWdAUomJNRws
	bIQvTW2mXZldkr6P4cDIEF8BEn3qAz+hmpxsoWImPj5qRjxz5sC9A06UDBwlaiHhoPzKgHUleBk
	VWhyvFLUnjlBHrbEyT4pXJ2PTPUnlaRvj/9B7DTbSdoW/9SIwXHZZMqIwtohQtmDw6vljb3oSLR
	dnru2iv17/JL6+s3DWkEsYSVjVL05MyrBQRBLiqMhS+aCuc6gCV62ZnUb4Y/c7JkDc4XWuBscbE
	BZJsQugfkxqiVAoGwzurh1m09PxxAMkKFLqelSiTwf/S3271wSONs6IIgfM=
X-Received: by 2002:a17:907:990c:b0:c49:df95:fd0 with SMTP id a640c23a62f3a-c4d356494a4mr184834566b.48.1793989421209;
        Fri, 06 Nov 2026 10:23:41 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356eb407sm96595366b.86.2026.11.06.10.23.40
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:23:40 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso138729066b.2
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:23:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwSQ259LzL3YzIYjrRg1t9om+Zmb50T1zLNTDQE1MS/NfKLNmSakrEPV57qGdGpJ8vpEpPLyjGQsA==@vger.kernel.org
X-Received: by 2002:a17:907:6ea1:b0:c49:903e:1e19 with SMTP id
 a640c23a62f3a-c4d354e89acmr271729566b.26.1793989420455; Fri, 06 Nov 2026
 10:23:40 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026024840.23482-1-xuyuqiabc@gmail.com>
In-Reply-To: <20261026024840.23482-1-xuyuqiabc@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:23:27 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
X-Gm-Features: AclHuK-C3Nt3Bae-E0GNpd5wrE9zs0X4WIFo37tTe1DY5jHnZaQm4KTY5Zirqa8
Message-ID: <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: Account for asymmetric key payload data in the quota
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:50=E2=80=AFAM Yuqi Xu <xuyuqiabc@gmail.com> wrote=
:
>
> add_key("asymmetric", ...) preparses the supplied blob and then
> instantiates the key with generic_key_instantiate(), which charges
> prep->quotalen to the owning user's key quota through
> key_payload_reserve().
>
> pkcs8_parse() duplicates the attacker-controlled PrivateKey OCTET
> STRING with kmemdup() into pub->key. pkcs8_key_preparse() stores that
> object in the asymmetric-key payload but hard-codes prep->quotalen to
> 100, so the quota records 100 bytes regardless of the retained private
> key size. The ASN.1 decoder accepts blobs up to 65535 bytes, so one
> key can pin about 64 KiB while consuming 100 quota bytes. With the
> default non-root limits (200 keys / 20000 bytes) a user can retain
> roughly 12 MiB instead of the 20 KiB the limit is meant to allow.
>
> x509_key_preparse() keeps the parsed public key, its parameters, the
> signature and the authority key IDs, but also charges a fixed 100
> bytes. PKCS#8 later repeated the same fixed-100 accounting. The same
> add_key() call reaches the X.509 parser, so fixing only PKCS#8 would
> leave the bypass reachable.
>
> Charge the size of the retained payload instead. An oversized PKCS#8
> key now fails with -EDQUOT instead of being accepted for 100 bytes,
> and the same applies to an X.509 certificate that retains an oversized
> public key or set of authority key IDs. A charge which does not fit
> in unsigned short is rejected with -EINVAL before the payload is
> installed, because key_payload_reserve() keeps the full delta in the
> user counter and refunds only the truncated key->quotalen. key_alloc()
> also charges the key description to the same field, so include the
> effective description length in that limit as well.
>
> Measured on v7.3-rc1 (10396a2d6d41), 2 vCPU / 2 GiB QEMU guest, as uid
> 1000, adding PKCS#8 keys with a 65000-byte PrivateKey field. Before
> the patch, 176 keys were retained (about 11.4 MiB) while
> /proc/key-users charged only 19712 bytes. After the patch the
> oversized key is rejected immediately, and a 200-byte PrivateKey still
> loads and is charged 264 bytes. A small X.509 certificate whose only
> large object is a 26000-byte authorityKeyIdentifier is likewise
> rejected, while the unpatched kernel accepted it and charged 109
> bytes.
>
> Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.5=
09 certificates")

SInce we touch PKCS8 as well, missing a relevant "Fixes:"

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>
> ---
> Changes in v4:
>  - Sashiko (High): "keys: integer truncation of key->quotalen causes
>    permanent quota leak" on key_alloc() and key_payload_reserve().
>    Include the effective key description length in the USHRT_MAX
>    limit. key_alloc() and key_payload_reserve() add the description
>    and the payload to the same unsigned short field, so checking the
>    payload alone was not enough.
>  - v3 Link: https://lore.kernel.org/all/20261019041314.48569-1-xuyuqiabc@=
gmail.com/
>
> Changes in v3:
>  - Sashiko (High): "keys: integer truncation of key->quotalen causes
>    permanent quota leak" on pkcs8_key_preparse() and
>    x509_key_preparse(). A payload charge above USHRT_MAX is rejected
>    with -EINVAL before the payload is installed. key_payload_reserve()
>    keeps the full delta in the user quota and refunds only the
>    truncated key->quotalen, so that charge would leak quota.
>  - Reposted so Sashiko records a review against this Message-ID, as
>    requested by Herbert Xu. v2 was posted and Ignat Korchagin replied.
>  - v2 Link: https://lore.kernel.org/all/4a0b2e00f5cc62c173a01fec2f56eab1b=
04d70bb.1790568982.git.xuyuqiabc@gmail.com/
>
> Changes in v2:
>  - Move the bug details and the measured quota numbers into this
>    commit message, as requested by Ignat Korchagin.
>  - Sashiko (High): "keys: integer truncation in key->quotalen causes
>    permanent quota leak" on pkcs8_key_preparse() and
>    x509_key_preparse(). Not changed in v2. The same finding is
>    addressed in v3 and v4.
>  - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gm=
ail.com/
>
> diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_ke=
ys/pkcs8_parser.c
> index 9dd1c181789a..db2d57489d96 100644
> --- a/crypto/asymmetric_keys/pkcs8_parser.c
> +++ b/crypto/asymmetric_keys/pkcs8_parser.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/oid_registry.h>
>  #include <keys/asymmetric-subtype.h>
> @@ -136,6 +137,8 @@ static struct public_key *pkcs8_parse(const void *dat=
a, size_t datalen)
>  static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
>  {
>         struct public_key *pub;
> +       const char *description;
> +       size_t desclen, quotalen;
>
>         pub =3D pkcs8_parse(prep->data, prep->datalen);
>         if (IS_ERR(pub))
> @@ -144,13 +147,26 @@ static int pkcs8_key_preparse(struct key_preparsed_=
payload *prep)
>         pr_devel("Cert Key Algo: %s\n", pub->pkey_algo);
>         pub->id_type =3D "PKCS8";
>
> +       /*
> +        * key_alloc() charges the description to the same unsigned short
> +        * field that key_payload_reserve() later adds the payload to.

While today indeed only the asymmetric keys hit this I wonder if the
fix is better to be in key_payload_reserve(). Something like a fail if
key->quotelen + delta > USHRT_MAX. That fixes all current and future
key types.

> +        */
> +       description =3D prep->orig_description ?: prep->description;
> +       desclen =3D description ? strlen(description) + 1 : 0;
> +
> +       quotalen =3D sizeof(*pub) + pub->keylen;
> +       if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
> +               public_key_free(pub);
> +               return -EINVAL;
> +       }
> +
>         /* We're pinning the module by being linked against it */
>         __module_get(public_key_subtype.owner);
>         prep->payload.data[asym_subtype] =3D &public_key_subtype;
>         prep->payload.data[asym_key_ids] =3D NULL;
>         prep->payload.data[asym_crypto] =3D pub;
>         prep->payload.data[asym_auth] =3D NULL;
> -       prep->quotalen =3D 100;
> +       prep->quotalen =3D quotalen;
>         return 0;
>  }
>
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..4a9c85277ce0 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -163,9 +163,11 @@ static int x509_key_preparse(struct key_preparsed_pa=
yload *prep)
>  {
>         struct x509_certificate *cert __free(x509_free_certificate) =3D N=
ULL;
>         struct asymmetric_key_ids *kids __free(kfree) =3D NULL;
> +       struct asymmetric_key_id *id;
>         char *p, *desc __free(kfree) =3D NULL;
> -       const char *q;
> -       size_t srlen, sulen;
> +       const char *description, *q;
> +       size_t desclen, srlen, sulen, quotalen;
> +       int i;
>
>         cert =3D x509_cert_parse(prep->data, prep->datalen);
>         if (IS_ERR(cert))
> @@ -221,6 +223,36 @@ static int x509_key_preparse(struct key_preparsed_pa=
yload *prep)
>         if (IS_ERR(kids->id[2]))
>                 return PTR_ERR(kids->id[2]);
>
> +       /* Charge the memory retained in the payload, not a fixed estimat=
e */
> +       quotalen =3D sizeof(*cert->pub) + cert->pub->keylen +
> +                  cert->pub->paramlen;
> +       if (cert->sig) {
> +               quotalen +=3D sizeof(*cert->sig) + cert->sig->s_size;
> +               if (cert->sig->m_free)
> +                       quotalen +=3D cert->sig->m_size;
> +               for (i =3D 0; i < ARRAY_SIZE(cert->sig->auth_ids); i++) {
> +                       id =3D cert->sig->auth_ids[i];
> +                       if (id)
> +                               quotalen +=3D sizeof(*id) + id->len;
> +               }
> +       }
> +       quotalen +=3D sizeof(*kids);
> +       for (i =3D 0; i < ARRAY_SIZE(kids->id); i++) {
> +               id =3D kids->id[i];
> +               if (id)
> +                       quotalen +=3D sizeof(*id) + id->len;
> +       }
> +       /*
> +        * key_alloc() charges the description to the same unsigned short
> +        * field that key_payload_reserve() later adds the payload to.
> +        */
> +       description =3D prep->orig_description ?: desc;
> +       desclen =3D strlen(description) + 1;
> +       if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
> +               kfree(kids->id[2]);
> +               return -EINVAL;
> +       }
> +
>         /* We're pinning the module by being linked against it */
>         __module_get(public_key_subtype.owner);
>         prep->payload.data[asym_subtype] =3D &public_key_subtype;
> @@ -228,7 +260,7 @@ static int x509_key_preparse(struct key_preparsed_pay=
load *prep)
>         prep->payload.data[asym_crypto] =3D cert->pub;
>         prep->payload.data[asym_auth] =3D cert->sig;
>         prep->description =3D desc;
> -       prep->quotalen =3D 100;
> +       prep->quotalen =3D quotalen;
>
>         /* We've finished with the certificate */
>         cert->pub =3D NULL;
> --
> 2.56.0
>
>
>

Ignat
