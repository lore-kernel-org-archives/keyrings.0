From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 15 Jul 2019 16:44:28 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
In-Reply-To: <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, tyhicks@canonical.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 7/11/2019 9:48 PM, Jarkko Sakkinen wrote:
> On Fri, Jul 05, 2019 at 06:37:35PM +0200, Roberto Sassu wrote:
>> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
>> TPM") allows the trusted module to be loaded even a TPM is not found to
>> avoid module dependency problems.
>>
>> Unfortunately, this does not completely solve the issue, as there could be
>> a case where a TPM is found but is not functional (the TPM commands return
>> an error). Specifically, after the tpm_chip structure is returned by
>> tpm_default_chip() in init_trusted(), the execution terminates after
>> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
>> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
>>
>> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
>> TPM_ERR_DISABLED errors.
> 
> Why allow trusted module to initialize if TPM is not functional?

According to the bug report at https://bugs.archlinux.org/task/62678,
the trusted module is a dependency of the ecryptfs module. We should
load the trusted module even if the TPM is inactive or deactivated.

Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
"get random"") changes the return code of tpm_get_random(), the patch
should be modified to ignore the -EIO error. I will send a new version.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
