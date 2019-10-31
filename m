From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 31 Oct 2019 21:47:45 +0000
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-Id: <20191031214745.GG10507@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, janne.karhunen@gmail.com, corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, stuart.yoder@arm.com, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Thu, Oct 31, 2019 at 07:28:42PM +0530, Sumit Garg wrote:
> Provide documentation for usage of TEE based Trusted Keys via existing
> user-space "keyctl" utility. Also, document various use-cases.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This is the most important commit in order for someone who don't deal
that much with ARM TEE to get right. Until this commit is right, I don't
unfortunately have much to say about other commits.

Instead of making disjoint islands, you should edit trusted-encrypted.rst
so that it describes commonalities and differences.

What the document currently describes is the usage model. It could be a
section of its own. In that you should describe first the common
parameters and separetely the backend specific parametrs.

From kernel internals (there could be a section with this name)  the
document describe the key generation e.g. is the hardware used and how
it is used, is there salting with krng and so forth.

/Jarkko
