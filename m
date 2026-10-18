Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C64CF496;
	Sun, 18 Oct 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289947; cv=none; b=jeCMisbyZUI5lg3OOSGiC+cPmGlQF/h6Ld+P9o2ObzLQteAHjRt+COGF3X5hNhplE4ggRtJAg3L/DGa28PyR+skkBvTA3HaByxk29BP3uzHSWc2izEYOKznQ+R4VZSAAhoT+TrY0r5DnUU7hbF3XmbWadI94DKBjREZyusChw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289947; c=relaxed/simple;
	bh=ENoEErGIF45uEZchIneXGytylYZQ4wLdX7Cm1nFVtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUCAOcFKxHLAv/hsoxA646nGKD4Jv+4dOaO7K33Ilc7/ybahE0efm7fdnFgh60w4VX9hd31copNdiq77jmm9R5dMfYp5stFBI7kdXszU+a+kH9vvpCCE0v488VUa57kupQveAMOgJkSQ6x4tZz8wZ+RYFDpI4bB413S1mO8KHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl+iauia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl+iauia"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B01011F000C4;
	Sun, 18 Oct 2026 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792289946;
	bh=G+8PPkcy5Cj2BcxCWW4Qjj5ncRVjqmwS/D/XD+zSC4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tl+iauia3v1o5Mz3Mbc8/Y3brVWRvVDdASYboBCbSdkbwW1rl7Vvv6yoK+BS3CH28
	 qULQrTsDt+zWl+8iWngZfQn6c7/buD5SmiOhcqHTToILa9XV+KDipu8JLdQxz/sW7G
	 mKVbM6FIUt5BWrgg4Y5y80LzLijjf5CRMTvegY/8O39/eUGjioq2SJmwjymXeGHsk0
	 YiqfvT1Jftshk6I2KGBOUMYPCPfj+IQprg84ULqxpa/MqFdfgriHuSTSGROWsB3VaM
	 ylqFOfntMCHqaD8mxI6GP8UcaxQBFjZuYrPjFLcnebAL0HzZYjqUck/Ct9o6CkNkTe
	 kBeEBsNF7UboA==
Date: Sun, 18 Oct 2026 05:19:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: list.lkml.keyrings@me.benboeckel.net
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
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Subject: Re: [PATCH] lib/tests: kunit for associative array
Message-ID: <atQsloTurzo4cl7c@kernel.org>
References: <20261014160144.1835860-1-jarkko@kernel.org>
 <atQcpQ-1J28uJyT9@rotor.dev.benboeckel.internal>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atQcpQ-1J28uJyT9@rotor.dev.benboeckel.internal>

On Sat, Oct 17, 2026 at 09:11:01PM -0400, Ben Boeckel wrote:
> On Wed, Oct 14, 2026 at 19:01:38 +0300, Jarkko Sakkinen wrote:
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
> > ---
> >  lib/Kconfig.debug             |  15 +
> >  lib/tests/Makefile            |   1 +
> >  lib/tests/assoc_array_kunit.c | 570 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 586 insertions(+)
> >  create mode 100644 lib/tests/assoc_array_kunit.c
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 6b24a2c89b84..3e8d3852f53c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2857,6 +2857,21 @@ config HASHTABLE_KUNIT_TEST
> > 
> >  	  If unsure, say N.
> > 
> > +config ASSOC_ARRAY_KUNIT_TEST
> > +	tristate "KUnit test for assoc_array" if !KUNIT_ALL_TESTS
> > +	depends on KUNIT
> > +	default KUNIT_ALL_TESTS
> > +	select ASSOCIATIVE_ARRAY
> > +	help
> > +	  This builds the assoc_array KUnit test suite.
> > +	  It tests the basic functionality of the API defined in
> > +	  include/linux/assoc_array.h.
> > +
> > +	  For more information on KUnit and unit tests in general please refer
> > +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +	  If unsure, say N.
> > +
> >  config LINEAR_RANGES_TEST
> >  	tristate "KUnit test for linear_ranges"
> >  	depends on KUNIT
> > diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> > index 3cac3b63a752..107e16b4ebc1 100644
> > --- a/lib/tests/Makefile
> > +++ b/lib/tests/Makefile
> > @@ -4,6 +4,7 @@
> > 
> >  # KUnit tests
> >  CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
> > +obj-$(CONFIG_ASSOC_ARRAY_KUNIT_TEST) += assoc_array_kunit.o
> >  obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
> >  obj-$(CONFIG_BITOPS_KUNIT) += bitops_kunit.o
> >  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
> 
> Why does this one end with `_TEST` and the others do not? I see
> `LINEAR_RANGES_TEST` in the context above, but it also lacks `_KUINT`.
> There is `HASHTABLE_KUNIT_TEST` nearby too, so perhaps consistency has
> just never been popular around these parts.

A blind spot. I started with that name.

This is phasing down as an RF patch set with rhashtable migration
is already out.

> 
> Thanks,
> 
> --Ben

Regardless, appreciate your feedback, thanks!

Br, Jarkko
