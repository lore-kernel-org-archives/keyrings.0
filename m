From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 21 Aug 2019 19:13:54 +0000
Subject: Re: [RFC/RFT v4 1/5] tpm: move tpm_buf code to include/linux/
Message-Id: <20190821191354.4redyuo5j2njkruy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-2-git-send-email-sumit.garg@linaro.org>
 <20190819165629.qv7cmg6kiwb6oxig@linux.intel.com>
 <CAFA6WYMoX95UcuGb2UdrUMnq=4wYJChwcMgm8pHHPs_Lg=5iNg@mail.gmail.com>
In-Reply-To: <CAFA6WYMoX95UcuGb2UdrUMnq=4wYJChwcMgm8pHHPs_Lg=5iNg@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Tue, Aug 20, 2019 at 11:22:05AM +0530, Sumit Garg wrote:
> On Mon, 19 Aug 2019 at 22:26, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Aug 13, 2019 at 01:23:00PM +0530, Sumit Garg wrote:
> > > Move tpm_buf code to common include/linux/tpm.h header so that it can
> > > be reused via other subsystems like trusted keys etc.
> > >
> > > Also rename trusted keys TPM 1.x buffer implementation to tpm1_buf to
> > > avoid any compilation errors.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > A question: did you try to do this as mechanically as you ever could
> > or did you do any other code changes? I did go through it but it is
> > possible that I missed something.
> >
> 
> There aren't any other code changes apart from "tpm1_buf" rename.

Thanks. I had to ask because it would be hard to check it manually.

/Jarkko
