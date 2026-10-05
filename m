Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC130F526
	for <keyrings@vger.kernel.org>; Mon,  5 Oct 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179625; cv=pass; b=ue7y7cd6pivF8h+Ksvv41CzuFdpeWQhHt7hmxFWzJ1mlakMl/7TQMeHiaxGajj+nnNIoheqwWP3fOhmQZYk3w8LEqeRruAft8DTgeedP1fU5QbKIQblhDT/5JUhYAm2UsUVqtn31/HsMiVNELoKEPmNqCALfZpW8v6LiC5DN9Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179625; c=relaxed/simple;
	bh=/Ze/jOMdibKyIRE9oGzvxNmCM4QVvN890ZX2bkJzS98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6fvhGI0UX/7KsRixkemUrGCx0CXTxy89Ah3P1En5VpCPFypRjUnHLqY39m/C7apSji/WJ84Q457kkjUlrQpRwyCX3vQALbBA5VqNGEOaKG+QEVS1XqKvD7V+ULi9NJYJv923Cz5MjhdfVqDpa+LZRPWtl6aehTh+eBy5cl9E8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxGWPgLk; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxGWPgLk"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19bcd2faso255360a12.2
        for <keyrings@vger.kernel.org>; Sun, 04 Oct 2026 22:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791179622; cv=none;
        d=google.com; s=arc-20260327;
        b=Gm23fq52nEkKz5AHKWugSBZ7iEXPjHr/qkgAl1Zc6q37BEPlGk/W/J4PtmfP983krs
         ocgMlD6RT66xKS6i5gPBzZfHg6k3aFME25uj5gnjEzHCM/E6BJ51/SxmULesSasCULR/
         EZNhEuVpxkn2n1qHLqriv1ulJhIRaNIqYECqFgrRzquneqlV8DzFAJBW4YwIw8US0+sq
         GpUtnnXL9RVU0L4luVQDDUnaa5SOLmo0s5TXE2J4y3cQgm5dWIjynrYfrdBG9RefVi+7
         j9eGBmRFlLZra64iPwOolFFDDzCs9pKv3Y3HhOyED6smZT8smYjqAIlNavapPtzsruaM
         F3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        fh=XcmMHk4+siQXoyLh9w0NaREwIS0fl3ZC03Xhyldtdys=;
        b=LKC5JKXH4G/celjfg93xF/XRwP5eUtqpycSsNVeTb8sqWNF7UIIgb5AVC/6h4FQ+Np
         Z+OE/bvpg3PFm0IJ3DEBAo5FCxgcvxhzmNR00Yewk+1KowikTrcrNm0zxVl7dNHHHshg
         xFaZK2tKWZ0/QksWIA/VTvaQzxsnfXa2H13RWnmb12EBq3PuFTDgtvnsbjn8xM1xSwNU
         aV6jjowvM7PrTE26Ypm5msiqOd7HZVyNhol5i/W3Z83YuvquLwPZZ3AeyDmZBmNMZwfA
         9OmlK/V0orwTBSVTq/dqs+UVOQz4/EsY83RoUMiKCXn3pQPOlcNG/8+soTCjGP0Wb0/R
         rRXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791179622; x=1791784422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        b=IxGWPgLkO3H1hY3Eeu8f1TNXcRx//SHxDFYpI/LHwpgY/ep4Ne1N2H4BeKUHWo/rA0
         zFDgMof8Ok1+4ivJIYo+ZYXr3Kbl9iYrP9MX4YRkTuHxJQ2fzTp0BLHI5I9MRnSiXl/R
         66kfvaRovFY8aYcHqb1xuouKD5zOGSBNMwC4pwlvA6UWkvoC/S5G4gSN7pblXO0CdGL8
         5oqMTP9eyIYEj+8YthAzuoEQG3iHLDnCbqXtVKuZnmP/ePB7rHsWVu3HgFEW0dyn0UAU
         ptpcpYS72RyihM7jGe7zP7iiVLYtMJcsLijH2acFBRDIySyIJ35G+n+zLfRsFfs0W8NR
         EZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179622; x=1791784422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        b=IV5FVwaW/Bd7u5A5J9uKTJGgQoMurWr1LjBye88m0aWq/GFiGVjK7P+0F6VggwDxqG
         DkFhHdf3MPqFN92cfRC7sqEQXkzRjxYrf9VeXbuD+8/btRMjuzQNlnxsc3jYyWynMEnC
         uCVhQgBe4lroUZ7wfdcylz8fay5nNTx6KEIPF7A+ijZL3UWxTN8/FmSEcpwkgzXZa/4v
         5oz/b/Jq415BtEtYqFhaSexOmvZ2dijROnWTsSjlFbmWMhcUVOShpMpo71cRGCGz/8wM
         Fyy5leB/Qb1TV6Y09/l+VoTjYcQhXOujwRwh5f/BZoG/b3vSsW6c6MgkDoXGxcf5H+Po
         LdrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzngJDA/fFNsTIgGR+hOoHtUu9bwB//Nzmk9VhUncYFYgclZ31Fhhn6AqN2sy66X3GzOH7d0CJtBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIITTT7pp31RoXgS6FiA+phz0/J5hV7yngTQ+hgI6N5YEedUXZn
	dU+fkDsGYbizFipyJOORaqeir34w93ucYRPxKdWBefkJA2pXfdzMN9w0EkqRiH2WD5jlKD5UtwO
	ZbAWIm7Y2joke8yaZmaRKZEKXF7nyyf4=
X-Gm-Gg: AYBFou26Sl4xp+0Eswr3+6BRxq9tn/PjDFWSVimGZoOyyaU+cjAqHYWyb8hL4uSRpp9
	gMMsRGY7WHfN2FBoPPXm7Cz8obExqIr71t9bLafsKREh4jT2G3miCAorGDM/HbXZAIns0bg02dk
	WNQoEMigOYzGY7GLqtu55SrbJ62GR0sl4w/Kf3zmRi1ylBFcLgg4KEo12s4RC4Yz3/pGTxqwhiM
	qMqBHRFOe3yVWDAVaOGDmPqreKgbEXCzRCNuPRKdOdaK6wuuMzU6BAuZK5LSeSSgGy+S5D2bXHm
	VPJMEbAzttRYR5qp+rbSMDwrripJiGftP2GVi2iBCy6F6DD1fg0bxwXtISzmODp4TTC0XAs5P2m
	STX0pzGPJRRA=
X-Received: by 2002:a05:6402:1d4f:b0:6ad:723:1d6c with SMTP id
 4fb4d7f45d1cf-6af9e2ae5f7mr8588577a12.2.1791179621643; Sun, 04 Oct 2026
 22:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com> <asMIwpXXWQaD3gAD@kernel.org> <asMQMzqVkmYhwgMB@kernel.org>
In-Reply-To: <asMQMzqVkmYhwgMB@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 13:53:29 +0800
X-Gm-Features: AclHuK-pkRL-PIEptFTZp1svoeb3zjIH2fPWO872zakO885qLUCTEslthC1wtlc
Message-ID: <CAAo+4rULBiu6tOrdOjsgFcudjvyQO+DR9oZK=wms_3KxgFPNHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key accounting
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 10:49=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon, Oct 05, 2026 at 05:17:42AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 28, 2026 at 12:25:28AM +0800, Chengfeng Ye wrote:
> > > Protecting individual accesses to key->user does not make ownership
> > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > key->sem, but instantiation is serialized by key_construction_mutex a=
nd
> > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown o=
f
> > > an uninstantiated key.
> > >
> > > The instantiated-key count can therefore be charged to the wrong owne=
r:
> > >
> > >   instantiate                       keyctl_chown_key()
> > >   lock key_user_lock
> > >   increment old->nikeys
> > >   unlock key_user_lock
> > >                                     observe KEY_IS_UNINSTANTIATED
> > >                                     skip the nikeys transfer
> > >                                     replace key->user
> > >   mark key instantiated
> > >
> > > The key becomes instantiated under the new owner while the increment
> > > remains with the old owner. Negative instantiation has the same race.
> > >
> > > Quota reservation can likewise run between charging the new owner and
> > > replacing key->user. It then adjusts the old owner's quota and change=
s
> > > key->quotalen while chown is transferring that quota burden.
> > >
> > > Extend the key_user_lock critical section in keyctl_chown_key() acros=
s
> > > the quota and key-count transfers, state check, and owner replacement=
.
> > > Also extend the instantiation critical sections across the state upda=
te,
> > > so chown observes the count increment and instantiated state together=
.
> > > The existing per-user quota locks continue to serialize quota changes
> > > against other keys owned by the same user.
> > >
> > > Keep allocations, notifications and reference release outside
> > > key_user_lock, and release it on the quota-overrun path.
> > >
> > > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's=
 owner")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > ---
> > > Changes in v3:
> > > - Split from v2 as patch 2/2; see the cover letter for the full split=
.
> > > - Rebase onto current mainline and retain explicit reader-side lockin=
g.
> > >
> > > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gma=
il.com/
> > >
> > >  security/keys/key.c    | 4 ++--
> > >  security/keys/keyctl.c | 6 ++++--
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > index d0d583194b05..54c675b3b58d 100644
> > > --- a/security/keys/key.c
> > > +++ b/security/keys/key.c
> > > @@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key =
*key,
> > >                     /* mark the key as being instantiated */
> > >                     spin_lock(&key_user_lock);
> > >                     atomic_inc(&key->user->nikeys);
> > > -                   spin_unlock(&key_user_lock);
> > >                     mark_key_instantiated(key, 0);
> > > +                   spin_unlock(&key_user_lock);
> > >                     notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
> > >
> > >                     if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &=
key->flags))
> > > @@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
> > >             /* mark the key as being negatively instantiated */
> > >             spin_lock(&key_user_lock);
> > >             atomic_inc(&key->user->nikeys);
> > > -           spin_unlock(&key_user_lock);
> > >             mark_key_instantiated(key, -error);
> > > +           spin_unlock(&key_user_lock);
> > >             notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> > >             key_set_expiry(key, ktime_get_real_seconds() + timeout);
> > >
> > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > index c17924609317..83a9575b084e 100644
> > > --- a/security/keys/keyctl.c
> > > +++ b/security/keys/keyctl.c
> > > @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t us=
er, gid_t group)
> > >             if (!newowner)
> > >                     goto error_put;
> > >
> > > +           spin_lock(&key_user_lock);
> > > +
> > >             /* transfer the quota burden to the new user */
> > >             if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> > >                     unsigned maxkeys =3D uid_eq(uid, GLOBAL_ROOT_UID)=
 ?
> > > @@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t =
user, gid_t group)
> > >                     atomic_inc(&newowner->nikeys);
> > >             }
> > >
> > > -           spin_lock(&key_user_lock);
> > >             zapowner =3D key->user;
> > >             key->user =3D newowner;
> > > -           spin_unlock(&key_user_lock);
> > >             key->uid =3D uid;
> > > +           spin_unlock(&key_user_lock);
> > >     }
> > >
> > >     /* change the GID */
> > > @@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t us=
er, gid_t group)
> > >
> > >  quota_overrun:
> > >     spin_unlock_irqrestore(&newowner->lock, flags);
> > > +   spin_unlock(&key_user_lock);
> > >     zapowner =3D newowner;
> > >     ret =3D -EDQUOT;
> > >     goto error_put;
> > > --
> > > 2.43.0
> > >
> >
> > I double-checked this patch too given the concerns on 1/2 but nope, thi=
s
> > does not raise similar concerns as every critical section is strictly
> > related to ownership change.
> >
> > E.g., I can be sure that the granularity is where it should be and lock=
s
> > are actually needed in the first place.
> >
> > Thus, I'm still including this patch to my next PR, and drop the first
> > one.
>
> By dropping 1/2 I found out that 2/2 key.c becomes:
>
> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595..de63120c51ad 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -449,6 +449,7 @@ static int __key_instantiate_and_link(struct key *key=
,
>                         /* mark the key as being instantiated */
>                         atomic_inc(&key->user->nikeys);
>                         mark_key_instantiated(key, 0);
> +                       spin_unlock(&key_user_lock);
>                         notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>
>                         if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &=
key->flags))
> @@ -606,6 +607,7 @@ int key_reject_and_link(struct key *key,
>                 /* mark the key as being negatively instantiated */
>                 atomic_inc(&key->user->nikeys);
>                 mark_key_instantiated(key, -error);
> +               spin_unlock(&key_user_lock);
>                 notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>                 key_set_expiry(key, ktime_get_real_seconds() + timeout);
>
> This type of interleaving should never happen in a patch series.
>
> Please don't rush your changes like this in future.
>
> Br, Jarkko

Sorry for the mistake, I should have carefully verified that the tree
remained valid at each step of the series.

I will rework the locking on 1/2 to inspect if there might be any
unnecessary coverage, and verify each intermediate commit
independently before sending a revised version for the patch series.

Best regards,
Chengfeng
