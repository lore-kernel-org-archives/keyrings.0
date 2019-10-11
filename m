From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 11 Oct 2019 11:47:19 +0000
Subject: Re: [Patch v7 2/4] KEYS: Use common tpm_buf for trusted and asymmetric keys
Message-Id: <20191011114719.GB3129@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <1570425935-7435-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1570425935-7435-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, jsnitsel@redhat.com, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org

On Mon, Oct 07, 2019 at 10:55:33AM +0530, Sumit Garg wrote:
> Switch to utilize common heap based tpm_buf code for TPM based trusted
> and asymmetric keys rather than using stack based tpm1_buf code. Also,
> remove tpm1_buf code.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
