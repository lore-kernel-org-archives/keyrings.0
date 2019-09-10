From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 10 Sep 2019 14:25:04 +0000
Subject: Re: [PATCH v3] KEYS: trusted: correctly initialize digests and fix locking issue
Message-Id: <20190910142504.GA3768@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190908174542.509-1-roberto.sassu@huawei.com>
In-Reply-To: <20190908174542.509-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Sun, Sep 08, 2019 at 07:45:42PM +0200, Roberto Sassu wrote:
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1b4f95c13e00..1fffa91fc148 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -316,14 +316,14 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	int rc;
>  	int i;
>  
> -	chip = tpm_find_get_ops(chip);
> -	if (!chip)
> -		return -ENODEV;
> -
>  	for (i = 0; i < chip->nr_allocated_banks; i++)
>  		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
>  			return -EINVAL;
>  
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
>  		tpm_put_ops(chip);

You can only access chip's field when you hold the lock and have a legit
refcount. This would add a potential race. The bug is very much valid
and thank you for spotting that.

I sent a patch the fix the 2nd issue with your reported-by.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

/Jarkko
