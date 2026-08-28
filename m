Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84516EEA8;
	Fri, 28 Aug 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881737; cv=none; b=NJdZymMolOFaqYqr/s7AWZGzFmmUHC07nnUkqHNFGtmGNoOZeT5OGgrSu4MhM9I6RbFzPIvUO2KPYzij7E9CxztD54MiHkj50PCmXeb265G7anA0ijgAZLDrxrBd9RiYm5bRFa6ZSZ+J3ghuBcbllwiwXFA5IKxrHVvS5A4T1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881737; c=relaxed/simple;
	bh=9GQj1dAq1dLBVhD71kzsVD9cDCjAwoYyeauMj0pGsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrF+L+TWNiyY4QzgqDR2GUIAGE3nXOkL1dvk1olLeZd5Q17eti7V8GoqRDIhX2g62jyInNsrgRRyu3xb3/dipeuu+7FF1sWifX9yIk+PzgQ1fLJbnOE3ulqn5cicJ0tCcziKyxh2sq4GnulveWFj+IqdHE4QFFPlbhJKYNdcc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llxIWQFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llxIWQFT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D171B1F000E9;
	Fri, 28 Aug 2026 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881736;
	bh=wo4FCAjDOKndHUSorb8iLPYOJuJ6AlqY7FPfHRH2IWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=llxIWQFTKn0Z/beqIxCtTU75POIvFSVVU0323Nwdc2hBHycnHNfDAA55boR2+EiXU
	 qV+NBCVkZCc30eGKzTcOOuix//cnphHoNi9NfbfIKXzk88usSNNsd493AVEzd+pz0i
	 9DXN7kMKc0rpha+3UhWHV4KZ/wx6VKZul3xI3H+CJsMpVPbzK8F6duB+DMfg9+0rLR
	 5I5/MF04bXXjGo6YZ4FD5EDuwtzzs5I2VSCEnrdb9qEgUgKGveVmdE3/H+44VXYgb+
	 t+5jmzzfAu42wZdmYQBlaBFXBC6KQ3UcZlkS9HTgDxbMD8BjfedXrVZ3p02oKFAsnZ
	 pvNyxlvlbdbgg==
Date: Fri, 28 Aug 2026 04:48:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sanket Sharma <sanketsharmacsec@gmail.com>
Cc: sudhakar@linux.ibm.com, gregkh@linuxfoundation.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 2/2] keys: trusted: tpm1: reject unauthenticated
 response tag in TSS_checkhmac1/2
Message-ID: <apDpBEAmDmtuJShz@kernel.org>
References: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
 <20260826170700.616-1-sanketsharmacsec@gmail.com>
 <20260826170700.616-2-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826170700.616-2-sanketsharmacsec@gmail.com>

On Wed, Aug 26, 2026 at 05:07:00PM +0000, Sanket Sharma wrote:
> TSS_checkhmac1() and TSS_checkhmac2() silently return success when the
> response tag is TPM_TAG_RSP_COMMAND (0x00c4), bypassing HMAC
> verification entirely. A forged TPM response with this unauthenticated
> tag allows an attacker to skip integrity checks on TPM responses.

I don't think we need threat scenario role play here.

> 
> Reject TPM_TAG_RSP_COMMAND with -EINVAL in both functions, requiring
> all responses to carry a proper authenticated tag.
> 
> Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index d47cb7108..6dbbf4546 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -201,8 +201,6 @@ static int TSS_checkhmac1(unsigned char *buffer,
>  	tag = LOAD16(buffer, 0);
>  	ordinal = command;
>  	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
> -	if (tag == TPM_TAG_RSP_COMMAND)
> -		return 0;
>  	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
>  		return -EINVAL;
>  	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
> @@ -269,8 +267,6 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  	ordinal = command;
>  	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
>  
> -	if (tag == TPM_TAG_RSP_COMMAND)
> -		return 0;
>  	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
>  		return -EINVAL;
>  	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
> -- 
> 2.53.0
> 

BR, Jarkko
