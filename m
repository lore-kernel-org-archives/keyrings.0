From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 13 Jun 2019 15:32:02 +0000
Subject: Re: [RFC 4/7] KEYS: trusted: Introduce TEE based Trusted Keys
Message-Id: <20190613153202.GF18488@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1560421833-27414-5-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Thu, Jun 13, 2019 at 04:00:30PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Approach taken in this patch acts as an alternative to a TPM device in case
> platform doesn't possess one.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

How does this interact with the trusted module? Why there is no update
to security/keys/trusted-encrypted.txt?

Somehow the existing trusted module needs to be re-architected to work
with either. Otherwise, this will turn out to be a mess.

/Jarkko
