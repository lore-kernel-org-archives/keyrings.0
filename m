From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 08 Aug 2019 12:38:57 +0000
Subject: Re: [RFC/RFT v3 1/3] KEYS: trusted: create trusted keys subsystem
Message-Id: <CAFA6WYPsNuN=F9y+Q0r8-6MQAGGZeKUtRheQgKv3HmE1ViyviA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-2-git-send-email-sumit.garg@linaro.org> <20190807185921.lhdt3ek6tphj33bo@linux.intel.com>
In-Reply-To: <20190807185921.lhdt3ek6tphj33bo@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Thu, 8 Aug 2019 at 00:29, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:18PM +0530, Sumit Garg wrote:
> > Move existing code to trusted keys subsystem. Also, rename files with
> > "tpm" as suffix which provides the underlying implementation.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> The name for should be still trusted.ko even if new backends are added.
> Must be done in order not to break user space.

Agree. I think I need to update Makefile as follows:

obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
trusted-y += trusted-tpm.o

-Sumit

>
> Situation is quite similar as when new backends were added to tpm_tis
> some time ago: MMIO backed implementation was kept as tpm_tis.ko, the
> core module was named as tpm_tis_core and SPI backed implementation was
> named as tpm_tis_spi.ko.
>
> /Jarkko
