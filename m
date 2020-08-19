From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 19 Aug 2020 23:03:49 +0000
Subject: Re: [PATCH v3] docs: trusted-encrypted.rst: update parameters for command examples
Message-Id: <ec431164-21ae-8019-a9c0-b1e15004e4b9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200818170002.38145-1-colyli@suse.de>
 <20200819210234.GB9942@linux.intel.com>
In-Reply-To: <20200819210234.GB9942@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Coly Li <colyli@suse.de>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>

On 8/19/20 5:02 PM, Jarkko Sakkinen wrote:
> On Wed, Aug 19, 2020 at 01:00:02AM +0800, Coly Li wrote:
>> The parameters in command examples for tpm2_createprimary and
>> tpm2_evictcontrol are outdated, people (like me) are not able to create
>> trusted key by these command examples.
>>
>> This patch updates the parameters of command example tpm2_createprimary
>> and tpm2_evictcontrol in trusted-encrypted.rst. With Linux kernel v5.8
>> and tpm2-tools-4.1, people can create a trusted key by following the
>> examples in this document.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: James Bottomley <jejb@linux.ibm.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: Stefan Berger <stefanb@linux.ibm.com>
> OK, now it is clear. Thank you.
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> /Jarkko
>
>> ---
>> Changelog:
>> v3: update commit log with review comments from Jarkko Sakkinen.
>> v2: remove the change of trusted key related operation.
>> v1: initial version.
>>
>>   Documentation/security/keys/trusted-encrypted.rst | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>> index 9483a7425ad5..1da879a68640 100644
>> --- a/Documentation/security/keys/trusted-encrypted.rst
>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>> @@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
>>   
>>   Or with the Intel TSS 2 stack::
>>   
>> -  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
>> +  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
>>     [...]
>> -  handle: 0x800000FF
>> -  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
>> +  #> tpm2_evictcontrol -c key.ctxt 0x81000001
>>     persistentHandle: 0x81000001
>>   
>>   Usage::
>> -- 
>> 2.26.2
>>
