From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 16 Sep 2019 04:51:45 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Use common tpm_buf for asymmetric keys
Message-Id: <CAFA6WYP3cYM6=sw7pAe_RmiTbxdOLHptPqmk8D=915TLF14Ecw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568200910-31368-1-git-send-email-sumit.garg@linaro.org> <20190913133057.GD7412@linux.intel.com>
In-Reply-To: <20190913133057.GD7412@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 13 Sep 2019 at 19:01, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 11, 2019 at 04:51:50PM +0530, Sumit Garg wrote:
> > Switch to utilize common heap based tpm_buf code for TPM based
> > asymmetric keys rather than using stack based tpm_buf code.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Can you roll instead a new version of the whole patch set?

Okay, will send next version of whole patch-set along with this change.

-Sumit

>
> /Jarkko
