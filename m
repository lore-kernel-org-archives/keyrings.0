From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Aug 2019 05:40:11 +0000
Subject: Re: [PATCH v5 4/4] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <CAFA6WYPnoDoMWd=PT4mgXPhg1Wp0=AFDnWd_44UMP7sijXzAZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-5-git-send-email-sumit.garg@linaro.org> <20190827141742.6qxowsigqolxaod4@linux.intel.com>
In-Reply-To: <20190827141742.6qxowsigqolxaod4@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Tue, 27 Aug 2019 at 19:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Aug 21, 2019 at 06:29:05PM +0530, Sumit Garg wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2004 IBM Corporation
> > + * Copyright (C) 2014 Intel Corporation
>
> Everything below can be dropped from this new file. Git has the most
> accurate authority information.
>
> I'm not sure why I added the authors-list in the first place to the
> header when I implemented these functions as none of those folks have
> contributed to this particular piece of work.
>
> > + * Authors:
> > + * Leendert van Doorn <leendert@watson.ibm.com>
> > + * Dave Safford <safford@watson.ibm.com>
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Kylene Hall <kjhall@us.ibm.com>
> > + *
> > + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > + *
> > + * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
> > + */
>
> To summarize, I think this would be sufficient:
>
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * Copyright (C) 2004 IBM Corporation
>  * Copyright (C) 2014 Intel Corporation
>  */

Sounds good to me.

>
> I think there should never be such a rush that acronym could not be
> written with the correct spelling. I'm referring to 'tpm2' in the short
> summary.

So you mean to say we should use upper-case letters for 'TPM2' acronym?

> I'm sorry, I had to say it, just can't help myself with those
> kind of details :-) I can take care of fixing those once I apply these
> patches.
>
> You've done an awesome job. Thank you.
>

You are welcome.

> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks for your review.

-Sumit

> Unfortunately I'm not yet sure if I have time to test these before going
> to Linux Plumbers but these would be anyway too close to the next merge
> window to be added to the v5.4 PR.
>
> /Jarkko
