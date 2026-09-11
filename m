Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6F4A4F18;
	Fri, 11 Sep 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162948; cv=none; b=s7MrJC0LRhv8hJblb65KRUzIzDH0jmuVmA8qc3Xjv32uL0W5yrKvt++GUdVNYRx/99cmsPWbcX15fEEy4LQR6CGKTbKoAUZ7p+6GYfxvWP4i2xFXxDKw4A+Io9b/CQV5jvr62mvxBPwcl8VvKF3/gMfpLl20/qQ1IqEyer3WU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162948; c=relaxed/simple;
	bh=YXZHOkrqgjB2I/aPhOJZASUbR5udHHzdujxSKDglAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDnOXgl4Dn7vKPkEWzX1boNr6JxJtz9wAzkMVBpkkE2k+5gSqk4C4kkenB+xni3ULEPx1pBHARfwXHP81lc+4uIx+C8ZS3O7AMx2UvEVI1qsAzEUf+45ootDDR43dFEbdiIfaio4aAl2Fo/uQdby9v64uHLeicQAl9QUjDBPSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daJe7NnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daJe7NnO"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B53751F00893;
	Fri, 11 Sep 2026 21:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789162945;
	bh=dpFpwzqiE3Hgj2kxe5pSeLf8fecZkbfG1rJ5BKZWvDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daJe7NnOXHZpNlqvxxQ5T4SymTOAmpMjRphuFyQXw6AwHKAQJWMp42k891+HSA/TR
	 l0ptmLe3VEVtzWagfVVrowtvGhiENehubU8jleTJ14DTXfNyUSQhWdjzegizRlMk2s
	 tTXURJ3TRoabk1uwvwpejAeuxzXEvs7FFzTPkrarkBQ34dO6GtOTcKgKTocUy//x9j
	 P1ALp9f6n6OJ5mnOmGFNJhUvzN8ZQhlNpPYssAbiQQFSa522g6znYVws3QNAaJG+Z8
	 6JLQDu42nXG6NnB8joB41PhuaJ1eg6msf7LoO+6fPZYQ3vi3Z5iwQYlrGBUGoCU2tN
	 Q48rAHMRNvZcw==
Date: Sat, 12 Sep 2026 00:42:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v7 2/2] keys/trusted_keys: move TPM-specific fields into
 struct trusted_key_tpm
Message-ID: <aqR1vX9u209mCHsq@kernel.org>
References: <20260902230305.118931-1-ssrish@linux.ibm.com>
 <20260902230305.118931-3-ssrish@linux.ibm.com>
 <aqHfyBdvENc9i69r@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqHfyBdvENc9i69r@kernel.org>

On Thu, Sep 10, 2026 at 01:38:00AM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 03, 2026 at 04:33:05AM +0530, Srish Srinivasan wrote:
> > The trusted_key_options struct contains TPM-specific fields (keyhandle,
> > keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
> > policydigest_len, policydigest, and policyhandle). This leads to the
> > accumulation of backend-specific fields in the generic options structure.
> > 
> > Define struct trusted_key_tpm and move the TPM-specific fields there. Store
> > a pointer to it in the private member of struct trusted_key_options.
> > 
> > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  include/keys/trusted-type.h               |  11 --
> >  include/keys/trusted_tpm.h                |  14 +++
> >  security/keys/trusted-keys/trusted_tpm1.c | 123 ++++++++++++----------
> >  security/keys/trusted-keys/trusted_tpm2.c |  50 +++++----
> >  4 files changed, 111 insertions(+), 87 deletions(-)
> > 
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index 9f9940482da4..3db61b57cf73 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -39,17 +39,6 @@ struct trusted_key_payload {
> >  
> >  struct trusted_key_options {
> >  	uint16_t keytype;
> > -	uint32_t keyhandle;
> > -	unsigned char keyauth[TPM_DIGEST_SIZE];
> > -	uint32_t blobauth_len;
> > -	unsigned char blobauth[TPM_DIGEST_SIZE];
> > -	uint32_t pcrinfo_len;
> > -	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> > -	int pcrlock;
> > -	uint32_t hash;
> > -	uint32_t policydigest_len;
> > -	unsigned char policydigest[MAX_DIGEST_SIZE];
> > -	uint32_t policyhandle;
> >  	void *private;
> >  };
> >  
> > diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> > index 3a0fa3bc8454..dafbd4a84ddd 100644
> > --- a/include/keys/trusted_tpm.h
> > +++ b/include/keys/trusted_tpm.h
> > @@ -6,6 +6,20 @@
> >  
> >  extern struct trusted_key_ops trusted_key_tpm_ops;
> >  
> > +struct trusted_key_tpm {
> > +	uint32_t keyhandle;
> > +	unsigned char keyauth[TPM_DIGEST_SIZE];
> > +	uint32_t blobauth_len;
> > +	unsigned char blobauth[TPM_DIGEST_SIZE];
> > +	uint32_t pcrinfo_len;
> > +	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> > +	int pcrlock;
> > +	uint32_t hash;
> > +	uint32_t policydigest_len;
> > +	unsigned char policydigest[MAX_DIGEST_SIZE];
> > +	uint32_t policyhandle;
> > +};
> > +
> >  int tpm2_seal_trusted(struct tpm_chip *chip,
> >  		      struct trusted_key_payload *payload,
> >  		      struct trusted_key_options *options);
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index 9cdfeea800a3..3ec078ca3f97 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -48,15 +48,17 @@ enum {
> >  #ifdef CONFIG_TRUSTED_KEYS_DEBUG
> >  static inline void dump_options(struct trusted_key_options *o)
> >  {
> > +	struct trusted_key_tpm *private = o->private;
> > +
> >  	if (!trusted_debug)
> >  		return;
> >  
> >  	pr_debug("sealing key type %d\n", o->keytype);
> > -	pr_debug("sealing key handle %0X\n", o->keyhandle);
> > -	pr_debug("pcrlock %d\n", o->pcrlock);
> > -	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> > +	pr_debug("sealing key handle %0X\n", private->keyhandle);
> > +	pr_debug("pcrlock %d\n", private->pcrlock);
> > +	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
> >  	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
> > -			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> > +			     16, 1, private->pcrinfo, private->pcrinfo_len, 0);
> >  }
> >  
> >  static inline void dump_sess(struct osapsess *s)
> > @@ -626,6 +628,7 @@ static int tpm_unseal(struct tpm_buf *tb,
> >  static int key_seal(struct trusted_key_payload *p,
> >  		    struct trusted_key_options *o)
> >  {
> > +	struct trusted_key_tpm *private = o->private;
> >  	int ret;
> >  
> >  	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
> > @@ -637,9 +640,10 @@ static int key_seal(struct trusted_key_payload *p,
> >  	/* include migratable flag at end of sealed key */
> >  	p->key[p->key_len] = p->migratable;
> >  
> > -	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
> > +	ret = tpm_seal(tb, o->keytype, private->keyhandle, private->keyauth,
> >  		       p->key, p->key_len + 1, p->blob, &p->blob_len,
> > -		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
> > +		       private->blobauth, private->pcrinfo,
> > +		       private->pcrinfo_len);
> >  	if (ret < 0)
> >  		pr_info("srkseal failed (%d)\n", ret);
> >  
> > @@ -652,6 +656,7 @@ static int key_seal(struct trusted_key_payload *p,
> >  static int key_unseal(struct trusted_key_payload *p,
> >  		      struct trusted_key_options *o)
> >  {
> > +	struct trusted_key_tpm *private = o->private;
> >  	int ret;
> >  
> >  	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
> > @@ -660,8 +665,8 @@ static int key_unseal(struct trusted_key_payload *p,
> >  
> >  	tpm_buf_init(tb, TPM_BUFSIZE);
> >  
> > -	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
> > -			 o->blobauth, p->key, &p->key_len);
> > +	ret = tpm_unseal(tb, private->keyhandle, private->keyauth, p->blob,
> > +			 p->blob_len, private->blobauth, p->key, &p->key_len);
> >  	if (ret < 0)
> >  		pr_info("srkunseal failed (%d)\n", ret);
> >  	else
> > @@ -697,6 +702,7 @@ static const match_table_t key_tokens = {
> >  static int getoptions(char *c, struct trusted_key_payload *pay,
> >  		      struct trusted_key_options *opt)
> >  {
> > +	struct trusted_key_tpm *private = opt->private;
> >  	substring_t args[MAX_OPT_ARGS];
> >  	char *p = c;
> >  	int token;
> > @@ -712,7 +718,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  	if (tpm2 < 0)
> >  		return tpm2;
> >  
> > -	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> > +	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> >  
> >  	if (!c)
> >  		return 0;
> > @@ -726,11 +732,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  
> >  		switch (token) {
> >  		case Opt_pcrinfo:
> > -			opt->pcrinfo_len = strlen(args[0].from) / 2;
> > -			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
> > +			private->pcrinfo_len = strlen(args[0].from) / 2;
> > +			if (private->pcrinfo_len > MAX_PCRINFO_SIZE)
> >  				return -EINVAL;
> > -			res = hex2bin(opt->pcrinfo, args[0].from,
> > -				      opt->pcrinfo_len);
> > +			res = hex2bin(private->pcrinfo, args[0].from,
> > +				      private->pcrinfo_len);
> >  			if (res < 0)
> >  				return -EINVAL;
> >  			break;
> > @@ -739,12 +745,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  			if (res < 0)
> >  				return -EINVAL;
> >  			opt->keytype = SEAL_keytype;
> > -			opt->keyhandle = handle;
> > +			private->keyhandle = handle;
> >  			break;
> >  		case Opt_keyauth:
> >  			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
> >  				return -EINVAL;
> > -			res = hex2bin(opt->keyauth, args[0].from,
> > +			res = hex2bin(private->keyauth, args[0].from,
> >  				      SHA1_DIGEST_SIZE);
> >  			if (res < 0)
> >  				return -EINVAL;
> > @@ -755,21 +761,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  			 * hex strings.  TPM 2.0 authorizations are simple
> >  			 * passwords (although it can take a hash as well)
> >  			 */
> > -			opt->blobauth_len = strlen(args[0].from);
> > +			private->blobauth_len = strlen(args[0].from);
> >  
> > -			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> > -				res = hex2bin(opt->blobauth, args[0].from,
> > +			if (private->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> > +				res = hex2bin(private->blobauth, args[0].from,
> >  					      TPM_DIGEST_SIZE);
> >  				if (res < 0)
> >  					return -EINVAL;
> >  
> > -				opt->blobauth_len = TPM_DIGEST_SIZE;
> > +				private->blobauth_len = TPM_DIGEST_SIZE;
> >  				break;
> >  			}
> >  
> > -			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
> > -				memcpy(opt->blobauth, args[0].from,
> > -				       opt->blobauth_len);
> > +			if (tpm2 &&
> > +			    private->blobauth_len <=
> > +			    sizeof(private->blobauth)) {
> > +				memcpy(private->blobauth, args[0].from,
> > +				       private->blobauth_len);
> >  				break;
> >  			}
> >  
> > @@ -787,14 +795,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  			res = kstrtoul(args[0].from, 10, &lock);
> >  			if (res < 0)
> >  				return -EINVAL;
> > -			opt->pcrlock = lock;
> > +			private->pcrlock = lock;
> >  			break;
> >  		case Opt_hash:
> >  			if (test_bit(Opt_policydigest, &token_mask))
> >  				return -EINVAL;
> >  			for (i = 0; i < HASH_ALGO__LAST; i++) {
> >  				if (!strcmp(args[0].from, hash_algo_name[i])) {
> > -					opt->hash = i;
> > +					private->hash = i;
> >  					break;
> >  				}
> >  			}
> > @@ -806,14 +814,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  			}
> >  			break;
> >  		case Opt_policydigest:
> > -			digest_len = hash_digest_size[opt->hash];
> > +			digest_len = hash_digest_size[private->hash];
> >  			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
> >  				return -EINVAL;
> > -			res = hex2bin(opt->policydigest, args[0].from,
> > +			res = hex2bin(private->policydigest, args[0].from,
> >  				      digest_len);
> >  			if (res < 0)
> >  				return -EINVAL;
> > -			opt->policydigest_len = digest_len;
> > +			private->policydigest_len = digest_len;
> >  			break;
> >  		case Opt_policyhandle:
> >  			if (!tpm2)
> > @@ -821,7 +829,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  			res = kstrtoul(args[0].from, 16, &handle);
> >  			if (res < 0)
> >  				return -EINVAL;
> > -			opt->policyhandle = handle;
> > +			private->policyhandle = handle;
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > @@ -832,6 +840,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >  
> >  static struct trusted_key_options *trusted_options_alloc(void)
> >  {
> > +	struct trusted_key_tpm *private;
> >  	struct trusted_key_options *options;
> >  	int tpm2;
> >  
> > @@ -844,15 +853,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
> >  		/* set any non-zero defaults */
> >  		options->keytype = SRK_keytype;
> >  
> > -		if (!tpm2)
> > -			options->keyhandle = SRKHANDLE;
> > +		private = kzalloc_obj(*private);
> > +		if (!private) {
> > +			kfree_sensitive(options);
> > +			options = NULL;
> > +		} else {
> > +			if (!tpm2)
> > +				private->keyhandle = SRKHANDLE;
> > +			options->private = private;
> > +		}
> >  	}
> >  	return options;
> >  }
> >  
> >  static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
> >  {
> > -	struct trusted_key_options *options = NULL;
> > +	struct trusted_key_options *options __free(kfree_sensitive) = NULL;
> > +	struct trusted_key_tpm *private __free(kfree_sensitive) = NULL;
> >  	int ret = 0;
> >  	int tpm2;
> >  
> > @@ -864,15 +881,15 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
> >  	if (!options)
> >  		return -ENOMEM;
> >  
> > +	private = options->private;
> > +
> >  	ret = getoptions(datablob, p, options);
> >  	if (ret < 0)
> > -		goto out;
> > +		return ret;
> >  	dump_options(options);
> >  
> > -	if (!options->keyhandle && !tpm2) {
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > +	if (!private->keyhandle && !tpm2)
> > +		return -EINVAL;
> >  
> >  	if (tpm2)
> >  		ret = tpm2_seal_trusted(chip, p, options);
> > @@ -880,24 +897,24 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
> >  		ret = key_seal(p, options);
> >  	if (ret < 0) {
> >  		pr_info("key_seal failed (%d)\n", ret);
> > -		goto out;
> > +		return ret;
> >  	}
> >  
> > -	if (options->pcrlock) {
> > -		ret = pcrlock(options->pcrlock);
> > +	if (private->pcrlock) {
> > +		ret = pcrlock(private->pcrlock);
> >  		if (ret < 0) {
> >  			pr_info("pcrlock failed (%d)\n", ret);
> > -			goto out;
> > +			return ret;
> >  		}
> >  	}
> > -out:
> > -	kfree_sensitive(options);
> > +
> >  	return ret;
> >  }
> >  
> >  static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >  {
> > -	struct trusted_key_options *options = NULL;
> > +	struct trusted_key_options *options __free(kfree_sensitive) = NULL;
> > +	struct trusted_key_tpm *private __free(kfree_sensitive) = NULL;
> >  	int ret = 0;
> >  	int tpm2;
> >  
> > @@ -908,16 +925,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >  	options = trusted_options_alloc();
> >  	if (!options)
> >  		return -ENOMEM;
> > +	private = options->private;
> >  
> >  	ret = getoptions(datablob, p, options);
> >  	if (ret < 0)
> > -		goto out;
> > +		return ret;
> >  	dump_options(options);
> >  
> > -	if (!options->keyhandle && !tpm2) {
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > +	if (!private->keyhandle && !tpm2)
> > +		return -EINVAL;
> >  
> >  	if (tpm2)
> >  		ret = tpm2_unseal_trusted(chip, p, options);
> > @@ -925,18 +941,17 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >  		ret = key_unseal(p, options);
> >  	if (ret < 0) {
> >  		pr_info("key_unseal failed (%d)\n", ret);
> > -		goto out;
> > +		return ret;
> >  	}
> >  
> > -	if (options->pcrlock) {
> > -		ret = pcrlock(options->pcrlock);
> > +	if (private->pcrlock) {
> > +		ret = pcrlock(private->pcrlock);
> >  		if (ret < 0) {
> >  			pr_info("pcrlock failed (%d)\n", ret);
> > -			goto out;
> > +			return ret;
> >  		}
> >  	}
> > -out:
> > -	kfree_sensitive(options);
> > +
> >  	return ret;
> >  }
> >  
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 67225dd562a9..29da1a3328ef 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -23,6 +23,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  			   struct trusted_key_options *options,
> >  			   u8 *src, u32 len)
> >  {
> > +	struct trusted_key_tpm *private = options->private;
> >  	const int SCRATCH_SIZE = PAGE_SIZE;
> >  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> >  	u8 *work = scratch, *work1;
> > @@ -45,7 +46,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
> >  			       asn1_oid_len(tpm2key_oid));
> >  
> > -	if (options->blobauth_len == 0) {
> > +	if (private->blobauth_len == 0) {
> >  		unsigned char bool[3], *w = bool;
> >  		/* tag 0 is emptyAuth */
> >  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> > @@ -68,7 +69,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  		goto err;
> >  	}
> >  
> > -	work = asn1_encode_integer(work, end_work, options->keyhandle);
> > +	work = asn1_encode_integer(work, end_work, private->keyhandle);
> >  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> >  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
> >  
> > @@ -101,6 +102,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
> >  			   struct trusted_key_options *options,
> >  			   u8 **buf)
> >  {
> > +	struct trusted_key_tpm *private = options->private;
> >  	int ret;
> >  	struct tpm2_key_context ctx;
> >  	u8 *blob;
> > @@ -120,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
> >  		return -ENOMEM;
> >  
> >  	*buf = blob;
> > -	options->keyhandle = ctx.parent;
> > +	private->keyhandle = ctx.parent;
> >  
> >  	memcpy(blob, ctx.priv, ctx.priv_len);
> >  	blob += ctx.priv_len;
> > @@ -232,6 +234,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  		      struct trusted_key_payload *payload,
> >  		      struct trusted_key_options *options)
> >  {
> > +	struct trusted_key_tpm *private = options->private;
> >  	off_t offset = TPM_HEADER_SIZE;
> >  	struct tpm_buf *buf __free(kfree) = NULL;
> >  	struct tpm_buf *sized __free(kfree) = NULL;
> > @@ -240,11 +243,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  	u32 flags;
> >  	int rc;
> >  
> > -	hash = tpm2_find_hash_alg(options->hash);
> > +	hash = tpm2_find_hash_alg(private->hash);
> >  	if (hash < 0)
> >  		return hash;
> >  
> > -	if (!options->keyhandle)
> > +	if (!private->keyhandle)
> >  		return -EINVAL;
> >  
> >  	rc = tpm_try_get_ops(chip);
> > @@ -274,18 +277,18 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  
> >  	tpm_buf_init_sized(sized, TPM_BUFSIZE);
> >  
> > -	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> > +	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
> >  	if (rc)
> >  		goto out;
> >  
> >  	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
> > -				    options->keyauth, TPM_DIGEST_SIZE);
> > +				    private->keyauth, TPM_DIGEST_SIZE);
> >  
> >  	/* sensitive */
> > -	tpm_buf_append_u16(sized, options->blobauth_len);
> > +	tpm_buf_append_u16(sized, private->blobauth_len);
> >  
> > -	if (options->blobauth_len)
> > -		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
> > +	if (private->blobauth_len)
> > +		tpm_buf_append(sized, private->blobauth, private->blobauth_len);
> >  
> >  	tpm_buf_append_u16(sized, payload->key_len);
> >  	tpm_buf_append(sized, payload->key, payload->key_len);
> > @@ -298,14 +301,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  
> >  	/* key properties */
> >  	flags = 0;
> > -	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> > +	flags |= private->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> >  	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
> >  	tpm_buf_append_u32(sized, flags);
> >  
> >  	/* policy */
> > -	tpm_buf_append_u16(sized, options->policydigest_len);
> > -	if (options->policydigest_len)
> > -		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
> > +	tpm_buf_append_u16(sized, private->policydigest_len);
> > +	if (private->policydigest_len)
> > +		tpm_buf_append(sized, private->policydigest,
> > +			       private->policydigest_len);
> >  
> >  	/* public parameters */
> >  	tpm_buf_append_u16(sized, TPM_ALG_NULL);
> > @@ -376,6 +380,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >  			 u32 *blob_handle)
> >  {
> >  	u8 *blob_ref __free(kfree) = NULL;
> > +	struct trusted_key_tpm *private = options->private;
> >  	struct tpm_buf *buf __free(kfree) = NULL;
> >  	unsigned int private_len;
> >  	unsigned int public_len;
> > @@ -395,7 +400,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >  	}
> >  
> >  	/* new format carries keyhandle but old format doesn't */
> > -	if (!options->keyhandle)
> > +	if (!private->keyhandle)
> >  		return -EINVAL;
> >  
> >  	/* must be big enough for at least the two be16 size counts */
> > @@ -439,11 +444,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >  	tpm_buf_init(buf, TPM_BUFSIZE);
> >  	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> >  
> > -	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> > +	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
> >  	if (rc)
> >  		return rc;
> >  
> > -	tpm_buf_append_hmac_session(chip, buf, 0, options->keyauth,
> > +	tpm_buf_append_hmac_session(chip, buf, 0, private->keyauth,
> >  				    TPM_DIGEST_SIZE);
> >  
> >  	tpm_buf_append(buf, blob, blob_len);
> > @@ -483,6 +488,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >  			   struct trusted_key_options *options,
> >  			   u32 blob_handle)
> >  {
> > +	struct trusted_key_tpm *private = options->private;
> >  	struct tpm_header *head;
> >  	struct tpm_buf *buf __free(kfree) = NULL;
> >  	u16 data_len;
> > @@ -507,10 +513,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (!options->policyhandle) {
> > +	if (!private->policyhandle) {
> >  		tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
> > -					    options->blobauth,
> > -					    options->blobauth_len);
> > +					    private->blobauth,
> > +					    private->blobauth_len);
> >  	} else {
> >  		/*
> >  		 * FIXME: The policy session was generated outside the
> > @@ -523,9 +529,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >  		 * could repeat our actions with the exfiltrated
> >  		 * password.
> >  		 */
> > -		tpm2_buf_append_auth(buf, options->policyhandle,
> > +		tpm2_buf_append_auth(buf, private->policyhandle,
> >  				     NULL /* nonce */, 0, 0,
> > -				     options->blobauth, options->blobauth_len);
> > +				     private->blobauth, private->blobauth_len);
> >  		if (tpm2_chip_auth(chip)) {
> >  			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
> >  						    NULL, 0);
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko


$ b4 shazam -s -l https://lore.kernel.org/linux-integrity/aqHfyBdvENc9i69r@kernel.org/
Grabbing thread from lore.kernel.org/all/aqHfyBdvENc9i69r@kernel.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
  Added from v8: 2 patches
Analyzing 8 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 1 code-review messages
Analyzing 1 code-review messages
Will use the latest revision: v8
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ERROR: missing [1/2]!
  ✓ [PATCH v8 2/2] keys/trusted_keys: move TPM-specific fields into struct trusted_key_tpm
    ✓ Signed: DKIM/ibm.com (From: ssrish@linux.ibm.com)
    + Link: https://lore.kernel.org/r/20260910075232.178855-3-ssrish@linux.ibm.com
    + Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Total patches: 1
---
WARNING: Thread incomplete!
Applying: keys/trusted_keys: move TPM-specific fields into struct trusted_key_tpm
Patch failed at 0001 keys/trusted_keys: move TPM-specific fields into struct trusted_key_tpm
error: patch failed: security/keys/trusted-keys/trusted_tpm1.c:925
error: security/keys/trusted-keys/trusted_tpm1.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

Please send a proper version of the patch set.

BR, Jarkko
