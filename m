From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 09 Oct 2019 07:33:15 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191009073315.GA5884@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1570107752.4421.183.camel@linux.ibm.com>
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
To: Ken Goldman <kgold@linux.ibm.com>
Cc: "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Oct 09, 2019 at 02:53:39AM +0300, Jarkko Sakkinen wrote:
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
> And for trusted keys the least trust solution is to do generation
> with the kernel assets and sealing with TPM. With TEE the least
> trust solution is equivalent.
> 
> Are you proposing that the kernel random number generation should
> be removed? That would be my conclusion of this discussion if I
> would agree any of this (I don't).

The whole point of rng in kernel has been to use multiple entropy
sources in order to disclose the trust issue.

Even with weaker entropy than TPM RNG it is still a better choice for
*non-TPM* keys because of better trustworthiness. Using only TPM RNG is
a design flaw that has existed probably because when trusted keys were
introduced TPM was more niche than it is today.

Please remember that a trusted key is not a TPM key. The reality
distortion field is strong here it seems.

/Jarkko
