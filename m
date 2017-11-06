From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Mon, 06 Nov 2017 10:29:07 +0000
Subject: Re: [PATCH v2 3/5] crypto: dh - Don't permit 'key' or 'g' size longer than 'p'
Message-Id: <7bc602b4-5d78-f587-9620-c15a964630fd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171106023048.8067-1-ebiggers3@gmail.com>
 <20171106023048.8067-4-ebiggers3@gmail.com>
In-Reply-To: <20171106023048.8067-4-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Stephan Mueller <smueller@chronox.de>, qat-linux@intel.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org



On 11/06/2017 04:30 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The "qat-dh" DH implementation assumes that 'key' and 'g' can be copied
> into a buffer with size 'p_size'.  However it was never checked that
> that was actually the case, which most likely allowed users to cause a
> buffer underflow via KEYCTL_DH_COMPUTE.
> 
> Fix this by updating crypto_dh_decode_key() to verify this precondition
> for all DH implementations.
> 
> Fixes: c9839143ebbf ("crypto: qat - Add DH support")
> Cc: <stable@vger.kernel.org> # v4.8+

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   crypto/dh_helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
> index 708ae20d2d3c..7f00c771fe8d 100644
> --- a/crypto/dh_helper.c
> +++ b/crypto/dh_helper.c
> @@ -83,6 +83,14 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
>   	if (secret.len != crypto_dh_key_len(params))
>   		return -EINVAL;
>   
> +	/*
> +	 * Don't permit the buffer for 'key' or 'g' to be larger than 'p', since
> +	 * some drivers assume otherwise.
> +	 */
> +	if (params->key_size > params->p_size ||
> +	    params->g_size > params->p_size)
> +		return -EINVAL;
> +
>   	/* Don't allocate memory. Set pointers to data within
>   	 * the given buffer
>   	 */
> 
