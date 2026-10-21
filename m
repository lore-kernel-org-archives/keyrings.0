Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578534;
	b=Z7MNBSpeLAUVqwI1nRJM2/0WG6/lLwEm51HCQrhAJGyYfZ8JKNEf2slU9H5bJ9oIDHqr
	 yRzw2wu2tcQ3v6Fd5s1J/3jfiSI/GkunhLwodxuy7CuptmAeGHXVevSlfeajtsSFUxslM
	 1w8XnXbO55ZX5/9gVwg7tLZLN+gPIq0XQ5OX1ykfkP84rHEkL5qA6+XRIuLnrMIhrm13b
	 MY3ZfyvBCv62YJnHz1tZynE/blWKqnN3kptTKKAMod5L6HpFaB2xPKCwpHv8lhAYH8BPA
	 Rr5R9JX81MqjRkpWeXaxLE7c85cHUwIhfOFS34EZJAwjC5ZpuvXytUEzkHJ+9lr3kGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578534;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RyNlnTCg8f5jnRjirKufUnFU6MO9l6lq6sjeVEWl6yg=;
	b=2ppiq38xkUomtfQVJrEckNOmntHG+mNUzD2ntGMgvzoBjSQAfsxCG8NtIpnYOcPGM2Ke
	 CtokzYvPqFwq+8KbuL7tFSjJFeEKVJVCsrM1CiQ24WT3KHjFQnKMR5/UQpN0K4Ecc8ozh
	 tf0vI8JwBDjJ5HRQsFvTmfyXztyYfju5C+ydIVgBZ6sOdHvrTCohtIE/XjscRfDCRPQAP
	 6andBVkicVh2drh5tXBdRU1/SxKV4YtKXhLQIFnjGZkXxTpMHLGszRb8M/fWPxFggV2qd
	 xY1XRW5OMazU0ma/J5TYEkn1NH1w8dK/QQzyYbC7qZ1BKdwgnj56iXa2Jiqz9kD9Bbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khVTwex6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608260A2604;
	Wed, 21 Oct 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khVTwex6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0013E1F000CF;
	Wed, 21 Oct 2026 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578529;
	bh=RyNlnTCg8f5jnRjirKufUnFU6MO9l6lq6sjeVEWl6yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khVTwex6HuJEnfARXW1KWD+f7Ysf5SKiY9H9XV2U3S7JxHQmuSvwT/4ZS2f/4VdO+
	 h7pOJT8bseaZKjMDxBQSn7DpA2lqtFPTi0ch7FnYNswC7YZlibEmBfC78gqGQbRP+v
	 aOCzkJ1A+kkTuExGRevT+oYALDUEeY5GCEwE8w+g5WG7FK0sS+X1QuH6gsAcc7JE9x
	 3wc2ArVPZ2j5ac0yLnHg4edaId3P8+TabR6hxTwHYX4xNP8dfbDd7WR9EH7O/4hgVo
	 uYu0IK9t0JP5i41IdDOs1AIcd9ty6FyaOhZaEmr0Kq/AQv/954NfvBHguOld2t+Nsy
	 fmR9FNGfELRNw==
Date: Wed, 21 Oct 2026 12:28:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Message-ID: <20261021-beisammen-pokal-unbefangen-436577686165@brauner>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
 <asfBRYy597qvzdCW@hallyn.com>
 <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
 <179191993398.6.7035194670175996999@toxicpanda.com>
 <atYGiiGPs39lTFQ7@hallyn.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atYGiiGPs39lTFQ7@hallyn.com>

On Mon, Oct 19, 2026 at 07:01:14AM -0500, Serge Hallyn wrote:
> On Tue, Oct 13, 2026 at 07:32:13PM +0000, Josef Bacik wrote:
> > On Fri, Oct 09, 2026 at 09:41:59AM +0200, Christian Brauner wrote:
> > > On Thu, Oct 08, 2026 at 11:13:57AM -0500, Serge Hallyn wrote:
> > > > Yeah, that's what I was thinking.  Or even stricter: ensure that to join
> > > > any user namespace, a process must have a superset of the namespace
> > > > creator's capabilities.
> > >
> > > I think both are fine and I like this proposal.
> > 
> > One correction to what I wrote: the weaker version isn't enough.  A
> > namespace that maps "0 100000 1000" doesn't map the parent's uid 0, so
> > it passes that check.  But with an idmapped mount that maps fs 0 to
> > 100000, a task that joined it can write fscaps that are stored with
> 
> I actually don't think that's something we should work around here.
> 
> Christian, what is your opinion on this?

I want as little moving parts as possible. :)

> IMO most people should not do id-mapped mounts from host range anyway
> (they should shift a base rootfs to a high range, then do idmapped
> mounts from there),

So that's pretty common though. Doesn't Incus do exactly that? And it
does write fscaps through onto the host on purpose and restricts access
to /var/lib/containers via strict DAC.

> > rootid 0 and honoured by the host.  We test that flow.  So it has to be
> > Serge's stricter version.
> > 
> > > I think that this is an acceptable restriction. Mapping uid 0 to 0 and
> > > dropping caps is borderline useless.
> > 
> > That makes the restriction wider than the 0 to 0 case.  A root task
> > without CAP_SETFCAP couldn't join an ordinary "0 100000" container
> > either.
> > 
> > setns() also only covers the routes that go through it.  These don't,
> > and need their own checks either way:
> > 
> > - writing through a uid_map fd opened by a task with CAP_SETFCAP
> > - ptrace and pidfd_getfd of an entitled task from outside
> > - a task without CAP_SETFCAP creating its own namespace, which a
> >   privileged task then maps "0 0 1" for
> > 
> > So v2 would be a level on the namespace computed at create time, the
> > strict setns() check, and the checks at the map write, setxattr and
> > ptrace reading the namespace's level instead of the cred's.  If that
> > sounds right I'll put it together.
> 
> I still think it would be easier to reason about, long term, if we
> could get away with storing the cap_eff of the process which creates
> the user namespace, and check (ns-targeted) the capabilities of any task
> trying to setns to it against that.
