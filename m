Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3F17A30A;
	Sat,  4 Apr 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333457; cv=none; b=mg1jBrSt3OB2l1O9Iw6gxblNDub79wClpK4suqNTddw/+lJ3Riur9XUdU06R41wFDUqATZ873o5/NdEgCAPEJ53Iyld84UUDQ5lPa+ukSc2wJIp8pBPZds8k1dTapc9wL4ModsVFQv+JjAplB01Sv7lmjO5UH+StCUBY6vibWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333457; c=relaxed/simple;
	bh=xHNfLHPPCUrX7KwupbxGpbJNGivKoYjH983TQbNQ0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsHj2hlR/e6Ywn9E7ELc71G7wtIgs/7QV3M5pofwYTWGkM4rlzMWv13lu5TzNHxLM6zmZpyIg8nDtvLxmYMpyaQOMVNy2qt//E5eR5w+8KufVScFmqEkH0BF32/AlTeAOlF4bKpnsY8l+vl0IxHiC3wCuRFeP8t9MjxQ7YKZzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5Qi6qNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5Qi6qNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CC4C19421;
	Sat,  4 Apr 2026 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775333457;
	bh=xHNfLHPPCUrX7KwupbxGpbJNGivKoYjH983TQbNQ0ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5Qi6qNmsiXvsV8rGW1njd1ZEitxHoJN9yTumcXmBXyn9rLk3PXGhv6q7Jx4f/FMb
	 Av0TtT2N548m3bhDBVVZTCnNuD3zTj8+kxqsuVNnKgtkvb61dZPpeN3Km737ey0JCw
	 yBFPSd17WTGKDThxO9bE1BuroJuEquPMO6LDaZQ2sAsXr20zHh+tK7hQ8KvrMUBDdt
	 GZrJMm9S58On7vXrS2T1i7pSZHrHA2ocVFQoTQWtju2pRoe5gSCn5ze6po0Tg1bNgV
	 bhE3VqVXY2a4hbiXS/TeWNphia0A9xV9+LIzHQkEdNxQkwNyF8/lik7UAT1V3kuJRY
	 hEfj2Guxv1V9Q==
Date: Sat, 4 Apr 2026 13:09:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Remove unnecessary selection of
 CRYPTO_RNG
Message-ID: <20260404200942.GA29238@sol>
References: <20260321224218.60418-1-ebiggers@kernel.org>
 <e77dc41b88d60377b81a0cdff4e3823d8aafe98a.camel@linux.ibm.com>
 <20260325000227.GC3622@quark>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325000227.GC3622@quark>

On Tue, Mar 24, 2026 at 05:02:27PM -0700, Eric Biggers wrote:
> On Tue, Mar 24, 2026 at 07:46:10PM -0400, Mimi Zohar wrote:
> > Hi Eric,
> > 
> > On Sat, 2026-03-21 at 15:42 -0700, Eric Biggers wrote:
> > > encrypted-keys uses the regular Linux RNG (get_random_bytes()), not the
> > > duplicative crypto_rng one.  So it does not need to select CRYPTO_RNG.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > > ---
> > > 
> > > This patch is targeting the keyrings tree
> > 
> > Not sure what you mean by targeting the keyrings tree. I can definitely queue
> > it.
> 
> Last time I sent a patch for encrypted-keys, Jarkko took it.  If you'd
> like to take it instead, that's fine with me.  As long as someone does
> it.  Thanks,

Anyone planning to take this?  It's not in linux-next yet.

- Eric
