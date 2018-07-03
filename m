From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 03 Jul 2018 15:21:29 +0000
Subject: Re: [PATCH 1/2] tpm: Implement public tpm_put_chip() to release reference to chip
Message-Id: <4789ea0ee11f0a87afcd89ad2814ad0964dd4809.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org, Stefan Berger <stefanb@liux.vnet.ibm.com>

On Tue, 2018-06-26 at 15:30 -0400, Stefan Berger wrote:
> Some subsystems that got a hold of a TPM chip through tpm_default_chip()
> need a way to release the reference to the TPM chip when they shut down.
> The tpm_put_chip() function enables this.
> 
> Signed-off-by: Stefan Berger <stefanb@liux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 10 ++++++++++
>  include/linux/tpm.h         |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 46caadca916a..c744289d82e0 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -80,6 +80,16 @@ void tpm_put_ops(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
> +/**
> + * tpm_put_chip() - Releae a ref to the tpm_chip
> + * @chip: Chip to put
> + */
> +void tpm_put_chip(struct tpm_chip *chip)
> +{
> +	put_device(&chip->dev);
> +}
> +EXPORT_SYMBOL_GPL(tpm_put_chip);
> +
>  /**
>   * tpm_default_chip() - find a TPM chip and get a reference to it
>   */
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e0e51c49a0e6..889dafe739e1 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -62,6 +62,7 @@ extern int tpm_unseal_trusted(struct tpm_chip *chip,
>  			      struct trusted_key_payload *payload,
>  			      struct trusted_key_options *options);
>  extern struct tpm_chip *tpm_default_chip(void);
> +extern void tpm_put_chip(struct tpm_chip *chip);
>  #else
>  static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
> @@ -101,5 +102,8 @@ static inline struct tpm_chip *tpm_default_chip(void)
>  {
>  	return NULL;
>  }
> +static inline void tpm_put_chip(struct tpm_chip *chip)
> +{
> +}
>  #endif
>  #endif

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
