From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Mon, 06 Nov 2017 10:29:47 +0000
Subject: Re: [PATCH v2 5/5] crypto: dh - Remove pointless checks for NULL 'p' and 'g'
Message-Id: <bde90151-419b-a36f-1a95-e49df30ff291@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171106023048.8067-1-ebiggers3@gmail.com>
 <20171106023048.8067-6-ebiggers3@gmail.com>
In-Reply-To: <20171106023048.8067-6-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Stephan Mueller <smueller@chronox.de>, qat-linux@intel.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>



On 11/06/2017 04:30 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Neither 'p' nor 'g' can be NULL, as they were unpacked using
> crypto_dh_decode_key().  And it makes no sense for them to be optional.
> So remove the NULL checks that were copy-and-pasted into both modules.
> 

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   crypto/dh.c                                   | 3 ---
>   drivers/crypto/qat/qat_common/qat_asym_algs.c | 3 ---
>   2 files changed, 6 deletions(-)
> 
> diff --git a/crypto/dh.c b/crypto/dh.c
> index aadaf36fb56f..5659fe7f446d 100644
> --- a/crypto/dh.c
> +++ b/crypto/dh.c
> @@ -53,9 +53,6 @@ static int dh_check_params_length(unsigned int p_len)
>   
>   static int dh_set_params(struct dh_ctx *ctx, struct dh *params)
>   {
> -	if (unlikely(!params->p || !params->g))
> -		return -EINVAL;
> -
>   	if (dh_check_params_length(params->p_size << 3))
>   		return -EINVAL;
>   
> diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
> index 7655fdb499de..13c52d6bf630 100644
> --- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
> +++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
> @@ -443,9 +443,6 @@ static int qat_dh_set_params(struct qat_dh_ctx *ctx, struct dh *params)
>   	struct qat_crypto_instance *inst = ctx->inst;
>   	struct device *dev = &GET_DEV(inst->accel_dev);
>   
> -	if (unlikely(!params->p || !params->g))
> -		return -EINVAL;
> -
>   	if (qat_dh_check_params_length(params->p_size << 3))
>   		return -EINVAL;
>   
> 
