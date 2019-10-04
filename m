From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 04 Oct 2019 18:42:54 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <1570214574.3563.32.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191003114119.GF8933@linux.intel.com>
         <1570107752.4421.183.camel@linux.ibm.com>
         <20191003175854.GB19679@linux.intel.com>
         <1570128827.5046.19.camel@linux.ibm.com>
         <20191003215125.GA30511@linux.intel.com>
         <20191003215743.GB30511@linux.intel.com>
         <1570140491.5046.33.camel@linux.ibm.com>
         <1570147177.10818.11.camel@HansenPartnership.com>
         <20191004182216.GB6945@linux.intel.com>
         <1570213491.3563.27.camel@HansenPartnership.com>
         <20191004183342.y63qdvspojyf3m55@cantor>
In-Reply-To: <20191004183342.y63qdvspojyf3m55@cantor>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Fri, 2019-10-04 at 11:33 -0700, Jerry Snitselaar wrote:
> On Fri Oct 04 19, James Bottomley wrote:
> > On Fri, 2019-10-04 at 21:22 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Oct 03, 2019 at 04:59:37PM -0700, James Bottomley wrote:
> > > > I think the principle of using multiple RNG sources for strong
> > > > keys is a sound one, so could I propose a compromise:  We have
> > > > a tpm subsystem random number generator that, when asked for
> > > > <n> random bytes first extracts <n> bytes from the TPM RNG and
> > > > places it into the kernel entropy pool and then asks for <n>
> > > > random bytes from the kernel RNG? That way, it will always have
> > > > the entropy to satisfy the request and in the worst case, where
> > > > the kernel has picked up no other entropy sources at all it
> > > > will be equivalent to what we have now (single entropy source)
> > > > but usually it will be a much better mixed entropy source.
> > > 
> > > I think we should rely the existing architecture where TPM is
> > > contributing to the entropy pool as hwrng.
> > 
> > That doesn't seem to work: when I trace what happens I see us
> > inject 32 bytes of entropy at boot time, but never again.  I think
> > the problem is the kernel entropy pool is push not pull and we have
> > no triggering event in the TPM to get us to push.  I suppose we
> > could set a timer to do this or perhaps there is a pull hook and we
> > haven't wired it up correctly?
> > 
> > James
> > 
> 
> Shouldn't hwrng_fillfn be pulling from it?

It should, but the problem seems to be it only polls the "current" hw
rng ... it doesn't seem to have a concept that there may be more than
one.  What happens, according to a brief reading of the code, is when
multiple are registered, it determines what the "best" one is and then
only pulls from that.  What I think it should be doing is filling from
all of them using the entropy quality to adjust how many bits we get.

James
