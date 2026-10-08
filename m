Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A71369D71;
	Thu,  8 Oct 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482332; cv=none; b=fA2XwTQKAQPmQofCsPH9jrwy7VgAGiAwRl4RnImS/mr6T5oeIbMVXi0hS/HbUxUQC+WLBSo8CjReNzzdyu4LFcgGp3Jyt1B98tZB2Tp1AHGW1ohDM86IRYwQZFHus8C7/ABv6HBE5RoBe4o3QZQuFQdqlKAaHnjqkm7sP11W7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482332; c=relaxed/simple;
	bh=ZOfIeqBZSG2XguYYH3G5Naq0ZUZFObMY5beXrDyMbs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jelBm0nc7CB5z0rES4VbxAU0PPFPk3sjEd/L373FwAwilQds8U5otWutNrr0209pd9CDrpVaUPAEgxm9ZNskYPggz8Ml+IgtdKPEKLkNhKiubhVElJOhGRRUDeeJ3irvYvxN8kuaPx/0IyWXEyGVzE1t3E+8QFeBF/Uvws4bJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDTJOmiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDTJOmiL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C5431F000FF;
	Thu,  8 Oct 2026 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482331;
	bh=Y+bL6D+HnKfyYxE4NI4ieT/71j8kh37gFgMr1EDpsyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDTJOmiLc9MUAxlybqfHoLTYJt3rxg0mlqmpmxTb3VqPUAl/nJfIG1Xjv9+ip7Xwp
	 G3X7eWCSgZ3wDHFNm6pO97+U4uYV0W7HIUdGBKxXAn5H1G5l+JyWs7n2ySRWLx8quT
	 +EIhRvn0CM615nDabVQWVh8vXf8bcfqN2CPC3+sGg5qpzNlVR72WXggSvOLi6cGDz4
	 SInX9espC2o8XxlOkZhszAUK3Hg/bnpGMNSOyBH3EwkMNDW9hbRkNfKebZIZ8maNip
	 4ZO/stX6DcAK+OUzuo/KAy1hotLSKI3Hm0y9881At2Gyypjp22YGY+axemAnkUolZ9
	 nqQqLtBOd5r1A==
Date: Thu, 8 Oct 2026 20:58:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: adrimg3196@gmail.com
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH] KEYS: Fix key_reject_and_link() race with keyring
 restriction
Message-ID: <asfZ176MFPXkUIGq@kernel.org>
References: <CACO1+RSZuymnONwwmmRj=2ji=hNP4MTyOZOPKvR-Rr1OXQtJ0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO1+RSZuymnONwwmmRj=2ji=hNP4MTyOZOPKvR-Rr1OXQtJ0A@mail.gmail.com>

On Thu, Oct 08, 2026 at 03:51:32AM -0700, adrimg3196@gmail.com wrote:
> The restrict_link check in key_reject_and_link() is done before taking
> the keyring semaphore, racing with a concurrent keyring_restrict()
> that installs the restriction while holding the semaphore in write
> mode.
> 
> This is the same pattern that commit dd3ea3fc ("KEYS: Fix add_key()
> race with keyring restriction") just fixed in __key_create_or_update()
> by moving the restrict_link snapshot to after the semaphore is taken.
> 
> Move the check under __key_link_lock() so a restriction installed
> concurrently cannot be bypassed when linking a negative key.
> 
> Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> ---
>  security/keys/key.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Something went wrong I guess? That's fine. I'm just pointing out
that there's no code change.

Br, Jarkko
