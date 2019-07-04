From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 04 Jul 2019 10:03:25 +0000
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()"
Message-Id: <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190701131505.17759-1-msuchanek@suse.de>
In-Reply-To: <20190701131505.17759-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>, linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <jejb@linux.ibm.com>, David Howells <dhowells@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Tomas Winkler <tomas.winkler@intel.com>, Armijn Hemel <armijn@tjaldur.nl>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> following crash:

Thank you. I think this the right choice for the moment. I fixed
a trivial checkpatch.pl error and added the mandatory tags. Can
you check quickly v2 (just posted)?

I already made it available in my master and next.

/Jarkko
