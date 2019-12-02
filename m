From: James Bottomley <jejb@linux.ibm.com>
Date: Mon, 02 Dec 2019 06:44:35 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1575269075.4080.31.camel@linux.ibm.com>
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
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Mon, 2019-12-02 at 06:23 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> The PCR7 value and PCR7 policy is as below, please review, thanks. 
> 
> # tpm2_pcrlist -L sha256:7 -o pcr7_2.sha256
> sha256:
>   7 :
> 0x061AAD0705A62361AD18E58B65D3D7383F4D10F7F5A7E78924BE057AC6797408
> 
> # tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy
> pcr7_bin.policy > pcr7.policy
> 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> 
> # cat pcr7.policy
> 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9

Well, the IBM TSS says that's the correct policy.  Your policy command
is

jejb@jarvis:~> tsspolicymakerpcr -bm 000080 -if ~/pcr7.txt -pr | tee tmp.policy
0000017f00000001000b038000009a47350fdbcc77ebeadcb4b4818d8e82a21717ea24434333c791c0cd0d1dc14e

And that hashes to
jejb@jarvis:~> tsspolicymaker -if ~/tmp.policy  -pr
 policy digest length 32
 32 1f bd 28 b6 0f cc 23 01 7d 50 1b 13 3b d5 db 
 f2 88 98 14 58 8e 8a 23 51 0f e1 01 05 cb 2c c9 

So I don't understand why the userspace Intel TSS command is failing to
do the unseal.

James
