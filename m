Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB922B594;
	Tue, 28 Jul 2026 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199855; cv=none; b=hkeXAS5vRm3j8zyP3LW1x9MrTiltYt7hXgVfgSKXZSmnB7hr8U4AXhv2Je+U4hRQ3VOOCSGqYPnPxzHmthjrsICA2hb1LMQUrcAC0PZak4vX3xYcObUJV/oLbnMXPg9HqHo6JIv29H1P3OSFHeudiLaehI3MR4mEyoTtVdN4w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199855; c=relaxed/simple;
	bh=qXLV1T7YzFDfZtzNOpgxi2A/LwNUSo/i/T3uO4abBVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOCUxJUy+O9O1CpkGj2l0Fqog6KQDEpRTzdn5264cM7nCohS3CE5OBecLWyisxeLK0bBtrEhwnBiDJMFIcHl05ItKzxBEmajSxKegep6bWqy6G5Ozs2mFNSdNA0/+CHiLokNGGt97UBZh/vnKX130yKSup5AGoNNeCaytTm9R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3Bf8XKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3Bf8XKI"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8BD0F1F000E9;
	Tue, 28 Jul 2026 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199854;
	bh=gBvpdGbMQ+Vdh7SKiUBdw7JeuUYo7ZiTrvBh+n6xUY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l3Bf8XKI1/aGKTZvln6qfnqBPbHgIC67v5uql2TJEdqFA771pGk0I/vl+dbai0V30
	 NthVUaGQFtTdZQgzBT16DdTvmcotyjy2ztLR4McK1kx95mmx3WpHkLRADd/kEOhEEA
	 DqCt18xADE2609S/z9ohhZQ8BcrBuPOTBbWAldz//siG23YlY1RaIg9vbqV/j8junW
	 ojhgopeHDUWQkvjjozOa/yBsN9Y26weSKBZqxFKJoVLy5Ff2077PlojsLaRrr5iIBk
	 WEFLX6dvLXv9FfQ/WwGzu8/XgaahE8QSG2uvgvlIItKKD2/iFKMG77lpYVc9iQ8+Pa
	 oqAEHJo0+4TsA==
Date: Tue, 28 Jul 2026 03:50:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Fabrice Derepas <fabrice.derepas@canonical.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: [GIT PULL] KEYS: for-next-keys-7.2-rc6
Message-ID: <amf86pBd_7wmh2Pf@kernel.org>
References: <amenZnA_QgqwMNeC@kernel.org>
 <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
 <amf8lG0-TnummN5Q@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amf8lG0-TnummN5Q@kernel.org>

On Tue, Jul 28, 2026 at 03:49:28AM +0300, Jarkko Sakkinen wrote:
> On Mon, Jul 27, 2026 at 02:22:47PM -0700, Linus Torvalds wrote:
> > On Mon, 27 Jul 2026 at 11:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > This pull request contains bug fixes discussed in [1] and two fixes
> > > (in one commit) from Fabrice for DCP trusted keys backend..
> > 
> > Please don't explain commits with links. The commit log is supposed to
> > be legible without a network connection. Links are ok as supplements
> > and background information, but not as a "this is explained by link".
> > 
> > And the pull request is supposed to have what I can useas that commit
> > log (either in the email or in the tag). Yes, I edit things for
> > clarity and consistency, but I don't want to follow links and try to
> > figure out what some discussion was all about.
> > 
> > So please give me an explanation for what you are asking me to pull.
> > Both so that I see what I'm pulling, and so that I'll have a merge
> > message explaining things for later.
> > 
> > I've done this myself this time, but please make your pull requests
> > legible in the future. The patch series you merged even had a cover
> > letter, please keep track of these things and don't make people search
> > for them.
> > 
> >              Linus
> 
> I'll keep this is mind and yeah, get the frustration with this.

Right, and thanks for still merging it.

BR, Jarkko
