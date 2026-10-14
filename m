Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFE56510E;
	Wed, 14 Oct 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999137; cv=none; b=Qq9bBPZWJGz3+kA4FWSsLvTeDaKeMbL0GfQ+FhCDP/h0s5KxaRTnc85rfLVpTURnkTGGnKrPKm06+Lhq1hnIBvM1IEXteCXqf2UkBdHQbQ0KbEXg900IumfI4OkVSYfPG8G4g2Cw5XvZGFTjiorzQ6z+S6zILff8JKRs2ClleRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999137; c=relaxed/simple;
	bh=RmPWIZSrYBFYX4KWZ1Bq+CMJ9VyDGE3FThuF8wfsyqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw9OgHZLBo4skOLPdVj2LL0Awfadht4lDgbDA8cJHQamQPIfs7v/HsDtkiCDyN9lBE9nMr1ajcswpUUjXa2rOB+dX+tUCAnIriPIKEEo3I6b2s1uEvavAVkkYZyMOFiis1WpsRcop9AVHkhfLXYqReHspnbXuvVjzPgsiMIk5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRjonO7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRjonO7E"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 54A551F000C4;
	Wed, 14 Oct 2026 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999133;
	bh=Lh2+5+y9dzuZQicr8d0lju0dpCfKBKwbkrDtnEw29uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZRjonO7EA+wOsOYDeDu4vhs3PukxtUrGhF4vnGxgpVPKDwsXWLdA0IQ/ZSURUXawu
	 R7JitPz6DEf04oTgd6+LGhW5s5HR3CtoSpHbKEDZWdpEYWNF1Jl8pudxq+fA1GHcal
	 edYHXvxv6fR+oP3MgZt4xr68ecFhs+mdAYswcM/U8wvnDDFSPGNVUUsXjmP+KlKb18
	 0cL36L1ZCr/ayPCCNs+JEm2Ekxm20xVmDkZ30RIiC2x63yb3+cu1K4tJXjZujuoC5U
	 c1EsvnQtqiFUqiFsgeFKUGNlJFQm2btMvVk00TQoMVnFvTvq1XfdqzDeoJM1cqXf7R
	 Hd/2isbeZc8jw==
Date: Wed, 14 Oct 2026 20:32:09 +0300
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
Message-ID: <as-8mWD3WdwaXFLQ@kernel.org>
References: <20261014160144.1835860-1-jarkko@kernel.org>
 <20261014163550.GA327771@quark>
 <as-0PE_UBbV_4ooz@kernel.org>
 <as-18RDvaxJhl2By@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-18RDvaxJhl2By@kernel.org>

On Wed, Oct 14, 2026 at 08:03:50PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 14, 2026 at 07:56:32PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 14, 2026 at 06:35:50PM +0200, Eric Biggers wrote:
> > > On Wed, Oct 14, 2026 at 07:01:38PM +0300, Jarkko Sakkinen wrote:
> > > > This is a kunit test for lib/assoc_array.c, which maintains a shadow model
> > > > across assoc_array operations, and checks its integrity after every
> > > > operation.
> > > > 
> > > > I wrote a draft version so that I could properly test 'assoc-array-fixes'
> > > > tag at Linus' tree, and spent today rewriting a new more polished version
> > > > with as good description as I could possibly could on how the seeded test
> > > > keys were cherry-picked. Along the way I also tweaked the numbers to be
> > > > a bit less messier set than in my original version.
> > > > 
> > > > The transcripts that follow were executed with this command-line:
> > > > 
> > > >     ./tools/testing/kunit/kunit.py run --raw_output assoc_array
> > > > 
> > > > With 'assoc-array-fixes' commits and its subsequent tag iterations all
> > > > eight tests pass, and without them all of them fail.
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > Would this effort (and Linus's effort) be better spent on converting
> > > keyrings to use an rhashtable?
> > 
> > It did cross my mind when I reviewed and tested those fixes but you
> > are asking something that I would need at least a few hours to have
> > any opinion.
> > 
> > We do bugs and QA to the end-of-life-cycle. We neither can predict
> > exact time how such major overhaul would take, if we even want to
> > do it. I don't know.
> > 
> > My brain is on this and I'm really bad at multitasking :-)
> 
> If migration was done probably two-phase approach is what should
> sought after. I.e. keep the API and change the internals.
> 
> After that it is time for re-consideration because from that point
> there are multiple (API) paths forward.

rhashtable is the best pick I think. xarray not so much given the
data topology.

Br, Jarkko
