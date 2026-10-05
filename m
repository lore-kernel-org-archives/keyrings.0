Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AD4BB268;
	Mon,  5 Oct 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212499; cv=none; b=Z+P0HDYNaVf7Ki+teLMZiulxwJYwXneUXftZwqX4UdDyZZDDszYg6tSy/Cksuuu/6+QjhCzvw3fdbzSk53Gvh9bErKifafnslo13OZVDGOtVRGKZ6mDP5VhRhJ0/t/qAVZ3OSf4ao8H/gj0EUB5l0TsDHAjz1kw9kBlxXZj/7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212499; c=relaxed/simple;
	bh=EskCKeiZGwxdu9zfkZksEUoza5HBgmgb/BIr5b4K5z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXfJ4BudyYiRX5Rx/XjLoDS7/eRYgRjITN7nKHtScIhofSaGznR6jLPOdtfS6ReQcmhzz4duM0YoXb86Zle4NCqbkzHtwtU7QIb/Ybtx6DZLQb5ga1CbRoenT3WT6Y8+/YG3ik0WfDVYIucpTxmKZ7844fZzRnARhy77V1HlKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=FS2r2uYt; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="FS2r2uYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791212492; bh=EskCKeiZGwxdu9zfkZksEUoza5HBgmgb/BIr5b4K5z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FS2r2uYtMmNL2S3mSPpa0gsXu1TxF1BfXP4NJMpNWj0WJ45+W6Oir/D5xvRvnlwTr
	 uxFZDS9fba7AdgDVKOnf3XDmCCna0CxYSkoTscaVo1Er47ZIvofuBFO6859q7z03K2
	 S1FGoWCG7vyCgCd8fwYCTMVM27A56CvW8yVNAw/tfixzpUkq5nX+twt3+ya3pD7PNN
	 0OwBeHQ9HgAxepy2GuPiamIaAWVGefig4HVmL2KUMV5Lds25oRM5clMs5mg9XiWhsl
	 ARgFEkjwP7huj0lZVbGAa4wCdPvX3RI6wn9+83+dMq56nONRU/QzKueoryrnzElH8B
	 zsCLn0JDCTqGQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C5B9B5A9; Mon,  5 Oct 2026 10:01:32 -0500 (CDT)
Date: Mon, 5 Oct 2026 10:01:32 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted_keys: reuse TPM version in option
 handling
Message-ID: <asO7zHFE3C6W8TV/@hallyn.com>
References: <20261002071050.179879-1-ssrish@linux.ibm.com>
 <asMYa0lD7RNcoszb@iki.fi>
 <d3574d84-84dd-4aa5-b80f-acc7844c3f12@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3574d84-84dd-4aa5-b80f-acc7844c3f12@linux.ibm.com>

On Mon, Oct 05, 2026 at 11:31:46AM +0530, Srish Srinivasan wrote:
> Hi Jarkko,
> 
> On 10/5/26 8:54 AM, Jarkko Sakkinen wrote:
> > On Fri, Oct 02, 2026 at 12:40:50PM +0530, Srish Srinivasan wrote:
> > > Determine the TPM version once in the seal and unseal paths and reuse it
> > > when allocating and parsing trusted key options. This avoids redundant TPM
> > > version checks.
> > So this is a bit nitpicking perhaps but a patch that would just clean
> > the code up a bit would not be be worth of applying. Almost anything
> > that "does nothing" goes to that bin.
> > 
> > What I'm saying is that the conclusion in the last sentence goes to
> > wrong direction but luckily the change has also feasible effects that
> > we care about.
> > 
> > By caching tpm_is_tpm2() there are less fallible sites in the key
> > creation process, and reduced number of roundtrips with the TPM chip.
> > 
> > Or from blackbox perspective it reduces I/O traffic between kernel
> > and the hardware platform.
> 
> 
> Yes, that makes sense. Thank you for pointing this out.
> 
> I will revise the commit message to highlight the reduced failure
> surface and I/O between the kernel and the TPM, and
> send v3.

And I've seen chips where every round trip is a roll of the dice as
to whether the chip will become useless till next reboot, so that is
a bigger win than I was first thinking.

> > > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > > Changelog:
> > > 
> > >   v2:
> > >    - Use bool to indicate whether the chip is TPM 2.0 in the option helpers
> > > 
> > >   security/keys/trusted-keys/trusted_tpm1.c | 35 +++++++++--------------
> > >   1 file changed, 13 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > > index 3ec078ca3f97..6dbce058368f 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > > @@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
> > >   /* can have zero or more token= options */
> > >   static int getoptions(char *c, struct trusted_key_payload *pay,
> > > -		      struct trusted_key_options *opt)
> > > +		      struct trusted_key_options *opt, bool is_tpm2)
> > >   {
> > >   	struct trusted_key_tpm *private = opt->private;
> > >   	substring_t args[MAX_OPT_ARGS];
> > > @@ -712,13 +712,8 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> > >   	unsigned long token_mask = 0;
> > >   	unsigned int digest_len;
> > >   	int i;
> > > -	int tpm2;
> > > -
> > > -	tpm2 = tpm_is_tpm2(chip);
> > > -	if (tpm2 < 0)
> > > -		return tpm2;
> > > -	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> > > +	private->hash = is_tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> > >   	if (!c)
> > >   		return 0;
> > > @@ -773,7 +768,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> > >   				break;
> > >   			}
> > > -			if (tpm2 &&
> > > +			if (is_tpm2 &&
> > >   			    private->blobauth_len <=
> > >   			    sizeof(private->blobauth)) {
> > >   				memcpy(private->blobauth, args[0].from,
> > > @@ -808,14 +803,15 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> > >   			}
> > >   			if (i == HASH_ALGO__LAST)
> > >   				return -EINVAL;
> > > -			if  (!tpm2 && i != HASH_ALGO_SHA1) {
> > > +			if (!is_tpm2 && i != HASH_ALGO_SHA1) {
> > >   				pr_info("TPM 1.x only supports SHA-1.\n");
> > >   				return -EINVAL;
> > >   			}
> > >   			break;
> > >   		case Opt_policydigest:
> > >   			digest_len = hash_digest_size[private->hash];
> > > -			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
> > > +			if (!is_tpm2 ||
> > > +			    strlen(args[0].from) != (2 * digest_len))
> > >   				return -EINVAL;
> > >   			res = hex2bin(private->policydigest, args[0].from,
> > >   				      digest_len);
> > > @@ -824,7 +820,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> > >   			private->policydigest_len = digest_len;
> > >   			break;
> > >   		case Opt_policyhandle:
> > > -			if (!tpm2)
> > > +			if (!is_tpm2)
> > >   				return -EINVAL;
> > >   			res = kstrtoul(args[0].from, 16, &handle);
> > >   			if (res < 0)
> > > @@ -838,15 +834,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> > >   	return 0;
> > >   }
> > > -static struct trusted_key_options *trusted_options_alloc(void)
> > > +static struct trusted_key_options *trusted_options_alloc(bool is_tpm2)
> > >   {
> > >   	struct trusted_key_tpm *private;
> > >   	struct trusted_key_options *options;
> > > -	int tpm2;
> > > -
> > > -	tpm2 = tpm_is_tpm2(chip);
> > > -	if (tpm2 < 0)
> > > -		return NULL;
> > >   	options = kzalloc_obj(*options);
> > >   	if (options) {
> > > @@ -858,7 +849,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
> > >   			kfree_sensitive(options);
> > >   			options = NULL;
> > >   		} else {
> > > -			if (!tpm2)
> > > +			if (!is_tpm2)
> > >   				private->keyhandle = SRKHANDLE;
> > >   			options->private = private;
> > >   		}
> > > @@ -877,13 +868,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
> > >   	if (tpm2 < 0)
> > >   		return tpm2;
> > > -	options = trusted_options_alloc();
> > > +	options = trusted_options_alloc(tpm2);
> > >   	if (!options)
> > >   		return -ENOMEM;
> > >   	private = options->private;
> > > -	ret = getoptions(datablob, p, options);
> > > +	ret = getoptions(datablob, p, options, tpm2);
> > >   	if (ret < 0)
> > >   		return ret;
> > >   	dump_options(options);
> > > @@ -922,12 +913,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> > >   	if (tpm2 < 0)
> > >   		return tpm2;
> > > -	options = trusted_options_alloc();
> > > +	options = trusted_options_alloc(tpm2);
> > >   	if (!options)
> > >   		return -ENOMEM;
> > >   	private = options->private;
> > > -	ret = getoptions(datablob, p, options);
> > > +	ret = getoptions(datablob, p, options, tpm2);
> > >   	if (ret < 0)
> > >   		return ret;
> > >   	dump_options(options);
> > > -- 
> > > 2.53.0
> > > 
> > Br, Jarkko
> 
> Thanks,
> Srish
