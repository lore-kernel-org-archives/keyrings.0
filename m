Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774618;
	b=dYUBJ6Bemp0X1yw2J7fAyBXbA1v4V42Tfq5FZaJQdLVrJ5x6w8nUr+wc8trPEi39ynXH
	 lknICi+3vpINVC0iPsCLdgpYYKy3fWP6hPfdyDOH5JwXqntos/ykrwPts7hmxhcmqPDVt
	 1a90jlLRi9wl06xz7dIKAL+Wwt2ckUTI51/0Ryf9QILemg7W00FlqcNPsSuY36nXi5lPA
	 2z1Uiw4v4TENG4yDqDyEsLn6w5rUS4qY3nI2OBk4qvyZSMIm6JiUjWidBrilvD2EfPk8E
	 PiBJ8WSOndlpRjd/J+uP5OmPG/xq6rK2uWezi0L7BgL/Ti9t5aWqVTwXqTTLGmfC9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OWlsnGp1ddm01pWLl7MfgYBEzGueAiwmpHDUhMI1vWQ=;
	b=V0zStxNiBEVV7ymFUp3wEOrTVX/pVHmsXq/iLgmkLgBbL9J0B86p9CmghI4FqccoRWsQ
	 VL5syy6sCXsGlU2BW12TA7I9fREwgBmOs+lSb4jSpxm8s1kvrzYprwCUhIBzNL+S4N2BU
	 Rc+j/76ZzK9HhI3W3sIGzWI2j+LSbWI/r2v1BMlRKSom9BtvBI6cNhN8sr8ofqIG/ti4s
	 D7YhZfWTabl+jFv2NtiI8PKupsCZB2oeVXfcAAvQMKmF6y281F3pt8E813i8xDeICWQFt
	 H2OEIjF339XJWsqWxqSMbfDMWQ6zCx0Jr7IKq8rOK+ooghKj0eMpekW3+s2W4U6Uk1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfH9nEs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CC606A31A;
	Fri, 23 Oct 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfH9nEs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26201F01828;
	Fri, 23 Oct 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792774618;
	bh=OWlsnGp1ddm01pWLl7MfgYBEzGueAiwmpHDUhMI1vWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfH9nEs7/bHzhrUk9EtdyZd6xlizw4pb8eqLkhuzpa9mRTutJcCBQ+H69OIrVOvSJ
	 J7fZrx3SkMtemT4bARnidbXjRFYiOnUCTjjGWejwha/65opTpsskPJVgKpQldEhSNV
	 IBIpZJC256/iP5bEyefSLoZWoH5BqMy4Y/qaWGcwI6iJ9eoHdkOop6TFO1tSU9kzv3
	 FabKSz9DFnRNkGTWcn+o+aiCuDBSBZs495qoYYE4zHsm4w3lC40ThzYaiemdET4TDI
	 sjHmGxiLzey3jr7UEja2OSoV3FDEKFOFSlZwfmwjL0MrRjiG1iQfzVpyysyuXWGXmL
	 ZaZj2bfOEOEnA==
Message-ID: <sashiko-outbox-182974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
In-Reply-To: <20261023-b4-setfcap-userns-v5-4-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-4-0620223be951@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:56:57 +0000
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
- [High] capabilities: unconverted v2 fscap bypass in cap_convert_nscap()
--

commit e902e2977ca7e209d89cc64e5a8e3a585eddb980
Author: Josef Bacik <josef@toxicpanda.com>

capabilities: limit fscaps to where CAP_SETFCAP reaches

This commit restricts writing file capabilities in cap_convert_nscap() so
that the root user named by a v2 or v3 security.capability xattr (both as
seen through an idmapped mount and on the underlying filesystem) cannot be
uid 0 in an ancestor user namespace beyond task_ns->setfcap_level.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 8a9d998b18972..3551ce9b046ad 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -216,6 +216,29 @@ bool cred_may_setfcap_userns(const struct cred *cred=
, struct user_namespace *ns)
>  	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
>  }
> =20
> +/**
> + * cap_root_level - Find the topmost namespace in which a kuid is the ro=
ot user
> + * @kuid: The kuid to look for
> + * @ns: The user namespace to start from
> + *
> + * Return: the lowest ->level among @ns and its ancestors in which @kuid=
 is
> + * uid 0, which is how far up file capabilities with that root user are
> + * honoured; INT_MAX if there is no such namespace.
> + */
> +static int cap_root_level(kuid_t kuid, struct user_namespace *ns)
> +{
> +	int level =3D INT_MAX;
> +
> +	for (;; ns =3D ns->parent) {
> +		if (from_kuid(ns, kuid) =3D=3D 0)
> +			level =3D ns->level;
> +		if (ns =3D=3D &init_user_ns)
> +			break;
> +	}
> +
> +	return level;
> +}
> +
>  /**
>   * cap_settime - Determine whether the current process may set the syste=
m clock
>   * @ts: The time to set
> @@ -671,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap=
, struct dentry *dentry,
>  		return -EINVAL;
>  	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
>  		return -EPERM;
> -	if (size =3D=3D XATTR_CAPS_SZ_2 && (idmap =3D=3D &nop_mnt_idmap))
> -		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
> -			/* user is privileged, just write the v2 */
> -			return size;
> +	/*
> +	 * A v2 xattr belongs to the root user of the filesystem's namespace,
> +	 * which may be the root user of ancestors of our namespace as well.
> +	 * Only write it unconverted if that root user is within reach, the
> +	 * checks below handle everything else.
> +	 */
> +	if (size =3D=3D XATTR_CAPS_SZ_2 && idmap =3D=3D &nop_mnt_idmap &&
> +	    ns_capable(fs_ns, CAP_SETFCAP) &&
> +	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=3D
> +	    task_ns->setfcap_level)
> +		/* user is privileged, just write the v2 */
> +		return size;

[Severity: High]
What happens in cap_convert_nscap() if uid 0 is not mapped in fs_ns when
writing a v2 capability xattr (size =3D=3D XATTR_CAPS_SZ_2) on a non-idmapp=
ed
mount (idmap =3D=3D &nop_mnt_idmap)?

Unlike the v3 conversion path further down in cap_convert_nscap(), which
checks vfsuid_valid(vfsrootid) and uid_valid(rootid) before calling
cap_root_level(), this v2 fast-path passes make_kuid(fs_ns, 0) directly to
cap_root_level() without checking uid_valid().

When uid 0 is not mapped in fs_ns, make_kuid(fs_ns, 0) returns INVALID_UID.
In cap_root_level(INVALID_UID, task_ns), from_kuid(ns, INVALID_UID) returns
(uid_t)-1 for every namespace up to init_user_ns, so cap_root_level() retur=
ns
INT_MAX. Because INT_MAX >=3D task_ns->setfcap_level is always true,
cap_convert_nscap() returns size and writes the unconverted v2 xattr.

For example, if a task without CAP_SETFCAP unshares a user namespace
(setting setfcap_level to 1) and maps only a non-zero UID (or creates an
unmapped child user namespace and mounts a tmpfs in it), make_kuid(fs_ns, 0)
is INVALID_UID. Wouldn't that allow the task to write an unconverted v2
security.capability xattr on the tmpfs inode, which could then be honoured
through an overlay mounted in init_user_ns, or honoured if fs_ns->uid_map is
later written to map uid 0? And when task_ns =3D=3D fs_ns has no uid 0 mapp=
ing,
writing a v2 xattr writes an unconverted v2 xattr instead of falling through
to rootid_from_xattr() and failing with -EINVAL.

Should the v2 check verify uid_valid(make_kuid(fs_ns, 0)) (or should
cap_root_level() reject !uid_valid(kuid)) before allowing the unconverted v2
xattr to be written?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-b4-setfcap=
-userns-v5-0-0620223be951@toxicpanda.com?part=3D4
