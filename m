From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 09 Dec 2019 19:47:15 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <20191209194715.GD19243@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
 <1575057916.6220.7.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
 <1575260220.4080.17.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
 <1575267453.4080.26.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
 <1575269075.4080.31.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
 <1575312932.24227.13.camel@linux.ibm.com>
In-Reply-To: <1575312932.24227.13.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Mon, Dec 02, 2019 at 10:55:32AM -0800, James Bottomley wrote:
> blob but it looks like we need to fix the API.  I suppose the good news
> is given this failure that we have the opportunity to rewrite the API
> since no-one else can have used it for anything because of this.  The

I did successfully run this test when I wrote it 5 years ago:

https://github.com/jsakkine-intel/tpm2-scripts/blob/master/keyctl-smoke.sh

Given that there is API a way must be found that backwards compatibility
is not broken. New format is fine but it must co-exist.

/Jarkko
