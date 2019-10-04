From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 04 Oct 2019 06:17:29 +0000
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
Message-Id: <CAFA6WYObsZnTptYg1Qorxt0FMaxHKoZ6D53Wjsj05OEGNhpckg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org> <20190917181415.GA8472@linux.intel.com>
 <20190917181507.GB8472@linux.intel.com> <CAFA6WYMbUGQ6+-XvR9_qSc=oVe1QSTg4kB-+y6rBmQLq+B6skg@mail.gmail.com>
 <20190925011115.GA3503@linux.intel.com>
In-Reply-To: <20190925011115.GA3503@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>

Hi Jarkko,

On Wed, 25 Sep 2019 at 06:41, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 18, 2019 at 11:53:08AM +0530, Sumit Garg wrote:
> > No worries :). I will send next version of patch-set.
> >
> > FYI, I will be travelling for Linaro Connect next week so you could
> > expect some delays in my responses.
>
> These patches will go to v5.5. There is nothing to rush.

I am back now on my regular schedule after Linaro Connect. And I see
your patch-set [1] to detach page allocation from tpm_buf. It seems
like either this patch-set needs rebase over yours or vice-versa.

So should I wait to send next version of this patch-set until your
patch-set arrives in tpmdd master/next branch or would you like to
rebase your patch-set over this?

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2119910.html

-Sumit

>
> /Jarkko
