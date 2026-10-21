Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616849;
	b=KLthIDMunN8wBEhsNWx3W+qP80McxjOYRCGMnhiW1UzE4BahYeqA0getZZ6bR5hQk0rH
	 LLZF/T25COCiNjJN0dsip4wxyKjpb8/f75HhBxuIpBwRo1JNmtXlAes8THPmkzMmIn0tT
	 lfenbYDSFEIU1+MAwrnZMnp+HffJ/OusmE2nSHOhfAexTAFK4pA3eDz9y7fi2r6gqt39t
	 iVa7BNgQ6MowissQmEDtbrZH2DzbICkh12Khx8XBgnjfb8Ueg4sX/HswYQhUY9HGW/qBk
	 kmJU4Vy4XfCkjEwn7GfHoUVjzggD9WCqVVk/OrUZ9+nOj8Vq4OmGhdadV5iLk93EpUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FYbc5NkIKuLceADs32XiRA2GOTbv4etYMcJmUxCu2eA=;
	b=HbZFgcKQYevAkooLsjmO9EWzjwVzaps66S+yTVTMCQQj3S7AgL4rivGWn1c72edgpBBe
	 3jaZouVGnvJw/o56rmUoM9rqMtrgEZvuwAfS88mcfqcfpFb02ug9GC+dpiU3Nk8ts61mF
	 vb0yhvUqhVgFEYV5i7+PqZsnyspiGkWioBGFFsNHsFhXrFmcxc+iFmcqWd7pTYyluId+M
	 vOMr5bhFJSldGuZNmR8otXs0kiTW6flpPUCQbE4RWHfs9JegynV0S4nJufXF3vKRJNplv
	 Wb66S4Z6IsZmcmBTfCcBgoEwemzGkjRvTktnyPni5exAptu80VP1PdSs5NOqGEaKMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbhFAPP1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 351B7606A31A;
	Wed, 21 Oct 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbhFAPP1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 547871F000C1;
	Wed, 21 Oct 2026 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616848;
	bh=FYbc5NkIKuLceADs32XiRA2GOTbv4etYMcJmUxCu2eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kbhFAPP1CmNwkpH3mFWZfHbgd+UtfahV7Csjbjz4djbz89vvLbPVEIIwpK02EpT2M
	 P0gt1VggM/lu6jv+Z2wQYX09MSNqHpQra3pEgJUaKW4Kx67kUX0PpXbtalsLDjKsXq
	 2Lk/pAPkn0cbuSXcjZeb14x+AypymJ0aetLYd1oEnOHWcQqu5vMIgdqxLp5NKqQ9ee
	 urOTCZM2niGErqtsNTyEQB+hQRARYNJ6ipEeyRtx4dk5ZLHAx3GcGCVh1Fv0GtOoVO
	 vlkLYFYOz79thSUlpLb4jBlClEI67fYRjccVzbfpwu1oSjNWbQrHNK5QCNpcaIVB9g
	 JqnyK6h71z5Cg==
Date: Thu, 22 Oct 2026 00:07:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] KEYS: rhashtable bug fixes
Message-ID: <atkpjEWI6Ot7FVs3@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <atkTgEwRQfh94zeV@kernel.org>
 <20261021200327.GA2210933@google.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021200327.GA2210933@google.com>

On Wed, Oct 21, 2026 at 08:03:27PM +0000, Eric Biggers wrote:
> On Wed, Oct 21, 2026 at 10:33:20PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 20, 2026 at 08:43:18PM +0300, Jarkko Sakkinen wrote:
> > > My patch set that migrates assoc_array to rhashtable had some LLM
> > > scavegend bug fixes. Unfortunately most them where either plain wrong or
> > > not in the right scope. The bug fixes in this patch set are by human
> > > labour constructed fully but they are derived from what I got out of the
> > > original LLM source. Thus, they are tagged as LLM assisted.
> > 
> > I guess these are ready to be merged? Eric do you have something for
> > this revision? I already sent -rc1 pull request i.e., I don't mind
> > to update it if necessary but otherwise I rather would just apply
> > these.
> 
> Looks okay now.
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> - Eric

Awesome, thank you.

Br, Jarkko
