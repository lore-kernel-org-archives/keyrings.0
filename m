From: Mimi Zohar <zohar@kernel.org>
Date: Thu, 15 Aug 2019 15:06:49 +0000
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-Id: <1565881609.9424.7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
         <1565789078.10490.10.camel@kernel.org>
         <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Thu, 2019-08-15 at 18:33 +0530, Sumit Garg wrote:
> Hi Mimi,
> 
> On Wed, 14 Aug 2019 at 18:54, Mimi Zohar <zohar@kernel.org> wrote:
> >
> > Hi Sumit,
> >
> > On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> > > This patch-set is an outcome of discussion here [1]. It has evolved very
> > > much since v1 to create, consolidate and generalize trusted keys
> > > subsystem.
> > >
> > > This framework has been tested with trusted keys support provided via TEE
> > > but I wasn't able to test it with a TPM device as I don't possess one. It
> > > would be really helpful if others could test this patch-set using a TPM
> > > device.
> >
> > With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
> > options enabled, which is required for linux-next, it fails to build.
> >
> 
> TBH, I wasn't aware about this test feature for headers. 

It's new to me too.

> It looks like
> the header which fails this test is "include/keys/trusted_tpm.h" which
> is basically a rename of "include/keys/trusted.h" plus changes in this
> patch-set.
> 
> And "include/keys/trusted.h" header is already put under blacklist
> here: "include/Kbuild +68" as it fails to build. So its that rename
> due to which build failure is observed now.
> 
> It seems to be an easy fix for this build failure via following changes:
> 
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 7b593447920b..ca1bec0ef65d 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -2,6 +2,9 @@
>  #ifndef __TRUSTED_TPM_H
>  #define __TRUSTED_TPM_H
> 
> +#include <keys/trusted-type.h>
> +#include <linux/tpm_command.h>
> +
>  /* implementation specific TPM constants */
>  #define MAX_BUF_SIZE                   1024
>  #define TPM_GETRANDOM_SIZE             14
> 
> So I will include above changes in this patch-set and also remove
> "include/keys/trusted.h" header from the blacklist.

That works, thanks.  With this patch set, at least the EVM trusted key
is properly being decrypted by the encrypted key with both a TPM 1.2
and PTT TPM 2.0.  My laptop still boots properly.  Over the weekend
I'll try to actually review the patches.

Mimi
