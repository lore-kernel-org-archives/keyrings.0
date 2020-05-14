From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 14 May 2020 00:25:14 +0000
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Message-Id: <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, zohar@linux.ibm.com, jejb@linux.ibm.com
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, op-tee@lists.trustedfirmware.org, corbet@lwn.net, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusked keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implemtations like TPM, TEE etc. could be easily plugged-in.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I tend to agree how this is implemented and could merge it as such.

I'm just thinking if we could refine this patch in a way that instead of
copying TRUSTED_DEBUG macro we could just replace pr_info() statements
with pr_debug()?

/Jarkko
