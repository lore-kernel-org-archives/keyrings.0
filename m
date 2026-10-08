Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76F3939B1;
	Thu,  8 Oct 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476049; cv=none; b=Eylaet9fvK4T8Dosd4WZ7BGc7w6XUu7w8Q9dtLolTkJGjSilRSl+mUKwbBR1N9bFNcm811SR/mtWJpycTrWAp1AHlqehkcR+7QsmWtCMWl+rWYPO6w2YnWu0bbLUmIe/QcGYRPyKC58odzL5D8SSMvs3ODJDJlstV4ArM8HX9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476049; c=relaxed/simple;
	bh=I8VgyQsADjnSNwP8IrwNRupP46kFvIihceEwfXG1CPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkBlOpXkwwneAIH+hhLrLgHW+oALxYKi+dOhqbI2p1D6rNsaW20nufE+28KuKaslhds3PT3qjLQwdZ0PIhsqWIJQur0ANhs2LQ92m72aTjOxF6zbFqTeGQ6XIld8aUn67CS/qHjpznbDkI5hLQgHlXZajFEaGlMevLlfv8GKk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=1r3u8kT+; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="1r3u8kT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791476037; bh=I8VgyQsADjnSNwP8IrwNRupP46kFvIihceEwfXG1CPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1r3u8kT+UvfgyW/BcsTB+P9F18gqW5Bj/iqXmNpM9dHvOH7tnIqkaejpaKCuXQAZm
	 P3RkZy8+9QG13Tx6gYZy+e1KigpTWCmMOWhn7fY9YQwvqFRSWKBeJrNOlcuFFFt7G5
	 YjJ77rBkzQ6yYeibAxSoWwvRuMrauRzCc9KKTZtpIORFD90iWk+6Jxl7jtuQsnhjey
	 /BUzLN0lHrb07q7sjvwOgJ2fATdMv7dxNXLsWRHjITnXAAxuSl5D0dQRcqcL79KNv4
	 h5zfYpO5XK52KP//rF5MlIClAfiRDnAyvaVSSr1Y0KUgJBU3rgT4HvU8C7wfdQnK/U
	 N1oKOaPaztYiA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C27331B49; Thu,  8 Oct 2026 11:13:57 -0500 (CDT)
Date: Thu, 8 Oct 2026 11:13:57 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Message-ID: <asfBRYy597qvzdCW@hallyn.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179147397027.4.15064782992163283819@toxicpanda.com>

On Thu, Oct 08, 2026 at 03:39:30PM +0000, Josef Bacik wrote:
> On Thu, Oct 08, 2026 at 08:57:56AM -0500, Serge E. Hallyn wrote:
> > Would you mind describing what other solutions you considered?  I've been
> > looking over this set since Tuesday, and finding it hard to reason about.
> > (Part of that is certainly the nature of the problem, and it's possible
> > that this is the best/simplest solution.)
> 
> Everything we looked at kept the state in the cred.  We model checked
> the variants before writing the code, and these fell over:
> 
> - a bool per cred for "had CAP_SETFCAP over the parent when it entered".
>   It breaks on two hops: setns() into a namespace that maps 0, unshare
>   again, and the bool says yes for the second namespace.  Hence the
>   level.
> - checking only at uid_map write time.  That misses setxattr of
>   security.capability in a namespace that already maps 0, hence patch 4.
> 
> We didn't look at keeping the state on the namespace.
> 
> > If we replaced the userns->parent_could_setfcap bool with a ref to the
> > creator's cred, then at both setns and write we could check the actor's
> > credentials, right?  There are probably issues with that specific idea,
> > but that's why it would be good to see what else you've considered.
> 
> Checking at write time alone doesn't work: once a task is inside the
> namespace its cred says nothing about what it could do outside, so a
> joiner and the creator look the same.
> 
> It does work if setns() refuses to join a namespace that maps, or can
> still map, the parent's uid 0 unless the joiner has CAP_SETFCAP over the
> parent.  Then everybody in a namespace has the same reach, and it can be

Yeah, that's what I was thinking.  Or even stricter: ensure that to join
any user namespace, a process must have a superset of the namespace
creator's capabilities.

> a level stored on the namespace at create time instead of a cred ref,
> which would pin keyrings and the rest for the life of the namespace.
> The checks would be setns(), the map write (opener and writer are in the
> parent, so a plain capable check), setxattr of security.capability, and
> ptrace.
> 
> The difference in behaviour is that the -EPERM moves to setns(): a root
> task without CAP_SETFCAP couldn't enter a root-owned container that maps
> host uid 0 at all, where with this series it can enter and is refused
> only for the map, fscaps and ptrace.  I can prototype it if you prefer
> that.

Sorry let me think about it (or let us talk about it) a bit more.

> > Of course UID 0 will always continue to carry privileges even with an
> > empty cap_eff.  Here we're stopping it from writing filecaps to uid 0
> > owned files, but if it can open a 0 owned file on the host, like
> > /bin/sh or a systemd init file, or ptrace a process (in a child ns that
> > maps parent uid 0) doing so, it can still cause damage.  My point being,
> > we do need to keep in mind the tradeoff of keeping the code simple
> > versus the realistic threat of the problem being addressed.
> 
> On the same kernels, the restricted root task can copy a binary and
> chmod 4755 it (it owns it, no capability needed), and a uid 1000 user
> runs it with a full CapEff.  With SECBIT_NOROOT that setuid copy gives
> uid 1000 nothing, while the fscap file still gives it what's in the
> xattr on an unpatched kernel.  So SECBIT_NOROOT is the case the series
> adds anything for, the same case db2e718a4798 covers.
> 
> A smaller version is patches 1, 4 and 5, with cap_root_level() moved
> from 2 into 4.  I built that and ran the same flows: every route that
> ends in a file capability still gets -EPERM and uid 1000 gets nothing.
> The uid 0 map writes refused by 2 and 3 go through again, but the fscap
> write after them is refused.
> 
> Let me know which way you'd like to go and I'll rework it.
> 
> Thanks,
> Josef
