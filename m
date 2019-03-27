From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 27 Mar 2019 04:54:50 +0000
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-Id: <20190327045450.GC15397@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <20190326113725.GA10898@linux.intel.com>
 <1553602220.3960.29.camel@linux.ibm.com>
 <1553610317.2900.2.camel@linux.ibm.com>
In-Reply-To: <1553610317.2900.2.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, Denis Kenzior <denkenz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, James Morris <james.morris@microsoft.com>

On Tue, Mar 26, 2019 at 07:25:17AM -0700, James Bottomley wrote:
> On Tue, 2019-03-26 at 08:10 -0400, Mimi Zohar wrote:
> > Hi Jarrko,
> > 
> > On Tue, 2019-03-26 at 13:37 +0200, Jarkko Sakkinen wrote:
> > > Mimi,
> > > 
> > > Can you fix this and I can ack and send PR through my tree?
> > 
> > Making the "trusted.h" include file public was part of David's "KEYS:
> > Support TPM-wrapped key and crypto ops" patch set.  I wasn't involved
> > in reviewing or upstreaming this patch set.  As I recall, it was
> > upstreamed rather quickly without much review.  As it is TPM related,
> > it should have at least been posted on the linux-integrity mailing
> > list.  I have no idea if "trusted.h" should have been made public.
> > 
> > I'm not sure just "fixing" the MAINTAINERS file is the right
> > solution.  I was hoping to look at it later this week.  Perhaps you
> > and James could take a look?
> 
> Looking at the contents of linux/keys/trusted.h, it looks like the
> wrong decision to move it.  The contents are way too improperly named
> and duplicative to be in a standard header.  It's mostly actually TPM
> code including a redefinition of the tpm_buf structure, so it doesn't
> even seem to be necessary for trusted keys.
> 
> If you want to fix this as a bug, I'd move it back again, but long term
> I think it should simply be combined with trusted.c because nothing
> else can include it sanely anyway.

<offtopic>
Fully agree with the long term plan.

I think it would be better to take the TPM2 trusted keys code from the
driver to the keyring subsystem once TPM1 trusted keys code has been
converted to use tpm_buf.

I don't also know any good reason for the core TPM driver to be compiled
as a module. It is just makes the kernel build configuration more
awkward. Would be nice to get the TPM callable from any subsystem
without fuzz. There is no a production use case for "TPM as an LKM"
(obviously drivers for different types of TPM hardware must and will
be compilable as LKM's).
</offtopic>

/Jarkko
