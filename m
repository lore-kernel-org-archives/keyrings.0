From: James Bottomley <jejb@linux.ibm.com>
Date: Thu, 05 Mar 2020 20:46:10 +0000
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <1583441170.3927.37.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
         <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com>
         <alpine.DEB.2.21.2003052132540.5431@felia>
In-Reply-To: <alpine.DEB.2.21.2003052132540.5431@felia>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 21:34 +0100, Lukas Bulwahn wrote:
> 
> On Thu, 5 Mar 2020, Jarkko Sakkinen wrote:
> 
> > On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys
> > > subsystem")
> > > renamed trusted.h to trusted_tpm.h in include/keys/, and moved
> > > trusted.c
> > > to trusted-keys/trusted_tpm1.c in security/keys/.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > 
> > >   warning: no file matches F: security/keys/trusted.c
> > >   warning: no file matches F: include/keys/trusted.h
> > > 
> > > Rectify the KEYS-TRUSTED entry in MAINTAINERS now.
> > > 
> > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > > Sumit, please ack.
> > > Jarkko, please pick this patch.
> > 
> > I'll pick it when it is done. I acknowledge the regression but I
> > see no reason for rushing as this does not break any systems in
> > the wild.
> > 
> 
> Agree. No need to rush this. I sent out a v3, and I hope to get
> Sumit's ACK and then you can pick it for the next merge window.

From a process point of view, I don't quite understand this.  You're
altering an entry in the MAINTAINERS file which belongs to the three
maintainers of trusted keys, you only need our ack to do that, which
picking up via the trusted key tree will substitute for.  It would be
useful to have Sumit review this because he moved the files and there
may be something we missed, but a reviewed-by: is a nice to have and
not a block on the process.

James
