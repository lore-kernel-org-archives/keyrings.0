From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 30 Jan 2019 07:52:40 +0000
Subject: Re: [PATCH v8 1/7] tpm: dynamically allocate the allocated_banks array
Message-Id: <ddf3515d-efba-6cf0-e224-90966be9cb18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-2-roberto.sassu@huawei.com>
 <20190129192941.GB14305@linux.intel.com>
In-Reply-To: <20190129192941.GB14305@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, silviu.vlasceanu@huawei.com

On 1/29/2019 8:29 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 24, 2019 at 04:49:04PM +0100, Roberto Sassu wrote:
>> +	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
>> +					GFP_KERNEL);
>> +	if (!chip->allocated_banks) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	chip->allocated_banks[0] = TPM2_ALG_SHA1;
>> +	chip->nr_allocated_banks = 1;
> 
> Everything else looks nice in this patch except this.
> 
> You always branch for TPM 1.2, and it will always have just SHA1. This
> is unnecessary.

Without this, users of the TPM driver have to call tpm_is_tpm2() first,
while instead they can look directly at chip->allocated_banks.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
