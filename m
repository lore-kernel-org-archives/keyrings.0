From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Aug 2019 16:57:50 +0000
Subject: Re: [RFC/RFT v4 2/5] KEYS: trusted: use common tpm_buf for TPM1.x code
Message-Id: <20190819165750.h4zlqtjubwm7tohg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 13, 2019 at 01:23:01PM +0530, Sumit Garg wrote:
> Utilize common heap based tpm_buf code for TPM1.x trusted keys rather
> than using stack based tpm1_buf code. Also, remove tpm1_buf code.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
