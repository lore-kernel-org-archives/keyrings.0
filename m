Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363334B43F
	for <keyrings@vger.kernel.org>; Mon, 22 Jun 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159681; cv=none; b=oBh2J8/qds41b/hH/pO2muM3nlEHiX5MHzel6qBuaAnE3L64LuUe29gX9wgiLgEybG2h36QhDrO/f9Rvj6LeuCpl9/mb4+A/UjIVurRjC9rFaBFcjpXg861F4RyMwNQxlC/yMcziRLnCiJ2OiGhMPcvEThcwz4rAPnJLa0OvPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159681; c=relaxed/simple;
	bh=nnx1Bky1wAIRaB3zi2foM2fegfU+yLHj+NalW3CIDc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq9ymS95+qDDKWBTGq2Ca6Fyh/rBIZ4fMUUNeOWqvgrvRUkQNd0t01j3iKeSmrLu3ou2QjY5VXTwuQ2dL3PExEBTwMm5VFsRGkq57Oup3NBU4hdux3LeCtMLRY6dWL7oV5g6lAa+tL/i1hHnaAbrxrnMUE0y95DPpBmeKxr1PC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c0c5d170ad4so312060666b.3
        for <keyrings@vger.kernel.org>; Mon, 22 Jun 2026 13:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159678; x=1782764478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVlFfRpn9UntpPh6Z18ZIlYWvmrIqOtd+zdy9KzVAtA=;
        b=d7nn0v7PfULG+cJ1gx82eENkWHPu3i/ub9CS8H8SyzA3m6Z8k8Q5G4nrj0by0e3ELX
         ehEN4CAlfr+X5efYqoXMrSOlMmDw3Jay+Aiy1L+QRtZRS3DhS5B2OrhXpNdVbI+O3EOp
         fHcwZ+hWRcz8CJYhXvxj/NI1/kUDPyErEqAs0QEEVA0F2Yip272KPrYmcOh4gvN1HFg0
         SQvpXMxfutEOjy/wTlKm/piyVlmrxfErgDwyYq09x1FTYEJwew7YG9vxi/RzfgEk9wNv
         qLYFrLuQsszP/mcnbZTOkayY3RCIJm7+0sNlHgfu+uV3bZ+q0muU96FCiPmSv0jv//ge
         E7Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8PfTQUO1CFx1iwPAHGm9mF4g5XnSJjzVqVlzVYewPe0kHWo/4NplNWsRzWYT+taa1eRvkgaAyjKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Id0/TfIJ3Jk8JxMzZxMMB04X0lWIsuXs8oTHH5ARgybmVAu0
	8RJTghziiqPFK2Tq7g9ATj+Py4kbAITMWd5Eag2lb2lbMT9T9mWVooMe/FbvmfeGBoU=
X-Gm-Gg: AfdE7cmyJb7WZoiWREWnT03LefwnoWyI479sLuRhsqsxTSj4WULZjG9Bs/65NgZUC1o
	2z+y2vuoruYKCgoSXOe4gG3SwyLM7W2Bl0dec3Y1Dj285LxMqU4FAV3BtvOufNe/0gYUKpOgIgB
	gCKiH6qlDbjpYSBwklAyhKgCdk844/LB7bDK8sdBMIAsKgot7PTFKPz7+QNk2HGTLL+8uZZX7qS
	mN2j4LiS4ZkSw0PIu1bhla2sl9CZ5hl1O/P01iMdNWcWjcHJmTQkCuKnV63719kmWWP0yqEIOLL
	K57+iE6GiYxCEO9c8Vx907KinzDTw5hT4zUzDXhVW4s8s3VCo2lhrcpGAk2yXez8v9MaC4jQTOQ
	Vm6AU5+cnqiNFeYJMq7JAaRHl9IhumnIksgsjrnBZxuXVzsTPCeBRz4AG9TeU9AUuIpul5eXEsq
	05KxHKeU2CdMC+w3Sc4lX9L3BPKN2WVyXL95SCuqsEQio=
X-Received: by 2002:a17:907:26c2:b0:beb:8ab8:30ce with SMTP id a640c23a62f3a-c097ae4b6ebmr789478466b.20.1782159677537;
        Mon, 22 Jun 2026 13:21:17 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1002d6c5f6sm60598866b.49.2026.06.22.13.21.16
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 13:21:16 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697ad7f663cso2439159a12.1
        for <keyrings@vger.kernel.org>; Mon, 22 Jun 2026 13:21:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8EOBqIGSfb5zuQhQYQV2NoMMSKNER4OUiExN3Y4+vVM8CfxBh058cenr5FhvmEiQaZHSM+SbeABA==@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:c0d:7573:7256 with SMTP id
 a640c23a62f3a-c0d7573740amr435737666b.51.1782159676483; Mon, 22 Jun 2026
 13:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502163328.696098-2-bestswngs@gmail.com> <aji3B9a72VEAOu03@gondor.apana.org.au>
 <ajlNCxltXkuWfIw-@kernel.org>
In-Reply-To: <ajlNCxltXkuWfIw-@kernel.org>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 22 Jun 2026 21:21:04 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVutdn6vqjSxidx-fA_R8PYsqJbbpMRUW+ijJeXoavCYA@mail.gmail.com>
X-Gm-Features: AVVi8CcdlgikvHr2XETEkUfuG_HaLob-n6pc__1dO-GEG4Nf3-J3r6h8h6TyyI4
Message-ID: <CAOs+rJVutdn6vqjSxidx-fA_R8PYsqJbbpMRUW+ijJeXoavCYA@mail.gmail.com>
Subject: Re: [PATCH v2] asymmetric_keys: check asymmetric_key_ids() for NULL
 before dereference
To: Herbert Xu <herbert@gondor.apana.org.au>, Weiming Shi <bestswngs@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:56=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon, Jun 22, 2026 at 12:16:07PM +0800, Herbert Xu wrote:
> > On Sat, May 02, 2026 at 09:33:29AM -0700, Weiming Shi wrote:
> > >
> > > diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymme=
tric_keys/asymmetric_type.c
> > > index 16a7ae16593c..22f04656d529 100644
> > > --- a/crypto/asymmetric_keys/asymmetric_type.c
> > > +++ b/crypto/asymmetric_keys/asymmetric_type.c
> > > @@ -109,6 +109,8 @@ struct key *find_asymmetric_key(struct key *keyri=
ng,
> > >     if (id_0 && id_1) {
> > >             const struct asymmetric_key_ids *kids =3D asymmetric_key_=
ids(key);
> > >
> > > +           if (!kids)
> > > +                   goto reject;
> >
> > This check is actually unnecessary because we've already matched
> > the key against the kid so it must be present.
> >
> > I'd get rid of this check or perhaps add a comment instead.
>
> +1
>
> >
> > >             if (!kids->id[1]) {
> > >                     pr_debug("First ID matches, but second is missing=
\n");
> > >                     goto reject;
> > > diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_ke=
ys/restrict.c
> > > index 86292965f493..ccf1084f720e 100644
> > > --- a/crypto/asymmetric_keys/restrict.c
> > > +++ b/crypto/asymmetric_keys/restrict.c
> > > @@ -243,10 +243,14 @@ static int key_or_keyring_common(struct key *de=
st_keyring,
> > >                     if (IS_ERR(key))
> > >                             key =3D NULL;
> > >             } else if (trusted->type =3D=3D &key_type_asymmetric) {
> > > +                   const struct asymmetric_key_ids *kids;
> > >                     const struct asymmetric_key_id **signer_ids;
> > >
> > > -                   signer_ids =3D (const struct asymmetric_key_id **=
)
> > > -                           asymmetric_key_ids(trusted)->id;
> > > +                   kids =3D asymmetric_key_ids(trusted);
> > > +                   if (!kids)
> > > +                           goto skip_trusted;
> >
> > Yes this is definitely buggy.
> >
> > I think it was introduced by these two commits:
> >
> > commit 3c58b2362ba828ee2970c66c6a6fd7b04fde4413
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Tue Oct 9 17:47:46 2018 +0100
> >
> >     KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]
> >
> > and
> >
> > commit 7e3c4d22083f6e7316c5229b6197ca2d5335aa35
> > Author: Mat Martineau <martineau@kernel.org>
> > Date:   Mon Jun 27 16:45:16 2016 -0700
> >
> >     KEYS: Restrict asymmetric key linkage using a specific keychain
> >
> > So the Fixes header should point to them.
>
> +1
>
> >
> > > @@ -290,6 +294,7 @@ static int key_or_keyring_common(struct key *dest=
_keyring,
> > >             }
> > >     }
> > >
> > > +skip_trusted:
> > >     if (check_dest && !key) {
> > >             /* See if the destination has a key that signed this one.=
 */
> > >             key =3D find_asymmetric_key(dest_keyring, sig->auth_ids[0=
],
> >
> > I'm not sure continuing here is a good idea.  Having a private key
> > here makes no sense whatsoever and we should just bail out right
> > away.
> >
> > I would recommend returning an error of some sort if kids is NULL.
> >
> > David/Lukas/Ignat, any opinions?

As I reread the original submission (somehow I never got the V2) it
seems we're restricting a keyring with a private key?! Which indeed
does not make sense.

> I think with a quick skim that you are right. I'll work on this area
> for the next version.
>
> >
> > Thanks,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>
> Thanks for the review!
>
> BR, Jarkko
>
>
