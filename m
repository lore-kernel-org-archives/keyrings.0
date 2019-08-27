From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 27 Aug 2019 14:17:42 +0000
Subject: Re: [PATCH v5 4/4] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <20190827141742.6qxowsigqolxaod4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1566392345-15419-5-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Wed, Aug 21, 2019 at 06:29:05PM +0530, Sumit Garg wrote:
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + * Copyright (C) 2014 Intel Corporation

Everything below can be dropped from this new file. Git has the most
accurate authority information.

I'm not sure why I added the authors-list in the first place to the
header when I implemented these functions as none of those folks have
contributed to this particular piece of work.

> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> + *
> + * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
> + */

To summarize, I think this would be sufficient:

// SPDX-License-Identifier: GPL-2.0-only
/*
 * Copyright (C) 2004 IBM Corporation
 * Copyright (C) 2014 Intel Corporation
 */

I think there should never be such a rush that acronym could not be
written with the correct spelling. I'm referring to 'tpm2' in the short
summary. I'm sorry, I had to say it, just can't help myself with those
kind of details :-) I can take care of fixing those once I apply these
patches.

You've done an awesome job. Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Unfortunately I'm not yet sure if I have time to test these before going
to Linux Plumbers but these would be anyway too close to the next merge
window to be added to the v5.4 PR.

/Jarkko
