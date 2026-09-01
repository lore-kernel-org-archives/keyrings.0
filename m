Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E91367B73;
	Tue,  1 Sep 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282107; cv=none; b=nRz3BJxdy5kh8+JO02amReldKgYB9WsdikAivpn/fdDuiWpQbtAy4fUuIH0V7DAAjH7MiGMz4dnOPTp30szXK8bVL4O9h7pzq/BprjWEMQ2xhkJtBmi/AP1Z/VtS8Xxgn0ILsmMkzYX3MaiZOYe4k9UzF98v96nvcOz7z9PA4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282107; c=relaxed/simple;
	bh=qZwhwotQ/fNKgEH1EMxc0uXOl74DjMSswC1Y1WVKU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiCgVb7KxYWQ8MczLWgNKI098InHDFW1+8xrd7uJPWkupgHZP5mI7f6g2lxwJb8N6tP8vHBG/jbWB/sp/nfF58w4AUSoqDV0OuCa1vP0KuDwPq3H6mbDAJanK8k8MgSZXQU9FuUYlK9T8QHAw/SCNcZMvsLgWD9vt5RPfOVzFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZAzyaEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZAzyaEf"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 86A6C1F000E9;
	Tue,  1 Sep 2026 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282105;
	bh=jjLG+PQZ47Hm0f3rhkRfvwiU5o5E2dISkJrvKrFO75o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CZAzyaEffmr3P2IoCAYoDKTk3KgAb33VPcPzb+D0S39DfS+pYW9su7+IVmFFCgDaQ
	 e0laZpn423n0rPnDwclZ5pB5ngIsIr6yqJZ6etpBaiWkUvZ5Uno/VE79BL5ZJUxPJV
	 mEnyq9ILRwDHvc9jz0hMMSahznVh4vLYc4jXSbRlPT25ds4/htMuSLnDf64/LLjK7k
	 G/adEz776+15bVBCJJnjc+/ajsJgvym8j59ryzpjjUYm6hVTYWVwyToZtZpMUwLmw4
	 2zwLGOAKjFRHA+9yFoT26iRJies17aq4uQZmDMMt7aHONnK643ezItL6OHDQy/MvlE
	 DI9nAsHMIxQCA==
Date: Tue, 1 Sep 2026 20:01:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH v5] keys/trusted_keys: move TPM-specific fields into
 struct trusted_key_tpm
Message-ID: <apcE9YgRpplF39_1@kernel.org>
References: <20260901154132.140741-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901154132.140741-1-ssrish@linux.ibm.com>

On Tue, Sep 01, 2026 at 09:11:32PM +0530, Srish Srinivasan wrote:
> The trusted_key_options struct contains TPM-specific fields (keyhandle,
> keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
> policydigest_len, policydigest, and policyhandle). This leads to the
> accumulation of backend-specific fields in the generic options structure.
> 
> Define struct trusted_key_tpm and move the TPM-specific fields there. Store
> a pointer to it in the private member of struct trusted_key_options.
> 
> No functional change intended.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
> Changelog:
> 
>  v5:
>   - Rename struct trusted_tpm_options to struct trusted_key_tpm, as suggested
>     by Jarkko.
> 
>  v4:
>   - Rebased onto mainline after tpm-buf memory-safe allocation changes were
>     merged
>   - Resolved the resulting merge conflicts
> 
>  v3:
>   - Exclude the preparatory clean up patch as the problem has been addressed
>     in commit 9ec4175a30eb ("KEYS: trusted: Debugging as a feature")
> 
>  v2:
>   - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
>   - Rename instances of trusted_tpm_options from tpm_opts to private
>   - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory clean
>     up patch)
>   - Address other minor comments from Jarkko
> 
>  include/keys/trusted-type.h               | 11 ---
>  include/keys/trusted_tpm.h                | 14 ++++
>  security/keys/trusted-keys/trusted_tpm1.c | 96 ++++++++++++++---------
>  security/keys/trusted-keys/trusted_tpm2.c | 50 ++++++------
>  4 files changed, 102 insertions(+), 69 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 9f9940482da4..3db61b57cf73 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -39,17 +39,6 @@ struct trusted_key_payload {
>  
>  struct trusted_key_options {
>  	uint16_t keytype;
> -	uint32_t keyhandle;
> -	unsigned char keyauth[TPM_DIGEST_SIZE];
> -	uint32_t blobauth_len;
> -	unsigned char blobauth[TPM_DIGEST_SIZE];
> -	uint32_t pcrinfo_len;
> -	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> -	int pcrlock;
> -	uint32_t hash;
> -	uint32_t policydigest_len;
> -	unsigned char policydigest[MAX_DIGEST_SIZE];
> -	uint32_t policyhandle;
>  	void *private;
>  };
>  
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 3a0fa3bc8454..dafbd4a84ddd 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -6,6 +6,20 @@
>  
>  extern struct trusted_key_ops trusted_key_tpm_ops;
>  
> +struct trusted_key_tpm {
> +	uint32_t keyhandle;
> +	unsigned char keyauth[TPM_DIGEST_SIZE];
> +	uint32_t blobauth_len;
> +	unsigned char blobauth[TPM_DIGEST_SIZE];
> +	uint32_t pcrinfo_len;
> +	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> +	int pcrlock;
> +	uint32_t hash;
> +	uint32_t policydigest_len;
> +	unsigned char policydigest[MAX_DIGEST_SIZE];
> +	uint32_t policyhandle;
> +};
> +
>  int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_payload *payload,
>  		      struct trusted_key_options *options);
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index bf0bf7f36970..d396f4267180 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -48,15 +48,17 @@ enum {
>  #ifdef CONFIG_TRUSTED_KEYS_DEBUG
>  static inline void dump_options(struct trusted_key_options *o)
>  {
> +	struct trusted_key_tpm *private = o->private;
> +
>  	if (!trusted_debug)
>  		return;
>  
>  	pr_debug("sealing key type %d\n", o->keytype);
> -	pr_debug("sealing key handle %0X\n", o->keyhandle);
> -	pr_debug("pcrlock %d\n", o->pcrlock);
> -	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	pr_debug("sealing key handle %0X\n", private->keyhandle);
> +	pr_debug("pcrlock %d\n", private->pcrlock);
> +	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
>  	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
> -			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> +			     16, 1, private->pcrinfo, private->pcrinfo_len, 0);
>  }
>  
>  static inline void dump_sess(struct osapsess *s)
> @@ -626,6 +628,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>  static int key_seal(struct trusted_key_payload *p,
>  		    struct trusted_key_options *o)
>  {
> +	struct trusted_key_tpm *private = o->private;
>  	int ret;
>  
>  	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
> @@ -637,9 +640,10 @@ static int key_seal(struct trusted_key_payload *p,
>  	/* include migratable flag at end of sealed key */
>  	p->key[p->key_len] = p->migratable;
>  
> -	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
> +	ret = tpm_seal(tb, o->keytype, private->keyhandle, private->keyauth,
>  		       p->key, p->key_len + 1, p->blob, &p->blob_len,
> -		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
> +		       private->blobauth, private->pcrinfo,
> +		       private->pcrinfo_len);
>  	if (ret < 0)
>  		pr_info("srkseal failed (%d)\n", ret);
>  
> @@ -652,6 +656,7 @@ static int key_seal(struct trusted_key_payload *p,
>  static int key_unseal(struct trusted_key_payload *p,
>  		      struct trusted_key_options *o)
>  {
> +	struct trusted_key_tpm *private = o->private;
>  	int ret;
>  
>  	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
> @@ -660,8 +665,8 @@ static int key_unseal(struct trusted_key_payload *p,
>  
>  	tpm_buf_init(tb, TPM_BUFSIZE);
>  
> -	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
> -			 o->blobauth, p->key, &p->key_len);
> +	ret = tpm_unseal(tb, private->keyhandle, private->keyauth, p->blob,
> +			 p->blob_len, private->blobauth, p->key, &p->key_len);
>  	if (ret < 0)
>  		pr_info("srkunseal failed (%d)\n", ret);
>  	else
> @@ -697,6 +702,7 @@ static const match_table_t key_tokens = {
>  static int getoptions(char *c, struct trusted_key_payload *pay,
>  		      struct trusted_key_options *opt)
>  {
> +	struct trusted_key_tpm *private = opt->private;
>  	substring_t args[MAX_OPT_ARGS];
>  	char *p = c;
>  	int token;
> @@ -712,7 +718,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> -	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> +	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>  
>  	if (!c)
>  		return 0;
> @@ -726,11 +732,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  
>  		switch (token) {
>  		case Opt_pcrinfo:
> -			opt->pcrinfo_len = strlen(args[0].from) / 2;
> -			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
> +			private->pcrinfo_len = strlen(args[0].from) / 2;
> +			if (private->pcrinfo_len > MAX_PCRINFO_SIZE)
>  				return -EINVAL;
> -			res = hex2bin(opt->pcrinfo, args[0].from,
> -				      opt->pcrinfo_len);
> +			res = hex2bin(private->pcrinfo, args[0].from,
> +				      private->pcrinfo_len);
>  			if (res < 0)
>  				return -EINVAL;
>  			break;
> @@ -739,12 +745,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			if (res < 0)
>  				return -EINVAL;
>  			opt->keytype = SEAL_keytype;
> -			opt->keyhandle = handle;
> +			private->keyhandle = handle;
>  			break;
>  		case Opt_keyauth:
>  			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
>  				return -EINVAL;
> -			res = hex2bin(opt->keyauth, args[0].from,
> +			res = hex2bin(private->keyauth, args[0].from,
>  				      SHA1_DIGEST_SIZE);
>  			if (res < 0)
>  				return -EINVAL;
> @@ -755,21 +761,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			 * hex strings.  TPM 2.0 authorizations are simple
>  			 * passwords (although it can take a hash as well)
>  			 */
> -			opt->blobauth_len = strlen(args[0].from);
> +			private->blobauth_len = strlen(args[0].from);
>  
> -			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> -				res = hex2bin(opt->blobauth, args[0].from,
> +			if (private->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> +				res = hex2bin(private->blobauth, args[0].from,
>  					      TPM_DIGEST_SIZE);
>  				if (res < 0)
>  					return -EINVAL;
>  
> -				opt->blobauth_len = TPM_DIGEST_SIZE;
> +				private->blobauth_len = TPM_DIGEST_SIZE;
>  				break;
>  			}
>  
> -			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
> -				memcpy(opt->blobauth, args[0].from,
> -				       opt->blobauth_len);
> +			if (tpm2 &&
> +			    private->blobauth_len <=
> +			    sizeof(private->blobauth)) {
> +				memcpy(private->blobauth, args[0].from,
> +				       private->blobauth_len);
>  				break;
>  			}
>  
> @@ -787,14 +795,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			res = kstrtoul(args[0].from, 10, &lock);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->pcrlock = lock;
> +			private->pcrlock = lock;
>  			break;
>  		case Opt_hash:
>  			if (test_bit(Opt_policydigest, &token_mask))
>  				return -EINVAL;
>  			for (i = 0; i < HASH_ALGO__LAST; i++) {
>  				if (!strcmp(args[0].from, hash_algo_name[i])) {
> -					opt->hash = i;
> +					private->hash = i;
>  					break;
>  				}
>  			}
> @@ -806,14 +814,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			}
>  			break;
>  		case Opt_policydigest:
> -			digest_len = hash_digest_size[opt->hash];
> +			digest_len = hash_digest_size[private->hash];
>  			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
>  				return -EINVAL;
> -			res = hex2bin(opt->policydigest, args[0].from,
> +			res = hex2bin(private->policydigest, args[0].from,
>  				      digest_len);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->policydigest_len = digest_len;
> +			private->policydigest_len = digest_len;
>  			break;
>  		case Opt_policyhandle:
>  			if (!tpm2)
> @@ -821,7 +829,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			res = kstrtoul(args[0].from, 16, &handle);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->policyhandle = handle;
> +			private->policyhandle = handle;
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -832,6 +840,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  
>  static struct trusted_key_options *trusted_options_alloc(void)
>  {
> +	struct trusted_key_tpm *private;
>  	struct trusted_key_options *options;
>  	int tpm2;
>  
> @@ -844,14 +853,22 @@ static struct trusted_key_options *trusted_options_alloc(void)
>  		/* set any non-zero defaults */
>  		options->keytype = SRK_keytype;
>  
> -		if (!tpm2)
> -			options->keyhandle = SRKHANDLE;
> +		private = kzalloc_obj(*private);
> +		if (!private) {
> +			kfree_sensitive(options);
> +			options = NULL;
> +		} else {
> +			if (!tpm2)
> +				private->keyhandle = SRKHANDLE;
> +			options->private = private;
> +		}
>  	}
>  	return options;
>  }
>  
>  static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  {
> +	struct trusted_key_tpm *private = NULL;
>  	struct trusted_key_options *options = NULL;

It would be leaner if you did:

	struct trusted_key_options *options __free(kfree_sensitive) = NULL;

Then you can just return instead of jumping to "out".

Applies also to trusted_tpm_unseal at least.

>  	int ret = 0;
>  	int tpm2;
> @@ -869,7 +886,8 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -883,20 +901,23 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	}
>  
> -	if (options->pcrlock) {
> -		ret = pcrlock(options->pcrlock);
> +	if (private->pcrlock) {
> +		ret = pcrlock(private->pcrlock);
>  		if (ret < 0) {
>  			pr_info("pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
>  	}
>  out:
> +	if (options)
> +		kfree_sensitive(options->private);
>  	kfree_sensitive(options);
>  	return ret;
>  }
>  
>  static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  {
> +	struct trusted_key_tpm *private = NULL;
>  	struct trusted_key_options *options = NULL;
>  	int ret = 0;
>  	int tpm2;
> @@ -914,7 +935,8 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -926,14 +948,16 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  	if (ret < 0)
>  		pr_info("key_unseal failed (%d)\n", ret);
>  
> -	if (options->pcrlock) {
> -		ret = pcrlock(options->pcrlock);
> +	if (private->pcrlock) {
> +		ret = pcrlock(private->pcrlock);
>  		if (ret < 0) {
>  			pr_info("pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
>  	}
>  out:
> +	if (options)
> +		kfree_sensitive(options->private);
>  	kfree_sensitive(options);
>  	return ret;
>  }
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 67225dd562a9..29da1a3328ef 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -23,6 +23,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
>  {
> +	struct trusted_key_tpm *private = options->private;
>  	const int SCRATCH_SIZE = PAGE_SIZE;
>  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	u8 *work = scratch, *work1;
> @@ -45,7 +46,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>  			       asn1_oid_len(tpm2key_oid));
>  
> -	if (options->blobauth_len == 0) {
> +	if (private->blobauth_len == 0) {
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> @@ -68,7 +69,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		goto err;
>  	}
>  
> -	work = asn1_encode_integer(work, end_work, options->keyhandle);
> +	work = asn1_encode_integer(work, end_work, private->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
>  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
>  
> @@ -101,6 +102,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 **buf)
>  {
> +	struct trusted_key_tpm *private = options->private;
>  	int ret;
>  	struct tpm2_key_context ctx;
>  	u8 *blob;
> @@ -120,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  		return -ENOMEM;
>  
>  	*buf = blob;
> -	options->keyhandle = ctx.parent;
> +	private->keyhandle = ctx.parent;
>  
>  	memcpy(blob, ctx.priv, ctx.priv_len);
>  	blob += ctx.priv_len;
> @@ -232,6 +234,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_payload *payload,
>  		      struct trusted_key_options *options)
>  {
> +	struct trusted_key_tpm *private = options->private;
>  	off_t offset = TPM_HEADER_SIZE;
>  	struct tpm_buf *buf __free(kfree) = NULL;
>  	struct tpm_buf *sized __free(kfree) = NULL;
> @@ -240,11 +243,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	u32 flags;
>  	int rc;
>  
> -	hash = tpm2_find_hash_alg(options->hash);
> +	hash = tpm2_find_hash_alg(private->hash);
>  	if (hash < 0)
>  		return hash;
>  
> -	if (!options->keyhandle)
> +	if (!private->keyhandle)
>  		return -EINVAL;
>  
>  	rc = tpm_try_get_ops(chip);
> @@ -274,18 +277,18 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  
>  	tpm_buf_init_sized(sized, TPM_BUFSIZE);
>  
> -	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
>  	if (rc)
>  		goto out;
>  
>  	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
> -				    options->keyauth, TPM_DIGEST_SIZE);
> +				    private->keyauth, TPM_DIGEST_SIZE);
>  
>  	/* sensitive */
> -	tpm_buf_append_u16(sized, options->blobauth_len);
> +	tpm_buf_append_u16(sized, private->blobauth_len);
>  
> -	if (options->blobauth_len)
> -		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
> +	if (private->blobauth_len)
> +		tpm_buf_append(sized, private->blobauth, private->blobauth_len);
>  
>  	tpm_buf_append_u16(sized, payload->key_len);
>  	tpm_buf_append(sized, payload->key, payload->key_len);
> @@ -298,14 +301,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  
>  	/* key properties */
>  	flags = 0;
> -	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> +	flags |= private->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
>  	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
>  	tpm_buf_append_u32(sized, flags);
>  
>  	/* policy */
> -	tpm_buf_append_u16(sized, options->policydigest_len);
> -	if (options->policydigest_len)
> -		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
> +	tpm_buf_append_u16(sized, private->policydigest_len);
> +	if (private->policydigest_len)
> +		tpm_buf_append(sized, private->policydigest,
> +			       private->policydigest_len);
>  
>  	/* public parameters */
>  	tpm_buf_append_u16(sized, TPM_ALG_NULL);
> @@ -376,6 +380,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  			 u32 *blob_handle)
>  {
>  	u8 *blob_ref __free(kfree) = NULL;
> +	struct trusted_key_tpm *private = options->private;
>  	struct tpm_buf *buf __free(kfree) = NULL;
>  	unsigned int private_len;
>  	unsigned int public_len;
> @@ -395,7 +400,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	}
>  
>  	/* new format carries keyhandle but old format doesn't */
> -	if (!options->keyhandle)
> +	if (!private->keyhandle)
>  		return -EINVAL;
>  
>  	/* must be big enough for at least the two be16 size counts */
> @@ -439,11 +444,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	tpm_buf_init(buf, TPM_BUFSIZE);
>  	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
>  
> -	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
>  	if (rc)
>  		return rc;
>  
> -	tpm_buf_append_hmac_session(chip, buf, 0, options->keyauth,
> +	tpm_buf_append_hmac_session(chip, buf, 0, private->keyauth,
>  				    TPM_DIGEST_SIZE);
>  
>  	tpm_buf_append(buf, blob, blob_len);
> @@ -483,6 +488,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  			   struct trusted_key_options *options,
>  			   u32 blob_handle)
>  {
> +	struct trusted_key_tpm *private = options->private;
>  	struct tpm_header *head;
>  	struct tpm_buf *buf __free(kfree) = NULL;
>  	u16 data_len;
> @@ -507,10 +513,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	if (rc)
>  		return rc;
>  
> -	if (!options->policyhandle) {
> +	if (!private->policyhandle) {
>  		tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
> -					    options->blobauth,
> -					    options->blobauth_len);
> +					    private->blobauth,
> +					    private->blobauth_len);
>  	} else {
>  		/*
>  		 * FIXME: The policy session was generated outside the
> @@ -523,9 +529,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		 * could repeat our actions with the exfiltrated
>  		 * password.
>  		 */
> -		tpm2_buf_append_auth(buf, options->policyhandle,
> +		tpm2_buf_append_auth(buf, private->policyhandle,
>  				     NULL /* nonce */, 0, 0,
> -				     options->blobauth, options->blobauth_len);
> +				     private->blobauth, private->blobauth_len);
>  		if (tpm2_chip_auth(chip)) {
>  			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
>  						    NULL, 0);
> -- 
> 2.53.0
> 

BR, Jarkko
