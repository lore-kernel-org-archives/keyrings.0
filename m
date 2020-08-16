From: Coly Li <colyli@suse.de>
Date: Sun, 16 Aug 2020 17:22:26 +0000
Subject: Re: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-Id: <90ce83bf-3547-7ad4-ea6d-40e2e77e29dd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200815075143.47082-1-colyli@suse.de>
 <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
 <096636f4-a928-dd00-dba6-216651c3d63b@suse.de>
 <1597597699.8344.11.camel@linux.ibm.com>
In-Reply-To: <1597597699.8344.11.camel@linux.ibm.com>
To: jejb@linux.ibm.com
Cc: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>

On 2020/8/17 01:08, James Bottomley wrote:
> On Mon, 2020-08-17 at 01:01 +0800, Coly Li wrote:
>> On 2020/8/17 00:06, Stefan Berger wrote:
>>> On 8/15/20 3:51 AM, Coly Li wrote:
> [...]
>>>>     Usage::
>>>> @@ -115,7 +114,7 @@ append 'keyhandle=0x81000001' to statements
>>>> between quotes, such as
>>>
>>>
>>> A note in this file states this:
>>>
>>> Note: When using a TPM 2.0 with a persistent key with handle
>>> 0x81000001, append 'keyhandle=0x81000001' to statements between
>>> quotes, such as "new 32 keyhandle=0x81000001".
>>>
>>> Now if someone was (still) interested in TPM 1.2 then the below
>>> changes you are proposing wouldn't work for them. Maybe you should
>>> adapt the note to state that these keyhandle=... should be removed
>>> for the TPM 1.2 case.
>>>
>>
>> I agree. Indeed I have no idea why number 0x81000001 is used, and I
>> don't have practice experience with TPM 1.2. Now the purpose of this
>> patch accomplished: experts response and confirm my guess :-)
> 
> It was the conventional persistent value for the RSA 2048 version of
> the primary storage seed.  Originally the PC spec required the
> manufacturer provision this on all TPM 2.0 based PC class systems. 
> Unfortunately in spite of it being in the Windows Hardware guide no
> manufacturer ever did, meaning you either have to create it yourself or
> do something different.  Because of usability problems, every consumer
> of TPM key function has opted to do something different, namely derive
> the EC primary if no parent is specified.

Aha, thanks for the hint :-)

My motivation is for the NVDIMM security with TPM 2.0 chip on x86 server
(Lenovo SR650). To automatically load a trusted key, I encounter the
outdated command line in trusted-encrypted.rst. From your response, it
seems 0x81000001 is still a working value that I can recommend to other
people who want to encrypt/decrypt their NVDIMM banks.

Coly Li
