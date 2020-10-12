From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 12 Oct 2020 20:18:02 +0000
Subject: Re: [PATCH v2] encrypted-keys: Print more useful debug info if encryption algo is not available
Message-Id: <17400748c976eb3964c5356fe41b3cca3cd23d65.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201005225258.200181-1-anatol.pomozov@gmail.com>
In-Reply-To: <20201005225258.200181-1-anatol.pomozov@gmail.com>
To: keyrings@vger.kernel.org

Hi Anatol,

On Mon, 2020-10-05 at 15:52 -0700, Anatol Pomozov wrote:
> It helps to improve a cryptic message "encrypted_key failed to alloc_cipher (-2)".
> Adding algo name makes it easier to understand what cipher has failed.
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

The "if" clause in the Subject line doesn't belong there, but in the
patch description.  I would start the patch description with "Improve
the cryptic message ... by adding ..."

> ---
>  security/keys/encrypted-keys/encrypted.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 192e531c146f..c09d48f53682 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -84,8 +84,8 @@ static int aes_get_sizes(void)
>  
>  	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(tfm)) {
> -		pr_err("encrypted_key: failed to alloc_cipher (%ld)\n",
> -		       PTR_ERR(tfm));
> +		pr_err("encrypted_key: failed to alloc_cipher for %s (%ld)\n",
> +		       blkcipher_alg, PTR_ERR(tfm));

I don't have a problem with including the blkcipher_alg in the error
message.   It is currently defined as "cbc(aes)".   Is it ever anything
else?

thanks,

Mimi

>  		return PTR_ERR(tfm);
>  	}
>  	ivsize = crypto_skcipher_ivsize(tfm);
