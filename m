From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 13:38:54 +0000
Subject: Re: [PATCH v9 4/6] tpm: move tpm_chip definition to include/linux/tpm.h
Message-Id: <20190201133854.GC17861@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-5-roberto.sassu@huawei.com>
In-Reply-To: <20190201100641.26936-5-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 11:06:39AM +0100, Roberto Sassu wrote:
> The tpm_chip structure contains the list of PCR banks currently allocated
> in the TPM. When support for crypto agility will be added to the TPM
> driver, users of the driver have to provide a digest for each allocated
> bank to tpm_pcr_extend(). With this patch, they can obtain the PCR bank
> algorithms directly from chip->allocated_banks.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
