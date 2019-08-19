From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Aug 2019 17:04:58 +0000
Subject: Re: [RFC/RFT v4 3/5] KEYS: trusted: create trusted keys subsystem
Message-Id: <20190819170458.m7adhkji64kta32d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-4-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-4-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 13, 2019 at 01:23:02PM +0530, Sumit Garg wrote:
> Move existing code to trusted keys subsystem. Also, rename files with
> "tpm" as suffix which provides the underlying implementation.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  crypto/asymmetric_keys/asym_tpm.c                       | 2 +-
>  include/keys/{trusted.h => trusted_tpm.h}               | 4 ++--
>  security/keys/Makefile                                  | 2 +-
>  security/keys/trusted-keys/Makefile                     | 7 +++++++
>  security/keys/{trusted.c => trusted-keys/trusted-tpm.c} | 2 +-
>  5 files changed, 12 insertions(+), 5 deletions(-)
>  rename include/keys/{trusted.h => trusted_tpm.h} (98%)
>  create mode 100644 security/keys/trusted-keys/Makefile
>  rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (99%)

Would prefer trusted_tpm.c.

/Jarkko
