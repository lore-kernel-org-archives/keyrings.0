From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 29 Jan 2019 20:43:07 +0000
Subject: Re: [PATCH v8 6/7] KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
Message-Id: <20190129204307.GE11615@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-7-roberto.sassu@huawei.com>
In-Reply-To: <20190124154910.29948-7-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, dhowells@redhat.com, James.Bottomley@HansenPartnership.com
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, silviu.vlasceanu@huawei.com

On Thu, Jan 24, 2019 at 04:49:09PM +0100, Roberto Sassu wrote:
> When crypto agility support will be added to the TPM driver, users of the
> driver have to retrieve the allocated banks from chip->allocated_banks and
> use this information to prepare the array of tpm_digest structures to be
> passed to tpm_pcr_extend().
> 
> This patch retrieves a tpm_chip pointer from tpm_default_chip() so that the
> pointer can be used to prepare the array of tpm_digest structures.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/keys/trusted.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 4d98f4f87236..1a20a9692fef 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -34,6 +34,7 @@
>  
>  static const char hmac_alg[] = "hmac(sha1)";
>  static const char hash_alg[] = "sha1";
> +static struct tpm_chip *chip;
>  
>  struct sdesc {
>  	struct shash_desc shash;
> @@ -362,7 +363,7 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>  	int rc;
>  
>  	dump_tpm_buf(cmd);
> -	rc = tpm_send(NULL, cmd, buflen);
> +	rc = tpm_send(chip, cmd, buflen);
>  	dump_tpm_buf(cmd);
>  	if (rc > 0)
>  		/* Can't return positive return codes values to keyctl */
> @@ -384,10 +385,10 @@ static int pcrlock(const int pcrnum)
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> -	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
> +	ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
>  	if (ret != SHA1_DIGEST_SIZE)
>  		return ret;
> -	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
> +	return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
>  }
>  
>  /*
> @@ -400,7 +401,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
>  	unsigned char ononce[TPM_NONCE_SIZE];
>  	int ret;
>  
> -	ret = tpm_get_random(NULL, ononce, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE)
>  		return ret;
>  
> @@ -496,7 +497,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = tpm_get_random(NULL, td->nonceodd, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE)
>  		goto out;
>  	ordinal = htonl(TPM_ORD_SEAL);
> @@ -606,7 +607,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>  
>  	ordinal = htonl(TPM_ORD_UNSEAL);
>  	keyhndl = htonl(SRKHANDLE);
> -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE) {
>  		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
>  		return ret;
> @@ -751,7 +752,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	int i;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(chip);
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> @@ -920,7 +921,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
>  	struct trusted_key_options *options;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(chip);
>  	if (tpm2 < 0)
>  		return NULL;
>  
> @@ -970,7 +971,7 @@ static int trusted_instantiate(struct key *key,
>  	size_t key_len;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(chip);
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> @@ -1011,7 +1012,7 @@ static int trusted_instantiate(struct key *key,
>  	switch (key_cmd) {
>  	case Opt_load:
>  		if (tpm2)
> -			ret = tpm_unseal_trusted(NULL, payload, options);
> +			ret = tpm_unseal_trusted(chip, payload, options);
>  		else
>  			ret = key_unseal(payload, options);
>  		dump_payload(payload);
> @@ -1021,13 +1022,13 @@ static int trusted_instantiate(struct key *key,
>  		break;
>  	case Opt_new:
>  		key_len = payload->key_len;
> -		ret = tpm_get_random(NULL, payload->key, key_len);
> +		ret = tpm_get_random(chip, payload->key, key_len);
>  		if (ret != key_len) {
>  			pr_info("trusted_key: key_create failed (%d)\n", ret);
>  			goto out;
>  		}
>  		if (tpm2)
> -			ret = tpm_seal_trusted(NULL, payload, options);
> +			ret = tpm_seal_trusted(chip, payload, options);
>  		else
>  			ret = key_seal(payload, options);
>  		if (ret < 0)
> @@ -1225,17 +1226,26 @@ static int __init init_trusted(void)
>  {
>  	int ret;
>  
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return -ENOENT;
>  	ret = trusted_shash_alloc();
>  	if (ret < 0)
> -		return ret;
> +		goto out_put;
>  	ret = register_key_type(&key_type_trusted);
>  	if (ret < 0)
> -		trusted_shash_release();
> +		goto out_release;
> +	return 0;
> +out_release:
> +	trusted_shash_release();
> +out_put:
> +	put_device(&chip->dev);
>  	return ret;
>  }

Since the labels are *only* used for exception fallbacks, I'd prefer
err_release and err_put.

Other than that, LGTM.

Unrelated side-note: I think the TPM subsystem starts to be soon in a
shape that TPM 2.0 trusted keys code could be eventually moved to
security/keys/trusted2.c, and TPM 1.2 trusted keys code could start to
use tpm_buf to build its commands.

/Jarkko
