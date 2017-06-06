From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 06 Jun 2017 20:58:51 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <20170606205851.GA65728@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com>
In-Reply-To: <20170606173900.29279-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

On Tue, Jun 06, 2017 at 07:39:00PM +0200, Jason A. Donenfeld wrote:
> This started out as just replacing the use of crypto/rng with
> get_random_bytes, so that we wouldn't use bad randomness at boot time.
> But, upon looking further, it appears that there were even deeper
> underlying cryptographic problems, and that this seems to have been
> committed with very little crypto review. So, I rewrote the whole thing,
> trying to keep to the conventions introduced by the previous author, to
> fix these cryptographic flaws.
> 
> First, it makes no sense to seed crypto/rng at boot time and then keep
> using it like this, when in fact there's already get_random_bytes_wait,
> which can ensure there's enough entropy and be a much more standard way
> of generating keys.
> 
> Second, since this sensitive material is being stored untrusted, using
> ECB and no authentication is simply not okay at all. I find it surprising
> that this code even made it past basic crypto review, though perhaps
> there's something I'm missing. This patch moves from using AES-ECB to
> using AES-GCM. Since keys are uniquely generated each time, we can set
> the nonce to zero.
> 
> So, to summarize, this commit fixes the following vulnerabilities:
> 
>   * Low entropy key generation, allowing an attacker to potentially
>     guess or predict keys.
>   * Unauthenticated encryption, allowing an attacker to modify the
>     cipher text in particular ways in order to manipulate the plaintext,
>     which is is even more frightening considering the next point.
>   * Use of ECB mode, allowing an attacker to trivially swap blocks or
>     compare identical plaintext blocks.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Eric Biggers <ebiggers3@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: security@kernel.org
> Cc: stable@vger.kernel.org
> ---
> This commit has been compile-tested only, so I'd appreciate it if
> somebody else who actually uses this would test it for functionality, or
> if somebody into the kernel's crypto API would check that it's been done
> correctly.
> 
>  security/keys/Kconfig   |   5 +-
>  security/keys/big_key.c | 120 +++++++++++++++++++++++-------------------------
>  2 files changed, 59 insertions(+), 66 deletions(-)
> 
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 6fd95f76bfae..2f91f2368d29 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -41,10 +41,9 @@ config BIG_KEYS
>  	bool "Large payload keys"
>  	depends on KEYS
>  	depends on TMPFS
> -	depends on (CRYPTO_ANSI_CPRNG = y || CRYPTO_DRBG = y)
>  	select CRYPTO_AES
> -	select CRYPTO_ECB
> -	select CRYPTO_RNG
> +	select CRYPTO_GCM
> +	select CRYPTO_AEAD

No need to select CRYPTO_AEAD; it's already selected by CRYPTO_GCM.

>  /*
> - * Crypto names for big_key data encryption
> - */
> -static const char big_key_rng_name[] = "stdrng";
> -static const char big_key_alg_name[] = "ecb(aes)";
> -
> -/*
> - * Crypto algorithms for big_key data encryption
> + * Crypto names for big_key data authenticated encryption
>   */
> -static struct crypto_rng *big_key_rng;
> -static struct crypto_skcipher *big_key_skcipher;
> +static const char big_key_alg_name[] = "gcm(aes)";
>  
>  /*
> - * Generate random key to encrypt big_key data
> + * Crypto algorithms for big_key data authenticated encryption
>   */
> -static inline int big_key_gen_enckey(u8 *key)
> -{
> -	return crypto_rng_get_bytes(big_key_rng, key, ENC_KEY_SIZE);
> -}
> +static struct crypto_aead *big_key_aead;
>  

Actually I just noticed another bug, which I suppose you might as well fix too.
Because different big_keys may be added or read concurrently, and each is
encrypted using a different encryption key, it's not safe to use a global
'crypto_aead'.  Instead, a separate crypto_aead must be created for each key, or
for each encryption/decryption, or else a mutex needs to be held during each
rekeying and encryption/decryption.  For what it's worth, I recently fixed a
similar bug for the "encrypted" key type:
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-fixes&idi307a05d4d58f4c29aa7e9d83dc59d63e28c382

>  /*
>   * Encrypt/decrypt big_key data
> @@ -93,27 +89,40 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
>  {
>  	int ret = -EINVAL;
>  	struct scatterlist sgio;
> -	SKCIPHER_REQUEST_ON_STACK(req, big_key_skcipher);
> -
> -	if (crypto_skcipher_setkey(big_key_skcipher, key, ENC_KEY_SIZE)) {
> +	u8 req_on_stack[sizeof(struct aead_request) +
> +			crypto_aead_reqsize(big_key_aead)];
> +	struct aead_request *aead_req = (struct aead_request *)req_on_stack;
> +
> +	/* We always use a zero nonce. The reason we can get away with this is
> +	 * because we're using a different randomly generated key for every
> +	 * different encryption. Notably, too, key_type_big_key doesn't define
> +	 * an .update function, so there's no chance we'll wind up reusing the
> +	 * key to encrypt updated data. Simply put: one key, one encryption.
> +	 */
> +	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
> +
> +	memset(req_on_stack, 0, sizeof(struct aead_request) +
> +				crypto_aead_reqsize(big_key_aead));
> +	memset(zero_nonce, 0, crypto_aead_ivsize(big_key_aead));

memset(req_on_stack, 0, sizeof(req_on_stack));
memset(zero_nonce, 0, sizeof(zero_nonce));

> +	sg_init_one(&sgio, data, datalen + (op = BIG_KEY_ENC ? ENC_AUTHTAG_SIZE : 0));
> +
> +	if (crypto_aead_setkey(big_key_aead, key, ENC_KEY_SIZE)) {
>  		ret = -EAGAIN;
>  		goto error;
>  	}
>  
> -	skcipher_request_set_tfm(req, big_key_skcipher);
> -	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> -				      NULL, NULL);
> -
> -	sg_init_one(&sgio, data, datalen);
> -	skcipher_request_set_crypt(req, &sgio, &sgio, datalen, NULL);
> +	aead_request_set_tfm(aead_req, big_key_aead);
> +	aead_request_set_crypt(aead_req, &sgio, &sgio, datalen, zero_nonce);
> +	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP,
> +				  NULL, NULL);
>  
>  	if (op = BIG_KEY_ENC)
> -		ret = crypto_skcipher_encrypt(req);
> +		ret = crypto_aead_encrypt(aead_req);
>  	else
> -		ret = crypto_skcipher_decrypt(req);
> -
> -	skcipher_request_zero(req);
> +		ret = crypto_aead_decrypt(aead_req);
>  
> +	memzero_explicit(req_on_stack, sizeof(struct aead_request) +
> +			 crypto_aead_reqsize(big_key_aead));

memzero_explicit(req_on_stack, sizeof(req_on_stack));

>  error:
>  	return ret;
>  }
> @@ -146,7 +155,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>  		 *
>  		 * File content is stored encrypted with randomly generated key.
>  		 */
> -		size_t enclen = ALIGN(datalen, crypto_skcipher_blocksize(big_key_skcipher));
> +		size_t enclen = datalen + ENC_AUTHTAG_SIZE;
>  
>  		/* prepare aligned data to encrypt */
>  		data = kmalloc(enclen, GFP_KERNEL);

It isn't "aligned" anymore --- instead, it's leaving room for the authentiation
tag.  I don't think it even needs to be zeroed, does it?  Can you update the
code and comments below this?

> @@ -162,13 +171,12 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>  			ret = -ENOMEM;
>  			goto error;
>  		}
> -
> -		ret = big_key_gen_enckey(enckey);
> +		ret = get_random_bytes_wait(enckey, ENC_KEY_SIZE);
>  		if (ret)
>  			goto err_enckey;

I think these fixes are going to have to be done separately from the switch to
get_random_bytes_wait().  Just make it use get_random_bytes() for now, and
switch it to get_random_bytes_wait() later in a separate patch.

Please also add a brief comment that anyone who might try to add an update()
method will find, e.g.:

struct key_type key_type_big_key = {
[...]
        .describe               = big_key_describe,
        .read                   = big_key_read,
        /* no ->update() yet; don't add it without changing big_key_crypt() */
};

Otherwise someone will add one, and the crypto will be broken again.

Eric
