Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72323F40D;
	Fri, 28 Aug 2026 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881594; cv=none; b=ZSAP6n9Iq91qJOUq2GaZQtHaikbDEgH55MACd+70xWuhlCpAEnS7lYSInL9KFkaPwkiog/jNKQKo3CRNE5TRFtWDdx88LQyoRakUh2L3TMrhv5PuvW4xecYXi28qjvgbONP8QX5sm/G/KKuuCSh/Rw1BMuDcqt9iIZsojY4pT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881594; c=relaxed/simple;
	bh=rWbPuiLM6kveF1zhG1HZoHtKHgeTBdcQs16WCUOXArU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k470bxOegC+h/LeMnuxJMxJwezTZj6ZFotHqGezPD4ltXN0HAwSDPLQ/mGZIL0iYNmMgnhav+eO7gm0BfYsyw/9QQlgtr9uqm3xJzs9nVpj8I8hu8RD0GuKMx1yYqv4ybXyK8L3ASCvI65G55Ldtu1VhRvz41wEQvYdnseaEltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdOfCn34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdOfCn34"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E80361F000E9;
	Fri, 28 Aug 2026 01:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881589;
	bh=BZWLsWtVITIf4iYFfpNvgFMDadOeUE6CNl8Ep+F4Jlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IdOfCn34EPGb4if09usnYBwqZNdiR4MND8x1vBJQwL15mgxOWLHADw+C+CF3mDrSS
	 rqSvfcwgmzvWA/lojO3niCTjRHOnd0kG9XSWjEc4+Iw7jCqmOjl6wXw8GR8ccoM3oH
	 DhRmqK3ZWBQXg6Qm0RqI04JpAzZzQ41ot12wnTMp7XVXILczjq+xsl2aUX74a6KTO+
	 8T+KHvg6imz3EwKUXCX9bfJcAOaiJC/wIpVnJ2qw3OoPF2K4uMGeQMpmpy0EbV+Ykg
	 zDGspfgYM+ld3TNXKo5chYc5rvRRWYyUv0RlZ3oxBHFriIkdOE3J1aI2nk4aIPHuN4
	 Xjo8TI6mEGw/g==
Date: Fri, 28 Aug 2026 04:46:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sn0x-sharma <sanketsharmacsec@gmail.com>,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, w@1wt.eu
Subject: Re: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal()
 before memcpy
Message-ID: <apDocVfEfwX3hFa_@kernel.org>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <2026082651-portal-valid-da58@gregkh>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082651-portal-valid-da58@gregkh>

On Wed, Aug 26, 2026 at 08:18:32AM +0200, Greg KH wrote:
> On Tue, Aug 25, 2026 at 06:29:18PM +0000, sn0x-sharma wrote:
> > tpm_seal() computes storedsize from TPM response fields and passes
> > it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
> > validation. A forged TPM response can set storedsize to 4086,
> > overflowing the 512-byte blob by 3574 bytes into adjacent slab
> > objects.
> > 
> > Add a check that storedsize does not exceed MAX_BLOB_SIZE before
> > the memcpy, returning -EINVAL on oversized responses.
> > 
> > Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
> > Link: https://lore.kernel.org/linux-integrity/
> 
> That's not a valid link :(

Oops, missed this one ;-)

Should be just deleted, b4 shazam will set the link tag.

> 
> > Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
> 
> No need for a reported-by: if you author and sign off on the patch.
> 
> And we need a real name please, not an alias.
> 
> thanks,
> 
> greg k-h

BR, Jarkko
