Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2934F479;
	Sun, 10 May 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422520; cv=none; b=lIdmgMsJIYKaMs7e3Sb/LchDYLhukv8AzqnuxQiCdOktyHq7DLff9/uyulFXRSfMKpjnwo8IxG+610dmN7cv3UnfswgLp5Kcyt0d7Y9qwwUv5UYnWVdfW8CnC7WNfOFM1i+FO1F3bfBbaYOF/cYH2o33F/pimPXJ4NTzsb2ZMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422520; c=relaxed/simple;
	bh=wRR1xeuPXc/ERpuUkGr/Dud0hz+KfTf1fQDlI/t+kC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK2O0fYpIptKIEIsmkrMt1C71OufswOHVhzkildC9JeVDXjaRFGVEk2YbWFFKoqBlnUlBkDoAW60NBZwnFxXuspD+CR6/J0R2ky5Uumlo6ZxxEocIKhnDXZFw81R6mGdG1ghpw8t45zn1xWt0vbZ4wUDTwoj/hF8AmN0i2YT14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1ZLSQzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1ZLSQzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77527C2BCB8;
	Sun, 10 May 2026 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778422520;
	bh=wRR1xeuPXc/ERpuUkGr/Dud0hz+KfTf1fQDlI/t+kC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1ZLSQzxfp11nndKq6q8tPg8mHk2I6A6l1hUNEpiMHhoSQFtaoXHhlJN2Q9iqsmcD
	 zluYrv8RGIbknYuFZCJiNldBWcLB1piH4ihTFttnefD6a1DzFNTPrVJBa6M5OCpj6T
	 Ibc7rqv0Rrdq7mlwEiwK6FdbFGnNyGB4ilFkWQmHND3YvZzQ+kR60h6LqUppqEe1hj
	 RsuJZl4fqbAmJaxSg+4O8Goy2Yd50p3nfw+v1dfXIhEGGFmbpa379Cqn6uejxjnEP5
	 Ct+E+onCyqEP9Z7AePh6eWINRqbxWy16/XprN/YB2ItP9kEzDZe7p/Sj0AgTDbJuKG
	 gcqb+fQfr5eIw==
Date: Sun, 10 May 2026 17:14:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
Message-ID: <agCS4O1E336c1aYc@kernel.org>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <20260427114422.313356-4-thorsten.blum@linux.dev>
 <af8ZUXn4uStU_vs5@kernel.org>
 <agBiPEJZhWHydwuz@linux.dev>
 <agCSNaiHTcsN3Ye8@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCSNaiHTcsN3Ye8@kernel.org>

On Sun, May 10, 2026 at 05:12:13PM +0300, Jarkko Sakkinen wrote:
> On Sun, May 10, 2026 at 12:47:24PM +0200, Thorsten Blum wrote:
> > On Sat, May 09, 2026 at 02:24:01PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Apr 27, 2026 at 01:44:24PM +0200, Thorsten Blum wrote:
> > > > Add the __counted_by() compiler attribute to the flexible array member
> > > > 'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > > > CONFIG_FORTIFY_SOURCE.
> > > > 
> > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > 
> > > This is again a crippled commit message.
> > > 
> > > I.e. this requires either knowing, remembering and/or cross-referencing
> > > "bunch of" unrelated to keyring.
> > 
> > I kept the commit message short because it follows the same pattern as
> > many other __counted_by() patches that have been accepted across several
> > subsystems.
> > 
> > I'm not sure which part of the message you want expanded. Could you be
> > more specific?
> 
> "Describe your problem. Whether your patch is a one-line bug fix or 5000
> lines of a new feature, there must be an underlying problem that
> motivated you to do this work. Convince the reviewer that there is a
> problem worth fixing and that it makes sense for them to read past the
> first paragraph."
> 
> This is a direct quote from https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

And there's pretty good reasons to do this too as commit message is not
just a cover leter for a patch. It's also reminder in the commit log why
something was done.

BR, Jarkko
