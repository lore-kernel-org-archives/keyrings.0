From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 02 Aug 2019 21:18:43 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190802211843.GH26616@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <1562618099.20748.13.camel@linux.ibm.com>
 <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
 <1562689905.28089.52.camel@linux.ibm.com>
In-Reply-To: <1562689905.28089.52.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Bottomley <jejb@linux.ibm.com>, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 2019-07-09 12:31:45, Mimi Zohar wrote:
> On Tue, 2019-07-09 at 19:24 +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 08, 2019 at 01:34:59PM -0700, James Bottomley wrote:
> > > Not a criticism of your patch, but can we please stop doing this. 
> > > Single random number sources are horrendously bad practice because it
> > > gives an attacker a single target to subvert.  We should ensure the TPM
> > > is plugged into the kernel RNG as a source and then take randomness
> > > from the mixed pool so it's harder for an attacker because they have to
> > > subvert all our sources to predict what came out.
> > 
> > It is and I agree.
> 
> I still haven't quite figured out why the digests need to be
> initialized to anything other than 0.

After looking into 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400, I have to
agree. I don't see the purpose of using tpm_get_random() in
init_digests().

Roberto, why can't we just initialize the digests with zeroes? It would
fix the bug for eCryptfs and NVDIMM and address the concern that James
had regarding the single random number source.

Tyler
