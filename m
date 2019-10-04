From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 04 Oct 2019 18:30:03 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191004183003.GD6945@linux.intel.com>
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
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
 <20191004182711.GC6945@linux.intel.com>
In-Reply-To: <20191004182711.GC6945@linux.intel.com>
To: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

> > There are many good reasons for wanting the keys to be based on the
> > TPM generator.  As the source for the kernel random number generator
> > itself says, some systems lack good randomness at startup, and systems
> > should preserve and reload the pool across shutdown and startup.
> > There are use cases for trusted keys which need to generate keys 
> > before such scripts have run. Also, in some use cases, we need to show
> > that trusted keys are FIPS compliant, which is possible with TPM
> > generated keys.
> 
> If you are able to call tpm_get_random(), the driver has already
> registered TPN as hwrng. With this solution you fail to follow the
> principle of defense in depth. If the TPM random number generator
> is compromissed (has a bug) using the entropy pool will decrease
> the collateral damage.

I.e. you make everything depend on single point of failure instead
of multiple (e.g. rdrand, TPM, whatnot).

/Jarkko
