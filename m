From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 21 Aug 2018 18:31:40 +0000
Subject: Re: [PATCH 02/23] TPM: Provide a facility for a userspace TPM emulator
Message-Id: <20180821183140.GD25543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486702302.13066.15889029286852815542.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486702302.13066.15889029286852815542.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:03PM +0100, David Howells wrote:
> Provide a misc device file (/dev/tpm_emul) by which a userspace TPM emulator
> can set up a virtual TPM device under the control of the TPM frontend.  The
> way this works is:
> 
>  (1) The emulator opens /dev/tpm_emul which is provided by the tpm_user
>      driver.
> 
>  (2) tpm_user registers a TPM device and the tpm driver creates a /dev/tpmN
>      misc device for the trousers package and suchlike to access.
> 
>  (3) The emulator sits in read() on the emulator device waiting for a command
>      to come through.
> 
>  (4) tpm_user passes requests from /dev/tpmN to the emulator's read() call.
> 
>  (5) The emulator processes the request.
> 
>  (6) The emulator either write()'s the reply or calls ioctl(fd,0,0) to cancel
>      the command.
> 
>  (7) The emulator goes back to read() to wait for the next command.
> 
>  (8) tpm_user passes the reply back to the tpm driver which passes it back to
>      /dev/tpmN.
> 
> When the emulator closes /dev/tpm_emul, the TPM driver is unregistered and the
> /dev/tpmN misc device is then removed.  Any outstanding requests are aborted
> and -EIO will be returned from then on.  Multiple TPMs can be registered.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/char/tpm/Kconfig         |   13 +
>  drivers/char/tpm/Makefile        |    1 
>  drivers/char/tpm/tpm_user_emul.c |  672 ++++++++++++++++++++++++++++++++++++++
>  include/linux/wait.h             |   11 +
>  4 files changed, 697 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_user_emul.c

This looks to duplicate the vtpm stuff...

Jason
