From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 21 Aug 2019 19:12:42 +0000
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-Id: <20190821191242.7z3en7om2few4tao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
 <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
In-Reply-To: <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Tue, Aug 20, 2019 at 11:16:46AM +0530, Sumit Garg wrote:
> I agree here that 5/5 should go along with TEE patch-set. But if you
> look at initial v1 patch-set, the idea was to get feedback on trusted
> keys abstraction as a standalone patch along with testing using a TPM
> (1.x or 2.0).
> 
> Since Mimi has tested this patch-set with TPM (1.x & 2.0), I am happy
> to merge 5/5 with TEE patch-set. But it would be nice if I could get
> feedback on 5/5 before I send next version of TEE patch-set.

OK, that is understandable. I'll check it out tomorrow.

/Jarkko
