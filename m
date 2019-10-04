From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 04 Oct 2019 18:27:11 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191004182711.GC6945@linux.intel.com>
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
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
To: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Fri, Oct 04, 2019 at 01:26:58PM +0000, Safford, David (GE Global Research, US) wrote:
> As the original author of trusted keys, let me make a few comments.
> First, trusted keys were specifically implemented and *documented* to
> use the TPM to both generate and seal keys. Its kernel documentation
> specifically states this as a promise to user space. If you want to have 
> a different key system that uses the random pool to generate the keys,
> fine, but don't change trusted keys, as that changes the existing promise
> to user space. 

TPM generating keys (i.e. the random number) would make sense if the key
would never leave from TPM (that kind of trusted keys would not be a
bad idea at all).

> There are many good reasons for wanting the keys to be based on the
> TPM generator.  As the source for the kernel random number generator
> itself says, some systems lack good randomness at startup, and systems
> should preserve and reload the pool across shutdown and startup.
> There are use cases for trusted keys which need to generate keys 
> before such scripts have run. Also, in some use cases, we need to show
> that trusted keys are FIPS compliant, which is possible with TPM
> generated keys.

If you are able to call tpm_get_random(), the driver has already
registered TPN as hwrng. With this solution you fail to follow the
principle of defense in depth. If the TPM random number generator
is compromissed (has a bug) using the entropy pool will decrease
the collateral damage.

> Second, the TPM is hardly a "proprietary random number generator".
> It is an open standard with multiple implementations, many of which are
> FIPS certified.
> 
> Third, as Mimi states, using a TPM is not a "regression". It would be a
> regression to change trusted keys _not_ to use the TPM, because that
> is what trusted keys are documented to provide to user space.

For asym-tpm.c it is without a question a regression because of the
evolution that has happened after trusted keys. For trusted keys
using kernel rng would be improvement.

/Jarkko
