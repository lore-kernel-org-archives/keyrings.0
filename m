From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 31 Jul 2019 13:59:08 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
In-Reply-To: <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
To: Janne Karhunen <janne.karhunen@gmail.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, 31 Jul 2019 at 15:51, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> To clarify a bit further - my thought was to support any type of trust
> source.

That could be very well accomplished via Trusted Keys abstraction
framework [1]. A trust source just need to implement following APIs:

struct trusted_key_ops ts_trusted_key_ops = {
       .migratable = 0, /* non-migratable */
       .init = init_ts_trusted,
       .seal = ts_key_seal,
       .unseal = ts_key_unseal,
       .get_random = ts_get_random,
       .cleanup = cleanup_ts_trusted,
};

> Remote, local or both. Just having one particular type of
> locally bound 'TEE' sounded very limited,

TEE is just one of trust source like TPM, we can have other trust
source as mentioned above.

> especially when nothing from
> the TEE execution side is really needed for supporting the kernel
> crypto. What you really need is the seal/unseal transaction going
> somewhere and where that somewhere is does not matter much.

Its only the seal/unseal operations that are provided by TEE driver
that hooks up under trusted keys abstraction layer.

> With the
> user mode helper in between anyone can easily add their own thing in
> there.
>

Isn't actual purpose to have trusted keys is to protect user-space
from access to kernel keys in plain format? Doesn't user mode helper
defeat that purpose in one way or another?

>

[1] https://lkml.org/lkml/2019/7/18/284

-Sumit

> --
> Janne
>
> On Wed, Jul 31, 2019 at 10:11 AM Janne Karhunen
> <janne.karhunen@gmail.com> wrote:
> >
> > Hi,
> >
> > Interesting, I wrote something similar and posted it to the lists a while back:
> > https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
> >
> > Since there are no generic 'TEEs' available, I implemented the same
> > thing as a generic protocol translator. The shared memory binding for
> > instance already assumes fair amount about the TEE and how that is
> > physically present in the system. Besides, the help from usage of shm
> > is pretty limited due to the size of the keydata.
> >
> >
> > --
> > Janne
> >
> >
> >
> >
> > On Tue, Jul 30, 2019 at 3:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This series also adds some TEE features like:
> > >
> > > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> > >
> > > Patch #3 enables support for private kernel login method required for
> > > cases like trusted keys where we don't wan't user-space to directly access
> > > TEE service to retrieve trusted key contents.
> > >
> > > Rest of the patches from #4 to #6 adds support for TEE based trusted keys.
> > >
> > > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > > found here [1].
> > >
> > > Also, this patch-set is dependent on generic Trusted Keys framework
> > > patch-set [2].
> > >
> > > [1] https://github.com/OP-TEE/optee_os/pull/3082
> > > [2] https://lkml.org/lkml/2019/7/18/284
> > >
> > > Changes in v2:
> > > 1. Add reviewed-by tags for patch #1 and #2.
> > > 2. Incorporate comments from Jens for patch #3.
> > > 3. Switch to use generic trusted keys framework.
> > >
> > > Sumit Garg (6):
> > >   tee: optee: allow kernel pages to register as shm
> > >   tee: enable support to register kernel memory
> > >   tee: add private login method for kernel clients
> > >   KEYS: trusted: Introduce TEE based Trusted Keys
> > >   doc: keys: Document usage of TEE based Trusted Keys
> > >   MAINTAINERS: Add entry for TEE based Trusted Keys
> > >
> > >  Documentation/security/keys/index.rst       |   1 +
> > >  Documentation/security/keys/tee-trusted.rst |  93 +++++++++
> > >  MAINTAINERS                                 |   9 +
> > >  drivers/tee/optee/call.c                    |   7 +
> > >  drivers/tee/tee_core.c                      |   6 +
> > >  drivers/tee/tee_shm.c                       |  16 +-
> > >  include/keys/trusted-type.h                 |   3 +
> > >  include/keys/trusted_tee.h                  |  66 +++++++
> > >  include/linux/tee_drv.h                     |   1 +
> > >  include/uapi/linux/tee.h                    |   8 +
> > >  security/keys/Kconfig                       |   3 +
> > >  security/keys/trusted-keys/Makefile         |   3 +-
> > >  security/keys/trusted-keys/trusted-tee.c    | 282 ++++++++++++++++++++++++++++
> > >  security/keys/trusted-keys/trusted.c        |   3 +
> > >  14 files changed, 498 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> > >  create mode 100644 include/keys/trusted_tee.h
> > >  create mode 100644 security/keys/trusted-keys/trusted-tee.c
> > >
> > > --
> > > 2.7.4
> > >
