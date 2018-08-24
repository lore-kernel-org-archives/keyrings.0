From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 24 Aug 2018 07:42:21 +0000
Subject: Re: [PATCH 05/23] TPM: Use struct tpm_chip rather than chip number as interface parameter
Message-Id: <20180824074221.GF3584@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486704294.13066.8818198038331415342.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486704294.13066.8818198038331415342.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:22PM +0100, David Howells wrote:
> Use struct tpm_chip rather than chip number as interface parameter for most
> interface functions.  This allows the client to be sure about the consistency
> of what device it uses.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/char/tpm/tpm-interface.c    |   76 ++++++++-------------------------
>  drivers/char/tpm/tpm-sysfs.c        |    2 -
>  include/linux/tpm.h                 |   16 ++++---
>  security/integrity/ima/ima.h        |    2 -
>  security/integrity/ima/ima_crypto.c |    4 +-
>  security/integrity/ima/ima_init.c   |   19 +++++---
>  security/integrity/ima/ima_queue.c  |    4 +-
>  security/keys/trusted.c             |   80 ++++++++++++++++++++++-------------
>  8 files changed, 96 insertions(+), 107 deletions(-)

Should be split at least to three patches and TPM side is
already in the upstream.

/Jarkko
