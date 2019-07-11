From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 11 Jul 2019 19:22:15 +0000
Subject: Re: [RFC/RFT] KEYS: trusted: Add generic trusted keys framework
Message-Id: <20190711192215.5w3fzdjwsebgoesh@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1562337154-26376-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1562337154-26376-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Fri, Jul 05, 2019 at 08:02:34PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusked keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implemtations like TPM, TEE etc. could be easily plugged-in.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

1. Needs to be somehow dissected into digestable/reviewable pieces.
2. As a precursory step probably would make sense to move all
   existing trusted keys code into one subsystem first.

/Jarkko
