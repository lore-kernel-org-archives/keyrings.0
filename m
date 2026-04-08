Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658F385502;
	Wed,  8 Apr 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637731; cv=none; b=JZ3gscOOMZuM9woBK8OHb5TSOXZMpXClpcX97WaaMfEU1v1nV+KfuzTgASldYNQxCUgu749OkiO2QMicQN2MtUmAO/FhiJ/FtIl2VQHsvFQFAK71HZPCQD4ib4OOmMnffq+n32QIImQ2n08djqx6BTnDSfGFSxia/Vo84b9YVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637731; c=relaxed/simple;
	bh=FLw7XffmbozsDsHljw3hJuztyYxlXHgTBU8/Dg64sLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ10Jevb+yxQFWS1FapPA5ODQrdl0k/tkxD5r06TDrjEwJUHxAqG+osnddwptEQbTYSQFUE23IiZhZbHZ8HvkSlVQMnlg2kYiLhnJdZr1M8iAsR+jvBn8rFAmjxeguEFN9woOnlBHGRHm3rZvthZKI4Fnw6InRc2tkZsJfbLN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmeSjcdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmeSjcdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D2C19424;
	Wed,  8 Apr 2026 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637731;
	bh=FLw7XffmbozsDsHljw3hJuztyYxlXHgTBU8/Dg64sLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmeSjcdK0dHqb5ZdCykmhF1b2PqT11Q5WOjiOhuJPb5YP7zdRASu2d14BMS+1yGbT
	 zADMU8g1kbGnZwhCdh/j6aHCJ1Hpm/NfWf2LTBfogcc2KxYHCax+SbfBlzld3z696Q
	 Sm8Gc213pDiJ1KdPSvPDAo1N/A4Ce44/dOUvDEdmGHFHx2eNSTWOeUG5zOT7Bx52es
	 k1UPi0DIgKb3YM3oq8uYz9yijLGyf7+Lcjouzh1wXDnr4HwOg+JEw8qA69KVvmc+J0
	 xVY1Is3J4StLwefwnKTUiliuinKE+EHOn3CFdRljEF83GyDtwoCH8gr7Ub5QHWarMG
	 qT9024CIFQ91A==
Date: Wed, 8 Apr 2026 11:42:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Remove unnecessary selection of
 CRYPTO_RNG
Message-ID: <adYU36nbA0vdXXGJ@kernel.org>
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
> 
> > 
> >  security/keys/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> > index 84f39e50ca36..f4510d8cb485 100644
> > --- a/security/keys/Kconfig
> > +++ b/security/keys/Kconfig
> > @@ -85,11 +85,10 @@ config ENCRYPTED_KEYS
> >  	tristate "ENCRYPTED KEYS"
> >  	select CRYPTO
> >  	select CRYPTO_AES
> >  	select CRYPTO_CBC
> >  	select CRYPTO_LIB_SHA256
> > -	select CRYPTO_RNG
> >  	help
> >  	  This option provides support for create/encrypting/decrypting keys
> >  	  in the kernel.  Encrypted keys are instantiated using kernel
> >  	  generated random numbers or provided decrypted data, and are
> >  	  encrypted/decrypted with a 'master' symmetric key. The 'master'
> > 
> > base-commit: 113ae7b4decc6c2d95bdbbe52e615a0137ef7f9f

I applied this.

BR, Jarkko
