From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 29 Oct 2019 14:16:37 +0000
Subject: Re: [PATCH] KEYS: trusted: Remove set but not used variable 'keyhndl'
Message-Id: <20191029141637.GA7415@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1572341612-31893-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1572341612-31893-1-git-send-email-zhengbin13@huawei.com>
To: zhengbin <zhengbin13@huawei.com>
Cc: dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com, sumit.garg@linaro.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, yi.zhang@huawei.com

On Tue, Oct 29, 2019 at 05:33:32PM +0800, zhengbin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/keys/trusted-keys/trusted_tpm1.c: In function tpm_unseal:
> security/keys/trusted-keys/trusted_tpm1.c:588:11: warning: variable keyhndl set but not used [-Wunused-but-set-variable]
> 
> It is introduced by commit 00aa975bd031 ("KEYS: trusted:
> Create trusted keys subsystem"), but never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I'll pick this to my tree.

/Jarkko
