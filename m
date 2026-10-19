Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01018499F31;
	Mon, 19 Oct 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411285; cv=none; b=qAUi+2rl0Bf7q9VsqpgP7n1rr2am0pwJZZtV1Il9Y7sX7P4//OM/ZnGGL34U/a8dzdp4yvATxw0zuYiZ3kTZ5GAyc8TnUsXu497kH0oxxUxbe0d/UNA5HAVMZx0AJSnTsCJcaV1qm6DOivBm5tdzfEB990WL1oEqi/E1oL+V4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411285; c=relaxed/simple;
	bh=qKmVXnbvrgmbSBXMKmgswg1CPuvbjvxz9Gk4ESPpl6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTVrGakQ/bze64Roy2QzodeeKDsX4QmTMGwTCui47Dv01L06AF0A7Drn5PYfNMazE9xPYYeDkg5b15hKMjX0OMe+MhdgxfwoeUHl+y3zAdZF2QmQ7812vVLkHfJndaTt4aq4Tk0B+sEV0O9BNgugtiey8O1x92P5gnrdR/TVY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=A/kCnsFd; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="A/kCnsFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1792411274; bh=qKmVXnbvrgmbSBXMKmgswg1CPuvbjvxz9Gk4ESPpl6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/kCnsFdVahR7QfbpjZXgip7cYuAwrFHMy6jj+hQsFjoG2PoZziStt9ULE90JR5ab
	 /GTr5AxS0qLDW+Paw2sJstgccU4ceyqUhKW/CEuQ3e6PL1H0gGJRCciU1CTZHH7Ned
	 GTwyWyaz+OdiDM3z4pI/5fu5U/DLiDXbT17lNQ5BCpTCWfhA/YtZBtVx7HYh2XeIe6
	 F18vEmbSYP1H4KhBuyMBkB8iF/jicUt0cmhMG23gHR5VLoinNgOBW1RY2gDv/8E1db
	 3g+0YAplb9cOSIjw52WB3Xc54wehX5iuCbZ5zdrGtEB4LQIM+57/+YnRL0ujBD19EK
	 VUyOr96ayTeSg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D8E6CF05; Mon, 19 Oct 2026 07:01:14 -0500 (CDT)
Date: Mon, 19 Oct 2026 07:01:14 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Message-ID: <atYGiiGPs39lTFQ7@hallyn.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
 <asfBRYy597qvzdCW@hallyn.com>
 <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
 <179191993398.6.7035194670175996999@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179191993398.6.7035194670175996999@toxicpanda.com>

On Tue, Oct 13, 2026 at 07:32:13PM +0000, Josef Bacik wrote:
> On Fri, Oct 09, 2026 at 09:41:59AM +0200, Christian Brauner wrote:
> > On Thu, Oct 08, 2026 at 11:13:57AM -0500, Serge Hallyn wrote:
> > > Yeah, that's what I was thinking.  Or even stricter: ensure that to join
> > > any user namespace, a process must have a superset of the namespace
> > > creator's capabilities.
> >
> > I think both are fine and I like this proposal.
> 
> One correction to what I wrote: the weaker version isn't enough.  A
> namespace that maps "0 100000 1000" doesn't map the parent's uid 0, so
> it passes that check.  But with an idmapped mount that maps fs 0 to
> 100000, a task that joined it can write fscaps that are stored with

I actually don't think that's something we should work around here.

Christian, what is your opinion on this?

IMO most people should not do id-mapped mounts from host range anyway
(they should shift a base rootfs to a high range, then do idmapped
mounts from there),

> rootid 0 and honoured by the host.  We test that flow.  So it has to be
> Serge's stricter version.
> 
> > I think that this is an acceptable restriction. Mapping uid 0 to 0 and
> > dropping caps is borderline useless.
> 
> That makes the restriction wider than the 0 to 0 case.  A root task
> without CAP_SETFCAP couldn't join an ordinary "0 100000" container
> either.
> 
> setns() also only covers the routes that go through it.  These don't,
> and need their own checks either way:
> 
> - writing through a uid_map fd opened by a task with CAP_SETFCAP
> - ptrace and pidfd_getfd of an entitled task from outside
> - a task without CAP_SETFCAP creating its own namespace, which a
>   privileged task then maps "0 0 1" for
> 
> So v2 would be a level on the namespace computed at create time, the
> strict setns() check, and the checks at the map write, setxattr and
> ptrace reading the namespace's level instead of the cred's.  If that
> sounds right I'll put it together.

I still think it would be easier to reason about, long term, if we
could get away with storing the cap_eff of the process which creates
the user namespace, and check (ns-targeted) the capabilities of any task
trying to setns to it against that.

> Thanks,
> Josef
