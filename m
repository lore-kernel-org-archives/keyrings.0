From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 07 Aug 2019 19:03:44 +0000
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem.

Missing a long description. The reason is that it is better consolidate
all trusted keys code to a single location so that it can be maintained
sanely and it should be stated here.

> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I would suggest adding at least two commits before this:

- A commit that just exports tpm_buf stuff and TPM2 constants to
  include/linux
- A commit that just changes the existing TPM 1.x trusted keys
  code to use tpm_buf.

These should be before the current 1/3 commit.

/Jarkko
