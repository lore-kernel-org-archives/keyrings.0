Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D188385502;
	Wed,  8 Apr 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637795; cv=none; b=ToKx5as6CWfTMob6Z4GEx+H5pyAywiTBs/0a4nVQLhJRvt5OsZmR5XoC0Z5m65NGg+BwmAen7JAVR0dBNRMbcqy1B9BwCJ+xyKywzOwokNNnUek+vdeSxQbVYwxGVTjIr7ogYhQVrYvblmERxEngUjKXuyqqFP1bT3SE86nDLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637795; c=relaxed/simple;
	bh=1uQvQ+PoU9qySMaPTkY2NM8sXmrnTbJwDP1Pmc2z4yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Bf8yHzGIq2FS+hsuFRcD/TukZlgpRSrK2UdMWQ3oZ+KUm2tJGz3B6ZWUtrTxVjWTvofh/IKRVhVnJAcsyFknvrl/SLboqYpKnCybW0pcfSmtkjJkIHTz7jJ7fbCsLfv9iSXl0s7P1eao9juo9NU4E/4Rb0sgUjwPGTgVNllcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnv4JK5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnv4JK5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEDCC19424;
	Wed,  8 Apr 2026 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637795;
	bh=1uQvQ+PoU9qySMaPTkY2NM8sXmrnTbJwDP1Pmc2z4yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnv4JK5ydR73NB8+fTUZDAWEKGGyGAqfej90Ct4h9rPezwt3v/0bcJ5Lq1kdjBskk
	 4qgM1+Zfnge2GEpceByhGQgqHMKhvokC4UN70825sQENFdjxw6Sm2+60iNG8z2HEMR
	 PnC3Q1Nq7SFe3mQg3hdyQEroEi95DKTwyObyqIIdIOwinGz88uUApjDQzPUpufJYC5
	 WqZfzWhp/ZtN3zD54OqXjAqKH5I/WqKN5UPn9HFXvUnnge+oP+4nbDwrXFk3AcW8EE
	 S9q3iHHjtFA1upaay9zBg2TLyAGjDdNaFz+sL0Ogi/KlYsZs4rWdaloPjB6P97Rg14
	 GNm5GMNqwTKpA==
Date: Wed, 8 Apr 2026 11:43:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Remove unnecessary selection of
 CRYPTO_RNG
Message-ID: <adYVH3upYAX_Quq7@kernel.org>
References: <20260321224218.60418-1-ebiggers@kernel.org>
 <e77dc41b88d60377b81a0cdff4e3823d8aafe98a.camel@linux.ibm.com>
 <20260325000227.GC3622@quark>
 <20260404200942.GA29238@sol>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404200942.GA29238@sol>

On Sat, Apr 04, 2026 at 01:09:42PM -0700, Eric Biggers wrote:
> On Tue, Mar 24, 2026 at 05:02:27PM -0700, Eric Biggers wrote:
> > On Tue, Mar 24, 2026 at 07:46:10PM -0400, Mimi Zohar wrote:
> > > Hi Eric,
> > > 
> > > On Sat, 2026-03-21 at 15:42 -0700, Eric Biggers wrote:
> > > > encrypted-keys uses the regular Linux RNG (get_random_bytes()), not the
> > > > duplicative crypto_rng one.  So it does not need to select CRYPTO_RNG.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > 
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > > ---
> > > > 
> > > > This patch is targeting the keyrings tree
> > > 
> > > Not sure what you mean by targeting the keyrings tree. I can definitely queue
> > > it.
> > 
> > Last time I sent a patch for encrypted-keys, Jarkko took it.  If you'd
> > like to take it instead, that's fine with me.  As long as someone does
> > it.  Thanks,
> 
> Anyone planning to take this?  It's not in linux-next yet.

It has been holiday season but I applied it. Later today I'll update my
next branch.

> 
> - Eric

BR, Jarkko
