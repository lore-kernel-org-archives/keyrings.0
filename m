From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 06 Mar 2020 22:40:26 +0000
Subject: Re: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <20200306224026.GA4095@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
 <20200306193127.GJ7472@linux.intel.com>
 <alpine.DEB.2.21.2003062148050.2990@felia>
In-Reply-To: <alpine.DEB.2.21.2003062148050.2990@felia>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:50:44PM +0100, Lukas Bulwahn wrote:
> 
> 
> On Fri, 6 Mar 2020, Jarkko Sakkinen wrote:
> 
> > On Thu, Mar 05, 2020 at 09:30:13PM +0100, Lukas Bulwahn wrote:
> > > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > > to trusted-keys/trusted_tpm1.c in security/keys/.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > 
> > >   warning: no file matches F: security/keys/trusted.c
> > >   warning: no file matches F: include/keys/trusted.h
> > > 
> > > Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> > > files in security/keys/trusted-keys/ are identified as part of
> > > KEYS-TRUSTED.
> > > 
> > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > > Changes to v1:
> > >   - use a global pattern for matching the whole security/keys/trusted-keys/
> > >     directory.
> > > Changes to v2:
> > >   - name the correct directory in the commit message
> > > 
> > > Sumit, please ack.
> > > Jarkko, please pick this patch v3.
> > 
> > Please tell me why you emphasize the moment when a patch that does not
> > fix a critical bug is picked?
> > 
> > Do you have systems that break because the MAINTAINERS file is not
> > updated?
> > 
> > It will end up in v5.7 PR for sure but saying things like that is same
> > as saying that there would be some catastrophically urgent need to still
> > squeeze the patch into v5.6. Unless you actually have something critical
> > in your hand, please stop doing that.
> > 
> 
> Got it. I did not intend to emphasize any urgency; I will not continue 
> to do that for patches of this clean-up type.

Anyway, thank you and I've applied your patch and will include it to my
v5.7 PR.

/Jarkko
