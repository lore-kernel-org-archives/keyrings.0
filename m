From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 02 Aug 2019 15:34:58 +0000
Subject: Re: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <3222714a-a280-0708-f4c0-5db6d342d8dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190802150733.1972-1-roberto.sassu@huawei.com>
 <20190802153030.GB26616@elm>
In-Reply-To: <20190802153030.GB26616@elm>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 8/2/2019 5:30 PM, Tyler Hicks wrote:
> On 2019-08-02 17:07:33, Roberto Sassu wrote:
>> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
>> TPM") allows the trusted module to be loaded even a TPM is not found to
>                                                     ^ if
> 
>> avoid module dependency problems.
>>
>> However, trusted module initialization can still fail if the TPM is
>> inactive or deactivated. This patch ignores tpm_get_random() errors in
>> init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
>> random data.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> The code changes look correct to me.
> 
>    Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> 
> For whoever takes this patch through their tree, I think that adding the
> following Fixes tag would be useful (as well as cc'ing stable):
> 
>    Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> 
> I think it is also worth leaving a short note, in the commit message,
> for backporters that commit 782779b60faa ("tpm: Actually fail on TPM
> errors during "get random"") should be included with any backports of
> this patch.

Right, thanks. I wait for Jarkko's comments and I add both the Fixes tag
and the short note in the next version of the patch.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
