From: Coly Li <colyli@suse.de>
Date: Sun, 16 Aug 2020 17:05:24 +0000
Subject: Re: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-Id: <dbe58528-e445-f637-4e22-fbcff7b6965a@suse.de>
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

BTW, where can I get the document you mentioned for "4.1.3 on F32
states" ? I only have a pdf file "A practical Guide to TPM 2.0" which
does not have 4.1.3

Thanks.

Coly Li
