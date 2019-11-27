From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 27 Nov 2019 15:39:28 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1574869168.4793.282.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574796456.4793.248.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E490961E5@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E490961E5@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

Hi Shirley,

On Wed, 2019-11-27 at 02:46 +0000, Zhao, Shirley wrote:
> Hi, Mimi, 
> 
> Answer your two questions:
> 
> 1. Yes, I have verified trusted key works well without PCR policy
> protection as below: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> 1055240928
> $ keyctl list @u
> 1 keys in keyring:
> 1055240928: --alswrv     0     0 trusted: kmk
> $ keyctl pipe 1055240928 > kmk.blob
> $ cat kmk.blob
> 007f0020ff808bd8b7239194e89aac6a95b4d210114742c20afa33493f002dffd068
> 5d510010c12d7ad51eb83d6d93895de066bf3d39718cc503adb4802cb087b88b2fff
> 4b040fe3a2be6a3f87c6749d087c9fb6e8734cb23f438d64087581a13bc83d5dc3b0
> 26e77a894ece6620d0eb85df6449ff3c609fd77d5f0caf79b4535b002e0008000b00
> 0000400000001000209a5b00b0d558fcf9e8c029522715e6b5906366eaec5f34367b
> 8ab16c0fb9009a0073000000000020e3b0c44298fc1c149afbf4c8996fb92427ae41
> e4649b934ca495991b7852b85501000b0022000bdcdb694e102e13a0fba5111081cb
> 6cf616c118d404936cac3e84db24c71e47d50022000b04b5db1aa52635dfb242e76f
> 6bde8e2176ae48fc682946c6c76d96f608079d1f0000002036b6fcca8206c7f722de
> 85821d7ecb4785976fdd642bc7538505a2a818c8a23880214000000100202aedde45
> 08f548d108193ec8fe166a7befde19113fe727ae2b29901bdece96e5
> $ keyctl clear @u
> $ keyctl list @u
> keyring is empty
> $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001"
> @u
> 1022963731
> $ keyctl print 1022963731
> 007f0020ff808bd8b7239194e89aac6a95b4d210114742c20afa33493f002dffd068
> 5d510010c12d7ad51eb83d6d93895de066bf3d39718cc503adb4802cb087b88b2fff
> 4b040fe3a2be6a3f87c6749d087c9fb6e8734cb23f438d64087581a13bc83d5dc3b0
> 26e77a894ece6620d0eb85df6449ff3c609fd77d5f0caf79b4535b002e0008000b00
> 0000400000001000209a5b00b0d558fcf9e8c029522715e6b5906366eaec5f34367b
> 8ab16c0fb9009a0073000000000020e3b0c44298fc1c149afbf4c8996fb92427ae41
> e4649b934ca495991b7852b85501000b0022000bdcdb694e102e13a0fba5111081cb
> 6cf616c118d404936cac3e84db24c71e47d50022000b04b5db1aa52635dfb242e76f
> 6bde8e2176ae48fc682946c6c76d96f608079d1f0000002036b6fcca8206c7f722de
> 85821d7ecb4785976fdd642bc7538505a2a818c8a23880214000000100202aedde45
> 08f548d108193ec8fe166a7befde19113fe727ae2b29901bdece96e5
> 
> 2. The following kernel file is related with this problem. 
> /security/keys/keyctl.c
> /security/keys/key.c
> /security/keys/trusted-keys/trusted_tpm1.c
> /security/keys/trusted-keys/trusted_tpm2.c
> 
> To load the PCR policy protection trusted key, the call stack is: 
> SYSCALL_DEFINE5(add_key,...) --> key_create_or_update() -->
> __key_instantiate_and_link() -->  trusted_instantiate() -->
> tpm2_unseal_trusted() --> tpm2_unseal_cmd(). 
> 
> Check dmesg, there will be error: 
> [73336.351596] trusted_key: key_unseal failed (-1)

Like the other kernel mailing lists, please bottom post.  When
reporting a problem, please include the kernel version and other
relevant details.  For example, the TPM version and type (eg. hardware
vendor, software TPM, etc).  Please indicate if this is a new problem
and which kernel release it first start happening?

I have no experience with the tpm2_ commands,  I suggest trying to
extend a single measurement to a PCR and sealing to that value.

Mimi
