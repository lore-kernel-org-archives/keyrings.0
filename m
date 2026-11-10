Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353736;
	b=VtobI+PwkuolVHJ9zUItd6zaupRcqQ9/xHhA1TwQKtFBDPZqRdlf4+CJup4lvDHGuwQn
	 88yaRL2buR8iTXAXB9X/qRdr7ir+TniOneDJ5KLEhcghQWSjMF02tldGQZ3yuPhLZbmSr
	 eK7J69OwxV4BKhlnRIgdcFXlFF5BDptBCzGWgGxSVSHgRnHqZjjPkHUbH2KKCqDvOz7mD
	 I8DYDH8pUg/jOTdDOGnGeVWRshrvDAQWti8mTXEE7aBueJOtcV4AEvA4gOkpbU4ETHwd5
	 DTYMnLJZt5XcYyzVWwqMCgSyo91i6gNIy20mFwdYr9QZAYz145U2/eDM525RDM5vdJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HqgtO8wh9AydBisW0XsX+FuFfiDMnuAaKUkPHp6YJMQ=;
	b=pyd9Cg7xalOt1OX+/+1tg8NJmpZZ+QoNFA0ZC7NC0jdsCT8CcBveqQuaa7ebU/ntIp08
	 LdvzkY3xz8DwRpiUilxbyRN6Xj3Bg20ZiK3Fe5brlMKDAVLr9xxrcCi+YcqSYzT+BgeTb
	 FJpchpyWFOZ1uYteikj1KZzSf9/eg/lqEODNrEZgVLunLwCCnwrd7vyKkf3nlR3kNLwtb
	 7h/2GUSn901lFIhXegh7JkfeWDOXZOQWcEBV57XR0pf56erBQs0wONcMAYmxy3NHb3hXX
	 TgMma2+8YZP/HD85ZCJoe9Mb2mjQNs/LZdnLi5Gw5ZOXEv4cE2l/rHznCV4s1D2EHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGX+ek3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7320606A325;
	Tue, 10 Nov 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGX+ek3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2247A1F0093C;
	Tue, 10 Nov 2026 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353735;
	bh=HqgtO8wh9AydBisW0XsX+FuFfiDMnuAaKUkPHp6YJMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGX+ek3Z69BZS8M39BO42a70dFGLLoYGIwOeyyz+N+MUM9WBBhgMjYVY36JhENP35
	 5d5RoPXwFTYoDEqh0ip4XlUy8uThetwEd34WT0aiYzz/d1rNnnnCsSy7K9DeC4/1KW
	 0TCii9JIQtuIDSwTM/8LnrB3Xex0cSou0cwjYaaI1JXiyfCM2Sbu8qPPvV1WsHZ7Uu
	 Ea9ByepgUEw3Z88ngogMlkT0hY82ibO8nbpNTRv1VB1gzN56Gy/kmeYItcBxn4oHkG
	 BYgv012s5ly5+2MhgRhfWIxiVIafXbbtJndisDqzF4xkJ4yCNN5pqcYmgCP9Iyh2ws
	 A87/lctqW+krw==
Message-ID: <sashiko-outbox-207942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, "Shuah
 Khan" <shuah@kernel.org>, "Bradley Morgan" <brads@mainlining.org>
In-Reply-To: <20261109-b4-setfcap-userns-v9-2-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
 <20261109-b4-setfcap-userns-v9-2-0d3f00976ce2@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:35:34 +0000
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
- [High] capabilities: bypass of cap_ptrace_borrows_setfcap() via target
  task
--

commit 13b53bed949001ddba3ad97bb6d9dfe1459dfe6f
Author: Josef Bacik <josef@toxicpanda.com>

capabilities: don't let ptrace borrow CAP_SETFCAP

This commit denies cross-namespace PTRACE_MODE_ATTACH and PTRACE_TRACEME
when a tracer lacking CAP_SETFCAP and CAP_SYS_PTRACE attempts to trace a
target task that holds CAP_SETFCAP or can regain it from its bounding set
in a user namespace where setns() would refuse the tracer.

Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hall=
yn.com/

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 0ece141c68a69..d550a4e5d36a3 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -176,14 +176,35 @@ int cap_settime(const struct timespec64 *ts, const =
struct timezone *tz)
>  	return 0;
>  }
> =20
> +/*
> + * See cred_borrows_setfcap().  Within one namespace the usual rules app=
ly: a
> + * tracer with CAP_SYS_PTRACE can take control of tasks with CAP_SETFCAP
> + * anyway.  A target that still has CAP_SETFCAP in its bounding set gets=
 it
> + * back from an execve() the tracer can make it do.
> + */
> +static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
> +				       const struct cred *child_cred)
> +{
> +	if (cred->user_ns =3D=3D child_cred->user_ns)
> +		return false;
> +	if (!cap_raised(child_cred->cap_permitted, CAP_SETFCAP) &&
> +	    !cap_raised(child_cred->cap_bset, CAP_SETFCAP))
> +		return false;
> +	return !cap_raised(cred->cap_permitted, CAP_SYS_PTRACE) &&
> +	       cred_borrows_setfcap(cred, child_cred->user_ns);
> +}

[Severity: High]
Can a tracer still make the target task obtain or exercise CAP_SETFCAP
over the tracer's root user when CAP_SETFCAP is cleared in both
child_cred->cap_permitted and child_cred->cap_bset?

If CAP_SETFCAP remains raised in child_cred->cap_inheritable, making a
root target task in child_cred->user_ns call execve() restores CAP_SETFCAP
in new->cap_permitted via handle_privileged_root(), which sets
new->cap_permitted =3D cap_combine(old->cap_bset, old->cap_inheritable).

Even if child_cred->cap_inheritable is empty, the tracer can make the
target task:
- call unshare(CLONE_NEWUSER), where set_cred_user_ns() resets
  cap_permitted, cap_effective and cap_bset to CAP_FULL_SET (and map a
  non-zero UID mapped to the tracer's root kuid to 0 in the new
  namespace),
- write "0 0 1" to /proc/self/uid_map using CAP_SYS_ADMIN if
  child_cred->user_ns is still unmapped and parent_could_setfcap is true,
  or
- ptrace another task in child_cred->user_ns that still holds CAP_SETFCAP,
  since cap_ptrace_borrows_setfcap() allows same-namespace ptrace.

In each case, the tracer can still write file capabilities valid for its
root user.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-setfcap=
-userns-v9-0-0d3f00976ce2@toxicpanda.com?part=3D2
