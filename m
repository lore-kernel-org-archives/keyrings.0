Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE937DEBE;
	Sat, 17 Oct 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254706; cv=none; b=DkYnnb8gSe2hS4jageRJIjkrzofG4EM5xxf3UQRR4qUrFRyfoXa9rtnCE95E37MwS8OiKDtVQXP1oNhkAjvZvp4ekKvqfvwYIWlW8MdpsomiqHvHT860oCRt0c3f65nGcHFj/df1qmlngfIHDeiVMlfrVeT7zuuJ4NcWVjMxUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254706; c=relaxed/simple;
	bh=8jOJa+MbU8Zm+0mXq8N5+ZxMiGN7YFK24PsWDy+GgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M400CchHWd1W5OWziTR8j/P4J2lgqsI4SEi9WIinY7XdZSqBeIh2xkq2RwlwrXnAqoagh4YBt+r4sKF+liGLEg53+OS9wl/fGDVdlzv9/mPwQSVRLhMGXvL/6znWAcF6e3ylSND/FDQbopEIRIUy4ct67Tm3amEs2CJHE3zg5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi34VOLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi34VOLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225961F000C4;
	Sat, 17 Oct 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254705;
	bh=YhTg6oempNh6mE56zws8dnfYhyHulr2WEOSJFJnU+ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gi34VOLaEeSvRC5JlMaDwNuF2p2dcVt4PDI74uvaClRFmOG4OzRu7L54M4T02MgvE
	 MjLbCVDcmNHpOPfEQWzhVLmq0pXFIDb8b9oHrXOJmpUKimzrMjxE1cBLP7I7fVQ6G6
	 r6CnJaGQX5cwDHH0mQj/TDDJWNZVmd2qAVYflim0Puuo/PZ5RZOyg8ExOW5nRzPSG1
	 7J26ctcJXhHjk1j3Qfvm3/elMUzoZrFJBl3uGJQejTWVZAI0kv0Dx8MiYrdgl5mM/a
	 iAGqTWNW1sBcA+ENoqhi0IFC71KTZChOxmuZJzpfxVT7ONmyBRhurLseW0oSmBy5BH
	 Ygs9YNswKfVpQ==
Date: Sat, 17 Oct 2026 19:31:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	sergeh@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <atOi7jWhglgRZ0C4@kernel.org>
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol>
 <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
 <atOiKzlHKH47SMNt@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atOiKzlHKH47SMNt@kernel.org>

On Sat, Oct 17, 2026 at 07:28:31PM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 17, 2026 at 03:47:32PM +0800, Cen Zhang wrote:
> > Hi Eric,
> > 
> > Eric Biggers <ebiggers@kernel.org> 于2026年10月17日周六 11:51写道：
> > >
> > > Don't key_serial_next() and find_ge_key() (used when reading from
> > > /proc/keys) have the same bug?
> > >
> > > - Eric
> > 
> > Thansk a lot for the reivew. You're right — key_serial_next() and
> > find_ge_key() have
> > the same issue.
> > 
> > I'll send a follow-up patch to fix those as well.
> > 
> > Thanks for the catch again.
> > 
> > Best regards,
> > Cen Zhang
> 
> Yeah, please do.
> 
> You put so much effort to scenario and you are nailing the bug
> that way, and I do appreciate that, so here's what you should do
> with the commit messages:
> 
> 1. Do the first half like you always do. That's great. And I've
>    also said that.
> 2. Think just a moment. If you get anxiety from that something
>    that should be mentioned e.g., something that you did not get
>    immediately yourself at first, write remarks those down. I'm
>    100% sure you know when it might be good tip on something
>    non-obvious.
> 3. Send that. If we feel it is lacking some info needed, let's
>    iterate that. It's not a big deal.
> 
> I'm just underlining this because so little would have to be
> improved to make this right :-)

And also: I would not complain about anything if I did not want
you to send patches because it does not make sense to waste time
like that. So take it this from that angle. And they bring value
thanks to well described scenarios.

Br, Jarkko
