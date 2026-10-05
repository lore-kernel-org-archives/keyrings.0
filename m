Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF942BB13;
	Mon,  5 Oct 2026 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791170681; cv=pass; b=BE0QyEUZuHHyNbCwStL0yjbo5pUsq925l39WWy2EIlbJG1q6gdXJEDDmXQsaotBvybaem9xhPC/bK+6BrlgRoDd/Z4rJrpE41hO7mDKmo6t/2Aq1UJUW1ZgQ1FtAZC0Qee0mfZMi0Iu2gAfrVd3/ZECR7oeOqQmTlPgr+jQGWlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791170681; c=relaxed/simple;
	bh=/OpyfRbtAnxayrlPh816YeH05yy4MNv3q+j0yCtF0ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s052Y0AKk7nWMK+QBeZfnCC0Sj7Oz7pwFpNZocb0T/59pQlQsJU2vEKchzg8LmXKEkEyezYU9y6gIcyH3C2WRH2+wXmbCL4caLGnFetLM5edG4lIgTukDyX68qR644ASJZ6G470UlNkmmXzMj1HBSDBrO4cSCAPtvExfaNNhVdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=yo5zQ1KS; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="yo5zQ1KS"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hyl9n53W2zyPr;
	Mon, 05 Oct 2026 06:24:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791170670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNRz1toTh6bB7HNi6C5BvLL1pGIm3Wc/gEwUsQhgObo=;
	b=yo5zQ1KSHgOYG/+tvsCG7IS0iWSuFWG3Oo3remyMHg4h6NiR2k/Wp3WyjM0aKF7mLcQvrZ
	9XelyGhfq4ARooBq9ZQfjJz9SgRNHr03oUOP7HipYTCVeQjgDBuyUH2sfoS1IH4waSRfy5
	wWmxrZ8jehQCn45C04Lp9Qj50yVuQx4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791170670;
	b=Zm5jRMhUMbECCzA5nmRSZoBWZvApiP6naqUPs6P10i3FGEbEyqSm7fRH+eagXSnC28741M
	j4qRm0M1jJNtpMBykVGGQ9oMhOyz/3pmuQbUBSQSVd97/xPA7g7Shx9Bt9RHsUnFOfrHvK
	e2+X4FE5wGY3B774RFxXwBosaCsfaxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791170670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNRz1toTh6bB7HNi6C5BvLL1pGIm3Wc/gEwUsQhgObo=;
	b=Niz3akOtlLt8YBYjdGdRpIQb/WlKkXCA9gHCPL3PUMP69nmHAbEs8vQ4sK4sExWGOkDjKg
	p0zKDh58uBlXnCCWmV4ZMAl/U8C5derDX+ytAlR3Sm7jEfm16OkJlG0rHQ1r29rYuCVlRA
	LS3nuLEJIrv8nUt2sp8B7ImIjvMvj8Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 06:24:27 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted_keys: reuse TPM version in option
 handling
Message-ID: <asMYa0lD7RNcoszb@iki.fi>
References: <20261002071050.179879-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002071050.179879-1-ssrish@linux.ibm.com>

On Fri, Oct 02, 2026 at 12:40:50PM +0530, Srish Srinivasan wrote:
> Determine the TPM version once in the seal and unseal paths and reuse it
> when allocating and parsing trusted key options. This avoids redundant TPM
> version checks.

So this is a bit nitpicking perhaps but a patch that would just clean
the code up a bit would not be be worth of applying. Almost anything
that "does nothing" goes to that bin.

What I'm saying is that the conclusion in the last sentence goes to
wrong direction but luckily the change has also feasible effects that
we care about.

By caching tpm_is_tpm2() there are less fallible sites in the key
creation process, and reduced number of roundtrips with the TPM chip.

Or from blackbox perspective it reduces I/O traffic between kernel
and the hardware platform.

> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
> Changelog:
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

Br, Jarkko
