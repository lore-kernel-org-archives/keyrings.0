Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8853D0DB
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000340; cv=pass; b=hkNqEfgP3oZP3yrqjRd39QAerqWaJ5MNZyXpako39hZAL9DoNd6uEg4X/2wEQLIICbIBbU4gzP3k2opqeEISAChxzAyozo4wyD1RLVTGMGNB6Bz+9nFvZojGJq7tRS7vnj36SrgGBbXL4ZkgahPy9WrmfPXvKJL7bJFXb//Lxtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000340; c=relaxed/simple;
	bh=hbHSPhq87+/pwYwNvx5gX2zfxPRsJyJzwGcwpxxTEbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FudMMKq0JFzw/P1sFMKycf8EKXOS+bLPFYcFBMpq7u5NdARP7ZPNtioWRsPLyWsFqLzwGx+pRnfw4I9yo5T8g3c4mqNEqy/2B0SnXzM4C3+jQn1kf1LpPs0fbs9z3A2z3E5cXJL7EMJ0/mPO9hD8spePLsqtyr5gbRJs1SGdb8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Qu1L4A; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Qu1L4A"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afdd46afe0so868832a12.2
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792000336; cv=none;
        d=google.com; s=arc-20260327;
        b=b0jNlhQSzNJ57is05cchG14JHzkTZTjys/WqgR6/qx/y9XFUev/H9jci3ksTkO/GoQ
         7fxDleiAR7pgML0kIDsAdECngdoEDkq8mirWBztY3tgQ1FcI65szSiCVoiJ5GnSmZl4t
         LzWUp5SdoQ0nzpM5cjinzZTxp1V682mbvhRxpqOrGPiApUEAXKkxqpy7TyFgylvhFLy5
         BUCiMV+WNDKpnHR+hQRn++lnHctunwH81+OBNDkVVhvTOhSzaRNIT+fTXw/Eem8Nk9de
         X3sRxXUjarkrDnjMOXwtICwbkmhEeDm44VHRXspk1gcDBJ/Xb1YNtK6E9HFEvVGcWdRE
         zynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        fh=Vvy/yD6uHW7ER/QoiZf9nBBsLQpM8XiYxLfN+smTU4A=;
        b=dWFS8M42K2UPfbsb+0E+q5mpwMRTNV6j0AyxI/rLCmayV43Xi45tCcKhn0DsCv4T5H
         g9GtY4Wu8kYJek1wwl5lcY0gmBVZ7bF9pQlButUVSs+2J78ALf3omXfSCaaQBdmMMtrg
         784cTW+lyH6nbKxiu5Rba2GtDyANNti3R3fl+yU5Pffp71p0PxbdWd80U4RmXTCwa/4l
         Ek+BM/39kS4CvfPFzhxoRj7mz492t/BiFSsr/J1JL9l0kU//T6bfvy+/1E1+el/9lZMJ
         e2KyCW4il1A61Q44z/FGTrWmmUK6yXqwHYtO3ptjRNrfLLo3cyiHm8tvUIXg8t8ZKaw/
         FJZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000336; x=1792605136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=R6Qu1L4AHJBuDACn4coyHjQUcnDafj/0vdancQ/EnPgGCGymLwW5yN7BGIb8tu4op9
         GM6DhSbKUn1RKLznNwv8otDYFe/HrSkHBsxMnC0dx3xlyM6pemKy5Lvyzn/Siy1OZn7Y
         9NlHfkHnFWqAW9bSdePJC56aeKpMsIe5LZJZQAjENpYq1V8KepoSzZcpUoUYwoeZOSwy
         JMSs4/jvpiIne23lCw6AkLphAae6zCfINStfEv3WeubyjoFELyK2UM7/c7BJz2eohVUh
         vDzturfzThHADm8teuq4PkDxmWb/sBVfHK5Z/ABbT5Tzi6qo5JSiAr7aujYldY4/6Mx4
         SHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000336; x=1792605136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=Aer/tWMqTFh5nOqKr3dFLW9iEGue1O8hRoMbl1jA0YYydadQxy4RhNmvG/BM0lxAMU
         A8Y7VedLIkca+aHvipbHBNqHWnzLgE4v/TMXwJ0PoCJRywNcNpS4qR+09zAADwinDLOj
         Ri9oeRhsF0xQ+W2CflSKkQu0OME3gZ2Iwo1HSmvq+BosGUgd4gruAuh3xH8FfwMO8C1z
         eSvc836iuWaUSKp2EvBjONqAQrzql7xLtrhpgjwYCRVBIFiogh1UttZj0MT8J35abdHa
         yXKaadlcyKzwa9HwqXqtj7J6BUFKYKf360KRQpEPYlHFo9KJ921XyFiqOdU0fNMZ55ZA
         2XFA==
X-Forwarded-Encrypted: i=1; AKwUvBymUkzR+DIrRM4M0pxAAMKoqsd9ZHMr/TNylWcKH09fLD7c2bbZkFwgGR8wyrTSj1e/PgJvov38zg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjIxG3nvaFGKcS0PurpNfmjoBlPGbksVN8OIyTCGqfH/5a41tM
	fJA8H7CVCHxTyrdxO8dMfVfVBw+qHikQWd4o6Gg0sjDaV9uFKymgYJ7dWPSo3hMQMAOvoP0HWxO
	/0LGs+B1mSx/dLS3M3Fe/vsfrJRjKPzE=
X-Gm-Gg: AYBFou1YPFv3l/RTVa9KTI8tpQEoC1PxekGVxCtTlMh73O4ZpK3ILC4Xx7lO53L5V4J
	7DZMBR51K+g9TYAFx0OuV55NcQvcbb36a8IOq+bdGh8AuhIEpL2J97uIcVmVhrvB0ZhxuEJvPsI
	UDot9xLg2RGfhDSBgQv3gMX2jTSOpLo2xnH31+e9+UjW3No3QYVateoH/H0Q1hufATKDKklpcaR
	snEr2CxerlyEkSEervx0kc8L9wZC3KGlRpgjuNfE73ieUWS8jnH7doGragW0IfpaY560ZJd6RdR
	CSoeX66JP72x+Hl1yF+tX6t37V1+1ssSpDXlQZotrbayWks00rLtD4SsiFKW3k5tCcIESx9xSh1
	Skycux08H
X-Received: by 2002:aa7:d496:0:b0:6b1:a51d:2091 with SMTP id
 4fb4d7f45d1cf-6b1a51d2173mr7110113a12.3.1792000335396; Wed, 14 Oct 2026
 10:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com> <as9otxVeOLbhkIMy@kernel.org>
In-Reply-To: <as9otxVeOLbhkIMy@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 01:52:04 +0800
X-Gm-Features: AclHuK-mF7f2-ToQFw5yb6eWZea95LJSk6oMoOQo82NHSzDQBf9ruJ97DzyUm-E
Message-ID: <CAAo+4rXGputXtxgkLLAtFSS=utgr=S=ajbqDFZV=jySZ1yz+sw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace filters
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jarkko,

On Wed, Oct 14, 2026 at 7:34=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, Oct 13, 2026 at 05:03:57PM +0800, Chengfeng Ye wrote:
> > keyctl_chown_key() replaces key->user under key->sem and drops the
> > reference to the previous owner after releasing the semaphore. Readers
> > which do not hold that semaphore can still be using the previous owner
> > when key_user_put() frees it.
> >
> > For example, namespace filtering in /proc/keys can race with chown:
> >
> >   /proc/keys reader                 keyctl_chown_key()
> >   user =3D key->user
> >                                     key->user =3D newowner
> >                                     key_user_put(old)
> >                                       kfree(old)
> >   read user->uid
> >
> > An earlier instrumented run reported:
> >
> >   BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
> >   Read of size 4 at addr ffff8881128abbc0 by task poc/88
> >   Call Trace:
> >    proc_keys_start+0x353/0x440
> >    seq_read_iter+0x25d/0x1190
> >    proc_reg_read_iter+0x19e/0x260
> >   Allocated by task 86:
> >    key_user_lookup+0x1b4/0x540
> >    keyctl_chown_key+0x3cc/0xbf0
> >   Freed by task 87:
> >    kfree+0x149/0x330
> >    keyctl_chown_key+0x7b0/0xbf0
>
> Last night I missed the text below.
>
> It is somewhat messy to the point that frankly I could not read it, or
> at least I did not understand it. Have you read it yourself?
>
> There is a whole eassay and I can only see that key->user can change
> unless key_user_lock is taken, and READ_ONCE() is required to pair with
> the writers.

That READ_ONCE() should be unnecessary, since key_user_lock now
serializes both readers and writers. I will double-check whether to
drop it.

> I don't understand what is going on down there, and what's your goal
> with it?

Yes, the messy commit message should be cleaned up before sending...
Sorry for that. Basically, it describes why the three `key->user` use
sites should be protected by the lock (because there's no
synchronization) and why the remaining access at other sites doesn't
need it (because other caller sites are synchronized). I will rephrase
the commit message to make it human-readable.


>
>
> >
> > Take key_user_lock explicitly while /proc/keys and find_keyring_by_name=
()
> > copy the owner's UID. find_ge_key() is the initial/seek lookup reached
> > by the reported proc_keys_start() fault; key_serial_next() applies the
> > same UID filter to subsequent entries. find_keyring_by_name() reads the
> > same replaceable owner when looking up named keyrings.
> >
> > key_serial_lock and keyring_name_lock protect these traversals but do
> > not exclude chown. Taking key->sem would sleep under those spinlocks.
> > The embedded key->user->lock cannot protect the dereference needed to
> > acquire it.
> >
> > key_user_put() already holds key_user_lock for the final reference
> > decrement and tree removal. A reader selecting an owner before removal
> > blocks its final release until the UID copy finishes. After removal,
> > the lock and reference-count ordering make the preceding owner
> > replacement visible, including when another task drops the final
> > reference. Mark the pointer loads with READ_ONCE() and the chown store
> > with WRITE_ONCE(); the existing lifetime locking provides the protectio=
n.
> >
> > Retain the quota-owner UID rather than substituting key->uid, since the=
y
> > may differ for thread keyrings.
> >
> > Other owner accesses already have lifetime protection. key_alloc() uses
> > a referenced owner before publishing the key. Final key_put() cannot
> > overlap chown, which holds a key reference. key_gc_unused_keys() handle=
s
> > unreferenced keys: serial-tree removal excludes /proc/keys readers, and
> > keyring_destroy() removes named keyrings under keyring_name_lock before
> > the owner reference is dropped. /proc/key-users already holds
> > key_user_lock during traversal. Quota reservation and instantiation nee=
d
> > the separate accounting serialization.
> >
> > Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> > Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GPT-6-Astra
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Move the quota-reservation and instantiation scopes from v3 1/2 to
> >   the complete accounting fix in 2/2; retain the combined lock coverage=
.
> > - Isolate the namespace-reader lifetime fix and make it independent of =
the
> >   accounting patch by relying on existing lookup/final-release locking.
> > - Pair READ_ONCE() pointer snapshots with WRITE_ONCE() in chown; explai=
n
> >   lifetime ordering and preserve the quota-owner UID filtering semantic=
s.
> > - Include analysis of of the other owner access sites in the changelog
> >
> > v3: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail=
.com/
> > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail=
.com/
> >
> >  security/keys/keyctl.c  |  2 +-
> >  security/keys/keyring.c |  7 ++++++-
> >  security/keys/proc.c    | 15 +++++++++++++--
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index d14ace88e529c..c89a4d6efed40 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -1039,3 +1039,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user=
, gid_t group)
> >               zapowner =3D key->user;
> > -             key->user =3D newowner;
> > +             WRITE_ONCE(key->user, newowner);
> >               key->uid =3D uid;
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 15bf4af8f2821..4a13749bc54cd 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name=
, bool uid_keyring)
> >  {
> >       struct user_namespace *ns =3D current_user_ns();
> >       struct key *keyring;
> > +     kuid_t uid;
> >
> >       if (!name)
> >               return ERR_PTR(-EINVAL);
> > @@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *nam=
e, bool uid_keyring)
> >        * grants Search permission and that hasn't been revoked
> >        */
> >       list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> > -             if (!kuid_has_mapping(ns, keyring->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(keyring->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (!kuid_has_mapping(ns, uid))
> >                       continue;
> >
> >               if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> > diff --git a/security/keys/proc.c b/security/keys/proc.c
> > index 4f4e2c1824f18..aa42ea4becec7 100644
> > --- a/security/keys/proc.c
> > +++ b/security/keys/proc.c
> > @@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_fi=
le *p, struct rb_node *n)
> >       n =3D rb_next(n);
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > -             if (kuid_has_mapping(user_ns, key->user->uid))
> > +             kuid_t uid;
> > +
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(key->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       break;
> >               n =3D rb_next(n);
> >       }
> > @@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, ke=
y_serial_t id)
> >       struct user_namespace *user_ns =3D seq_user_ns(p);
> >       struct rb_node *n =3D key_serial_tree.rb_node;
> >       struct key *minkey =3D NULL;
> > +     kuid_t uid;
> >
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > @@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p,=
 key_serial_t id)
> >               return NULL;
> >
> >       for (;;) {
> > -             if (kuid_has_mapping(user_ns, minkey->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(minkey->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       return minkey;
> >               n =3D rb_next(&minkey->serial_node);
> >               if (!n)
> > --
> > 2.43.0
> >
>
> Br, Jarkko

Best regards,
Chengfeng
