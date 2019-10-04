From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Date: Fri, 04 Oct 2019 19:56:01 +0000
Subject: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
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
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


> From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> owner@vger.kernel.org> On Behalf Of Jarkko Sakkinen
> Sent: Friday, October 4, 2019 2:27 PM
> Subject: EXT: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
> 
> If you are able to call tpm_get_random(), the driver has already registered
> TPN as hwrng. With this solution you fail to follow the principle of defense in
> depth. If the TPM random number generator is compromissed (has a bug)
> using the entropy pool will decrease the collateral damage.

And if the entropy pool has a bug or is misconfigured, you lose everything.
That does not sound like defense in depth to me. In the real world
I am not aware of a single instance of RNG vulnerability on a TPM.
I am directly aware of several published vulnerabilities in embedded systems 
due to a badly ported version of the kernel random pool. In addition, 
the random generator in a TPM is hardware isolated, and less likely to be
vulnerable to side channel or memory manipulation errors. The TPM
RNG is typically FIPS certified.  The use of the TPM RNG was a deliberate
design choice in trusted keys.

> > Third, as Mimi states, using a TPM is not a "regression". It would be
> > a regression to change trusted keys _not_ to use the TPM, because that
> > is what trusted keys are documented to provide to user space.
> 
> For asym-tpm.c it is without a question a regression because of the evolution
> that has happened after trusted keys. For trusted keys using kernel rng
> would be improvement.

Perhaps this is a language issue, but you are not using "regression" correctly.
Changing to the kernel pool would not only be a debatable  "improvement", 
but also would certainly be a change to the documented trusted key  
behavior, which I thought was frowned upon.

dave
