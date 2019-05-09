From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 May 2019 23:01:08 +0000
Subject: Re: [PATCH v10 09/12] ima: Implement support for module-style appended signatures
Message-Id: <1557442868.10635.87.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-10-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-10-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

Hi Thiago,

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fca7a3f23321..a7a20a8c15c1 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1144,6 +1144,12 @@ void ima_delete_rules(void)
>  	}
>  }
>  
> +#define __ima_hook_stringify(str)	(#str),
> +
> +const char *const func_tokens[] = {
> +	__ima_hooks(__ima_hook_stringify)
> +};
> +
>  #ifdef	CONFIG_IMA_READ_POLICY
>  enum {
>  	mask_exec = 0, mask_write, mask_read, mask_append
> @@ -1156,12 +1162,6 @@ static const char *const mask_tokens[] = {
>  	"MAY_APPEND"
>  };
>  
> -#define __ima_hook_stringify(str)	(#str),
> -
> -static const char *const func_tokens[] = {
> -	__ima_hooks(__ima_hook_stringify)
> -};
> -
>  void *ima_policy_start(struct seq_file *m, loff_t *pos)
>  {
>  	loff_t l = *pos;

Is moving this something left over from previous versions or there is
a need for this change?

Other than this, the patch looks good.

Mimi
