From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Date: Wed, 09 Oct 2019 12:11:06 +0000
Subject: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
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
Cc: Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


> From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Sent: Tuesday, October 8, 2019 7:54 PM
> To: Ken Goldman <kgold@linux.ibm.com>
> Cc: Safford, David (GE Global Research, US) <david.safford@ge.com>; Mimi
> Zohar <zohar@linux.ibm.com>; linux-integrity@vger.kernel.org;
> stable@vger.kernel.org; open list:ASYMMETRIC KEYS
> <keyrings@vger.kernel.org>; open list:CRYPTO API <linux-
> crypto@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: EXT: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
> 
> On Wed, Oct 09, 2019 at 02:49:35AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 07, 2019 at 06:13:01PM -0400, Ken Goldman wrote:
> > > The TPM library specification states that the TPM must comply with
> > > NIST
> > > SP800-90 A.
> > >
> > > https://trustedcomputinggroup.org/membership/certification/tpm-certi
> > > fied-products/
> > >
> > > shows that the TPMs get third party certification, Common Criteria EAL 4+.
> > >
> > > While it's theoretically possible that an attacker could compromise
> > > both the TPM vendors and the evaluation agencies, we do have EAL 4+
> > > assurance against both 1 and 2.
> >
> > Certifications do not equal to trust.
> 
> And for trusted keys the least trust solution is to do generation with the kernel
> assets and sealing with TPM. With TEE the least trust solution is equivalent.
> 
> Are you proposing that the kernel random number generation should be
> removed? That would be my conclusion of this discussion if I would agree any
> of this (I don't).
> 
> /Jarkko

No one is suggesting that.

You are suggesting changing the documented behavior of trusted keys, and
that would cause problems for some of our use cases. While certification
may not in your mind be equal to trust, it is equal to compliance with 
mandatory regulations.

Perhaps rather than arguing past each other, we should look into 
providing users the ability to choose, as an argument to keyctl?

dave
