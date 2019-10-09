From: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Date: Wed, 09 Oct 2019 08:02:52 +0000
Subject: RE: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <MN2PR20MB29732A856A40131A671F949FCA950@MN2PR20MB2973.namprd20.prod.outlook.com>
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
 <20191009073315.GA5884@linux.intel.com>
In-Reply-To: <20191009073315.GA5884@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ken Goldman <kgold@linux.ibm.com>
Cc: "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.org> On Behalf Of
> Jarkko Sakkinen
> Sent: Wednesday, October 9, 2019 9:33 AM
> To: Ken Goldman <kgold@linux.ibm.com>
> Cc: Safford, David (GE Global Research, US) <david.safford@ge.com>; Mimi Zohar
> <zohar@linux.ibm.com>; linux-integrity@vger.kernel.org; stable@vger.kernel.org; open
> list:ASYMMETRIC KEYS <keyrings@vger.kernel.org>; open list:CRYPTO API <linux-
> crypto@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
> 
> On Wed, Oct 09, 2019 at 02:53:39AM +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 09, 2019 at 02:49:35AM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Oct 07, 2019 at 06:13:01PM -0400, Ken Goldman wrote:
> > > > The TPM library specification states that the TPM must comply with NIST
> > > > SP800-90 A.
> > > >
> > > > https://trustedcomputinggroup.org/membership/certification/tpm-certified-products/
> > > >
> > > > shows that the TPMs get third party certification, Common Criteria EAL 4+.
> > > >
> > > > While it's theoretically possible that an attacker could compromise
> > > > both the TPM vendors and the evaluation agencies, we do have EAL 4+
> > > > assurance against both 1 and 2.
> > >
> > > Certifications do not equal to trust.
> >
> > And for trusted keys the least trust solution is to do generation
> > with the kernel assets and sealing with TPM. With TEE the least
> > trust solution is equivalent.
> >
> > Are you proposing that the kernel random number generation should
> > be removed? That would be my conclusion of this discussion if I
> > would agree any of this (I don't).
> 
> The whole point of rng in kernel has been to use multiple entropy
> sources in order to disclose the trust issue.
> 
I do understand that, and combining multiple entropy sources, if
you have them available to get _more_ entropy is a good idea, at 
least in theory. But ...

How do I know the mixing of entropy happens properly? Especially
if I'm not capable of judging this by myself. 
And how do I know the SW entropy pool and/or code cannot be influenced
_somehow_? (either directly or indirectly by influencing one of the
contributors). More code and/or HW involved means more attack vectors
and complication of the review process.

The point is, if you want to certify such an application, you would
have to have _all_ contributors _plus_ the kernel rng code certified.
And you would have to have it _recertified_ every time a _single_
component - including the kernel code itself! - changes.

> Even with weaker entropy than TPM RNG it is still a better choice for
> *non-TPM* keys because of better trustworthiness.
>
"Even with weaker entropy"? Now that's just silly. If you _know_ and
_trust_ the TPM to have _better_ entropy, then obviously that is the
better choice. I guess the key word being the trust you don't have.

> Using only TPM RNG is
> a design flaw that has existed probably because when trusted keys were
> introduced TPM was more niche than it is today.
>
For non-TPM keys, possibly. Assuming the kernel RNG indeed adds 
(or at least does not weaken) entropy. And assuming I _can_ trust
the kernel RNG implementation. Question is: why would I trust that
more than the TPM implementation? Sure, I could look at the code,
but would I truly and fully understand it? (so maybe _I_ would,
but would Joe Random User?)

> Please remember that a trusted key is not a TPM key. The reality
> distortion field is strong here it seems.
> 
Agree. But you should not mess with the possibility to generate
keys based on _just_ the TPM RNG _where that is required_ (and
perhaps _only_ where that is required, if possible)

> /Jarkko

Regards,
Pascal van Leeuwen
Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
www.insidesecure.com
