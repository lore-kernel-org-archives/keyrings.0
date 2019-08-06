From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 06 Aug 2019 13:55:39 +0000
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <CAFA6WYPVc_0dm2=w0Ec-Y0Sr9SipukGSJcjond-FrHREHQXTrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190806134322.GA10783@kroah.com>
In-Reply-To: <20190806134322.GA10783@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Tue, 6 Aug 2019 at 19:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/char/tpm/tpm-interface.c          |  56 -----
> >  drivers/char/tpm/tpm.h                    | 224 ------------------
> >  drivers/char/tpm/tpm2-cmd.c               | 307 ------------------------
> >  include/keys/trusted_tpm.h                |  23 +-
> >  include/linux/tpm.h                       | 264 +++++++++++++++++++--
> >  security/keys/trusted-keys/Makefile       |   3 +-
> >  security/keys/trusted-keys/trusted-tpm.c  |  16 +-
> >  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
> >  8 files changed, 652 insertions(+), 619 deletions(-)
> >  create mode 100644 security/keys/trusted-keys/trusted-tpm2.c
>
> 'git format-patch -M' will create a patch that shows the rename, and
> then any tiny differences that happened after that.  A patch like this
> is hard to see what changed in the move.
>

I used this option only to generate the patch-set. Following is the
command I used:

git format-patch -M -3 --cover-letter --subject-prefix="RFC/RFT v3"

It seems like for this patch I need to collect pieces from
"drivers/char/tpm/" and aggregate them under
"security/keys/trusted-keys/trusted-tpm2.c" and "include/linux/tpm.h"
files. So that could be the reason for such patch view.

-Sumit

> thanks,
>
> greg k-h
