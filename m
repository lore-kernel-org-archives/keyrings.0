From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 07 Sep 2019 19:02:08 +0000
Subject: Re: [PATCH v2] KEYS: trusted: correctly initialize digests and fix locking issue
Message-Id: <10abf6bea8b2612a40eae338e94704d152f53825.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190904185057.8400-1-roberto.sassu@huawei.com>
In-Reply-To: <20190904185057.8400-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Wed, 2019-09-04 at 20:50 +0200, Roberto Sassu wrote:
> This patch fixes two issues introduced with commit 0b6cf6b97b7e ("tpm: pass
> an array of tpm_extend_digest structures to tpm_pcr_extend()").
> 
> It initializes the algorithm in init_digests() for trusted keys, and moves
> the algorithm check in tpm_pcr_extend() before locks are taken in
> tpm_find_get_ops().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
> ---

The changelog is missing. You should place it right after these three
dashes before diffstat. So, why did you do v2?

I don't see any description of the two issues. The commit messages
goes on explaining right away what this patch does. Would be nice
to have one paragraph describing both of the issues at first before
striving into solutions.

Also, the granularity should be one patch per one issue so this will
require two patches in total.

/Jarkko
