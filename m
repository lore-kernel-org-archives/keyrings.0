From: Coly Li <colyli@suse.de>
Date: Sun, 16 Aug 2020 17:01:38 +0000
Subject: Re: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-Id: <096636f4-a928-dd00-dba6-216651c3d63b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200815075143.47082-1-colyli@suse.de>
 <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
In-Reply-To: <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>

On 2020/8/17 00:06, Stefan Berger wrote:
> On 8/15/20 3:51 AM, Coly Li wrote:
>> The parameters in tmp2 commands are outdated, people are not able to
>> create trusted key by the example commands.
>>
>> This patch updates the paramerters of tpm2 commands, they are verified
>> by tpm2-tools-4.1 with Linux v5.8 kernel.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: James Bottomley <jejb@linux.ibm.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   Documentation/security/keys/trusted-encrypted.rst | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/security/keys/trusted-encrypted.rst
>> b/Documentation/security/keys/trusted-encrypted.rst
>> index 9483a7425ad5..442a2775156e 100644
>> --- a/Documentation/security/keys/trusted-encrypted.rst
>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>> @@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
>>     Or with the Intel TSS 2 stack::
>>   -  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
>> +  #> tpm2_createprimary --hierarchy o -G rsa2048 key.ctxt
>>     [...]
>> -  handle: 0x800000FF
> 
> 
> Are you sure about this? My documentation for 4.1.3 on F32 states
> 
> 
> -c, --key-context=FILE:
> 
>          The file path to save the object context of the generated
> primary object.
> 
> 

Yes of course you are right, it is s/-o/-c

> 
>> -  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
>> +  #> tpm2_evictcontrol -c key.ctxt 0x81000001
>>     persistentHandle: 0x81000001
> 
> 
> This seems correct.
> 
> 
>>     Usage::
>> @@ -115,7 +114,7 @@ append 'keyhandle=0x81000001' to statements
>> between quotes, such as
> 
> 
> A note in this file states this:
> 
> Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
> append 'keyhandle=0x81000001' to statements between quotes, such as
> "new 32 keyhandle=0x81000001".
> 
> Now if someone was (still) interested in TPM 1.2 then the below changes
> you are proposing wouldn't work for them. Maybe you should adapt the
> note to state that these keyhandle=... should be removed for the TPM 1.2
> case.
> 

I agree. Indeed I have no idea why number 0x81000001 is used, and I
don't have practice experience with TPM 1.2. Now the purpose of this
patch accomplished: experts response and confirm my guess :-)

Thanks.

>>     ::
>>   -    $ keyctl add trusted kmk "new 32" @u
>> +    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
>>       440502848
>>         $ keyctl show
>> @@ -138,7 +137,7 @@ append 'keyhandle=0x81000001' to statements
>> between quotes, such as
>>     Load a trusted key from the saved blob::
>>   -    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
>> +    $ keyctl add trusted kmk "load `cat kmk.blob`
>> keyhandle=0x81000001" @u
>>       268728824
>>         $ keyctl print 268728824
> 
> 

Coly Li
