From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 13:34:51 +0000
Subject: Re: [PATCH v9 1/6] tpm: dynamically allocate the allocated_banks array
Message-Id: <20190201133451.GA17861@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-2-roberto.sassu@huawei.com>
In-Reply-To: <20190201100641.26936-2-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 11:06:36AM +0100, Roberto Sassu wrote:
> This patch renames active_banks (member of tpm_chip) to allocated_banks,
> stores the number of allocated PCR banks in nr_allocated_banks (new member
> of tpm_chip), and replaces the static array with a pointer to a dynamically
> allocated array.
> 
> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
> TPM2_Get_Capability(). If a bank is not allocated, the TPM returns that
> bank in TPML_PCR_SELECTION, with all bits in the mask set to zero. In this
> case, the bank is not included in chip->allocated_banks, to avoid that TPM
> driver users unnecessarily calculate a digest for that bank.
> 
> One PCR bank with algorithm set to SHA1 is always allocated for TPM 1.x.
> 
> As a consequence of the introduction of nr_allocated_banks,
> tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
> is equal to zero.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
