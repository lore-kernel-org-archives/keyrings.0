From: James Bottomley <jejb@linux.ibm.com>
Date: Mon, 02 Dec 2019 18:55:32 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1575312932.24227.13.camel@linux.ibm.com>
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
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Mon, 2019-12-02 at 06:50 +0000, Zhao, Shirley wrote:
> So I guess mostly like, it is the format of policydigest,
> policyhandle is not correctly in my keyctl command. 
> But what is the correct using?
> 
> My keyctl commands are attached as below: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr7.policy`" @u
> 874117045
> 
> Save the trusted key. 
> $ keyctl pipe 874117045 > kmk.blob

OK, looking at the actual code, it seems that whoever wrote it didn't
account for the differences between TPM1.2 and TPM2.0.  With TPM2.0
TPM2_Create returns the public and private parts plus three other tpm2b
entites used to certify and check the key.  When you load the blob back
using TPM2_Load, it only accepts the public and private parts. 
However, your blob contains the other extraneous elements, that's why
it can't be loaded.  You could make it loadable by stripping off the
extraneous pieces ... just take the first two tpm2b elements of the
blob but it looks like we need to fix the API.  I suppose the good news
is given this failure that we have the opportunity to rewrite the API
since no-one else can have used it for anything because of this.  The
fundamental problem with the current API is that most TPM2's only have
three available session registers.  It's simply not scalable to set
them up in userspace and have the kernel use them, so what we should be
doing is passing down the actual policy and having the kernel construct
the session at the point of use and then flush it, thus solving the
potential session exhaustion issue.

I'd actually propose we make a TSSLOADABLE the fundamental element of
operation for trusted keys.  The IBM and Intel TSS people have agreed
to do this as the format for TPM loadable keys, but it should also
apply to sealed data.  The beauty of TSSLOADABLE is that the ASN.1
format includes a policy specification:

/*
 * TSSLOADABLE ::= SEQUENCE {
 *	type		OBJECT IDENTIFIER
 *	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL
 *	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
 *	secret		[2] EXPLICIT OCTET STRING OPTIONAL
 *	parent		INTEGER
 *	pubkey		OCTET STRING
 *	privkey		OCTET STRING
 * }
 * TPMPolicy ::= SEQUENCE {
 *	CommandCode		[0] EXPLICIT INTEGER
 *	CommandPolicy		[1] EXPLICIT OCTET STRING
 * }
 */

James
