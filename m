From: James Bottomley <jejb@linux.ibm.com>
Date: Wed, 27 Nov 2019 18:06:17 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1574877977.3551.5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Tue, 2019-11-26 at 07:32 +0000, Zhao, Shirley wrote:
> Thanks for your feedback, Mimi. 
> But the document of dracut can't solve my problem. 
> 
> I did more test these days and try to descript my question in more
> detail. 
> 
> In my scenario, the trusted key will be sealed into TPM with PCR
> policy. 
> And there are some related options in manual like 
>        hash=         hash algorithm name as a string. For TPM 1.x the
> only
>                      allowed value is sha1. For TPM 2.x the allowed
> values
>                      are sha1, sha256, sha384, sha512 and sm3-256.
>        policydigest= digest for the authorization policy. must be
> calculated
>                      with the same hash algorithm as specified by the
> 'hash='
>                      option.
>        policyhandle= handle to an authorization policy session that
> defines the
>                      same policy and with the same hash algorithm as
> was used to
>                      seal the key. 
> 
> Here is my test step. 
> Firstly, the pcr policy is generated as below: 
> $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy
> pcr7_bin.policy > pcr7.policy
> 
> Pcr7.policy is the ascii hex of policy:
> $ cat pcr7.policy
> 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> 
> Then generate the trusted key and configure policydigest and get the
> key ID: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr7.policy`" @u
> 874117045
> 
> Save the trusted key. 
> $ keyctl pipe 874117045 > kmk.blob
> 
> Reboot and load the key. 
> Start a auth session to generate the policy:
> $ tpm2_startauthsession -S session.ctx
> session-handle: 0x3000000
> $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256
> $ tpm2_policypcr -S session.ctx -L sha256:7 -F pcr7.sha256 -f
> pcr7.policy
> policy-digest:
> 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> 
> Input the policy handle to load trusted key:
> $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001
> policyhandle=0x3000000" @u
> add_key: Operation not permitted
> 
> The error should be policy check failed, because I use TPM command to
> unseal directly with error of policy check failed. 
> $ tpm2_unseal -c 0x81000001 -L sha256:7
> ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) -
> tpm:session(1):a policy check failed
> ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run
> tpm2_unseal

I think there's a miscommunication here: you're complaining about the
error returned from a trusted key unseal operation that *should* fail,
correct?  You think it should return a TPM error but instead it returns
-EPERM.  That's completely correct: we translate all TPM errors into
linux ones as we pass them up to userspace, so the best we can do is
operation not permitted.

James
