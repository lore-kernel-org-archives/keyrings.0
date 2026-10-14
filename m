Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C53BCD3A;
	Wed, 14 Oct 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997431; cv=none; b=LzvZpBHQzpzSfUm/yvbZPL6ma1BW8T6RrZeIhCuCMwuJBw4zZBllUEBxXT0yG73aBAuapTckZFI7ZVJlN3Y+1R3Pq8VGHWYbHETvarl7Z5gTid/PWkq9uFv4/iPO5L5J3wHOvtV0ns4Nisn1ZcJhacClOepfoUskbECJFaXh0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997431; c=relaxed/simple;
	bh=a+z0R0dnskkkMLiz3io7c7v0PhV4mW3Rh8TxN3dJZVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM64kjmPxapLyQir0qd3G86ynZbC3slxcaJ1k/FCHBr/Jg5vHWt5PDEQxWg/oLUAj4X6C4ACiyD0u931NUNwEvArLIkWjvmhcitCyF7kI4MwUosltWIjqLfkcJKd30sYGZxSnWgv718fQrxfA6UzNqep2EpXG8xTKxRDdJTfLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJv5tQwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJv5tQwj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 32D051F000C4;
	Wed, 14 Oct 2026 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791997429;
	bh=WAwi+KjahJKmuK2rJk9ZiJGGGo4UHtIg6YDYM49ohMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJv5tQwjYdJIHspWjA2Ny6qItzQ7eUYnyxhggzoXKFj6135/2H04BtRe7TKOWnZjS
	 YP4rNZ0LZVaO9NIVl0Hssv5yWZUeqVJXk/J+sTmXKlKgO3QmLz9sXGhSOdGqdlUlRg
	 y8l9YOUJ5cfxAos5YTqNFKyI0WNrsMlfQJ/U2r8LoHJrmyENhScsySDWK/buwzRfGJ
	 osHGutEmxMKh+ljR6VFCxlS4xlpu4uEqk3ZZBIVx3d/Kfa0xaqI/SjmBxwpvCSt3jM
	 N2Q6IxUim0BjZypqrrdkNPIFVR3Zm9kQuhww6lsgd7mOuht3DmJHreLWkZcq9aXou/
	 SHGDLmlQh+mxA==
Date: Wed, 14 Oct 2026 20:03:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: keyrings@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rae Moar <raemoar63@gmail.com>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Kir Chou <note351@hotmail.com>, Petr Mladek <pmladek@suse.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lib/tests: kunit for associative array
Message-ID: <as-18RDvaxJhl2By@kernel.org>
References: <20261014160144.1835860-1-jarkko@kernel.org>
 <20261014163550.GA327771@quark>
 <as-0PE_UBbV_4ooz@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-0PE_UBbV_4ooz@kernel.org>

On Wed, Oct 14, 2026 at 07:56:32PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 14, 2026 at 06:35:50PM +0200, Eric Biggers wrote:
> > On Wed, Oct 14, 2026 at 07:01:38PM +0300, Jarkko Sakkinen wrote:
> > > This is a kunit test for lib/assoc_array.c, which maintains a shadow model
> > > across assoc_array operations, and checks its integrity after every
> > > operation.
> > > 
> > > I wrote a draft version so that I could properly test 'assoc-array-fixes'
> > > tag at Linus' tree, and spent today rewriting a new more polished version
> > > with as good description as I could possibly could on how the seeded test
> > > keys were cherry-picked. Along the way I also tweaked the numbers to be
> > > a bit less messier set than in my original version.
> > > 
> > > The transcripts that follow were executed with this command-line:
> > > 
> > >     ./tools/testing/kunit/kunit.py run --raw_output assoc_array
> > > 
> > > With 'assoc-array-fixes' commits and its subsequent tag iterations all
> > > eight tests pass, and without them all of them fail.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Would this effort (and Linus's effort) be better spent on converting
> > keyrings to use an rhashtable?
> 
> It did cross my mind when I reviewed and tested those fixes but you
> are asking something that I would need at least a few hours to have
> any opinion.
> 
> We do bugs and QA to the end-of-life-cycle. We neither can predict
> exact time how such major overhaul would take, if we even want to
> do it. I don't know.
> 
> My brain is on this and I'm really bad at multitasking :-)

If migration was done probably two-phase approach is what should
sought after. I.e. keep the API and change the internals.

After that it is time for re-consideration because from that point
there are multiple (API) paths forward.

Br, Jarkko
