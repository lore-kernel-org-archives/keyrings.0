Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664853D5253;
	Fri,  9 Oct 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531732; cv=none; b=eZidsAh9kWOhp3/bc+8cVOkGpzjCuvRBS33wtVYBpWJlU6fBIrCDocfRvt6qdKKZzU1CMjbRWQnK92wWajv0Vfj/OwrYhUv9RFyj0I932tI9Q3docCpeNQySronH7qUfsjwhyoDTd5v7UFeRUJyXfhAcgg35gmeEx42mn/16n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531732; c=relaxed/simple;
	bh=KK6hcUKNzTpjT+w6oo43Mdn+G6BEcfvhF7hhxgjxngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckFItoeic3oCGi5azoS3lmT9nbNrxTPQ1/u6bXJEP4DWXtYoQZzgskfk3cdO2CfND3WHihv14jboE2Dr0d5ddz0721lJXhe97W0PQRQC47CzgW3bVDuFQqEyle0OTiJVDUUOyn8Wg/3V9WU4dZ5UTM6DeMfJyiehWTjbGNwRTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKF431mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKF431mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC4C1F000FF;
	Fri,  9 Oct 2026 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531731;
	bh=rsMBX361Kx8vQKVV8EDRN0Xn/Nazwk8m05yUWcWSqiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKF431mtCCHYf2ieQl6MAF9ntDhRWeap5NdD5hWqa5qemmI1u1uieuJcu98D4E3Rn
	 5vE/DEoYSPXDgjUeOh7NV6MHRk/zK5wcN2bc1VNASWN49xYyizDS7NMRK3zpROSMh6
	 mOUE3gkK6h+pwFMF25O6lUO1N1rvuUA1bEkpPn7gUWseDUhqGN3jB3GDLTJJCfQDT1
	 UGVXAx4BlYPjHzofLX0QWC+/0QNKymWEiKcn7w54tXyY2uuRnSPSn4bV0TjcdSlOCK
	 +A/hkfmtsJJ4EpClcFzqByEfTrbueo7DxsP9sEQv/wDUgPVMsShwGgZhPmj6ljFhkk
	 nNzm/R7xwQlaA==
Date: Fri, 9 Oct 2026 09:41:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Message-ID: <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
 <asfBRYy597qvzdCW@hallyn.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asfBRYy597qvzdCW@hallyn.com>

On Thu, Oct 08, 2026 at 11:13:57AM -0500, Serge Hallyn wrote:
> On Thu, Oct 08, 2026 at 03:39:30PM +0000, Josef Bacik wrote:
> > On Thu, Oct 08, 2026 at 08:57:56AM -0500, Serge E. Hallyn wrote:
> > > Would you mind describing what other solutions you considered?  I've been
> > > looking over this set since Tuesday, and finding it hard to reason about.
> > > (Part of that is certainly the nature of the problem, and it's possible
> > > that this is the best/simplest solution.)
> > 
> > Everything we looked at kept the state in the cred.  We model checked
> > the variants before writing the code, and these fell over:
> > 
> > - a bool per cred for "had CAP_SETFCAP over the parent when it entered".
> >   It breaks on two hops: setns() into a namespace that maps 0, unshare
> >   again, and the bool says yes for the second namespace.  Hence the
> >   level.
> > - checking only at uid_map write time.  That misses setxattr of
> >   security.capability in a namespace that already maps 0, hence patch 4.
> > 
> > We didn't look at keeping the state on the namespace.
> > 
> > > If we replaced the userns->parent_could_setfcap bool with a ref to the
> > > creator's cred, then at both setns and write we could check the actor's
> > > credentials, right?  There are probably issues with that specific idea,
> > > but that's why it would be good to see what else you've considered.
> > 
> > Checking at write time alone doesn't work: once a task is inside the
> > namespace its cred says nothing about what it could do outside, so a
> > joiner and the creator look the same.
> > 
> > It does work if setns() refuses to join a namespace that maps, or can
> > still map, the parent's uid 0 unless the joiner has CAP_SETFCAP over the
> > parent.  Then everybody in a namespace has the same reach, and it can be
> 
> Yeah, that's what I was thinking.  Or even stricter: ensure that to join
> any user namespace, a process must have a superset of the namespace
> creator's capabilities.

I think both are fine and I like this proposal.

> 
> > a level stored on the namespace at create time instead of a cred ref,
> > which would pin keyrings and the rest for the life of the namespace.

Yeah, that's what I was worrying as well.

Fwiw, this brings me to another general idea of mine: I want to be able
to pin a "creds" light variant that doesn't pin all the unnecessary cred
cruft like keyrings that you really don't need in a lot of cases. Like a
core cred reference that does namespaces uids/gids, caps and ucount but
drops all the rest.

> > The checks would be setns(), the map write (opener and writer are in the
> > parent, so a plain capable check), setxattr of security.capability, and
> > ptrace.
> > 
> > The difference in behaviour is that the -EPERM moves to setns(): a root
> > task without CAP_SETFCAP couldn't enter a root-owned container that maps
> > host uid 0 at all, where with this series it can enter and is refused
> > only for the map, fscaps and ptrace.  I can prototype it if you prefer
> > that.
> 
> Sorry let me think about it (or let us talk about it) a bit more.

I think that this is an acceptable restriction. Mapping uid 0 to 0 and
dropping caps is borderline useless.
