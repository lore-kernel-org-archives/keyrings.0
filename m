Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695807;
	b=09lMODuByU+IJ9jVLqxkLdWctopCL58f2HHq5b+fopoqvUiAsP0BJ/uzVTgf6s8XHuag
	 zlm37vGlIw4pwYjUt/6x1a20UV5JaeO13xwHtQJpxG6TX904is8tE492uqHFfWwrgk9Xg
	 bNNlKeUY5bdKrfDkRxynNYnHWVjXHGEFZ0XzRz5DvnQ1NGHzyA6ykmC8Ga0wKomOeJYSb
	 aUCRI2BK1wRZLhO2aXUSvabI5t+AThpU38SnqBq6EMw787y9Twy+8jCgJqpmYHE7Jqhj4
	 bD/agIug0PgFzs5jhrLNEOzEbslfvzba8b/M07zYPyhq8pZuf6hV71MGfVFirHr72/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dI7qSQ1uZfZ0GzGE04Pdj6ATzE4VXqhOXdgkqy67juo=;
	b=orvbyWcnJJcxj1jkQUpPzYPRNv3Nr0LcbvrKJK82amA32/r9/l6+Dur37EI5uZOr2D4W
	 Pfw7/9gwNCNwVBZ8wqUuoIJFlWCIIAF8e1dMMLFe+X6OQyRRjpNNyd/mNfJw6iVHNlysy
	 wmTsZvt8wMQH8Rp1UixTbcoAJSTxBVTYCMxykVxH/4TVVyx2bfq9qqTxVtrN40t5XBcSC
	 EnLHOKyxDVUMWakNK1X/Ehwfnuu/3G9fPVTHi4A39QmA78yEUsFy1iCXj8zfOwcB4uLiG
	 DluhiJ3FSHEHPvNaE6T4YqjK0bS0EclVVfAyud70tqtvXz7YjbDUb3V69rjzwIc5dqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMfGtfRk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB22606A31A;
	Thu, 22 Oct 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMfGtfRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5521F01828;
	Thu, 22 Oct 2026 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695806;
	bh=dI7qSQ1uZfZ0GzGE04Pdj6ATzE4VXqhOXdgkqy67juo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMfGtfRk5iJ+4eRkdUSjgGpb0zihR8urPOXi6LjjeNwHTyXJ8pJEivX41uGfm8aXe
	 RXaReqBtKtVfm/Ehs0/oXldzV0BcBYHflb1Pwn+0sl1qolXXkR+sGuZLaKUSOxcdgI
	 NEX7Pa5nVLdRWPNaFPZMzgCoiQ7FVrSnrElaJnfcMwoG1LxxLXTdcvMX7mbOl8+4cF
	 59UE7zwyfLlGfCcHBZCuQHUpyPaX7jqEM+VupPHxOKDd22DupN49pdBbVHmFCz0POn
	 qgSFv4RBd+ZAWcld9X+MzZwhScbue1KqQwjsXCzDTjgtyffpUfaqfYDMY+Gk0exggO
	 kjt8TxWYErhWg==
Message-ID: <sashiko-outbox-181948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, "Bradley
 Morgan" <brads@mainlining.org>
In-Reply-To: <20261022-b4-setfcap-userns-v4-3-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
 <20261022-b4-setfcap-userns-v4-3-88aa0ffaa08f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:03:25 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] userns: verify_root_map() misses ancestor root mapped to non-zero =
parent UID
--

commit 768466ca2ab242701f21cc059dcec4536bf3c7d0
Author: Josef Bacik <josef@toxicpanda.com>

userns: check the opener and the writer before mapping uid 0

This commit updates verify_root_map() to check both the opener of the uid_m=
ap
file and the task performing the write when mapping parent uid 0. It also a=
dds
cap_root_level() to verify that both tasks have CAP_SETFCAP reaching the
topmost ancestor namespace that shares the parent's root user.

> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 7bd3692c2f3eb..f948cf31ecdfd 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c

[ ... ]

> @@ -897,7 +898,7 @@ static bool verify_root_map(const struct file *file,
>  			    struct user_namespace *map_ns,
>  			    struct uid_gid_map *new_map)
>  {
> -	int idx;
> +	int idx, level;
>  	const struct user_namespace *file_ns =3D file->f_cred->user_ns;
>  	struct uid_gid_extent *extent0 =3D NULL;
> =20
> @@ -915,24 +916,36 @@ static bool verify_root_map(const struct file *file,
>  	if (!extent0)
>  		return true;
> =20
> +	/* The parent may in turn share its root user with its ancestors. */
> +	level =3D cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);

[Severity: High]
Can an ancestor namespace's root user be mapped into map_ns without passing
this check if it is mapped to a non-zero uid in map_ns->parent?

In proc_uid_map_write() -> map_write() -> new_idmap_permitted() ->
verify_root_map(), the loop in kernel/user_namespace.c:verify_root_map()
only searches new_map for an extent with lower_first =3D=3D 0 and then chec=
ks
make_kuid(map_ns->parent, 0):

	for (idx =3D 0; idx < new_map->nr_extents; idx++) {
		if (new_map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
			extent0 =3D &new_map->extent[idx];
		else
			extent0 =3D &new_map->forward[idx];
		if (extent0->lower_first =3D=3D 0)
			break;

		extent0 =3D NULL;
	}

	if (!extent0)
		return true;

	/* The parent may in turn share its root user with its ancestors. */
	level =3D cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);

Unlike setfcap_top() in security/commoncap.c, which walks all ancestors
p =3D ns->parent and checks make_kuid(p, 0), verify_root_map() assumes an
ancestor's root user can only appear at uid 0 in map_ns->parent.

However, an ancestor p's root user make_kuid(p, 0) (for example,
KUIDT_INIT(0) from init_user_ns) can be mapped to a non-zero uid such as
1000 in ns1 =3D map_ns->parent (via "1000 0 1" or "0 2000 1\n1000 0 1" in
ns1->uid_map).

When a child namespace ns2 (map_ns) of ns1 is then mapped with "0 1000 1",
extent->lower_first is 1000 rather than 0, so verify_root_map() sees
!extent0 and returns true without checking CAP_SETFCAP or setfcap_level for
either the opener or the writer. Similarly, if "1000 0 1" is also included
when uid 0 in ns1 is KUIDT_INIT(2000), cap_root_level(make_kuid(ns1, 0), ns=
1)
only checks down to ns1->level rather than init_user_ns at level 0.

In new_idmap_permitted(), the unprivileged single-extent self-mapping path
then allows writing "0 1000 1" without CAP_SETUID or CAP_SETFCAP:

	if ((new_map->nr_extents =3D=3D 1) && (new_map->extent[0].count =3D=3D 1) =
&&
	    uid_eq(ns->owner, cred->euid)) {
		u32 id =3D new_map->extent[0].lower_first;
		if (cap_setid =3D=3D CAP_SETUID) {
			kuid_t uid =3D make_kuid(ns->parent, id);
			if (uid_eq(uid, cred->euid))
				return true;
		}

Even with the subsequent commit in the series ("capabilities: limit fscaps
to where CAP_SETFCAP reaches"), if ns2 was created by a task in ns1 with
CAP_SETFCAP (so ns2->setfcap_level =3D=3D 0 and ns2->owner =3D=3D KUIDT_INI=
T(0)), a
task in ns1 with euid =3D=3D KUIDT_INIT(0) that lacks CAP_SETFCAP can open
/proc/<pid>/uid_map (or receive the open fd) and write "0 1000 1". This
maps KUIDT_INIT(0) as uid 0 in ns2 while ns2->setfcap_level =3D=3D 0, allow=
ing
tasks in ns2 to pass cap_convert_nscap() and write security.capability
xattrs valid in init_user_ns.

Should verify_root_map() check whether any extent in new_map maps a kuid
that is uid 0 in any ancestor namespace, and compute the minimum
cap_root_level() across all mapped ancestor root users?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-setfcap=
-userns-v4-0-88aa0ffaa08f@toxicpanda.com?part=3D3
