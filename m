From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 07 Aug 2019 18:59:21 +0000
Subject: Re: [RFC/RFT v3 1/3] KEYS: trusted: create trusted keys subsystem
Message-Id: <20190807185921.lhdt3ek6tphj33bo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565098640-12536-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 06, 2019 at 07:07:18PM +0530, Sumit Garg wrote:
> Move existing code to trusted keys subsystem. Also, rename files with
> "tpm" as suffix which provides the underlying implementation.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

The name for should be still trusted.ko even if new backends are added.
Must be done in order not to break user space.

Situation is quite similar as when new backends were added to tpm_tis
some time ago: MMIO backed implementation was kept as tpm_tis.ko, the
core module was named as tpm_tis_core and SPI backed implementation was
named as tpm_tis_spi.ko.

/Jarkko
