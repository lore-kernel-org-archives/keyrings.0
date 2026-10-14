Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B53630BF;
	Wed, 14 Oct 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996992; cv=none; b=iZmTkqkxR29X3qD0Y8yDGKroGwv5xrxvL+HcCazAHSPLByp9EfpJeo20rSRU5XcK25orXH6tFzCHOzELbR/7COkmwocRvnk9Zh9N19/CUVnFKQdZc77ixVJCgcxHCa5qAENcWbBl0UfE2pU6wLzGhqQM1r6itwbn6cANVBDjqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996992; c=relaxed/simple;
	bh=Ih/+Fc8rOpdqE24PSwFkjc+Lfl0Fq5/RFaRcR9lXH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaqhaaMbND80BHTjor/ox+ohJF0E4MneRfIXUUbt21QRzqgdLlx54XaXZl3nFlaZyNQO1i+XCkgPhNSt44gHXKd0a/NFaoHiKpIF+6wd6fKWBBJcN0vczhpaNwdXqwFAZ5iNI/xWbnk2eii+hwFBpwNrT+dhX7AILRonHIBIF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV3/I2k6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV3/I2k6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45D361F000C4;
	Wed, 14 Oct 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996991;
	bh=TYYE42VFdxNI3x+LXpwKN3/ksnscbVETG6MgJA1Zj0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nV3/I2k6q80k1APJeM0fgnogaokTJcaE2lppensgSyz0O/L47KVZVCMCvlTSnv2A8
	 9aQhhEFmFgq1Yughhha2FP6AHm852gimNT1yQeNNCJ3hWSTvz8yrfzL0E1QQpRi6vy
	 JsXZjjqY1zmgMT8/oZBj42hN+Lcc8LBvPvrpeau9UFi2ceRVundgD14YbSMqcc1/51
	 53tloP5m9/a1u5cCdH2SXXuXEpVde2nlTiLP9yOL6+IwHt/Of0CA67HfSWQ4LZDnj0
	 ViIn6B3lPbkEXTI/XJNN7qZ5cDTyiQaIMxdOGqB5Gi4LxSiCMc5ExAGOUfwTRk40PL
	 r9EAS1bzmE8nw==
Date: Wed, 14 Oct 2026 19:56:28 +0300
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
Message-ID: <as-0PE_UBbV_4ooz@kernel.org>
References: <20261014160144.1835860-1-jarkko@kernel.org>
 <20261014163550.GA327771@quark>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014163550.GA327771@quark>

On Wed, Oct 14, 2026 at 06:35:50PM +0200, Eric Biggers wrote:
> On Wed, Oct 14, 2026 at 07:01:38PM +0300, Jarkko Sakkinen wrote:
> > This is a kunit test for lib/assoc_array.c, which maintains a shadow model
> > across assoc_array operations, and checks its integrity after every
> > operation.
> > 
> > I wrote a draft version so that I could properly test 'assoc-array-fixes'
> > tag at Linus' tree, and spent today rewriting a new more polished version
> > with as good description as I could possibly could on how the seeded test
> > keys were cherry-picked. Along the way I also tweaked the numbers to be
> > a bit less messier set than in my original version.
> > 
> > The transcripts that follow were executed with this command-line:
> > 
> >     ./tools/testing/kunit/kunit.py run --raw_output assoc_array
> > 
> > With 'assoc-array-fixes' commits and its subsequent tag iterations all
> > eight tests pass, and without them all of them fail.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Would this effort (and Linus's effort) be better spent on converting
> keyrings to use an rhashtable?

It did cross my mind when I reviewed and tested those fixes but you
are asking something that I would need at least a few hours to have
any opinion.

We do bugs and QA to the end-of-life-cycle. We neither can predict
exact time how such major overhaul would take, if we even want to
do it. I don't know.

My brain is on this and I'm really bad at multitasking :-)

> 
> keyrings is the only user of assoc_array.  So if it's made to use
> something else, assoc_array (all 1724 lines of it!) can just be deleted.
> 
> I understand assoc_array.c was intended to be for general use.  But
> clearly that hasn't happened in the 13 years it's been in the kernel.
> Keyrings has always been its only user.  All other kernel code needing a
> map data structure uses something else.
> 
> - Eric

Br, Jarkko
