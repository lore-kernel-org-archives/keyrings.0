From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 08 Aug 2019 13:33:38 +0000
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
In-Reply-To: <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Thu, 8 Aug 2019 at 00:33, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem.
>
> Missing a long description. The reason is that it is better consolidate
> all trusted keys code to a single location so that it can be maintained
> sanely and it should be stated here.

Sure will extend the description.

>
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I would suggest adding at least two commits before this:
>
> - A commit that just exports tpm_buf stuff and TPM2 constants to
>   include/linux

Okay, will create a separate patch for this.

> - A commit that just changes the existing TPM 1.x trusted keys
>   code to use tpm_buf.

It seems to be a functional change which I think requires proper unit
testing. I am afraid that I don't posses a TPM device to test this and
also very less conversant with tpm_buf code.

So what I have done here is to rename existing TPM 1.x trusted keys
code to use tpm1_buf.

And I would be happy to integrate a tested patch if anyone familiar
could work on this.

-Sumit

>
> These should be before the current 1/3 commit.
>
> /Jarkko
