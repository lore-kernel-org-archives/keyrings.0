From: Ken Goldman <kgold@linux.ibm.com>
Date: Mon, 07 Oct 2019 22:13:01 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
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
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com>
In-Reply-To: <20191007000520.GA17116@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

The TPM library specification states that the TPM must comply with NIST 
SP800-90 A.

https://trustedcomputinggroup.org/membership/certification/tpm-certified-products/

shows that the TPMs get third party certification, Common Criteria EAL 4+.

While it's theoretically possible that an attacker could compromise
both the TPM vendors and the evaluation agencies, we do have EAL 4+ 
assurance against both 1 and 2.

On 10/6/2019 8:05 PM, Jarkko Sakkinen wrote:
> 
> Kernel has the random number generator for two reasons:
> 
> 1. To protect against bugs in hwrng's.
> 2. To protect against deliberate backdoors in hwrng's.
> 
> How TPM RNG is guaranteed to protect against both 1 and 2?
