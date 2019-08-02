From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 02 Aug 2019 08:21:16 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
In-Reply-To: <20190801163215.mfkagoafkxscesne@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, tyhicks@canonical.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
>> According to the bug report at https://bugs.archlinux.org/task/62678,
>> the trusted module is a dependency of the ecryptfs module. We should
>> load the trusted module even if the TPM is inactive or deactivated.
>>
>> Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
>> "get random"") changes the return code of tpm_get_random(), the patch
>> should be modified to ignore the -EIO error. I will send a new version.
> 
> Do you have information where this dependency comes from?

ecryptfs retrieves the encryption key from encrypted keys (see
ecryptfs_get_encrypted_key()).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
