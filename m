From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 14 Oct 2019 19:11:50 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191014191150.GB15552@linux.intel.com>
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
 <20191009073315.GA5884@linux.intel.com>
 <20191009074133.GA6202@linux.intel.com>
 <MN2PR20MB2973CDE87E4EC25CA21DD2C8CA950@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <MN2PR20MB2973CDE87E4EC25CA21DD2C8CA950@MN2PR20MB2973.namprd20.prod.outlook.com>
To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc: Ken Goldman <kgold@linux.ibm.com>, "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Oct 09, 2019 at 08:09:29AM +0000, Pascal Van Leeuwen wrote:
> There's certification and certification. Not all certificates are
> created equally. But if it matches your specific requirements, why not.
> There's a _lot_ of HW out there that's not x86 though ...
> 
> And: is RDRAND certified for _all_ x86 processors? Or just Intel?
> Or perhaps even only _specific (server) models_ of CPU's?
> I also know for a fact that some older AMD processors had a broken
> RDRAND implementation ...
> 
> So the choice really should be up to the application or user.

I'm not seriously suggesting to move rdrand here. I'm trying find the
logic how to move forward with trusted keys with multiple backends (not
only TPM).

AKA we have a kernel rng in existence but no clear policy when it should
be used and when not. This leads to throwing a dice with the design
choices. Even it TPM RNG is the right choice in tpm_asym.c, the choice
was not based on anything (otherwise it would have been documented).

/Jarkko
