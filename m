From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 31 Oct 2017 20:03:03 +0000
Subject: Re: [PATCH v3] tpm: use struct tpm_chip for tpm_chip_find_get()
Message-Id: <20171031200303.GB18578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, David Safford <safford@us.ibm.com>, David Howells <dhowells@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)" <linux-security-module@vger.kernel.org>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>

On Thu, Oct 26, 2017 at 03:54:50PM +0200, Jarkko Sakkinen wrote:
> Device number (the character device index) is not a stable identifier
> for a TPM chip. That is the reason why every call site passes
> TPM_ANY_NUM to tpm_chip_find_get().
> 
> This commit changes the API in a way that instead a struct tpm_chip
> instance is given and NULL means the default chip. In addition, this
> commit refines the documentation to be up to date with the
> implementation.
> 
> Suggested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (@chip_num -> @chip)
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>

Jason
