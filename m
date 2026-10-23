Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775039;
	b=ErcVmZUP8c65EWQSS7oseDIaTbOpy5zCft4SLJrfOHZsKD1Beem+Iu8EZVSu8zUOLThc
	 Xujq7Tb/YM8S34yYrNFDmnFnmVxEzfp/4lEZjAA31miZAJomq/kx0hTBtJ8E0yYygOcar
	 RjrWd5HiceLT0xXQMh1ZzscwfLW+GDIl0tRBcRIzQcTvd+KQZojhP7C5v/1jDSlh3WJb0
	 9+Q+pVwupIWNblUfr6vU6LaWzeBzmhnnLgR2iUaZ3MGCymUwGwYpiNbN6ClM9T/GxaAMS
	 cnSJXCD+Nuz3a1SpJX6dJOwnbTgoS2m89yS1kkXc7E07jOLjL82lTVOvI3qCjWJEUgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZCC5JOrUNQMIw+oFYvhFNHsJxczmFNPdzGDQMP8ys10=;
	b=yGEGLdloVRe8nelKX8cT26QnZGS+xDFtQeXRk9+H22aDqnahS34O+bT1dEbIGPSMl2wz
	 zI/756iQ8FkHtAQ9T3KM91ujzcgvdm4pUovEurrzyUCBoPGuxkdQpj/tkcqr8F9OR53Wi
	 615Qg3r8Oanu50ygdTuFj48XXxRVDENKkWjoX/l4pgrU5obDC8zk0NFkAWa/CBfRf2dkI
	 HhoaHVtdJ6o+sapSR1NBQTFBxndYVPzRTw+zkBl3WoQfqOlf++eMKsFXPEYQPYGUrdtGd
	 Kauf2UrfaS6j/KtFSL94iM2+wOxNH4VXgoveUmoh1X85YyhY54ezZa+i31dDHie/vCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eB1cnVco;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB3606A323;
	Fri, 23 Oct 2026 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eB1cnVco
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169491F01828;
	Fri, 23 Oct 2026 17:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792775038;
	bh=ZCC5JOrUNQMIw+oFYvhFNHsJxczmFNPdzGDQMP8ys10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eB1cnVcoJHwz3c3qlpp0xuDwmwy98GL2MrdJOudff26jviK7zMI3W5FT11p58oH/b
	 U6V6O5R4TRMH11ym6Fnrj8jkDQAyQpO0FbogsoYkG3nsiutQ2/e/4VtIR0LcPAeXHw
	 lfOyeG/Dh5LAbYRzCgocIlGIej0n0JVtRhsO8s/BQh5LZfWBBE9+PeYmhkS1LTGFZ2
	 uh+ON9bOiZzw+4XVZDwCER7jNKnXN0svhJl2XikDiWUMM0xWRDCai8Q+tN3BygJzVK
	 oesh/gTJZlk+RfpLwMnuZ5YDaE7yYB1zelnQFLJMSd92yt42I+AN0pnwg1wsy1KmgR
	 mreXqIZcm95DA==
Message-ID: <sashiko-outbox-182977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
In-Reply-To: <20261023-b4-setfcap-userns-v5-3-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-3-0620223be951@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:03:57 +0000
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
- [High] userns: missing CAP_SETFCAP check in verify_root_map() for tasks i=
n map_ns
--

commit 715d4f4455aa94fb0eaba838f8aa378efb3afe54
Author: Josef Bacik <josef@toxicpanda.com>

userns: check the opener and the writer before mapping uid 0

This commit updates verify_root_map() to find the topmost ancestor whose ro=
ot
user is included in a new uid_map and checks that both the file opener and =
the
writer hold CAP_SETFCAP reaching that ancestor's level.

> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 7bd3692c2f3eb..661d7e9b72d56 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c

[ ... ]

> @@ -897,42 +937,40 @@ static bool verify_root_map(const struct file *file,
>  			    struct user_namespace *map_ns,
>  			    struct uid_gid_map *new_map)
>  {
> -	int idx;
>  	const struct user_namespace *file_ns =3D file->f_cred->user_ns;
> -	struct uid_gid_extent *extent0 =3D NULL;
> -
> -	for (idx =3D 0; idx < new_map->nr_extents; idx++) {
> -		if (new_map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
> -			extent0 =3D &new_map->extent[idx];
> -		else
> -			extent0 =3D &new_map->forward[idx];
> -		if (extent0->lower_first =3D=3D 0)
> -			break;
> -
> -		extent0 =3D NULL;
> -	}
> +	int level;
> =20
> -	if (!extent0)
> +	level =3D map_root_level(map_ns->parent, new_map);
> +	if (level =3D=3D INT_MAX)
>  		return true;
> =20
>  	if (map_ns =3D=3D file_ns) {
>  		/* The process unshared its ns and is writing to its own
>  		 * /proc/self/uid_map.  User already has full capabilites in
>  		 * the new namespace.  Verify that the parent had CAP_SETFCAP
> -		 * when it unshared.
> +		 * when it unshared, as far up as those root users go.
>  		 * */
> -		if (file_ns->setfcap_level >=3D file_ns->level)
> +		if (file_ns->setfcap_level > level)
>  			return false;
>  	} else {
>  		/* Process p1 is writing to uid_map of p2, who is in a child
>  		 * user namespace to p1's.  Verify that the opener of the map
>  		 * file has CAP_SETFCAP against the parent of the new map
> -		 * namespace */
> -		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
> +		 * namespace, and as far up as those root users go.
> +		 */
> +		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
> +		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
>  			return false;
>  	}
> =20
> -	return true;
> +	/* The file may have been handed to someone else since it was opened,
> +	 * so the same goes for the process that is doing the write.
> +	 */
> +	if (map_ns =3D=3D current_user_ns())
> +		return map_ns->setfcap_level <=3D level;
> +
> +	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
> +	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
>  }

[Severity: High]
When a task is in map_ns (so map_ns =3D=3D file_ns for the opener or
map_ns =3D=3D current_user_ns() for the writer), does checking only
map_ns->setfcap_level <=3D level allow a task that has dropped CAP_SETFCAP =
in
map_ns to still map the ancestor root user?

For example, if a process running as uid 0 with CAP_SETFCAP in init_user_ns
calls unshare(CLONE_NEWUSER), create_user_ns() sets map_ns->setfcap_level t=
o 0.
Inside map_ns (before uid_map is written), two cases can occur:

1. Task A opens /proc/self/uid_map and passes the descriptor (by fork or
   SCM_RIGHTS) to Task B in map_ns, which has dropped CAP_SETFCAP and all
   other capabilities via capset().
2. A task in map_ns drops CAP_SETFCAP via capset() while keeping
   CAP_SYS_ADMIN, and then opens /proc/self/uid_map itself.

When the task without CAP_SETFCAP writes "0 0 1" through:

  proc_uid_map_write()
    -> map_write()
      -> new_idmap_permitted()
        -> verify_root_map()

map_write() only checks file_ns_capable(file, map_ns, CAP_SYS_ADMIN) on the
opener, and new_idmap_permitted() takes the single-extent unprivileged bran=
ch
which only checks uid_eq(ns->owner, cred->euid):

kernel/user_namespace.c:new_idmap_permitted() {
	if (cap_setid =3D=3D CAP_SETUID && !verify_root_map(file, ns, new_map))
		return false;

	if ((new_map->nr_extents =3D=3D 1) && (new_map->extent[0].count =3D=3D 1) =
&&
	    uid_eq(ns->owner, cred->euid)) {
		u32 id =3D new_map->extent[0].lower_first;
		if (cap_setid =3D=3D CAP_SETUID) {
			kuid_t uid =3D make_kuid(ns->parent, id);
			if (uid_eq(uid, cred->euid))
				return true;
		}
}

Because verify_root_map() only checks map_ns->setfcap_level <=3D level when
map_ns =3D=3D file_ns and when map_ns =3D=3D current_user_ns(), the write s=
ucceeds
even though the task dropped CAP_SETFCAP. Once "0 0 1" is installed in
map_ns->uid_map, make_kuid(map_ns, 0) becomes KUIDT_INIT(0) instead of
INVALID_UID, allowing the task in map_ns to call execve() and regain full
capabilities (including CAP_SETFCAP) via handle_privileged_root() in
security/commoncap.c.

Note that cap_setfcap_level() in security/commoncap.c already handles a cred
whose user_ns is the target namespace by checking whether CAP_SETFCAP is st=
ill
raised in cred->cap_effective before returning cred->user_ns->setfcap_level:

security/commoncap.c:cap_setfcap_level() {
	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT) !=3D 0)
		return ns->level + 1;

	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
		return cred->user_ns->setfcap_level;

	/* All we have is that we own a child of our namespace. */
	return cred->user_ns->level + 1;
}

When map_ns =3D=3D file_ns (or map_ns =3D=3D current_user_ns()), should
verify_root_map() check file_ns_capable(file, map_ns, CAP_SETFCAP) and
cred_setfcap_reaches(file->f_cred, map_ns, level) for the opener, and
ns_capable(map_ns, CAP_SETFCAP) and
cred_setfcap_reaches(current_cred(), map_ns, level) for the writer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-b4-setfcap=
-userns-v5-0-0620223be951@toxicpanda.com?part=3D3
