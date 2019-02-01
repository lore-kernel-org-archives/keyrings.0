From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 13:41:51 +0000
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Message-Id: <20190201134151.GF17861@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <20190201133949.GE17861@linux.intel.com>
In-Reply-To: <20190201133949.GE17861@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 03:39:49PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 01, 2019 at 11:06:41AM +0100, Roberto Sassu wrote:
> > Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> > 
> > This patch replaces the hash parameter of tpm_pcr_extend() with an array of
> > tpm_digest structures, so that the caller can provide a digest for each PCR
> > bank currently allocated in the TPM.
> > 
> > tpm_pcr_extend() will not extend banks for which no digest was provided,
> > as it happened before this patch, but instead it requires that callers
> > provide the full set of digests. Since the number of digests will always be
> > chip->nr_allocated_banks, the count parameter has been removed.
> > 
> > Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
> > Since the number of allocated banks is not known in advance, the memory for
> > the digests must be dynamically allocated. To avoid performance degradation
> > and to avoid that a PCR extend is not done due to lack of memory, the array
> > of tpm_digest structures is allocated by the users of the TPM driver at
> > initialization time.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I tested that this does not break TPM. I'd need someone to check that
this does not break IMA. After that, I'm ready to apply this series.

/Jarkko
