From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 09 Jul 2019 16:24:58 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <1562618099.20748.13.camel@linux.ibm.com>
In-Reply-To: <1562618099.20748.13.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, tyhicks@canonical.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On Mon, Jul 08, 2019 at 01:34:59PM -0700, James Bottomley wrote:
> Not a criticism of your patch, but can we please stop doing this. 
> Single random number sources are horrendously bad practice because it
> gives an attacker a single target to subvert.  We should ensure the TPM
> is plugged into the kernel RNG as a source and then take randomness
> from the mixed pool so it's harder for an attacker because they have to
> subvert all our sources to predict what came out.

It is and I agree.

/Jarkko
