From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 01 Aug 2019 17:24:15 +0000
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
Message-Id: <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1563449086-13183-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Thu, Jul 18, 2019 at 04:54:45PM +0530, Sumit Garg wrote:
> Move existing code to trusted keys subsystem. Also, rename files with
> "tpm" as suffix which provides the underlying implementation.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

What about TPM2 trusted keys code?

/Jarkko
