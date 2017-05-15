From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 15 May 2017 11:16:29 +0000
Subject: Re: [PATCH v2 2/5] tpm: introduce tpm_pcr_algo_to_crypto() and tpm_pcr_algo_from_crypto()
Message-Id: <20170515111629.urjvbhqzohv4vakc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170505142152.29795-1-roberto.sassu@huawei.com>
	<20170505142152.29795-3-roberto.sassu@huawei.com>
In-Reply-To: <20170505142152.29795-3-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org

On Fri, May 05, 2017 at 04:21:49PM +0200, Roberto Sassu wrote:
> tpm_pcr_algorithms() returns to its callers the IDs of the hash algorithms
> supported by the TPM. This patch introduces tpm_pcr_algo_to_crypto(),
> so that the callers can use the crypto subsystem to calculate the digest
> to be passed to tpm_pcr_extend().
> 
> tpm_pcr_algo_from_crypto(), implemented for completeness, is instead used

What do you mean by completeness? Please, never add unused stuff.

> by tpm2_seal_trusted() to perform the opposite conversion.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> v2
> 
> - fixed return values of tpm2_pcr_algo_to_crypto() and
>   tpm2_pcr_algo_from_crypto() if TPM support is disabled in the kernel

Change Log only to the cover letter.

>  drivers/char/tpm/tpm-interface.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-cmd.c      | 42 +++++++++------------------------
>  include/linux/tpm.h              | 13 ++++++++++
>  3 files changed, 75 insertions(+), 31 deletions(-)

This commit is just deadly wrong in so many ways.

I would suggest to make extend always just take crypto ID in so you
don't have to add these bizarre conversion functions.

This probably covers all the patches but just "unsigned int" as type
for parameters and local variables.

I think I'll pass rest of the patches for now because just reviewing the
two first took too much time and wait for an updated version.

/Jarkko
