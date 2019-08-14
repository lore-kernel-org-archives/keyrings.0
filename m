From: Mimi Zohar <zohar@kernel.org>
Date: Wed, 14 Aug 2019 13:24:38 +0000
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-Id: <1565789078.10490.10.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

Hi Sumit,

On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> This patch-set is an outcome of discussion here [1]. It has evolved very
> much since v1 to create, consolidate and generalize trusted keys
> subsystem.
> 
> This framework has been tested with trusted keys support provided via TEE
> but I wasn't able to test it with a TPM device as I don't possess one. It
> would be really helpful if others could test this patch-set using a TPM
> device.

With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
options enabled, which is required for linux-next, it fails to build.

Mimi
