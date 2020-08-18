From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 18 Aug 2020 16:08:35 +0000
Subject: Re: [PATCH v2] docs: update trusted-encrypted.rst
Message-Id: <20200818160835.GB137138@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200817142837.5224-1-colyli@suse.de>
In-Reply-To: <20200817142837.5224-1-colyli@suse.de>
To: Coly Li <colyli@suse.de>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

On Mon, Aug 17, 2020 at 10:28:37PM +0800, Coly Li wrote:
> The parameters in tmp2 commands are outdated, people are not able to
> create trusted key by the example commands.

Please write acronyms in capitals (e.g. TPM2).

> This patch updates the paramerters of tpm2 commands, they are verified
                         ~~~~~~~~~~~
			 parameters, did you run checkpatch.pl?

Ditto.

> by tpm2-tools-4.1 with Linux v5.8 kernel.

The preffered form is to write as "Update the parameters..." (in any
kernel patch) when possible.

I have to say that I don't know how to interpret either of the sentences
in the long description. I don't understand how I should comprehend the
change that you are making from all of this.

Also, I don't understand how Linux v5.8 relates to this.

Finally, we have multiple TPM user space.

Maybe you want to start with like

  Intel TSS since v4.1 requires to add '-p' before the keyhandle when
  invoking tpm2_evictcontrol utility program because <...>. <And then
  describe in imperative form what you want to do>

BTW, this claim does not look right:

"The user must first create a storage key and make it persistent, so the
key is available after reboot. This can be done using the following
commands."

First, storage key is not a primary key, i.e. wrong wording is used.
Secondly, afaik you don't *have to* make a primary key persistent.
You can export it to dram and load when you need it.

Thirdly, no warning of any sort that you should prefer not to use
persistent keys for kernel testing, which is I think the worst issue
in this documentation.

This is the failing commit:

commit 4264f27a0815c46dfda9c9dd6d5f4abc1df04415
Author: Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri Oct 19 06:17:58 2018 -0400

    docs: Extend trusted keys documentation for TPM 2.0
    
    Extend the documentation for trusted keys with documentation for how to
    set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
    
    Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
    Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
    Reviewed-by: Dave Jiang <dave.jiang@intel.com>
    Acked-by: Dan Williams <dan.j.williams@intel.com>
    Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>
    Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

/Jarkko


> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> ---
> Changelog:
> v2: remove the change of trusted key related operation.
> v1: initial version.
> 
>  Documentation/security/keys/trusted-encrypted.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 9483a7425ad5..1da879a68640 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
>  
>  Or with the Intel TSS 2 stack::
>  
> -  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
> +  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
>    [...]
> -  handle: 0x800000FF
> -  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
> +  #> tpm2_evictcontrol -c key.ctxt 0x81000001
>    persistentHandle: 0x81000001
>  
>  Usage::
> -- 
> 2.26.2
> 
