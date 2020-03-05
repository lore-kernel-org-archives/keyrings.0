From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 05 Mar 2020 20:32:23 +0000
Subject: Re: [PATCH v2] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <alpine.DEB.2.21.2003052130520.5431@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200304211254.5127-1-lukas.bulwahn@gmail.com> <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
In-Reply-To: <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Thu, 5 Mar 2020, Sumit Garg wrote:

> On Thu, 5 Mar 2020 at 02:43, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > to trusted-keys/trusted_tpm1.c in security/keys/.
> >
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> >
> >   warning: no file matches F: security/keys/trusted.c
> >   warning: no file matches F: include/keys/trusted.h
> >
> > Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> > files in security/keys/ are identified as part of KEYS-TRUSTED.
> >
> 
> I guess you meant here security/keys/trusted-keys/ instead of security/keys/.
>

Yes, that is what I meant. I rushed the patch v2 last night.

Here is hopefully now a PATCH v3 you can ack:

https://lore.kernel.org/linux-integrity/20200305203013.6189-1-lukas.bulwahn@gmail.com/T/#u

Lukas
