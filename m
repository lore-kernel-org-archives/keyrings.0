From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 25 Mar 2019 14:56:19 +0000
Subject: Re: [PATCH] KEYS: trusted: defer execution of TPM-specific code until key instantiate
Message-Id: <20190325145619.GC29989@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190322180139.18856-1-roberto.sassu@huawei.com>
In-Reply-To: <20190322180139.18856-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: dhowells@redhat.com, zohar@linux.ibm.com, dan.j.williams@intel.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, david.safford@ge.com, jejb@linux.ibm.com, silviu.vlasceanu@huawei.com, stable@vger.kernel.org

On Fri, Mar 22, 2019 at 07:01:39PM +0100, Roberto Sassu wrote:
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
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Definitive NAK for the release. Sorting out the dependency problem is
definitely out of scope for v5.1.

/Jarkko
