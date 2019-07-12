From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 12 Jul 2019 05:25:38 +0000
Subject: Re: [RFC/RFT] KEYS: trusted: Add generic trusted keys framework
Message-Id: <CAFA6WYMOyKo2vXY8bO448ikmdGioK3s5JMZLz6c2y8ObPm4zHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1562337154-26376-1-git-send-email-sumit.garg@linaro.org> <20190711192215.5w3fzdjwsebgoesh@linux.intel.com>
In-Reply-To: <20190711192215.5w3fzdjwsebgoesh@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org, serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org

On Fri, 12 Jul 2019 at 00:52, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jul 05, 2019 at 08:02:34PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > support in case platform doesn't posses a TPM device.
> >
> > So this patch tries to add generic trusted keys framework where underlying
> > implemtations like TPM, TEE etc. could be easily plugged-in.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> 1. Needs to be somehow dissected into digestable/reviewable pieces.

Sure, will try to split this patch in next version.

> 2. As a precursory step probably would make sense to move all
>    existing trusted keys code into one subsystem first.

Okay.

-Sumit

>
> /Jarkko
