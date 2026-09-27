Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D933DEE9
	for <keyrings@vger.kernel.org>; Sun, 27 Sep 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529600; cv=pass; b=qlf/HcbhwM6a2viHS8KC8Ihg1zOr7YyRf0gmzxjdOFL6kP2+NqfnAlRk/mtvH5b52WqQPTzKIC6frUaNkhX2kNKYLr7376OdtbYnZQRH9LE6ew1HsXmZH+iQiCSDdD9bm9J3G4G9eIEbyc6aGLLylzt1rQm59lmES/nPSXLKIZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529600; c=relaxed/simple;
	bh=NgU7t86W/VexiwqKV9fxVLNSEaHoaTI7MJusd6ZnYzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR8k5lpSADU2WAz48OPSNwYmIfRf+UdUGTrlMh0lz3WBJE2FnIJUDp0T0dzfthIap5M7NF1mh6osT6ysXHTCqKx2L+SPhrQwwK2GR85SKFKB1FmLftaAqANXD36WTu2HppaYk7rgxBOyeyo/r1IfGXc5gO+CnNHv4I3CzXyveGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN/dTztp; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN/dTztp"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fb4b2a3so86573a12.3
        for <keyrings@vger.kernel.org>; Sun, 27 Sep 2026 10:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790529596; cv=none;
        d=google.com; s=arc-20260327;
        b=WGvVPYLbCa0WRK9BF1RU/GbUSjWHOvVnhhU/jIdj6cPa3bq/yJIZRbGCWGFouxKAak
         rL04+pdXkrt583b+kA6LKIvDWXKaGMeJErqa6vVNih7KafSEH9XwsZXmcGBVjFI3ruiQ
         lcs8xFBDNrH6xnL+sRzmYN6dGOHl4D/SnUvlcJOmX5fCFxHzcY1cDk19b96CRTmO3e0U
         EVwaZlJzBosbUUqmti7d785UNyhTnvi4ZPzDU2OteGaH55SGqZlXlu8csqtY8o0aPfQC
         C1nbnhBUZuBXPh4mbpPjvMndKoC5yfuwZJA4mUZcvqcr4VIXl1n6XLSbBxwIsl9FqTrJ
         MQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/R4IpN8egmbt+t8Ci9l3zcVKOJVLWdh83YYmUmU9rXA=;
        fh=i5uIXVmZgPTOnNDS44PUjlLJBzkEuqLeD5PRmanQ+1o=;
        b=AYVhd1vK0crP27aEiX7yZYj9Pu1KTwd9N9ZnMkwcnm9RvFPXs0C3cG57gOBzXdpM9W
         DRz1BbYziyPO8f0LGgqQeevm5uwrcL1ur1muXwlcNyj3KHvaoD+e8kqeWO0k+YtvFvSW
         HAwS5CJwMuWn4MJtSifo6hdyUlP/BY2OdeJ+h9DP5JX3zqKdOKnq+lS/swMUPaitQxK1
         TO6IEy7hZWtlWjMi5N/puyH1mvfc7HAWfcHA8KIWukEavxp2GU1BlImjS6L/6+OnJ9tZ
         P1xVzP02o/sU9EAzoJHPfbXQxOft45vow+uRxvEZfc/5hIDjlbGhXDatBGMiHX/5B4Rc
         wuPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790529596; x=1791134396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/R4IpN8egmbt+t8Ci9l3zcVKOJVLWdh83YYmUmU9rXA=;
        b=JN/dTztp5uBkVnr6owRPG+oeELNoohat3/eUjTx6gvx9CdxgoF3JZth2R8/9CJJV/X
         Lki27GSbXucwze04slXd5e3AonvCAk0x8uHm+2Hk43pycy1aL8vXk4GFMQJqI28h/C4r
         TjtUuJlnwB7onadn0T3OLEZYnD5DEqEYVmM8Q78B/U2QCfLtc2JCGuYwLQrwILT703Du
         yY5KJcnwWtSX/MWqg2q8xkAJwXXMyvBiWlXoJ+5eF4p3aQDrFUcH/WJW0HBYOsClO9S0
         BWOSQZ7/JoLxZIZ4ocvWr13cxXcVqvVxZYerW42xk3p4011Ympib5kWh1G6pLABoq8Kg
         hCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790529596; x=1791134396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/R4IpN8egmbt+t8Ci9l3zcVKOJVLWdh83YYmUmU9rXA=;
        b=EYbPB46bY/kiiRmitpIOAbjP3b0ECrU/hX629N8+atPThxwWfAqWn/3Di5+GCPa7/g
         wUApdGeiNxGnKpeBz735kXUYGXOqEgCb5La62aa7Yo8hEAblj3QRtAdGSRjT9bEVS/pO
         r9whTpv4ZHUs9OThUuKPVmSGypnXgkylFQjB4NBulbn2g/PB2HSbnGLu4rFEWWD8eJMp
         SJnabV4f2nmA+92GakN8W/AsACzvksBaUuBV7z+gm2opazREj+ST1dLyb0ufwa+9GC0z
         AwTO230d63toMh6N0q1PrqPYIfdhBL68ydsQ+BXD6haxZ1NbJ7fdxTWwcHcB9QbclKMh
         cpaw==
X-Forwarded-Encrypted: i=1; AKwUvByBDyPlUtIzMpDPbNZkLrLRQavwonfgrZD4jXRiKH4L0kICgKCTPoLYQqBlvewFDxNyfVTOD6H5vg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6D1WVV6qHzY08UzAT1l1j7oSyxz1T5ZzWJYhMSl3l9YCTn8DG
	nViPT8i5ie+XTv5vUV895TdTP0orCK6MOsXgIfa31+ImlB/JS7fFAIPIvVatr2QLOEG3eeiHuo9
	P303pbb01U/3HlMScRjmQzr+FIQfYIbN0vgWLxTiWlvlh
X-Gm-Gg: AYBFou0xlEtKQNcDZJIA32RdruSz7bv5taOajn5LSDdID9zBMjuIrcE5qXuO0y6wWfw
	lXo938UTOdHmClvnEkgJkYpBX52ltFBS12v5cRG3hV0rhNf/TLzqEYMtVWE8Rw8Ft+5SbiEEpg9
	Da2Hv4f2+5pfO8AFq4RrwbNSNd9iaXRc2Adcs3bnTYjEwatvkZPx3qpcKIhYMJRKRX3micMZMEG
	1hVNxCe/27x6WEAhzdUIT9iNrr36kVdHHI4gaYEZKmrH7lUnFl0T7UTh4DPzXlU2+zru76C21pn
	4efSvGbGAHEEPnHdnwx/bU1WGvH8Q4eIjF5RhepGsHwsZsoGiK8uJXhg8l7K3H1Awq3uTTCGdor
	S10pkJHl2mIA=
X-Received: by 2002:a05:6402:13ca:b0:6aa:490e:5518 with SMTP id
 4fb4d7f45d1cf-6aae1fcf708mr7295949a12.2.1790529596172; Sun, 27 Sep 2026
 10:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904080940.575882-1-nicoyip.dev@gmail.com> <aqHhZO0GjMTOer4j@kernel.org>
In-Reply-To: <aqHhZO0GjMTOer4j@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 28 Sep 2026 01:19:44 +0800
X-Gm-Features: AclHuK8YMIA5n5DLx6saWD3JedHa-zp1toc5aC5wKE4OHA3Bf05WcoKKBxjw3MI
Message-ID: <CAAo+4rW_kT_GL_3cr8aSHkAM29yQQgNL4EJktfTirOi4nHwOOA@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Fix key_user use-after-free during ownership changes
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 6:44=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri, Sep 04, 2026 at 04:09:40PM +0800, Chengfeng Ye wrote:
> > keyctl_chown_key() replaces key->user and then drops the key's
> > reference to the previous key_user. Several paths access key->user
> > without any common synchronization with this replacement, including
> > the /proc/keys iterators, find_keyring_by_name(), quota accounting, and
> > key instantiation.
> >
> > This allows an ownership change to free the previous key_user while a
> > reader is still accessing it:
> >
> >   CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
> >   user =3D key->user
> >                                 old =3D key->user
> >                                 key->user =3D newowner
> >                                 key_user_put(old)
> >                                   kfree(old)
> >   uid =3D user->uid
> >
> > The same missing synchronization also can corrupt instantiated-key
> > accounting. KEY_LOOKUP_PARTIAL allows keyctl_chown_key() to change the
> > owner of a key while it is still being instantiated:
> >
> >   CPU 0 (instantiate)           CPU 1 (KEYCTL_CHOWN)
> >   atomic_inc(old->nikeys)
> >                                 observe KEY_IS_UNINSTANTIATED
> >                                 skip the nikeys transfer
> >                                 key->user =3D newowner
> >   mark key instantiated
> >
> > The increment remains charged to the previous owner. Quota reservation
> > can similarly select one owner for its quota limit and another owner
> > for the usage update, or access an owner that has already been freed.
> >
> > The existing locks do not provide common exclusion for these
> > operations. keyctl_chown_key() holds key->sem, key construction uses
> > key_construction_mutex, and the affected readers hold their respective
> > tree or list locks.
> >
> > Use key_user_lock to serialize access to key ownership. Hold it across
> > the accounting transfer and key->user replacement in keyctl_chown_key()=
.
> > Use the same lock while readers copy the owner's UID, while quota usage
> > is updated, and while the instantiated-key count and key state are
> > committed.
> >
> > key_user_lock already serializes final key_user removal, so an old
> > owner cannot be freed while one of these readers is accessing it.
> >
> > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's o=
wner")
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v2:
> > - Audit every user->uid occurrence and all direct key->user accesses.
> > - Take key_user_lock explicitly at each namespace-filtering reader inst=
ead
> >   of hiding the lock acquisition in an accessor.
> > - Serialize quota reservation and construction accounting with ownershi=
p
> >   changes while preserving the existing direct key->user accesses.
> > - Use the commit that introduced ownership changes as the Fixes target.
> >
> > Link: https://lore.kernel.org/keyrings/20260823170448.3856516-1-nicoyip=
.dev@gmail.com/ [v1]
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#se=
parate-your-changes
>
> I.e. no bundle commits. This unreviewable.

Thanks for the review. I have split the changes into two patches
and sent them as v3:

https://lists.openwall.net/linux-kernel/2026/09/27/734

Best regards,
Chengfeng
