Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3A4E432E;
	Wed, 14 Oct 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981787; cv=none; b=C2nkEr+1ayz2PtRMn92Cdjx2W5dzn1yxR1UkRCOkPLpT77b44TVVWrHQvQpujLp+Kf431wNdydA67x+E59nxR1RBD2kT135FIqM3pDOwM/RytPhyI2IyNOiDVwadrLDCFS555yRcgvOuWnWxY3kag2g0hOwZ7lfPJgKaFhoU1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981787; c=relaxed/simple;
	bh=Y2lM4EzlaIXPpK6qwuX98QxB3nPWBH/nrRzl7ZOwpXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPQSNAGf1sH6pf5e5mzPYZ4LxkC6DuINNCpcS1T2zGKK1fphRDegy9cVU3bIqaKrAm2lWVegvF3SeRM3nGs8NEhfw8rd1HxeCNwkWASyOR9zAI+1/2HM2YoXoNVXtfXGKWoVk823DVYh0PcuDdE/d0Z61HLZStzwgX1OQV2Or2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIy55xAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIy55xAo"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 99F4E1F000FF;
	Wed, 14 Oct 2026 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981786;
	bh=iPLrY9eK2rtIIWdHd/Lavg1paupKO3LVGrSIRGRjJks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIy55xAogAIrYMZV4L1gLKJcgW+uwnuoHronQ8f5XFz++GmV8pXNo+eie37oeBrrP
	 i6L6JIhAtP0g6MOU/r9gD51UeQNJgPcFDbCykKDpQ1ri6s85QGZ0hLafBVRUnc4Gwh
	 2KU7VxDKixgm4kcCTFJNctInGC8AsN1wG8dUPD5Er+rH1k4jrdJYzflLaLqE+nKjRu
	 2uGRsG1P1/5p4cnSLIO5bKWnjIT4wRCOjmvWCb4xSI9ezmbSCMO/0yQaf9TMlnvI9C
	 WPLylTlpmgeNjlhPS3BjOwnWY/4MltydW9wMouIfv7njzVSyIetGVqQJsyVWrzMxH/
	 pPpdmGZ5RwYvw==
Date: Wed, 14 Oct 2026 15:43:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH v2] keys: make keyring indexes independent of kernel
 addresses
Message-ID: <as941m0HXNruztLc@kernel.org>
References: <20261013231251.56170-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013231251.56170-1-kylebot@openai.com>

On Tue, Oct 13, 2026 at 04:12:51PM -0700, Kyle Zeng wrote:
> KEYCTL_READ returns the serial numbers in a keyring in associative-array
> traversal order.  The first word of the index is a public, deterministic
> hash of the type pointer, domain pointer and description.  An unprivileged
> user can therefore insert keys with known descriptions, predict their
> order for each possible KASLR slide, and recover the kernel image address.
> On an x86-64 build with 16 MiB alignment, 45 user keys suffice to
> distinguish the candidate slides.
> 
> Remove the addresses from the whole index, not just its first hash word.
> Assign each key type and domain a nonzero 64-bit ID and hash those IDs and
> the description with a once-initialized SipHash key.  Use the full IDs in
> the later index chunks as well.  Truncating or hashing the IDs there would
> lose the guarantee that distinct type/domain/description tuples have a
> differing index bit.
> 
> Allocate IDs lazily since private key types need not be registered.  Cache
> them in the index key so tree walks and copies of an existing index do not
> need to dereference a type descriptor that may have been unregistered.
> Keep the 32-bit chunk layout and diff_objects() bit offsets consistent,
> and retain the separate root slot for keyrings used by recursive search.
> The key comparison, permissions and userspace data format are unchanged;
> only the address-dependent in-memory ordering is replaced.
> 
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll apply this.

And thanks for addressing that and sorry for nitpicking. Looks good to
me and thanks for addressing the bug. This is kind of AI assisted commit
to works for me; and I believe that checks are balances are in place.

Not everyone gets this, and the problem is that they also in effect
reduce the number of point of failures from two to one due
ignorance-by-a-choice.

A person submitting an AI-assisted patch is also a reviewer, and
ignoring this increases the probability of bad getting into mainline
quite literally.

I think some people might not really understand this at all but is
just that it is much less likely that two people get a patch wrong
and at the same time, than just one. That's it ;-)

This is not an AI/LLM problem. It is a misconduct by people quite
well scoped really...

Sorry for the rant just wanted to write this down and get this out
of my chest. Absolutely nothing to do with this patch.

Br, Jarkko
