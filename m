From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 12 Nov 2019 17:05:05 +0000
Subject: Re: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to only measure keys added to the spe
Message-Id: <1573578305.17949.42.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-3-nramas@linux.microsoft.com>
In-Reply-To: <20191111193303.12781-3-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

The C maximum line length is 80 characters.  The subject line is even
less than that (~50).  The Subject line here could be "ima: add
support to limit measuring keys".

On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
> IMA policy needs to support measuring only those keys linked to
> a specific set of keyrings.

Patch descriptions should be written in the imperative.  For example, 
"Limit measuring keys to those keys being loaded onto a specific
keyring."

> 
> This patch defines a new IMA policy option namely "keyrings=" that
> can be used to specify a set of keyrings. If this option is specified
> in the policy for func=KEYRING_CHECK then only the keys linked to
> the keyrings given in "keyrings=" option are measured.

This description does not seem to match the code, which for some
reason isn't included in this patch, nor in 3/10.  Please
combine/squash patches 2 & 3.  Missing from the combined patch is the
keyring matching code in ima_match_rules().

> 
> If "keyrings=" option is not specified for func=KEYRING_CHECK then
> all keys are measured.

The last sentence is unnecessary.  Please remove.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 10 +++++++++-
>  security/integrity/ima/ima_policy.c  |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 341df49b5ad1..be2874fa3928 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,7 +25,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> -				[appraise_flag=]
> +				[appraise_flag=] [keyrings=]
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> @@ -43,6 +43,9 @@ Description:
>  			appraise_flag:= [check_blacklist]
>  			Currently, blacklist check is only for files signed with appended
>  			signature.
> +			keyrings:= list of keyrings
> +			(eg, .builtin_trusted_keys|.ima). Only valid
> +			when action is "measure" and func is KEYRING_CHECK.
>  			template:= name of a defined IMA template type
>  			(eg, ima-ng). Only valid when action is "measure".
>  			pcr:= decimal value
> @@ -119,3 +122,8 @@ Description:
>  		all keys:
>  
>  			measure func=KEYRING_CHECK
> +
> +		Example of measure rule using KEYRING_CHECK to only measure
> +		keys added to .builtin_trusted_keys or .ima keyring:
> +
> +			measure func=KEYRING_CHECK keyrings=.builtin_trusted_keys|.ima
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9ca32ffaaa9d..a0f7ffa80736 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -34,6 +34,7 @@
>  #define IMA_EUID	0x0080
>  #define IMA_PCR		0x0100
>  #define IMA_FSNAME	0x0200
> +#define IMA_KEYRINGS	0x0400
>  
>  #define UNKNOWN		0
>  #define MEASURE		0x0001	/* same as IMA_MEASURE */
> @@ -79,6 +80,7 @@ struct ima_rule_entry {
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
> +	char *keyrings; /* Measure keys added to these keyrings */
>  	struct ima_template_desc *template;
>  };
>  
