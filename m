From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 13 Oct 2020 10:53:51 +0000
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Message-Id: <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
 <20201013014304.GC41176@linux.intel.com>
In-Reply-To: <20201013014304.GC41176@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-security-module@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, James Bottomley <jejb@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Luke Hinds <lhinds@redhat.com>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Tue, 13 Oct 2020 at 07:13, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > support in case platform doesn't posses a TPM device.
> >
> > Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > which contains necessary functions of a backend.
> >
> > Also, add a module parameter in order to select a particular trust source
> > in case a platform support multiple trust sources.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> This is exactly kind of place where I think static_call() should be
> taken into use, which is a v5.10 feature [1]. For background and
> context, I'd read [2].

This looks like an interesting feature. But I am not sure about the
real benefits that it will provide in case of trusted keys. If we are
looking at it performance wise then I think the gain will be
negligible when compared with slow TPM communication interface (eg.
SPI, I2C) or when compared with context switching involved in TEE.

Also, it requires arch specific support too which currently seems to
be limited to x86 only.

>
> The other thing that I see that does not make much else than additional
> complexity, is trusted_tpm.ko. We can do with one trusted.ko.
>

Current implementation only builds a single trusted.ko module. There
isn't any trusted_tpm.ko.

-Sumit

> I'd also *guess* that the static_call() mechanism does not work accross
> module boundaries.
>
> [1] https://lore.kernel.org/lkml/20201012155542.GA3557765@gmail.com/
> [2] https://lwn.net/Articles/815908/
>
> /Jarkko
