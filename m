From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 May 2019 15:42:08 +0000
Subject: Re: [PATCH v10 01/12] MODSIGN: Export module signature definitions
Message-Id: <1557416528.10635.62.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-2-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-2-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> IMA will use the module_signature format for append signatures, so export
> the relevant definitions and factor out the code which verifies that the
> appended signature trailer is valid.
> 
> Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
> and be able to use mod_check_sig() without having to depend on either
> CONFIG_MODULE_SIG or CONFIG_MODULES.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>

Just a couple minor questions/comments below.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---

< snip >


> diff --git a/init/Kconfig b/init/Kconfig
> index 4592bf7997c0..a71019553ee1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1906,7 +1906,7 @@ config MODULE_SRCVERSION_ALL
>  config MODULE_SIG
>  	bool "Module signature verification"
>  	depends on MODULES
> -	select SYSTEM_DATA_VERIFICATION
> +	select MODULE_SIG_FORMAT
>  	help
>  	  Check modules for valid signatures upon load: the signature
>  	  is simply appended to the module. For more information see
> @@ -2036,6 +2036,10 @@ config TRIM_UNUSED_KSYMS
>  
>  endif # MODULES
>  
> +config MODULE_SIG_FORMAT
> +	def_bool n
> +	select SYSTEM_DATA_VERIFICATION

Normally Kconfigs, in the same file, are defined before they are used.
 I'm not sure if that is required or just a convention.


>  config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6c57e78817da..d2f2488f80ab 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -57,6 +57,7 @@ endif
>  obj-$(CONFIG_UID16) += uid16.o
>  obj-$(CONFIG_MODULES) += module.o
>  obj-$(CONFIG_MODULE_SIG) += module_signing.o
> +obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
>  obj-$(CONFIG_KALLSYMS) += kallsyms.o
>  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
>  obj-$(CONFIG_CRASH_CORE) += crash_core.o
> diff --git a/kernel/module.c b/kernel/module.c
> index 985caa467aef..326ddeb364dd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -19,6 +19,7 @@
>  #include <linux/export.h>
>  #include <linux/extable.h>
>  #include <linux/moduleloader.h>
> +#include <linux/module_signature.h>
>  #include <linux/trace_events.h>
>  #include <linux/init.h>
>  #include <linux/kallsyms.h>
> diff --git a/kernel/module_signature.c b/kernel/module_signature.c
> new file mode 100644
> index 000000000000..6d5e59f27f55
> --- /dev/null
> +++ b/kernel/module_signature.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Module signature checker
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/printk.h>
> +#include <linux/module_signature.h>
> +#include <asm/byteorder.h>
> +
> +/**
> + * mod_check_sig - check that the given signature is sane
> + *
> + * @ms:		Signature to check.
> + * @file_len:	Size of the file to which @ms is appended.

"name" is missing.

Mimi

> + */
