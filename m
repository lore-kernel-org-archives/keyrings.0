From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 03 Oct 2019 23:59:37 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <1570147177.10818.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
         <1570024819.4999.119.camel@linux.ibm.com>
         <20191003114119.GF8933@linux.intel.com>
         <1570107752.4421.183.camel@linux.ibm.com>
         <20191003175854.GB19679@linux.intel.com>
         <1570128827.5046.19.camel@linux.ibm.com>
         <20191003215125.GA30511@linux.intel.com>
         <20191003215743.GB30511@linux.intel.com>
         <1570140491.5046.33.camel@linux.ibm.com>
In-Reply-To: <1570140491.5046.33.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, 2019-10-03 at 18:08 -0400, Mimi Zohar wrote:
> On Fri, 2019-10-04 at 00:57 +0300, Jarkko Sakkinen wrote:
> > On Fri, Oct 04, 2019 at 12:51:25AM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Oct 03, 2019 at 02:53:47PM -0400, Mimi Zohar wrote:
> > > > [Cc'ing David Safford]
> > > > 
> > > > On Thu, 2019-10-03 at 20:58 +0300, Jarkko Sakkinen wrote:
> > > > > On Thu, Oct 03, 2019 at 09:02:32AM -0400, Mimi Zohar wrote:
> > > > > > On Thu, 2019-10-03 at 14:41 +0300, Jarkko Sakkinen wrote:
> > > > > > > On Wed, Oct 02, 2019 at 10:00:19AM -0400, Mimi Zohar
> > > > > > > wrote:
> > > > > > > > On Thu, 2019-09-26 at 20:16 +0300, Jarkko Sakkinen
> > > > > > > > wrote:
> > > > > > > > > Only the kernel random pool should be used for
> > > > > > > > > generating random numbers.
> > > > > > > > > TPM contributes to that pool among the other sources
> > > > > > > > > of entropy. In here it
> > > > > > > > > is not, agreed, absolutely critical because TPM is
> > > > > > > > > what is trusted anyway
> > > > > > > > > but in order to remove tpm_get_random() we need to
> > > > > > > > > first remove all the
> > > > > > > > > call sites.
> > > > > > > > 
> > > > > > > > At what point during boot is the kernel random pool
> > > > > > > > available?  Does this imply that you're planning on
> > > > > > > > changing trusted keys as well?
> > > > > > > 
> > > > > > > Well trusted keys *must* be changed to use it. It is not
> > > > > > > a choice because using a proprietary random number
> > > > > > > generator instead of defacto one in the kernel can be
> > > > > > > categorized as a *regression*.
> > > > > > 
> > > > > > I really don't see how using the TPM random number for TPM
> > > > > > trusted keys would be considered a regression.  That by
> > > > > > definition is a trusted key.  If anything, changing what is
> > > > > > currently being done would be the regression. 
> > > > > 
> > > > > It is really not a TPM trusted key. It trusted key that gets
> > > > > sealed with the TPM. The key itself is used in clear by
> > > > > kernel. The random number generator exists in the kernel to
> > > > > for a reason.
> > > > > 
> > > > > It is without doubt a regression.
> > > > 
> > > > You're misusing the term "regression" here.  A regression is
> > > > something that previously worked and has stopped working.  In
> > > > this case, trusted keys has always been based on the TPM random
> > > > number generator.  Before changing this, there needs to be some
> > > > guarantees that the kernel random number generator has a pool
> > > > of random numbers early, on all systems including embedded
> > > > devices, not just servers.
> > > 
> > > I'm not using the term regression incorrectly here. Wrong
> > > function was used to generate random numbers for the payload
> > > here. It is an obvious bug.
> > 
> > At the time when trusted keys was introduced I'd say that it was a
> > wrong design decision and badly implemented code. But you are right
> > in that as far that code is considered it would unfair to speak of
> > a regression.

I think that's a bit unfair: when the code was written, a decade ago,
the TPM was thought to be the state of the art in terms of random
number generators.  Of course, since then the kernel RNG has become way
better and we've become more aware of nation state actors thinking that
influencing the RNG is the best way to compromise strong crypto.

> > asym-tpm.c on the other hand this is fresh new code. There has been
> > *countless* of discussions over the years that random numbers
> > should come from multiple sources of entropy. There is no other
> > categorization than a bug for the tpm_get_random() there.
> 
> This week's LWN article on "5.4 Merge window, part 2" discusses
> "boot- time entropy".  This article couldn't have been more perfectly
> timed.

I think the principle of using multiple RNG sources for strong keys is
a sound one, so could I propose a compromise:  We have a tpm subsystem
random number generator that, when asked for <n> random bytes first
extracts <n> bytes from the TPM RNG and places it into the kernel
entropy pool and then asks for <n> random bytes from the kernel RNG? 
That way, it will always have the entropy to satisfy the request and in
the worst case, where the kernel has picked up no other entropy sources
at all it will be equivalent to what we have now (single entropy
source) but usually it will be a much better mixed entropy source.

James
