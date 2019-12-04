From: James Bottomley <jejb@linux.ibm.com>
Date: Wed, 04 Dec 2019 03:33:09 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1575430389.14163.27.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
         <1575269075.4080.31.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
         <1575312932.24227.13.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
         <1575342724.24227.41.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E877@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909E877@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Wed, 2019-12-04 at 03:01 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> Using policy digest to reload trusted key, doesn't work, either. 
> Please check the steps below. 
> I think policy digest should be calculated by TPM when verifying the
> policy to reload key. 

You misunderstand my meaning: the API we have now doesn't work; the key
blob the kernel returns currently after key create won't reload because
it contains extraneous data.  I was proposing a working API I thought
might replace it, but obviously it has to be coded up and accepted into
a kernel version before you can use it.

If you want to get trusted keys working today, I think the TPM 1.2 API
still works if you have a TPM 1.2 system.

James
