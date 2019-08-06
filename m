From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 06 Aug 2019 13:43:22 +0000
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <20190806134322.GA10783@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/tpm/tpm-interface.c          |  56 -----
>  drivers/char/tpm/tpm.h                    | 224 ------------------
>  drivers/char/tpm/tpm2-cmd.c               | 307 ------------------------
>  include/keys/trusted_tpm.h                |  23 +-
>  include/linux/tpm.h                       | 264 +++++++++++++++++++--
>  security/keys/trusted-keys/Makefile       |   3 +-
>  security/keys/trusted-keys/trusted-tpm.c  |  16 +-
>  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
>  8 files changed, 652 insertions(+), 619 deletions(-)
>  create mode 100644 security/keys/trusted-keys/trusted-tpm2.c

'git format-patch -M' will create a patch that shows the rename, and
then any tiny differences that happened after that.  A patch like this
is hard to see what changed in the move.

thanks,

greg k-h
