From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 17 Sep 2020 16:21:42 +0000
Subject: Re: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
Message-Id: <20200917162142.GB9750@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
 <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-security-module@vger.kernel.org, daniel.thompson@linaro.org, op-tee@lists.trustedfirmware.org, corbet@lwn.net, jejb@linux.ibm.com, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, lhinds@redhat.com, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusted keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implementations like TPM, TEE etc. could be easily plugged-in.

I would rephrase this a bit:

"Add a generic trusted keys framework where underlying implementations
can be easily plugged in. Create struct trusted_key_ops to achieve this,
which contains necessary functions of a backend."

I remember asking about this approach that what if there was just a
header for trusted key functions and a compile time decision, which C
file to include instead of ops struct. I don't remember if these was a
conclusion on this or not.

E.g. lets say you have a device with TEE and TPM, should you be able
to be use both at run-time? I might play along how this works now but
somehow, in the commit message preferably, it should be conclude why
one alternative is chosen over another.

/Jarkko
