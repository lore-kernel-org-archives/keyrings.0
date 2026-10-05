Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85527311C2C;
	Mon,  5 Oct 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185964; cv=none; b=tepjaulAHpn3lkiYOmU3q2+OP32kHY3IvbQNbxQD1rSuO647ndrfYns0RQixkVNyAqnQjAhvJ1BDyJklipi/dDcNN/3J+m8d2WSm6euAmsw9/o5M9ioxy5P0f+ntwWwSl6zgSQEJlaX04fc7x7F6yYcFfm09zDwkRQhsRMTMQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185964; c=relaxed/simple;
	bh=R0UMO0ZisrBL/9mzVTcUKMICQaS+k7EaK7/N1YAvpbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUEI2hN0sHP7CbJhejHOu+Mv2PtD3ZVwP2AM6hfauo9FV8FSvGQmtktjXPlLlAesm8/QQ2M4xQ7icvYfOGEUv0MfmbmlYo2w0HUC1WO4AiUO4y+fpqy7JtAoLHpnQBo1rrvuLwwX6C8CzQCfsrxCSE9A4gj209Xe/YnXtiwK46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8PJtDAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8PJtDAs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3F75B1F000FF;
	Mon,  5 Oct 2026 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185962;
	bh=qeTjX6V1/llBNwNhy/HZwmi3JE2ekGp1kdz0gFyfevE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m8PJtDAsHKPHd57Pw+KhqhcB2US210H6q7vyvNP9BdSo1uqcjoztKg9n34GewIKiL
	 K1SZ5p1ZxWYgOfdIN/k215pRoDdxI+7wvY5SgxMwtcgRU9O28/DM5isVxrXKlWAIbh
	 2iPnOThmZXlGcMBjhwk/QOlYG5Xl31bQuTbvuJ0BoZcy2Gbm7KkD0YuB2EZ5dV7Bv3
	 WaKNp4yo3XiyQ8Jm6XpWvrXbWM7lv/Ft1O/IKhPWvHHjxn5IYfbzh8/z2GXb1A/7XA
	 lbZu8yPkPT12AgkGhtaUFqbt8rkBv9/3FaJ5V+IpDgY3DYK394g/f2ksNR8pFiRbvz
	 CyoIli5UmvOUg==
Date: Mon, 5 Oct 2026 10:39:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v3] keys/trusted_keys: reuse TPM version in option
 handling
Message-ID: <asNUJlc-cIB1R0xP@kernel.org>
References: <20261005062732.140733-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005062732.140733-1-ssrish@linux.ibm.com>

On Mon, Oct 05, 2026 at 11:57:32AM +0530, Srish Srinivasan wrote:
> Determine the TPM version once in the seal and unseal paths, and reuse
> it when allocating and parsing trusted key options.
> 
> This reduces the number of fallible calls to tpm_is_tpm2() and avoids
> unnecessary I/O between the kernel and the TPM.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
> Changelog:
> 
>  v3:
>   - Tweak the commit message to highlight the reduced failure surface and
>     TPM I/O
> 
>  v2:
>   - Use bool to indicate whether the chip is TPM 2.0 in the option helpers
> 
>  security/keys/trusted-keys/trusted_tpm1.c | 35 +++++++++--------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 3ec078ca3f97..6dbce058368f 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
>  
>  /* can have zero or more token= options */
>  static int getoptions(char *c, struct trusted_key_payload *pay,
> -		      struct trusted_key_options *opt)
> +		      struct trusted_key_options *opt, bool is_tpm2)
>  {
>  	struct trusted_key_tpm *private = opt->private;
>  	substring_t args[MAX_OPT_ARGS];
> @@ -712,13 +712,8 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	unsigned long token_mask = 0;
>  	unsigned int digest_len;
>  	int i;
> -	int tpm2;
> -
> -	tpm2 = tpm_is_tpm2(chip);
> -	if (tpm2 < 0)
> -		return tpm2;
>  
> -	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> +	private->hash = is_tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>  
>  	if (!c)
>  		return 0;
> @@ -773,7 +768,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  				break;
>  			}
>  
> -			if (tpm2 &&
> +			if (is_tpm2 &&
>  			    private->blobauth_len <=
>  			    sizeof(private->blobauth)) {
>  				memcpy(private->blobauth, args[0].from,
> @@ -808,14 +803,15 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			}
>  			if (i == HASH_ALGO__LAST)
>  				return -EINVAL;
> -			if  (!tpm2 && i != HASH_ALGO_SHA1) {
> +			if (!is_tpm2 && i != HASH_ALGO_SHA1) {
>  				pr_info("TPM 1.x only supports SHA-1.\n");
>  				return -EINVAL;
>  			}
>  			break;
>  		case Opt_policydigest:
>  			digest_len = hash_digest_size[private->hash];
> -			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
> +			if (!is_tpm2 ||
> +			    strlen(args[0].from) != (2 * digest_len))
>  				return -EINVAL;
>  			res = hex2bin(private->policydigest, args[0].from,
>  				      digest_len);
> @@ -824,7 +820,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			private->policydigest_len = digest_len;
>  			break;
>  		case Opt_policyhandle:
> -			if (!tpm2)
> +			if (!is_tpm2)
>  				return -EINVAL;
>  			res = kstrtoul(args[0].from, 16, &handle);
>  			if (res < 0)
> @@ -838,15 +834,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	return 0;
>  }
>  
> -static struct trusted_key_options *trusted_options_alloc(void)
> +static struct trusted_key_options *trusted_options_alloc(bool is_tpm2)
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
> @@ -858,7 +849,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
>  			kfree_sensitive(options);
>  			options = NULL;
>  		} else {
> -			if (!tpm2)
> +			if (!is_tpm2)
>  				private->keyhandle = SRKHANDLE;
>  			options->private = private;
>  		}
> @@ -877,13 +868,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
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
> @@ -922,12 +913,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
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

Great, applied thank you.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
