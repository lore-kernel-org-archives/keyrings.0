From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 09 Sep 2020 17:30:08 +0000
Subject: Re: [PATCH v4] docs: trusted-encrypted.rst: update parameters for command examples
Message-Id: <20200909113008.6ee6e109@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200821135356.15737-1-colyli@suse.de>
In-Reply-To: <20200821135356.15737-1-colyli@suse.de>
To: Coly Li <colyli@suse.de>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Stefan Berger <stefanb@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>

On Fri, 21 Aug 2020 21:53:56 +0800
Coly Li <colyli@suse.de> wrote:

> The parameters in command examples for tpm2_createprimary and
> tpm2_evictcontrol are outdated, people (like me) are not able to create
> trusted key by these command examples.
> 
> This patch updates the parameters of command example tpm2_createprimary
> and tpm2_evictcontrol in trusted-encrypted.rst. With Linux kernel v5.8
> and tpm2-tools-4.1, people can create a trusted key by following the
> examples in this document.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> ---
> Changelog:
> v4: update Reviewed-by list, and Cc linux-doc and linux-integrity
>     maintainers.
> v3: update commit log with review comments from Jarkko Sakkinen. 
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

This has been languishing, sorry; I've just applied it.

Thanks,

jon
