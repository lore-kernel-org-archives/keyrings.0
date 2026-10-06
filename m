Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E42F0680;
	Tue,  6 Oct 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268420; cv=none; b=D4NBP7/FYlump+lsTuyVtLp943HW31hJc1MBjjgywguBUWi0PvclqV8uFfKM4eVUIznne8QXNdYhk7/nJIA58ayGq+NbITSZUTG5vMRDo7RuD1eJULJmTDM1d/2BfST1RN3xkdcNnxW23f3uiDlByEdXYZpL81HXE03aNV8v1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268420; c=relaxed/simple;
	bh=NnuhxiR4gVN4aJx01Js1d4BAQJ5lEZz/GsWBKJ/w1Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghinFfmfVdR0wfMO1S6coZFGoyCNRnpFe7UPhNvgUEBwwO+vctoXpgsR3at3oqUQp1CUQ0sJT4z30FoxYTqtWjS9xNUOvDlCAoFqr2Ji2lVO/z+NYz8mPEEm8z7Z4yDIieK+OVGxW/zFNeTns8QEuv6x5c1EA0tkMdcAFII0hbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDYmzU8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDYmzU8S"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CC8D31F00893;
	Tue,  6 Oct 2026 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791268419;
	bh=zM/KXG88/fTkLOeHu33eo7gMKQUPJgWQ2DhYmmQKOKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDYmzU8SLyh28XIJ7VDfyu0Ngh4gwgqf/vaHVbeKFX6i/a9h8h5VPxdOuul3TaKDg
	 5b/28t/ifg2cUk/2LPDyAcuuE5/KZMBgs6epgA5a2vJRaDFoMsSgQcjJka+29VSil0
	 EFsat3gUXZu40nw1m7nKslLDysIpXUO3nKF3zRlOKVQgxqL/2uKUMkg18NjHAQFcYU
	 7+Inelch3zg4Uh4L990W5jEHDbEs+KxiGMxSX6j3VnLqRGCqpmzCuateNDZ2LRRiZb
	 3Drc576tr93jy+zEzSYuCPknGIy0ZGAEILkA+dqeKsVt7L8NLWPDTvB1hYBlzSJVI/
	 MnMOFf7fnXraA==
Date: Tue, 6 Oct 2026 09:33:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] KEYS changes for v7.3-rc7
Message-ID: <asSWP-QfvvpjvELc@kernel.org>
References: <asQo0Kb0SF0vZcHa@kernel.org>
 <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>

On Tue, Oct 06, 2026 at 05:03:42AM +0200, Linus Torvalds wrote:
> On Tue, 6 Oct 2026 at 00:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > I've started to take steps towards better quality PRs.
> 
> Looks better.
> 
> It reads like an llm, but that's perfectly acceptable use of tooling.
> If it was an llm, you can tell it to be a bit less verbose, and that
> it should prefer imperative voice ("Fix it by" vs "The bug was fixed
> by")

Nope, this was not with LLM, honestly :-) I hope it isn't Claude tho
because I can't stand it...

I spent just way too much time fitting all the details while keeping
then compact as possible and that is what I ended up with. And as I
recall saying (I think) previously, I will take a habbit of writing
these at the time when I ack the patch.

I also think that while there are situations where I could use an LLM
for development, using them for PR would impose a quality risk as it is
also the last time to sanity check and drop patches when needed.

Putting things down early and eagerly is probably a right choice and
it is best use of the energy spent on review process.

> 
>                 Linus

Br, Jarkko
