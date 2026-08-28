Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDA3F106C;
	Fri, 28 Aug 2026 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881474; cv=none; b=R89F0E1GzQe7/PDskxpoea26J90DvFrtnd1hdgVfVDI4DDtfuNTqokjeO/sbcagb0mOc5Q7mdITOIVU68BafM9rg9wmqBZF0keq+0g1Ude+WY27BkdwpjyLERK/NmXkRKTzYIY/kjV7bwUgcLw/UChERoY9btTzj73S3x/ZODIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881474; c=relaxed/simple;
	bh=Jie+QLkYg6YgDo8ApBRmyR11+TL4JDlQwsPxo4+6amY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbmgGu/SrNiAoOz1mMgr+4pC/8hfFN7A2ykm/o7pAA+jTeRCh9NmOagPq5IyfmRYMoCheWS4cr4q64R/vcOdAH0evIB7Wj+gkBsK1dHfcY8yR4X/xnkWEKxnTr3NLOk1moBbiFNPQEfQRufjcGs0CzS0j4zT6QMaoNVeG8atgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GofVuAGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GofVuAGE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 195861F000E9;
	Fri, 28 Aug 2026 01:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881472;
	bh=ptnA8B4SOg2D1E4VCTxVl7KR4hgwvDyXWo+zLIjdg3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GofVuAGEYqcjKWWKyO90i6xTGjHcx6cEhcPDQcRDAFCuYWYcVTaI5U6ZaVgy845d6
	 +mvfNkVEelT7Ltce5qOQlrCM/jS+oS0jgvQ1dcmGnzg/SpNOmtSEYCQ3FmjZXmi2Sr
	 yttQJG6iuIf/fXJLt2cN4M8QbZhm8vwAGizYiQe6AVLJ3GWS6tAGs9svZ9++7xDUjK
	 BwI1iu9na3htC4YV3vBaaM0ygBRS6ziTqLq4H4Zs0RzkoekeiWYQiSrokJeuXi3y6q
	 Em4iSk983HU/UdqqAyrXhmEYVq+CVEDEcel4oGxCe9K5sZPA+2y7M7QFFB6hMEP4rK
	 F7zQ+u4cKN1qw==
Date: Fri, 28 Aug 2026 04:44:28 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sn0x-sharma <sanketsharmacsec@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, w@1wt.eu
Subject: Re: [PATCH 2/2] keys: trusted: tpm1: reject unauthenticated response
 tag in TSS_checkhmac1/2
Message-ID: <apDn_ODmEGo0JxRQ@kernel.org>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <20260825182919.15943-2-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825182919.15943-2-sanketsharmacsec@gmail.com>

On Tue, Aug 25, 2026 at 06:29:19PM +0000, sn0x-sharma wrote:
> TSS_checkhmac1() and TSS_checkhmac2() silently return success when the
> response tag is TPM_TAG_RSP_COMMAND (0x00c4), bypassing HMAC
> verification entirely. A forged TPM response with this unauthenticated
> tag allows an attacker to skip integrity checks on TPM responses.
> 
> Reject TPM_TAG_RSP_COMMAND with -EINVAL in both functions, requiring
> all responses to carry a proper authenticated tag.
> 
> Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>

SOB is enough.

> Link: https://lore.kernel.org/linux-integrity/
> Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>

If by any means possible, use your real name here.

> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index d47cb7108..c89fc6cfe 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -202,7 +202,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
>  	ordinal = command;
>  	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
>  	if (tag == TPM_TAG_RSP_COMMAND)
> -		return 0;
> +		return -EINVAL;
>  	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
>  		return -EINVAL;
>  	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
> @@ -270,7 +270,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
>  
>  	if (tag == TPM_TAG_RSP_COMMAND)
> -		return 0;
> +		return -EINVAL;
>  	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
>  		return -EINVAL;
>  	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
> -- 
> 2.53.0
> 

otherwise looks ok

BR, Jarkko
