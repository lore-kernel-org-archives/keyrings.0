From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 14 Sep 2019 13:04:41 +0000
Subject: Re: [PATCH v4] KEYS: trusted: correctly initialize digests and fix locking issue
Message-Id: <20190914130441.GE9560@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190913185136.780-1-roberto.sassu@huawei.com>
In-Reply-To: <20190913185136.780-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, jsnitsel@redhat.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Sep 13, 2019 at 08:51:36PM +0200, Roberto Sassu wrote:
> Commit 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to
> tpm_pcr_extend()") modifies tpm_pcr_extend() to accept a digest for each
> PCR bank. After modification, tpm_pcr_extend() expects that digests are
> passed in the same order as the algorithms set in chip->allocated_banks.
> 
> This patch fixes two issues introduced in the last iterations of the patch
> set: missing initialization of the TPM algorithm ID in the tpm_digest
> structures passed to tpm_pcr_extend() by the trusted key module, and
> unreleased locks in the TPM driver due to returning from tpm_pcr_extend()
> without calling tpm_put_ops().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")

Reviewed-by:  <jarkko.sakkinen@linux.intel.com>

I picked up this patch to my tree.

/Jarkko
