From: James Bottomley <jejb@linux.ibm.com>
Date: Fri, 29 Nov 2019 20:05:16 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1575057916.6220.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Fri, 2019-11-29 at 01:40 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> Maybe the TPM command confused you. 

Well you did seem to be saying we had a problem in the TPM sealed key
subsystem.

> The question is I use keyctl command sealed a trusted key with PCR
> policy, but load it failed after reboot. 
> I don't know why it was loaded failed. I use TPM command to help find
> it, it report policy check failed. 

Right, so your question seems to be why after a reboot, the TPM policy
no longer works to authorize the key even from user space?  My best
guess would be the PCR value you've sealed it to changed over the
reboot for some reason.

> So my question is how to load the PCR policy sealed trusted key
> correctly?

You have to set the sealing release policy to something you know will
be invariant across reboots for an unseal to happen reliably.  However,
usually you also want the unseal to fail if something you don't like
changes, so you set the policy to be something that's invariant unless
that happens.  Not really knowing what your conditions are we can't
really tell you what your policy should look like.

> How to use policydigest and policyhandle correctly. 

I've no real idea how the tpm2_ commands work, but the tsspolicy
commands all have man pages which do a pretty good explanation.  If I
infer how your tpm2_ commands seem to be working, I think
you're sealing to a pcr7 hash?  pcr7 is the one that's supposed to
measure the secure boot path and properties and as such shouldn't
change across reboots, so I think your problem becomes finding out why
it changed.

James
