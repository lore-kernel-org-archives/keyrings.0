From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 29 Jan 2019 20:34:22 +0000
Subject: Re: [PATCH v8 5/7] tpm: move tpm_chip definition to include/linux/tpm.h
Message-Id: <20190129203422.GD11615@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-6-roberto.sassu@huawei.com>
In-Reply-To: <20190124154910.29948-6-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, silviu.vlasceanu@huawei.com

On Thu, Jan 24, 2019 at 04:49:08PM +0100, Roberto Sassu wrote:
> -enum tpm_const {
> -	TPM_MINOR = 224,	/* officially assigned */
> -	TPM_BUFSIZE = 4096,
> -	TPM_NUM_DEVICES = 65536,
> -	TPM_RETRY = 50,		/* 5 seconds */
> -	TPM_NUM_EVENT_LOG_FILES = 3,
> -};

Here using enum has been a bad idea in the first place, as they don't
relate in any meaningful way.

Replace the definition with the following in drivers/char/tpm/tpm.h:

#define TPM_MINOR	224 /* misc backwards compatibility */
#define TPM_BUFSIZE	4096
#define TPM_NUM_DEVICES	65536
#define TPM_RETRY	5 /* seconds */

And only add this to include/linux/tpm.h:

#define TPM_NUM_EVENT_LOG_FILES 3

Otherwise, this looks good.

/Jarkko
