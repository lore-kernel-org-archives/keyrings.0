From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 21 Aug 2018 18:31:08 +0000
Subject: Re: [PATCH 04/23] TPM: Expose struct tpm_chip and related find_get and put functions
Message-Id: <20180821183108.GC25543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:16PM +0100, David Howells wrote:
> Expose struct tpm_chip and related find_get and put functions so that
> TPM-using code can make sure it uses the same TPM for any related set of
> operations.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---

>  drivers/char/tpm/tpm-interface.c |   19 ++++++++++++++++---
>  drivers/char/tpm/tpm.h           |    5 -----
>  include/linux/tpm.h              |   10 ++++++++++
>  3 files changed, 26 insertions(+), 8 deletions(-)

I think this is already in the kernel .. Stephen did it.

Jason
