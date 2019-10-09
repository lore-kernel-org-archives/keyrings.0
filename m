From: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Date: Wed, 09 Oct 2019 07:10:08 +0000
Subject: RE: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <MN2PR20MB2973D1DDDC1C0D41D449E4CCCA950@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191003114119.GF8933@linux.intel.com>
 <1570107752.4421.183.camel@linux.ibm.com>
 <20191003175854.GB19679@linux.intel.com>
 <1570128827.5046.19.camel@linux.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
 <20191004182711.GC6945@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com>
 <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com>
 <20191008235339.GB13926@linux.intel.com>
In-Reply-To: <20191008235339.GB13926@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ken Goldman <kgold@linux.ibm.com>
Cc: "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.org> On Behalf Of
> Jarkko Sakkinen
> Sent: Wednesday, October 9, 2019 1:54 AM
> To: Ken Goldman <kgold@linux.ibm.com>
> Cc: Safford, David (GE Global Research, US) <david.safford@ge.com>; Mimi Zohar
> <zohar@linux.ibm.com>; linux-integrity@vger.kernel.org; stable@vger.kernel.org; open
> list:ASYMMETRIC KEYS <keyrings@vger.kernel.org>; open list:CRYPTO API <linux-
> crypto@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
> 
> On Wed, Oct 09, 2019 at 02:49:35AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 07, 2019 at 06:13:01PM -0400, Ken Goldman wrote:
> > > The TPM library specification states that the TPM must comply with NIST
> > > SP800-90 A.
> > >
> > > https://trustedcomputinggroup.org/membership/certification/tpm-certified-products/
> > >
> > > shows that the TPMs get third party certification, Common Criteria EAL 4+.
> > >
> > > While it's theoretically possible that an attacker could compromise
> > > both the TPM vendors and the evaluation agencies, we do have EAL 4+
> > > assurance against both 1 and 2.
> >
> > Certifications do not equal to trust.
> 
So having an implementation reviewed by a capable third party of 
your choosing (as that's how certification usually works) is less
trustworthy than having random individuals hacking away at it?
(and trust me, _most_ people are not going to review that by 
themselves - very few people on this planet are capable to do so)

> And for trusted keys the least trust solution is to do generation
> with the kernel assets and sealing with TPM. With TEE the least
> trust solution is equivalent.
> 
> Are you proposing that the kernel random number generation should
> be removed? That would be my conclusion of this discussion if I
> would agree any of this (I don't).
> 
Life is not that black and white.

If certification is _not_ a requirement you can use the kernel random
number generator, especially if you don't trust, say, the TPM one.
If you _do_ require certification - and in many industries this is
_mandatory_, you simply _must_ follow the certification rules (which
may impose restrictions how the random number generation is done),
and this should not be made impossible for such _existing_ use cases.

Having said all that, generating _true_ entropy (and, importantly,
ensuring it cannot be manipulated) is a very complicated subject and
considering how all encryption security ultimately  depends on the
quality of the random numbers used for key material, I would not 
trust any implementation that has not been certified or otherwise 
carefully scrutinized by people _proven_ to have the expertise.

Regards,
Pascal van Leeuwen
Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
www.insidesecure.com
