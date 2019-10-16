From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 16 Oct 2019 11:00:31 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191016110031.GE10184@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
 <20191004182711.GC6945@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com>
 <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com>
 <20191008235339.GB13926@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
 <20191014190033.GA15552@linux.intel.com>
 <1571081397.3728.9.camel@HansenPartnership.com>
In-Reply-To: <1571081397.3728.9.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Ken Goldman <kgold@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Oct 14, 2019 at 12:29:57PM -0700, James Bottomley wrote:
> The job of the in-kernel rng is simply to produce a mixed entropy pool
> from which we can draw random numbers.  The idea is that quite a few
> attackers have identified the rng as being a weak point in the security
> architecture of the kernel, so if we mix entropy from all the sources
> we have, you have to compromise most of them to gain some predictive
> power over the rng sequence.

The documentation says that krng is suitable for key generation.
Should the documentation changed to state that it is unsuitable?

> The point is not how certified the TPM RNG is, the point is that it's a
> single source and if we rely on it solely for some applications, like
> trusted keys, then it gives the attackers a single known point to go
> after.  This may be impossible for script kiddies, but it won't be for
> nation states ... are you going to exclusively trust the random number
> you got from your chinese certified TPM?

I'd suggest approach where TPM RNG result is xored with krng result.

> Remember also that the attack doesn't have to be to the TPM only, it
> could be the pathway by which we get the random number, which involves
> components outside of the TPM certification.

Yeah, I do get this.

/Jarkko
