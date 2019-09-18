From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 18 Sep 2019 06:35:08 +0000
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
Message-Id: <CAFA6WYMbUGQ6+-XvR9_qSc=oVe1QSTg4kB-+y6rBmQLq+B6skg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org> <20190917181415.GA8472@linux.intel.com>
 <20190917181507.GB8472@linux.intel.com>
In-Reply-To: <20190917181507.GB8472@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>

On Tue, 17 Sep 2019 at 23:45, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Sep 17, 2019 at 09:14:15PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 16, 2019 at 04:04:24PM +0530, Sumit Garg wrote:
> > > Move TPM2 trusted keys code to trusted keys subsystem. The reason
> > > being it's better to consolidate all the trusted keys code to a single
> > > location so that it can be maintained sanely.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > This commit has couple of issues that I only noticed when looking into
> > bug reported by Mimi.
> >
> > Right now tpm_send() is the exported function that is used by other
> > subsystems. tpm_transmit_cmd() is an internal function. This commit adds
> > two unrelated code paths to send TPM commands, which is unacceptable.

Makes sense, will update.

> >
> > You should make tpm2 functionality to use tpm_send() instead and remove
> > tpm_seal_trusted() and tpm_unseal_trusted() completely in this commit.

Okay.

>
> The consequence is that the result needs unfortunately re-review. Sorry
> about that, just took this time to notice this glitch.

No worries :). I will send next version of patch-set.

FYI, I will be travelling for Linaro Connect next week so you could
expect some delays in my responses.

-Sumit

>
> /Jarkko
