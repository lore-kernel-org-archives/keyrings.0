From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 11 Oct 2019 12:25:33 +0000
Subject: Re: [Patch v7 4/4] KEYS: trusted: Move TPM2 trusted keys code
Message-Id: <20191011122533.GC3129@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <1570425935-7435-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1570425935-7435-5-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, jsnitsel@redhat.com, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org

On Mon, Oct 07, 2019 at 10:55:35AM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem. The reason
> being it's better to consolidate all the trusted keys code to a single
> location so that it can be maintained sanely.
> 
> Also, utilize existing tpm_send() exported API which wraps the internal
> tpm_transmit_cmd() API.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
