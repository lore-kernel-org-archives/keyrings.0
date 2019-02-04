From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 04 Feb 2019 23:26:40 +0000
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Message-Id: <20190204232640.GB14992@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <1549048506.6993.73.camel@linux.ibm.com>
 <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
 <20190204120746.GG26799@linux.intel.com>
 <8b519a73-eb76-c700-69bc-17f7788cca08@huawei.com>
In-Reply-To: <8b519a73-eb76-c700-69bc-17f7788cca08@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Mon, Feb 04, 2019 at 02:21:59PM +0100, Roberto Sassu wrote:
> I can include your fix in patch 4/6, if you prefer.

It is not really a question of my preference because the changes in
4/6 are not part of the bug fix.

/Jarkko
