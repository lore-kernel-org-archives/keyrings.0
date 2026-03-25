Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3495533D6;
	Wed, 25 Mar 2026 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396949; cv=none; b=Ri9L1II9rqS2qIjRJ6Oz0lDC7S1gmGP64FAfgWJQrPDEUx1OCxcvu+QKfje+CvMqD/BvgaACD+/VF2oJ3HDk44vml3FOlv4CyApz7ba8o4NwmLlll0lV/SVODFWVDVLqNFnpiUlef1QPzybm0LjensgqvL/wdmHUv2UHgGtIXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396949; c=relaxed/simple;
	bh=2XSCqAjUOdMrD7e3kCPP87lCQ0jI38Z1ZJyMhRLsKgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPODVtYd+qHqypWmxTBncpalDJJeoRP45e+vkJbpaFBli1GwCuI1cvq5gi2f56Yw7ydoIINJjGHyWpCxtpZd43mOx/+OjF/kommz8YwKsbpikfB2ejYfxEmF751VxGiE2XeVyVdQwb9w3FKoy4IUibzaDbPmkOmxuurykjWpuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnf/cUjR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnf/cUjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A4C19424;
	Wed, 25 Mar 2026 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774396949;
	bh=2XSCqAjUOdMrD7e3kCPP87lCQ0jI38Z1ZJyMhRLsKgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnf/cUjRvmbNfgscsyAmP94GiBBcUUjegvEYtIWQBOouLKJaa87XeSpo0cMsZEArL
	 FiKPkl8kcXKLsHocBZwzTWeNmbKr7Ie/MUhZNvDlztiJ0j0lmq4/fu6fgTjqV+lATR
	 3FwmJS2FQkBh+8qS6WQIpkc1cGNmk5w4mVmnHbV5QAtmH/c3xVwNBgCQMBHVMX3wFn
	 fMP9EOnp8VQAf3rkLxUOcbrl+6qD9rxgwMmEnozYy8CeZRqjcFkO28ZXuM4qOPE9JM
	 ZcwAi9bfPL4XX5kY4XsdusI9Fwz1gNY0/u1lRnYLJgcIcv84pC02L7lssr+7q6iREd
	 FUAN0H9wMIt3A==
Date: Tue, 24 Mar 2026 17:02:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Remove unnecessary selection of
 CRYPTO_RNG
Message-ID: <20260325000227.GC3622@quark>
References: <20260321224218.60418-1-ebiggers@kernel.org>
 <e77dc41b88d60377b81a0cdff4e3823d8aafe98a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77dc41b88d60377b81a0cdff4e3823d8aafe98a.camel@linux.ibm.com>

On Tue, Mar 24, 2026 at 07:46:10PM -0400, Mimi Zohar wrote:
> Hi Eric,
> 
> On Sat, 2026-03-21 at 15:42 -0700, Eric Biggers wrote:
> > encrypted-keys uses the regular Linux RNG (get_random_bytes()), not the
> > duplicative crypto_rng one.  So it does not need to select CRYPTO_RNG.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> > ---
> > 
> > This patch is targeting the keyrings tree
> 
> Not sure what you mean by targeting the keyrings tree. I can definitely queue
> it.

Last time I sent a patch for encrypted-keys, Jarkko took it.  If you'd
like to take it instead, that's fine with me.  As long as someone does
it.  Thanks,

- Eric
