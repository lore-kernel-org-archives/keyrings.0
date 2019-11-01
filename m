From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 01 Nov 2019 09:46:18 +0000
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-Id: <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
 <20191031214745.GG10507@linux.intel.com>
In-Reply-To: <20191031214745.GG10507@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Janne Karhunen <janne.karhunen@gmail.com>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Stuart Yoder <stuart.yoder@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Fri, 1 Nov 2019 at 03:17, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Oct 31, 2019 at 07:28:42PM +0530, Sumit Garg wrote:
> > Provide documentation for usage of TEE based Trusted Keys via existing
> > user-space "keyctl" utility. Also, document various use-cases.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> This is the most important commit in order for someone who don't deal
> that much with ARM TEE to get right.
>

I agree that documentation needs to be updated and your following
comments seems to be somewhat similar to comments from Mimi here [1].

> Until this commit is right, I don't
> unfortunately have much to say about other commits.

Isn't this statement contradicting with your earlier statement
regarding the right order would be to complete TEE patches review
first and then come up with documentation here [2]?

[1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
[2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/

> Instead of making disjoint islands, you should edit trusted-encrypted.rst
> so that it describes commonalities and differences.
>
> What the document currently describes is the usage model. It could be a
> section of its own. In that you should describe first the common
> parameters and separetely the backend specific parametrs.
>
> From kernel internals (there could be a section with this name)  the
> document describe the key generation e.g. is the hardware used and how
> it is used, is there salting with krng and so forth.

BTW, here is the info regarding RNG provided by OP-TEE (an open-source
TEE implementation).

It's either direct output from hardware based RNG (if platform
supports one) [3] or a software based Fortuna CSPRNG (executing in
trusted environment) [4] which is seeded via multiple entropy sources
as described here [5].

Overall, I think salting this with krng sounds reasonable to address
single RNG source concern. So I would suggest to have a common wrapper
API that would do salting of trust source (TPM or TEE) RNG output with
krng.

[3] https://github.com/OP-TEE/optee_os/blob/master/core/crypto/rng_hw.c
[4] https://github.com/OP-TEE/optee_os/blob/master/core/crypto/rng_fortuna.c
[5] https://github.com/OP-TEE/optee_os/blob/master/core/include/crypto/crypto.h#L272

-Sumit

>
> /Jarkko
