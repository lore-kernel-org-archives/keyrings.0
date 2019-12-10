From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 10 Dec 2019 22:42:54 +0000
Subject: Re: [PATCH v10 3/6] IMA: Define an IMA hook to measure keys
Message-Id: <1576017774.4579.42.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-4-nramas@linux.microsoft.com>
In-Reply-To: <20191204224131.3384-4-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-12-04 at 14:41 -0800, Lakshmi Ramasubramanian wrote:
> Measure asymmetric keys used for verifying file signatures,
> certificates, etc.
> 
> This patch defines a new IMA hook namely ima_post_key_create_or_update()
> to measure the payload used to create a new key or update an existing key.
> 
> The IMA hook is defined in a new file namely ima_asymmetric_keys.c
> which is built only if CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is enabled.

Missing from the last paragraph is the reason for requiring a new
file.  I would prefix this last paragraph, explaining that the
asymmetric key structure is only defined when
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined.

Mimi

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/Makefile              |  1 +
>  security/integrity/ima/ima_asymmetric_keys.c | 52 ++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 security/integrity/ima/ima_asymmetric_keys.c
> 
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 31d57cdf2421..207a0a9eb72c 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>  ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> +obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> new file mode 100644
> index 000000000000..994d89d58af9
> --- /dev/null
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * File: ima_asymmetric_keys.c
> + *       Defines an IMA hook to measure asymmetric keys on key
> + *       create or update.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <keys/asymmetric-type.h>
> +#include "ima.h"
> +
> +/**
> + * ima_post_key_create_or_update - measure asymmetric keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @payload: The data used to instantiate or update the key.
> + * @payload_len: The length of @payload.
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + * The payload data used to instantiate or update the key is measured.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   const void *payload, size_t payload_len,
> +				   unsigned long flags, bool create)
> +{
> +	/* Only asymmetric keys are handled by this hook. */
> +	if (key->type != &key_type_asymmetric)
> +		return;
> +
> +	if (!payload || (payload_len = 0))
> +		return;
> +
> +	/*
> +	 * keyring->description points to the name of the keyring
> +	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> +	 * which the given key is linked to.
> +	 *
> +	 * The name of the keyring is passed in the "eventname"
> +	 * parameter to process_buffer_measurement() and is set
> +	 * in the "eventname" field in ima_event_data for
> +	 * the key measurement IMA event.
> +	 */
> +	process_buffer_measurement(payload, payload_len,
> +				   keyring->description, KEY_CHECK, 0);
> +}
