From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Aug 2019 16:54:00 +0000
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-Id: <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Aug 13, 2019 at 01:22:59PM +0530, Sumit Garg wrote:
> This patch-set is an outcome of discussion here [1]. It has evolved very
> much since v1 to create, consolidate and generalize trusted keys
> subsystem.
> 
> This framework has been tested with trusted keys support provided via TEE
> but I wasn't able to test it with a TPM device as I don't possess one. It
> would be really helpful if others could test this patch-set using a TPM
> device.

I think 1/5-4/5 make up a non-RFC patch set that needs to reviewed,
tested and merged as a separate entity.

On the other hand 5/5 cannot be merged even if I fully agreed on
the code change as without TEE patch it does not add any value for
Linux.

To straighten up thing I would suggest that the next patch set
version would only consists of the first four patches and we meld
them to the shape so that we can land them to the mainline. Then
it should be way more easier to concentrate the actual problem you
are trying to resolve.

/Jarkko
