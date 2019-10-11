From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 11 Oct 2019 11:41:05 +0000
Subject: Re: [Patch v7 1/4] tpm: Move tpm_buf code to include/linux/
Message-Id: <20191011114105.GA3129@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <1570425935-7435-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1570425935-7435-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, jsnitsel@redhat.com, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org

On Mon, Oct 07, 2019 at 10:55:32AM +0530, Sumit Garg wrote:
> Move tpm_buf code to common include/linux/tpm.h header so that it can
> be reused via other subsystems like trusted keys etc.
> 
> Also rename trusted keys and asymmetric keys usage of TPM 1.x buffer
> implementation to tpm1_buf to avoid any compilation errors.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  crypto/asymmetric_keys/asym_tpm.c |  12 +--
>  drivers/char/tpm/tpm.h            | 215 --------------------------------------
>  include/keys/trusted.h            |  12 +--
>  include/linux/tpm.h               | 215 ++++++++++++++++++++++++++++++++++++++
>  security/keys/trusted.c           |  12 +--
>  5 files changed, 233 insertions(+), 233 deletions(-)

Looks clean.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
