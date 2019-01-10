From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 10 Jan 2019 20:28:10 +0000
Subject: Re: [PATCH] KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails
Message-Id: <20190110202809.GB149637@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Sat, Nov 03, 2018 at 10:41:07AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> No error code was being set on this error path.
> 
> Fixes: ad4b1eb5fb33 ("KEYS: asym_tpm: Implement encryption operation [ver #2]")
> Fixes: c08fed737126 ("KEYS: Implement encrypt, decrypt and sign for software asymmetric key [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/asym_tpm.c   | 1 +
>  crypto/asymmetric_keys/public_key.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
> index 5d4c270463f60..8eeb2d251a82a 100644
> --- a/crypto/asymmetric_keys/asym_tpm.c
> +++ b/crypto/asymmetric_keys/asym_tpm.c
> @@ -479,6 +479,7 @@ static int tpm_key_encrypt(struct tpm_key *tk,
>  	if (ret < 0)
>  		goto error_free_tfm;
>  
> +	ret = -ENOMEM;
>  	req = akcipher_request_alloc(tfm, GFP_KERNEL);
>  	if (!req)
>  		goto error_free_tfm;
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index f5d85b47fcc6d..65fc08d9be087 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -169,6 +169,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
>  	if (IS_ERR(tfm))
>  		return PTR_ERR(tfm);
>  
> +	ret = -ENOMEM;
>  	req = akcipher_request_alloc(tfm, GFP_KERNEL);
>  	if (!req)
>  		goto error_free_tfm;
> -- 
> 2.19.1
> 

Ping.
