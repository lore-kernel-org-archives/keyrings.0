From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 17 Aug 2020 16:39:04 +0000
Subject: Re: [PATCH v2] docs: update trusted-encrypted.rst
Message-Id: <576928af-7e3f-3651-4125-75b4507b0115@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200817142837.5224-1-colyli@suse.de>
In-Reply-To: <20200817142837.5224-1-colyli@suse.de>
To: Coly Li <colyli@suse.de>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>

On 8/17/20 10:28 AM, Coly Li wrote:
> The parameters in tmp2 commands are outdated, people are not able to
> create trusted key by the example commands.
>
> This patch updates the paramerters of tpm2 commands, they are verified
> by tpm2-tools-4.1 with Linux v5.8 kernel.
>
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
>   Documentation/security/keys/trusted-encrypted.rst | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 9483a7425ad5..1da879a68640 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
>   
>   Or with the Intel TSS 2 stack::
>   
> -  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
> +  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
>     [...]
> -  handle: 0x800000FF
> -  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
> +  #> tpm2_evictcontrol -c key.ctxt 0x81000001
>     persistentHandle: 0x81000001
>   
>   Usage::

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
