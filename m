From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 04 Jul 2019 11:48:02 +0000
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()"
Message-Id: <1562240882.6165.78.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190701131505.17759-1-msuchanek@suse.de>
         <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
         <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
In-Reply-To: <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>, linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <jejb@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tomas Winkler <tomas.winkler@intel.com>, Armijn Hemel <armijn@tjaldur.nl>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
> On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
> > On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> >> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> >> following crash:
> > 
> > Thank you. I think this the right choice for the moment. I fixed
> > a trivial checkpatch.pl error and added the mandatory tags. Can
> > you check quickly v2 (just posted)?
> > 
> > I already made it available in my master and next.
> 
> Could you please wait few days? I would prefer to fix this issue instead
> of reverting the whole patch.

Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
allocated banks for IBM vtpm driver", which addresses this bug.

Mimi
