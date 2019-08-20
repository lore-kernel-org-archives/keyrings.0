From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Aug 2019 05:54:14 +0000
Subject: Re: [RFC/RFT v4 3/5] KEYS: trusted: create trusted keys subsystem
Message-Id: <CAFA6WYOTYhJ3kGYFGU9rxnxqFqMFMhVXfVYq+3bepOax92fLSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-4-git-send-email-sumit.garg@linaro.org> <20190819170458.m7adhkji64kta32d@linux.intel.com>
 <20190819170635.jlxxi6ogbm4s6gcx@linux.intel.com>
In-Reply-To: <20190819170635.jlxxi6ogbm4s6gcx@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Mon, 19 Aug 2019 at 22:36, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 19, 2019 at 08:04:58PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 13, 2019 at 01:23:02PM +0530, Sumit Garg wrote:
> > > Move existing code to trusted keys subsystem. Also, rename files with
> > > "tpm" as suffix which provides the underlying implementation.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  crypto/asymmetric_keys/asym_tpm.c                       | 2 +-
> > >  include/keys/{trusted.h => trusted_tpm.h}               | 4 ++--
> > >  security/keys/Makefile                                  | 2 +-
> > >  security/keys/trusted-keys/Makefile                     | 7 +++++++
> > >  security/keys/{trusted.c => trusted-keys/trusted-tpm.c} | 2 +-
> > >  5 files changed, 12 insertions(+), 5 deletions(-)
> > >  rename include/keys/{trusted.h => trusted_tpm.h} (98%)
> > >  create mode 100644 security/keys/trusted-keys/Makefile
> > >  rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (99%)
> >
> > Would prefer trusted_tpm.c.
>
> Actually, trusted_tpm1.c.
>

Okay.

-Sumit

> /Jarkko
