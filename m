From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 13 Jun 2019 15:34:14 +0000
Subject: Re: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-Id: <20190613153414.GG18488@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-7-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1560421833-27414-7-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Thu, Jun 13, 2019 at 04:00:32PM +0530, Sumit Garg wrote:
> Provide documentation for usage of TEE based Trusted Keys via existing
> user-space "keyctl" utility. Also, document various use-cases.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Sorry missed this patch. Anyway, I don't think we want multiple trusted
keys subsystems. You have to fix the existing one if you care to get
these changes in. There is no really other way around this.

/Jarkko
