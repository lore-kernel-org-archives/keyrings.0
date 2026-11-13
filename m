Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579012;
	b=GGGxTepz4Ef9qOy3bXQz5Y/EWJQ1Ylj1XG7xlxmVZfAdn2m8YhW7LT3fLZHw6A7hfXuJ
	 pVCkVKouLOzo+0x9xstRRk2v6reMmMmo+yryk+7FFiRL+Y4mW2/VMSGmYeEsiDYwfQHtv
	 TxrDgcZWnUS7jC2vk10kiUGziVrfj3x9GosTemU994ISalz/wsprKY5iiOTJ1tIFroJc+
	 qNjb+vAcnfHNa7hqQIwQeKbxdsR3NKsAAYfdau5MkVbvfqOhaQlsTYGmWeh7Xuts7n6x7
	 dSi8YWy31tO4HWvahZMhzFBNhMi3vsxPXJPchGsFSaRnRoQyK1f6KFdEVNx2B7u7vbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579012;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EyBrWOqpJB8NzQH3qSxQQbUZiyjhJcDw2e2H9dImxoQ=;
	b=Cd4nire2k5bumZHbz80yHTfwpM+iXyoRO/0T55ktc/PTzPmR3Hs0K2JCjRHKh8UtCTrq
	 iWKOPaHLndRtaYH20knPdxztRcSahTBYq7XVLdyN70GxSYA7nYi7bvhL6aH+TOBNpn7DJ
	 BZ+rIpokdk3ssgKrkegSiPDujTPFEiOn1Dhnyt9UVT2yvl6oRaXX7EHc51pSxdo775Ros
	 WRaaeGFw/SZufmt4/TyGuoUTsI1kz43mGWkCAAcBiOKtdFtBwglHUYrGCH++avsWuVEuS
	 Rcd+WNOcv8di9oHOvCNvW+8WDSX0V3rK3cPeD1+0Kbz9Lvv9Pq1x1FmjF0/3H5Vc3Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLNsdQQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CB8A1606A339;
	Fri, 13 Nov 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLNsdQQE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DDCDF1F000C6;
	Fri, 13 Nov 2026 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579012;
	bh=EyBrWOqpJB8NzQH3qSxQQbUZiyjhJcDw2e2H9dImxoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KLNsdQQEmhOBg3iDnIQM9by3fOiCh8gu8HuApUIemodGNo8XFNK3TDqpqltGN2rZI
	 OjXwbOFh0BpWtMrTGXnUgZH2KJC1i+wSAiNFNp0Ds3YoyRuFcEIUUAe4hrU1uB99Iw
	 JTBk8VLxlXSaLOpct0g1Q1GW04mYrtwd3FeAB8UjHKY5dGcy5FKDCk7URW9iHc+vVj
	 P+8tseU7AWddrOwbEpo+rGi1uePqD6kY3EnXKCIWRu0cgIJJwk7+JmkA1YGMM9NPRs
	 iok12Ap6U5g5yrTYrMLddYC0tnXYbOyqbFABxezK+rjBRhndM1DlE8fStO+S15Evv5
	 UWehWoVHSFLYw==
Date: Fri, 13 Nov 2026 16:10:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	dhowells@redhat.com, Florian Bauckholt <florian.bauckholt@cispa.de>
Subject: Re: [PATCH] KEYS: Fix signature input size for KEYCTL_PKEY_VERIFY
Message-ID: <avcaQGqHKnNFNFSG@kernel.org>
References: <20261113140311.1375048-1-stefanb@linux.ibm.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113140311.1375048-1-stefanb@linux.ibm.com>

On Fri, Nov 13, 2026 at 09:03:11AM -0500, Stefan Berger wrote:
> Revert the changes made for signature verification in cb481e59ea6c back
> to the old behavior where effectively the params->in2_len was set to the
> length of the user provided buffer uparams.in2_len (out_len is an alias
> for in2_len due to the union). We cannot use the max_sig_size in the
> case of signature verification since this is neither the true size of the
> input buffer nor would it pass tests of size indicators found in the ASN.1
> in the buffer comparing against the input buffer size.
> 
> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Florian Bauckholt <florian.bauckholt@cispa.de>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/keys/keyctl_pkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399b5..794fa3d01911 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  		    uparams.in2_len > info.max_sig_size)
>  			return -EINVAL;
>  
> -		params->out_len = info.max_sig_size;
> +		params->in2_len = uparams.in2_len;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> -- 
> 2.56.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

Br, Jarkko
