From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 13 Sep 2019 13:30:57 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Use common tpm_buf for asymmetric keys
Message-Id: <20190913133057.GD7412@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568200910-31368-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1568200910-31368-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:51:50PM +0530, Sumit Garg wrote:
> Switch to utilize common heap based tpm_buf code for TPM based
> asymmetric keys rather than using stack based tpm_buf code.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Can you roll instead a new version of the whole patch set?

/Jarkko
