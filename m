From: James Bottomley <jejb@linux.ibm.com>
Date: Mon, 02 Dec 2019 04:17:00 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1575260220.4080.17.camel@linux.ibm.com>
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
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Mon, 2019-12-02 at 01:44 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> The value of PCR7 is not changed. I have checked it with TPM command
> tpm_pcrlist. 
> 
> So I think the problem is how to use the option policydigest and
> policyhandle? Is there any example?
> Maybe the format in my command is not correct. 

OK, so previously you said that using the Intel TSS the policy also
failed after a reboot:

> The error should be policy check failed, because I use TPM command to
> unseal directly with error of policy check failed. 
> $ tpm2_unseal -c 0x81000001 -L sha256:7
> ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) -
> tpm:session(1):a policy check failed
> ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run
> tpm2_unseal

So this must mean the actual policy hash you constructed was wrong in
some way: it didn't correspond simply to a value of pcr7 ... well
assuming the -L sha256:7 means construct a policy of the sha256 value
of pcr7 and use it in the unseal.

I can tell you how to construct policies using TPM2 commands, but I
think you want to know how to do it using the Intel TSS?  In which case
you really need to consult the experts in that TSS, like Phil Tricca.

For the plain TPM2 case, the policy looks like

TPM_CC_PolicyPCR || pcrs || pcrDigest

Where TPM_CC_PolicyPCR = 0000017f and for selecting pcr7 only.  pcrs is
a complicated entity: it's a counted array of pcr selections.  For your
policy you only need one entry, so it would be 00000001 followed by a
single pcrSelection entry.  pcrSelection is the hash algorithm, the
size of the selection bitmap (always 3 since every current TPM only has
24 PCRs) and a bitmap selecting the PCRs in big endian format, so for
PCR7 using sha256 (algorithm 000b), pcrSelection = 000b 03 80 00 00. 
And then you follow this by the hash of the PCR value you're looking
for.  The policyhash becomes the initial policy (all zeros for the
start of the policy chain) hashed with this.

Regards,

James
