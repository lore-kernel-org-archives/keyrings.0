Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B730C160;
	Fri,  2 Oct 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911908; cv=none; b=mklFma6lwwS1mlu0yqQWK1XbdjbnghlVusEeCo8pjuTAhlaUq6DDHIDZ9U+dL/Z89SYtFABIIenYaLrN9ys0iRykcVFx13n05g1wnN0Pi36TzBCxTLh8X0ZHOOlaTLnyLK+6nOYaTiGeYpoH9L4n8nSlp+x+s/ZmAEZJqbb4sxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911908; c=relaxed/simple;
	bh=HRmbrYZUTwvE4rq+nQo7v5Hp/1ia7qHIZrpDdEYISGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw5ii1eev+gs8ErPQbR+jSB6WSWFLZh20TG4hhs84HfG+Ig6T23QqBLVpgtMvKRjXcDloxwG/AaMpAbyMnApI9CaXefMto6j3mmvQdkZRh19qISYfk3gvzo3R13I3udua4HKUQfdNk6C51IP3kjLRMRaElOg2Wzj+PG6WIOEMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlyL9pBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlyL9pBr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7503A1F000FF;
	Fri,  2 Oct 2026 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790911907;
	bh=TiibAs8PiBtqNA1LnqVckyg+8Z8VA15spk4Kr6gNLxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlyL9pBrWglWZBdnstHIi10nyz1EH4nsgbxNQIflzcAZYS2AgjQcYdzhphWogMXXt
	 uWCiXbC5iywpm3CwEgvcmniCoR8JGmd5nb6BHpquIFbUZ0RZw0jRCTiAQ48Hmo9nWn
	 bwBtbg81KxUSoq+SNrnfUelsj0UoCXhcAhmvuDKk50eDairID4/MBvSIcUY3oWGzbL
	 79OOlqvbY48sugUaMyKgty+hOen1C6m0arFO+jsOF9vWgQIBLVE4C5rtSd0mHX32tZ
	 bBBf4TsbZUrsTnI3K1++SRTHVDoQxB4u3P4OCpX9T4W60b45i7f92E3sFpf7TFBQql
	 woLAFJHHXWFsA==
Date: Fri, 2 Oct 2026 06:31:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH] keys/trusted_keys: reuse TPM version in option handling
Message-ID: <ar8ln4Au8rDe_Ssm@kernel.org>
References: <20260930060217.112471-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930060217.112471-1-ssrish@linux.ibm.com>

On Wed, Sep 30, 2026 at 11:32:17AM +0530, Srish Srinivasan wrote:
> Determine the TPM version once in the seal and unseal paths and reuse it
> when allocating and parsing trusted key options. This avoids redundant TPM
> version checks.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 3ec078ca3f97..70de4101923f 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
>  
>  /* can have zero or more token= options */
>  static int getoptions(char *c, struct trusted_key_payload *pay,
> -		      struct trusted_key_options *opt)
> +		      struct trusted_key_options *opt, int tpm2)
>  {
>  	struct trusted_key_tpm *private = opt->private;
>  	substring_t args[MAX_OPT_ARGS];
> @@ -712,11 +712,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	unsigned long token_mask = 0;
>  	unsigned int digest_len;
>  	int i;
> -	int tpm2;
> -
> -	tpm2 = tpm_is_tpm2(chip);
> -	if (tpm2 < 0)
> -		return tpm2;
>  
>  	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>  
> @@ -838,15 +833,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	return 0;
>  }
>  
> -static struct trusted_key_options *trusted_options_alloc(void)
> +static struct trusted_key_options *trusted_options_alloc(int tpm2)

Probably "bool is_tpm2" would be better here. It does not need to be
tightly coupled with the tristate acquired from tpm_is_tpm2.

>  {
>  	struct trusted_key_tpm *private;
>  	struct trusted_key_options *options;
> -	int tpm2;
> -
> -	tpm2 = tpm_is_tpm2(chip);
> -	if (tpm2 < 0)
> -		return NULL;
>  
>  	options = kzalloc_obj(*options);
>  	if (options) {
> @@ -877,13 +867,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> -	options = trusted_options_alloc();
> +	options = trusted_options_alloc(tpm2);
>  	if (!options)
>  		return -ENOMEM;
>  
>  	private = options->private;
>  
> -	ret = getoptions(datablob, p, options);
> +	ret = getoptions(datablob, p, options, tpm2);
>  	if (ret < 0)
>  		return ret;
>  	dump_options(options);
> @@ -922,12 +912,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> -	options = trusted_options_alloc();
> +	options = trusted_options_alloc(tpm2);
>  	if (!options)
>  		return -ENOMEM;
>  	private = options->private;
>  
> -	ret = getoptions(datablob, p, options);
> +	ret = getoptions(datablob, p, options, tpm2);
>  	if (ret < 0)
>  		return ret;
>  	dump_options(options);
> -- 
> 2.53.0
> 

Br, Jarkko
