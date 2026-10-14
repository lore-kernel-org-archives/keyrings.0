Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518D55D876;
	Wed, 14 Oct 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995776; cv=none; b=tUVFBVfMdD/cRDo9uRIKMC4ftEUhzX45B/NDOmPvSWoEDMvZo+oQfMd0RtWInSuM3kUDvSV4w6bl9w/daAVblAkjsrIRsflb2qYSTMuwtwFLYQ+APwbibppExH9KWmu0EzMnENjG7RrPPytMWdcf7hIH43+Ug8rd6EzCNLx/tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995776; c=relaxed/simple;
	bh=KMD7Towbunxb3x83kvj/jlmrKN5cUKVMsO6ERTpi9Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTYvnAtVW4x1kcPnDdXy3+0ekCP7NqrVNzjYGCqy5Em6xqeb1HhvoFKmlxkKVyxgseJ69fNcxUeW4TjAuBAHMKaDHv6+Plbr8aEsHAIu1ZqLmvc5ktEdEQ1D0LaJ18xfmfHLLqhgLxDPz85IyrBxJxRnUBZV77r9AH+ddsVmBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MflMOJU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MflMOJU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409121F000C4;
	Wed, 14 Oct 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995775;
	bh=Xe9rAmILOBAL5qEj1m6Rs0cQGMnFcSwviGw+I+tsq5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MflMOJU3bk3HTx5E7LUnFFqipXcK3PLvRbYVWE3DAujLB3A1pXCXiq9xHaowtrCy7
	 AjtOoVn1r1aqkfe2T0GR90AIHVRy7RuUIZ48zl8jG2KBqzpuNvHcUOYa6g2AapxTHF
	 mXTm95TzOTXQ+QjdFVvo8cDYEj1f46B+dWAr8QTvqBLJl+tfhwFMZVgoGvrlUjSio3
	 YhOI4GlwscYjapvN0pgu2FKrEV7gDnrELztWh7aROP+6Ug97kKJJU4lY8vteV54ga5
	 HM619bjWjlR7lGv/t6c5RLO4fYGQbsBg1OTwI9HNaevoJj65PVCUQRewQJ0YBgmtxj
	 PaXqN8FpNMICg==
Date: Wed, 14 Oct 2026 18:35:50 +0200
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <20261014163550.GA327771@quark>
References: <20261014160144.1835860-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014160144.1835860-1-jarkko@kernel.org>

On Wed, Oct 14, 2026 at 07:01:38PM +0300, Jarkko Sakkinen wrote:
> This is a kunit test for lib/assoc_array.c, which maintains a shadow model
> across assoc_array operations, and checks its integrity after every
> operation.
> 
> I wrote a draft version so that I could properly test 'assoc-array-fixes'
> tag at Linus' tree, and spent today rewriting a new more polished version
> with as good description as I could possibly could on how the seeded test
> keys were cherry-picked. Along the way I also tweaked the numbers to be
> a bit less messier set than in my original version.
> 
> The transcripts that follow were executed with this command-line:
> 
>     ./tools/testing/kunit/kunit.py run --raw_output assoc_array
> 
> With 'assoc-array-fixes' commits and its subsequent tag iterations all
> eight tests pass, and without them all of them fail.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Would this effort (and Linus's effort) be better spent on converting
keyrings to use an rhashtable?

keyrings is the only user of assoc_array.  So if it's made to use
something else, assoc_array (all 1724 lines of it!) can just be deleted.

I understand assoc_array.c was intended to be for general use.  But
clearly that hasn't happened in the 13 years it's been in the kernel.
Keyrings has always been its only user.  All other kernel code needing a
map data structure uses something else.

- Eric
