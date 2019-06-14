From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 14 Jun 2019 00:03:13 +0000
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
Message-Id: <1560470593.4805.109.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
         <d803283e-5e69-5deb-fe94-3f2e45fb95af@schaufler-ca.com>
In-Reply-To: <d803283e-5e69-5deb-fe94-3f2e45fb95af@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Thu, 2019-06-13 at 09:40 -0700, Casey Schaufler wrote:
> On 6/13/2019 3:30 AM, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This series also adds some TEE features like:
> 
> Please expand the acronym TEE on first use. That will
> help people who don't work with it on a daily basis
> understand what you're going on about.

Thanks, Casey.

"[6/7] doc: keys: Document usage of TEE based Trusted Keys" refers to
the kernel tee documentation, but that documentation is limited to
userspace interaction with the tee.

A trusted key is a random number generated and sealed(encrypted) by
the TPM, so that only the TPM may unseal it.  The sealing key never
leaves the TPM.  The sealed, trusted key may be exported to userspace.
 In the tee case, can the "sealing" key ever leave the tee?  Can the
sealed, trusted key, exported to userspace, be unsealed by the tee?
 Are the tee security protections similar to those of the TPM?  How do
they compare?

Mimi

> 
> >
> > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> >
> > Patch #3 enables support for private kernel login method required for
> > cases like trusted keys where we don't wan't user-space to directly access
> > TEE service to retrieve trusted key contents.
> >
> > Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
> >
> > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > found here [1].
> >
> > Looking forward to your valuable feedback/suggestions.
