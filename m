From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 04 Mar 2020 21:15:53 +0000
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <alpine.DEB.2.21.2003042214170.2698@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com> <1583338378.3284.7.camel@linux.ibm.com>
In-Reply-To: <1583338378.3284.7.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org


On Wed, 4 Mar 2020, James Bottomley wrote:

> On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > +F:	include/keys/trusted_tpm.h
> > +F:	security/keys/trusted-keys/trusted_tpm1.c
> 
> Everything under trusted-keys is part of the subsystem, so this should
> be a glob not a single file.
> 

Agree. I sent out a PATCH v2 for that:

https://lore.kernel.org/linux-integrity/20200304211254.5127-1-lukas.bulwahn@gmail.com/T/#u

Please ignore this v1 here and pick v2.

Thanks,

Lukas
