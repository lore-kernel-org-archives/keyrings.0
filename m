From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Aug 2019 16:56:29 +0000
Subject: Re: [RFC/RFT v4 1/5] tpm: move tpm_buf code to include/linux/
Message-Id: <20190819165629.qv7cmg6kiwb6oxig@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 13, 2019 at 01:23:00PM +0530, Sumit Garg wrote:
> Move tpm_buf code to common include/linux/tpm.h header so that it can
> be reused via other subsystems like trusted keys etc.
> 
> Also rename trusted keys TPM 1.x buffer implementation to tpm1_buf to
> avoid any compilation errors.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

A question: did you try to do this as mechanically as you ever could
or did you do any other code changes? I did go through it but it is
possible that I missed something.

In this type of changes it is mandatory be extra strict on not doing
anything extra (the rename you would was not of course extra because
it was necessary to do).

/Jarkko
