From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 13:39:15 +0000
Subject: Re: [PATCH v9 5/6] KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
Message-Id: <20190201133915.GD17861@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-6-roberto.sassu@huawei.com>
In-Reply-To: <20190201100641.26936-6-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 11:06:40AM +0100, Roberto Sassu wrote:
> When crypto agility support will be added to the TPM driver, users of the
> driver have to retrieve the allocated banks from chip->allocated_banks and
> use this information to prepare the array of tpm_digest structures to be
> passed to tpm_pcr_extend().
> 
> This patch retrieves a tpm_chip pointer from tpm_default_chip() so that the
> pointer can be used to prepare the array of tpm_digest structures.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
