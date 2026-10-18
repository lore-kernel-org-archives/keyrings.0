Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCF2868AB
	for <keyrings@vger.kernel.org>; Sun, 18 Oct 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285869; cv=none; b=qeH2aAum4cUrQVmbAB6NFYjIqq9lxK2nEfPunobu4zvFJfvdOK2/XGXE3Js3I7JKLRNCPdJjWJEEEI/9Hb55ekmew1ZdwoZVMwqUT3+36/klFv6wkJjlgWhBXzuo0pfjhq03bfA6E1Cn2/pZZ1nUB9/JbIPQ5n6sl6wR2IbzSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285869; c=relaxed/simple;
	bh=iClRPXEe5mR6eqpKMdMBt4IQqiTf2uKaNcox0pzAZ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leGeZuW4Y8tc9Tb2RrN/0NWQzNXK8rHCozFc4T9NBlsL4ya8CS6LLHL1EbKwoJDv6pwgyNitB0EcoGCMe12znEsP8Sduce2zS5IiKU4iiRA1wrOvGp8nKBJYrxYotOF3wiqWbmR0TN0iU6zRVGl7v9kjRkOx+ogZBTOxCqg8TKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=lvLKv3jN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQTzcmLt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="lvLKv3jN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQTzcmLt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E9CD1D0007A
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 21:11:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 17 Oct 2026 21:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1792285866;
	 x=1792372266; bh=IQsgVY0IWPoHORuYJpzS4mkNp1CJYmEIgbOfStHyy7Y=; b=
	lvLKv3jNBogmMUqjchVm4Nl3Rby3771Nrf2pmqLEmJM6+deNX//3dondo17gC/m5
	whyaiAZqUXZxtAJt8cSmJY8Qi3htrwdVnF2BCyjCA/UEKLCkOJ2HZ5f1m8670owi
	sD2GqEO6+WqWqDC84Y3htQISEdEUf1Aed1SKCRTAy3OStefX8tQfNIsnUjvjlc0S
	944IQcjP2LK7uk+FKS4haRxcis9RUzN45LzQPVpJKRTELzcGuRgR15aP9ID58bpt
	BUCHxg276iT3Z+6u2lfs+u+kgSO4OzeXGdwl+QcrsGr9obdSebFIIayu1ojkSbC9
	Y7S/saPjZm+YGl8mh/7U5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792285866; x=1792372266; bh=IQsgVY0IWPoHORuYJpzS4mkNp1CJ
	YmEIgbOfStHyy7Y=; b=tQTzcmLtpuziSWN/KwVQLT9e4ctmKj9C/Lobtei15FdS
	dlIEcfzEYpvoNNME8PiY9KEtOUSCKo77FG8E8dgvQHEnTFNUP2BD5DuKZi87/QgL
	onLwe/DcVNVuPDCkgp53EmcuwKOZtRqeOCFH6coS8IZKS0SUBq47D4cklRKA+zpQ
	c3SzMSopSjru7VnfDLXvwjbr9TKJRDvJnj//bVCKCU3xAnLo4R6EbvMUoZj9BDRu
	QWzwE7uQXbVU6tq2Vi3QBHrp2mAOVLvuqB8Tuunl9TR5luyhYpNiNJJ+e0UoWMud
	hVhqBtjVO8xDVjMULDhxjfSuNDMXd8HDh2UOPnb0+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=benboeckel.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792285866; d=benboeckel.net;
	mf=PG1lQGJlbmJvZWNrZWwubmV0Pg==;
	rt=PGtleXJpbmdzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:CUmEPooBTRCuXysTwEy+C0FfI785dCmdjR4ODsAa9DILqPU
	KFQkfHWbtnZNGJ0TKv7aXDERDq7/u9W9lY+WGsa7R3rzq1YIwZbBW5bNRjR0adKK
	Ep/1W4X/4Co8+pOWxAGs3zLtx7OYXeLRW/MW+D+zLqs2BGiqb8k/+JmbidRkh8nM
	14CDnHtZycuhV6Jon5xvOCm+o9veApn0SMZOUS13J/68I71SnJ9D4oNTGFbdbiXc
	xW+5FIBQNMm2UqTq8Gx5PNA1SiLjcMRnm3JvpOM74FbYvPXpVoZuWUWDXF7fnwD1
	/Ni6uunZspMjKeVCpCx8EgqP1bxQpzDV4FGZWzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to,user-agent;
Message-Instance: m=1; h=sha256:Vi3N86SJGk1w63md9NbJDlcOb0nEbeK8aupUZx13Qcw=:iClRPXEe5mR6eqpKMdMBt4IQqiTf2uKaNcox0pzAZ7s=;
X-ME-Sender: <xms:qRzUanjO0lq1_iCh05wWS2AszCPGvjzDid8C-T3UbQZZ9DXNWIrg3A>
    <xme:qRzUauuRh5pR02mB4Cfrd0JYA2WlTrXDp70WD79zGlUuFlQOuCUG04xiSnDZ1c_19
    mQAG7LUGACcRTIlNRDCRvJQdewbvnDYKPVJlZHcJvAQkmlsqliLaELF>
X-ME-Received: <xmr:qRzUatv1NfTgCZll3K0hCPY4u9872BlYnyv4URO7lYAnlhpz7JVZ2Yw3HQ>
X-ME-Proxy-Cause: dmFkZTEvnTXb7wlPNdbPCo79KPjALe1WyOomyRWhprFt/vGO9Ai679h2SHP/kqZH93QGjI
    +ozfqZTdZKg7h8D7XL5tDXORgip7Vh/Iw1HAwfLVrotIcUbd7YOIXOUoOee/rBp3M0Vjrg
    +dCHbCyJpUvgDwj1Sq6UvkNmqYLWR8LGlOPh9uV2QqNtST1P/mE8LA6cwr9Va8hyC94yqA
    qqkwb0dmWcp6pYePryL50SA2PuYbwEc/oVV6UaV7j3KaFhmXYKYR0BJI2+N0Gws0eA+Nvv
    w8QrVGxrfUZtk6pI7rj1J/u/MY/qe89NuVYCSQ08nvYnSuJ6oNm4hXM0wwwaygLSlzP9Z2
    i6YYlf3qZsHFPOoLLyit+n5ap1/Qs4Ie0j6ixsRKNtQlFdAaPTCgdofAa7FPkcFzs6jXLR
    ho2J8Xr4vG8Y8bqauGwrVN8gMu3StR+YaEd8vQtihFl/gfx0kksVPcbMPbklHSxjzz1TF/
    j0IVX0HUIWvE29G/xH4eqM/MJ3gn3EuO6IhK5MZSwyr/8xesImV8m7p0dVi3mr6SYr2TKD
    ZoxnebomkTJciLsrdw9VyavNzukigajK+MJR0voUUXE0mjZWSAwumFi6czU4JSxFZyVE9J
    L1TMYaATsDxvf3HfUk3zg09csqiR7mNC987cOX1OQ4+AQ0pTmI31L7zzWAvw
X-ME-Proxy: <xmx:qRzUavML6aKT6Hb0mb0yqO4TlzLkEGfSwRyNvmDZWKkJYnD4W6NQqw>
    <xmx:qRzUaveHmcbn-gT7gI0J_a5vsZ1ukzaBryWKzcQUtzRAxPODWES-JA>
    <xmx:qRzUamllVWv-rKXbsIQ3xUZqjMW4HNQUlzybCcm8wxqYr07_9l1wOw>
    <xmx:qRzUahxD-5JRBjWdwEg6TCNU04-zDCfbBiQX6PWr1JIbzKv5_sGRgw>
    <xmx:qhzUamTrVIHs9pioam_XAHDlj_qDvXSWKUjHS_1tMb6KEZkl1Q6a07rk>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 21:11:04 -0400 (EDT)
Date: Sat, 17 Oct 2026 21:11:01 -0400
From: Ben Boeckel <me@benboeckel.net>
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
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Subject: Re: [PATCH] lib/tests: kunit for associative array
Message-ID: <atQcpQ-1J28uJyT9@rotor.dev.benboeckel.internal>
Reply-To: list.lkml.keyrings@me.benboeckel.net
References: <20261014160144.1835860-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014160144.1835860-1-jarkko@kernel.org>
User-Agent: Mutt/2.4.2 (2026-08-30)

On Wed, Oct 14, 2026 at 19:01:38 +0300, Jarkko Sakkinen wrote:
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
> ---
>  lib/Kconfig.debug             |  15 +
>  lib/tests/Makefile            |   1 +
>  lib/tests/assoc_array_kunit.c | 570 ++++++++++++++++++++++++++++++++++
>  3 files changed, 586 insertions(+)
>  create mode 100644 lib/tests/assoc_array_kunit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 6b24a2c89b84..3e8d3852f53c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2857,6 +2857,21 @@ config HASHTABLE_KUNIT_TEST
> 
>  	  If unsure, say N.
> 
> +config ASSOC_ARRAY_KUNIT_TEST
> +	tristate "KUnit test for assoc_array" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	select ASSOCIATIVE_ARRAY
> +	help
> +	  This builds the assoc_array KUnit test suite.
> +	  It tests the basic functionality of the API defined in
> +	  include/linux/assoc_array.h.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config LINEAR_RANGES_TEST
>  	tristate "KUnit test for linear_ranges"
>  	depends on KUNIT
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 3cac3b63a752..107e16b4ebc1 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -4,6 +4,7 @@
> 
>  # KUnit tests
>  CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
> +obj-$(CONFIG_ASSOC_ARRAY_KUNIT_TEST) += assoc_array_kunit.o
>  obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
>  obj-$(CONFIG_BITOPS_KUNIT) += bitops_kunit.o
>  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o

Why does this one end with `_TEST` and the others do not? I see
`LINEAR_RANGES_TEST` in the context above, but it also lacks `_KUINT`.
There is `HASHTABLE_KUNIT_TEST` nearby too, so perhaps consistency has
just never been popular around these parts.

Thanks,

--Ben
