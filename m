From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 12 Oct 2018 01:50:22 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <20181012015022.GA7508@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
In-Reply-To: <20181011203126.15338-1-ndesaulniers@google.com>
To: ndesaulniers@google.com
Cc: jejb@linux.vnet.ibm.com, dhowells@redhat.com, ebiggers@google.com, Mimi Zohar <zohar@linux.vnet.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:31:26PM -0700, ndesaulniers@google.com wrote:
> by swapping h2 and h3.
> 
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>         va_start(argp, h3);
>                        ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                                ^
> 
> Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> standards explicitly call this out as undefined behavior:
> 
> The parameter parmN is the identifier of the rightmost parameter in
> the variable parameter list in the function definition (the one just
> before the ...). If the parameter parmN is declared with ... or with a
> type that is not compatible with the type that results after
> application of the default argument promotions, the behavior is
> undefined.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/41
> Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  security/keys/trusted.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index b69d3b1777c2..d425b2b839af 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>   */
>  static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned char h3, ...)
> +			unsigned char h2, unsigned char *h3, ...)

Prototype needs to be updated in include/keys/trusted.h and it looks
like this function is used in crypto/asymmetric_keys/asym_tpm.c so these
same changes should be made there.

Otherwise, looks good to me! Thanks for sending the patch.

Nathan

>  {
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
>  	struct sdesc *sdesc;
> @@ -139,7 +139,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  		return PTR_ERR(sdesc);
>  	}
>  
> -	c = h3;
> +	c = h2;
>  	ret = crypto_shash_init(&sdesc->shash);
>  	if (ret < 0)
>  		goto out;
> @@ -163,7 +163,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  	if (!ret)
>  		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
>  				  paramdigest, TPM_NONCE_SIZE, h1,
> -				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
> +				  TPM_NONCE_SIZE, h3, 1, &c, 0, 0);
>  out:
>  	kzfree(sdesc);
>  	return ret;
> @@ -508,7 +508,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	if (pcrinfosize = 0) {
>  		/* no pcr info specified */
>  		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> -				   sess.enonce, td->nonceodd, cont,
> +				   sess.enonce, cont, td->nonceodd,
>  				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
>  				   td->encauth, sizeof(uint32_t), &pcrsize,
>  				   sizeof(uint32_t), &datsize, datalen, data, 0,
> @@ -516,7 +516,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	} else {
>  		/* pcr info specified */
>  		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> -				   sess.enonce, td->nonceodd, cont,
> +				   sess.enonce, cont, td->nonceodd,
>  				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
>  				   td->encauth, sizeof(uint32_t), &pcrsize,
>  				   pcrinfosize, pcrinfo, sizeof(uint32_t),
> @@ -608,12 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
>  		return ret;
>  	}
>  	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
> -			   enonce1, nonceodd, cont, sizeof(uint32_t),
> +			   enonce1, cont, nonceodd, sizeof(uint32_t),
>  			   &ordinal, bloblen, blob, 0, 0);
>  	if (ret < 0)
>  		return ret;
>  	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
> -			   enonce2, nonceodd, cont, sizeof(uint32_t),
> +			   enonce2, cont, nonceodd, sizeof(uint32_t),
>  			   &ordinal, bloblen, blob, 0, 0);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.19.0.605.g01d371f741-goog
> 
