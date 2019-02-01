From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 13:36:11 +0000
Subject: Re: [PATCH v9 2/6] tpm: rename and export tpm2_digest and tpm2_algorithms
Message-Id: <20190201133611.GB17861@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-3-roberto.sassu@huawei.com>
In-Reply-To: <20190201100641.26936-3-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 11:06:37AM +0100, Roberto Sassu wrote:
> Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
> that these can be used by other kernel subsystems (e.g. IMA).
> 
> Also, set the length of the digest array in tpm_digest to a new constant
> named TPM_MAX_DIGEST_SIZE, equal to SHA512_DIGEST_SIZE.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
