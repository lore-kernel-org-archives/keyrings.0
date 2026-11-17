Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885848;
	b=VWo2yZnbLFb7ubA7XslNKM/sB+WnT9baU7rgGT4jxen7smcmIzskZV1Hkr0DW4Q8/Kkw
	 EIIKGpLwF/oDltoaytzOlMkPn+SckDHzDKVOBGrE3pUPolR8GSs74wgJGiaa22Ich+iwM
	 dlgQeW8qsDgzQo4NL4gwk5SNA7/bV0m9IVUP1lmOv4VuKso6BEjg57zETP1814hXK32RS
	 t301hUpOplF/XatTYUUJ9+ZQYcjaH3r2gue7x/NJbCwGPKLXzlABWb6R3UOIwEaLQ2CBb
	 mOkkS6PAz7O2kK9x10QTJKAMLZ0tKfmHG6ryFi3WxUzxvr8uQGDx4AytrPz4gGlmgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3orSBMWKdzbMx744GJIWZnn0L4NEkFQ8t34eASoTZSA=;
	b=1X452n1PXPAY9Hrz8eIVpxDt4vvONursPkNXZpcPPi2g+o8xX2LF4sbUIq67BFw4+bx2
	 Golb7Dls8ieDBwu8ye2MdwVoFX0+Q1xWpNr+8GREo9zv/jjORrPnC2FCXinPpdlG+Urkx
	 Jme2MdDZeyZ0KPKomS8f/JLw9struW24MN7JQvhawfYBlsPhiFVzK9whHqyXPLPcVdSoU
	 PncPvHxd1/cectYGRid9JleHQDiFge/WbbeEjYqdO+1sbTHrvRrf97qXHxYsE2Vheyf95
	 FuDwMVKXng6OvmwrwINZi5xh3PkoTMf8vf4/CE61GTCoAn0y3N+RCL04gkF3qfMxSEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jgrPVDr/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 737EE606A323;
	Tue, 17 Nov 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgrPVDr/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3B0CF1F000C4;
	Tue, 17 Nov 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885847;
	bh=3orSBMWKdzbMx744GJIWZnn0L4NEkFQ8t34eASoTZSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jgrPVDr/2pu0oWBxS7zsNS2iIhhXxVLBF68T/jibx5TmONcez9qvzUe2zs26Cnky/
	 7fGwO7fJXVFIopWdEFlOUlhlKn6/lV3rQVSIsjb6BgNhXm9HHUy40ZHPM4acFsZvop
	 ULsbIEktV8PZYsVqfAsdMRHDykFhpjXeEv2UMK79uc2ru1hjnzen4uzzXEaeyhbWjd
	 7oQU+yeEJ7nbV87XK69HDu0dlUcZnajNkfsoxKXG8/cxlcYhzG+J0TNkoRzI31XihN
	 YwcNHntvvKe0Fj8EaTSYD82mrtcc76SthYYTaLLSTumBFG5Un2jriZsELJepU7+4j8
	 01LgtnxlI9vyw==
Date: Tue, 17 Nov 2026 05:24:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: William =?utf-8?Q?Chuang=2C_Founder_=E2=80=93?= Logarcheon <founder@logarcheon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lib/asn1_decoder: add KUnit test suite
Message-ID: <avvI1PuQUtBlfZWP@kernel.org>
References: <20261117001711.47722-1-founder@logarcheon.com>
 <avuumVbCS2YQi4cv@kernel.org>
 <wzMUBnLl6Z2s-eoaXFHCl92wV6voRbr7imPSy9hdJzHqoxg3869_lCqHtMa3G5N3H0G9XfrGCW9Nzw0Vm0HCJhvNKkTUtUFDXuM7S821AIU=@logarcheon.com>
 <avvFgRqiYnBo9Q7c@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avvFgRqiYnBo9Q7c@kernel.org>

On Tue, Nov 17, 2026 at 05:09:57AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 17, 2026 at 02:39:37AM +0000, William Chuang, Founder – Logarcheon wrote:
> > Fair questions.
> > 
> > Why at all: asn1_ber_decoder() parses untrusted ASN.1 BER/DER input. X.509 certificates (keyrings) and PKCS#7 signatures (module signing) both go through it, and it has had a length-validation bug of this kind before — CVE-2016-0758, in asn1_find_indefinite_length(). 
> > Scope: the suite checks that malformed and truncated input is rejected rather than over-read, in the cases it exercises. It does not reproduce that CVE or prove the decoder memory-safe. That it isn’t vacuous: I weakened one bounds check in asn1_decoder.c to allow a short over-read. asn1_test_truncated_content then fails its return-value check — the decoder accepts a truncated SEQUENCE (returns 0 instead of -EBADMSG). The other 12 cases pass; reverting restores 13/13.
> > 
> > Why KUnit: it exercises the in-kernel decoder directly, with no
> > userspace harness, and the cases can also run under KASAN/UBSAN
> > (verified in my config). It is deterministic and is not built into production kernels.
> > 
> > Why in-kernel: the coverage travels with the code. An out-of-tree test does not run when someone changes lib/asn1_decoder.c.
> > 
> > I agree the maintenance has to be justified by the coverage. If the current cases are too thin to carry, I’m happy to strengthen or narrow them on your feedback.
> > 
> > Thanks,
> > William
> 
> I'd start by learning to use the email client properly at first:
> 
> https://docs.kernel.org/process/email-clients.html

Within past 17 years the total number of commits is 22. This includes
all the possible. Of these total six carry a Fixes tag.

That makes about 0.35 bug fixes annually. How do you explain this?

For me this looks whole a lot like LLM lottery i.e., sending random
and useless patches in the hopes that something might happen to get
in.

Your previous kunit supports this point of view given that it is
a possible "LLM remix" of a patch (kunit for assoc_array) that I
sent a month ago but we discarded the idea in favor of a better
solution.

Stop doing this.

Br, Jarkko
