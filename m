From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Aug 2019 05:58:46 +0000
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-Id: <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org> <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
In-Reply-To: <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Mon, 19 Aug 2019 at 22:24, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 13, 2019 at 01:22:59PM +0530, Sumit Garg wrote:
> > This patch-set is an outcome of discussion here [1]. It has evolved very
> > much since v1 to create, consolidate and generalize trusted keys
> > subsystem.
> >
> > This framework has been tested with trusted keys support provided via TEE
> > but I wasn't able to test it with a TPM device as I don't possess one. It
> > would be really helpful if others could test this patch-set using a TPM
> > device.
>
> I think 1/5-4/5 make up a non-RFC patch set that needs to reviewed,
> tested and merged as a separate entity.
>

Okay.

> On the other hand 5/5 cannot be merged even if I fully agreed on
> the code change as without TEE patch it does not add any value for
> Linux.
>

I agree here that 5/5 should go along with TEE patch-set. But if you
look at initial v1 patch-set, the idea was to get feedback on trusted
keys abstraction as a standalone patch along with testing using a TPM
(1.x or 2.0).

Since Mimi has tested this patch-set with TPM (1.x & 2.0), I am happy
to merge 5/5 with TEE patch-set. But it would be nice if I could get
feedback on 5/5 before I send next version of TEE patch-set.

> To straighten up thing I would suggest that the next patch set
> version would only consists of the first four patches and we meld
> them to the shape so that we can land them to the mainline. Then
> it should be way more easier to concentrate the actual problem you
> are trying to resolve.
>

Okay will send next patch-set version with first four patches only.

-Sumit

> /Jarkko
