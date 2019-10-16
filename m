From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 16 Oct 2019 16:25:43 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191016162543.GB6279@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com>
 <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com>
 <20191008235339.GB13926@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
 <20191014190033.GA15552@linux.intel.com>
 <1571081397.3728.9.camel@HansenPartnership.com>
 <20191016110031.GE10184@linux.intel.com>
 <1571229252.3477.7.camel@HansenPartnership.com>
In-Reply-To: <1571229252.3477.7.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Ken Goldman <kgold@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Oct 16, 2019 at 08:34:12AM -0400, James Bottomley wrote:
> reversible ciphers are generally frowned upon in random number
> generation, that's why the krng uses chacha20.  In general I think we
> shouldn't try to code our own mixing and instead should get the krng to
> do it for us using whatever the algorithm du jour that the crypto guys
> have blessed is.  That's why I proposed adding the TPM output to the
> krng as entropy input and then taking the output of the krng.

It is already registered as hwrng. What else? Was the issue that
it is only used as seed when the rng is init'd first? I haven't
at this point gone to the internals of krng.

/Jarkko
