From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Aug 2019 17:07:50 +0000
Subject: Re: [RFC/RFT v4 4/5] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <20190819170750.7cl7bdmtam3jras4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-5-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 13, 2019 at 01:23:03PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem. The reason
> being it's better to consolidate all the trusted keys code to a single
> location so that it can be maintained sanely.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/tpm/tpm-chip.c               |   1 +
>  drivers/char/tpm/tpm-interface.c          |  56 -----
>  drivers/char/tpm/tpm.h                    |  16 --
>  drivers/char/tpm/tpm2-cmd.c               | 308 +-----------------------
>  include/keys/trusted_tpm.h                |   7 +
>  include/linux/tpm.h                       |  56 +++--
>  security/keys/trusted-keys/Makefile       |   1 +
>  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++

Would prefer trusted_tpm2.c.

/Jarkko
