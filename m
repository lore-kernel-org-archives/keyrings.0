From: Tyler Hicks <tyhicks@canonical.com>
Date: Mon, 05 Aug 2019 17:20:14 +0000
Subject: Re: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190805172014.GE3449@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805164427.17408-1-roberto.sassu@huawei.com>
In-Reply-To: <20190805164427.17408-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 2019-08-05 18:44:27, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even if a TPM is not found, to
> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. tpm_get_random() returns an error.
> 
> This patch removes the call to tpm_get_random() and instead extends the PCR
> specified by the user with zeros. The security of this alternative is
> equivalent to the previous one, as either option prevents with a PCR update
> unsealing and misuse of sealed data by a user space process.
> 
> Even if a PCR is extended with zeros, instead of random data, it is still
> computationally infeasible to find a value as input for a new PCR extend
> operation, to obtain again the PCR value that would allow unsealing.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

The approach changed a fair bit from v2 to v3 so I'll confirm that my
Reviewed-by still stands.

Also, we have positive test results from an affected user:

 https://bugzilla.kernel.org/show_bug.cgi?id 3953#c10

Tyler

> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/keys/trusted.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 9a94672e7adc..ade699131065 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -1228,24 +1228,11 @@ static int __init trusted_shash_alloc(void)
>  
>  static int __init init_digests(void)
>  {
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> -	int ret;
> -	int i;
> -
> -	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
> -	if (ret < 0)
> -		return ret;
> -	if (ret < TPM_MAX_DIGEST_SIZE)
> -		return -EFAULT;
> -
>  	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
>  			  GFP_KERNEL);
>  	if (!digests)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < chip->nr_allocated_banks; i++)
> -		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
> -
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
