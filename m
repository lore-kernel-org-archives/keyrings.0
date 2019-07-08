From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 08 Jul 2019 12:53:39 +0000
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
Message-Id: <CAFA6WYPn3HB6BRocKmKTR+ZPE=Fav5w1TUdRgmLp-NkYobp3rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org, serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

Hi Jens,

On Thu, 13 Jun 2019 at 16:01, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This series also adds some TEE features like:
>
> Patch #1, #2 enables support for registered kernel shared memory with TEE.
>

Would you like to pick up Patch #1, #2 separately? I think both these
patches add independent functionality and also got reviewed-by tags
too.


-Sumit

> Patch #3 enables support for private kernel login method required for
> cases like trusted keys where we don't wan't user-space to directly access
> TEE service to retrieve trusted key contents.
>
> Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
>
> This patch-set has been tested with OP-TEE based pseudo TA which can be
> found here [1].
>
> Looking forward to your valuable feedback/suggestions.
>
> [1] https://github.com/OP-TEE/optee_os/pull/3082
>
> Sumit Garg (7):
>   tee: optee: allow kernel pages to register as shm
>   tee: enable support to register kernel memory
>   tee: add private login method for kernel clients
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   KEYS: encrypted: Allow TEE based trusted master keys
>   doc: keys: Document usage of TEE based Trusted Keys
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  Documentation/security/keys/tee-trusted.rst      |  93 +++++
>  MAINTAINERS                                      |   9 +
>  drivers/tee/optee/call.c                         |   7 +
>  drivers/tee/tee_core.c                           |   6 +
>  drivers/tee/tee_shm.c                            |  16 +-
>  include/keys/tee_trusted.h                       |  84 ++++
>  include/keys/trusted-type.h                      |   1 +
>  include/linux/tee_drv.h                          |   1 +
>  include/uapi/linux/tee.h                         |   2 +
>  security/keys/Kconfig                            |   3 +
>  security/keys/Makefile                           |   3 +
>  security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
>  security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
>  13 files changed, 737 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/security/keys/tee-trusted.rst
>  create mode 100644 include/keys/tee_trusted.h
>  create mode 100644 security/keys/tee_trusted.c
>
> --
> 2.7.4
>
