From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Mar 2019 18:49:27 +0000
Subject: Re: [PATCH] KEYS: trusted: defer execution of TPM-specific code until key instantiate
Message-Id: <CAPcyv4jU-TCyfJ5gxrEaZt1GDJ+b_FtYi9O8H=cqLbqOAaskuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190322180139.18856-1-roberto.sassu@huawei.com>
In-Reply-To: <20190322180139.18856-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, david.safford@ge.com, James Bottomley <jejb@linux.ibm.com>, Silviu Vlasceanu <silviu.vlasceanu@huawei.com>, stable <stable@vger.kernel.org>

On Fri, Mar 22, 2019 at 11:04 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Commit 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from
> tpm_default_chip()") changed the tpm_chip argument of every TPM function
> from NULL to a pointer that is retrieved at module initialization time.
>
> Unlike before this patch, the trusted module cannot be loaded if no TPM is
> available. Unfortunately, this causes a dependency problem because the
> encrypted key type requires the 'key_type_trusted' symbol when
> CONFIG_TRUSTED_KEYS is defined.
>
> This patch fixes the issue by deferring the execution of TPM-specific code
> until a new trusted key is instantiated: init_tpm(), to obtain a tpm_chip
> pointer; init_digests(), introduced by commit 0b6cf6b97b7e ("tpm: pass an
> array of tpm_extend_digest structures to tpm_pcr_extend()"), to get random
> bytes from the TPM to lock a PCR.
>
> Cc: stable@vger.kernel.org
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()")
> Reported-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks Robert!
