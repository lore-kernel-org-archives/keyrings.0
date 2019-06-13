From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 13 Jun 2019 15:17:14 +0000
Subject: Re: [RFC 1/7] tee: optee: allow kernel pages to register as shm
Message-Id: <20190613151714.GC18488@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-2-git-send-email-sumit.garg@linaro.org>
 <20190613151257.GA18488@linux.intel.com>
In-Reply-To: <20190613151257.GA18488@linux.intel.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Thu, Jun 13, 2019 at 06:12:57PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 13, 2019 at 04:00:27PM +0530, Sumit Garg wrote:
> > Kernel pages are marked as normal type memory only so allow kernel pages
> > to be registered as shared memory with OP-TEE.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> 
> Just out of pure interest why this was not allowed before?

Please spare me and ignore that one :-) Obviouslly because it
was not used.

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
