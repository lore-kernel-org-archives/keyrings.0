Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086712;
	b=vlB7t+E1hf1IkDbeBrORpQlrfGLt2UDFzzBVWVJCVCJdYVDPpZFy30e0rKstbMXk4exe
	 JpNPzFoKsYHUdII8vDg/hR/5pHBIneP/txvjrNokCdbyzD21MTngjA2JOZ8mkihfC41mn
	 Z2BVGs9zI646cqrXvO09VEFIJFMI1MsEmXm6hp3/ozJ+YzVLnL/9fpxVIqteYrslQkNJR
	 N01zGmA4Zyom3rWQ9BAzmP9gyzKWv8t10HHTLLAVZZv+Mmohkx1rrCOt2XHa+8wOLecgF
	 Vfg1fYf3hZys3lou9lDH3OSiloB2Y3KN9oYzwiQH32dXfKjdFeURSUpsr3X+4GMiXdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LCOapwdiJ/mxQK1vHFKgpgThzsZ2mfZKj0yvw8rC9Fs=;
	b=i4PNWA5UKAkR/5y3FuSXOLh7LSMdS+lyonT1EBMZjmiKOZ+W+eje2W9LYSilEt1YX5sI
	 iIE2Fvx5mFhygVnflDKvi3dSb2qncCIbUG/w+lL3iWF11I8RTVNY2n8snyx+wb+4fvW3S
	 NvOCe3lbsi0JmAWI/Pt6FeBYDr0baQdM0BymKhnuY2BnFmewXY8/g6rNoUsYNCa8hC4xi
	 HSGLX2nPeAHldsU05btHEsvFJ9+iLfeZo1ija3vZ6bZPuNJLMotLfXBICcIIISFHsyrOL
	 H3jdeG64C1/T0Rl43jOu/IPeQQlutFAKkO/XYZpPsUy8aWpygETDRAYE0dAx/2I5cCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrh0CvRG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C9606A320;
	Thu, 19 Nov 2026 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrh0CvRG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF21F000C7;
	Thu, 19 Nov 2026 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086711;
	bh=LCOapwdiJ/mxQK1vHFKgpgThzsZ2mfZKj0yvw8rC9Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrh0CvRGat3ns3SUcUqNHA2ku+OTgsog/fWII9YD65VL3zrd/DyiC9XTMepZCCZJW
	 Gg2RsvMHhf7swE+80rfO3SzFBzpsLZFYroP9niCbVw+cMMIe5EV9twSYRYZt1wIm/+
	 FDnZviWS95SSK99JrQA3akeqKG7qQrCiQ05WEPS/jkn5dSJt692uSbOdyRc/tX/hXh
	 6S21LwUWLa6O0fBnQmYh+HG63fOdUKfHItZOaaKrVWvlKAJhAOMHF0O0iujX3UMVe3
	 sUQgwlJF4ujO6hIotmfcHCSPbtCh84UKL5Dac7at48R+tPOdbJuNR4U736jQfUe6H4
	 xvgcHHzFi3l4w==
Message-ID: <sashiko-outbox-223014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for
 user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hallgrimur H. Gunnarsson" <halg@google.com>, "Christian Brauner" <brauner@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, "Andy Lutomirski" <luto@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, "Jonathan
 Calmels" <jcalmels@3xx0.net>, "Jann Horn" <jannh@google.com>,
 =?utf-8?b?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>, "KP Singh" <kpsingh@kernel.org>, "Casey
 Schaufler" <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
In-Reply-To: <20261119104208.782900-2-halg@google.com>
References: <20261119104208.782900-1-halg@google.com>
 <20261119104208.782900-2-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 11:11:50 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] userns: cap_ptrace_access_check() denies owner access without
  CAP_SYS_PTRACE
--

commit e4e71a2ec01bd6f7552fbbff2f1b525d5dbf74f6
Author: Hallgrimur H. Gunnarsson <halg@google.com>

userns: introduce capability bounding set for user namespaces

This commit introduces a per-user-namespace capability bounding set
(user_ns->cap_bset) and a per-credential userns capability set
(cred->cap_userns) controlled via prctl(PR_CAP_USERNS) and
SECBIT_CAP_USERNS_STRICT.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index d47ab30223435..ddac8e9176808 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -88,11 +88,15 @@ static inline int cap_capable_helper(const struct cre=
d *cred,
>  		if (ns->level <=3D cred_ns->level)
>  			return -EPERM;
> =20
> -		/*=20
> +		/*
>  		 * The owner of the user namespace in the parent of the
> -		 * user namespace has all caps.
> +		 * user namespace has all caps within the owned namespace's
> +		 * bounding set, as long as it does not exceed the caller's
> +		 * userns capability ceiling.
>  		 */
> -		if ((ns->parent =3D=3D cred_ns) && uid_eq(ns->owner, cred->euid))
> +		if (ns->parent =3D=3D cred_ns && uid_eq(ns->owner, cred->euid) &&
> +		    cap_issubset(ns->cap_bset, cred_userns_bset(cred)) &&
> +		    userns_has_cap(ns, cap))
>  			return 0;
> =20
>  		/*

[Severity: Medium]
Does bounding implicit owner capabilities by userns_has_cap(ns, cap) break
cap_ptrace_access_check() and cap_ptrace_traceme() for a parent namespace
owner when CAP_SYS_PTRACE is excluded from the child namespace's cap_bset?

When an unprivileged task lowers CAP_SYS_PTRACE (or uses
PR_CAP_USERNS_CLEAR_ALL) before creating a child user namespace,
cap_ptrace_access_check() skips the capability subset check because
cred->user_ns !=3D child_cred->user_ns and falls back to
ns_capable(child_cred->user_ns, CAP_SYS_PTRACE):

security/commoncap.c:cap_ptrace_access_check() {
    ...
	if (cred->user_ns =3D=3D child_cred->user_ns &&
	    cap_issubset(child_cred->cap_permitted, *caller_caps))
		goto out;
	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
		goto out;
	ret =3D -EPERM;
    ...
}

Because CAP_SYS_PTRACE is not in child_cred->user_ns->cap_bset,
ns_capable() now returns false even when the child task has an empty
cap_permitted set or only capabilities covered by the owner's userns
ceiling.  The parent owner is then denied ptrace_may_access() and
PTRACE_TRACEME on its own same-UID child tasks in that namespace, breaking
PTRACE_ATTACH, opening /proc/<child>/ns/*, setns(pidfd, ...), and
pidfd_getfd().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119104208.7829=
00-1-halg@google.com?part=3D1
