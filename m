From: Tom Rix <trix@redhat.com>
Date: Wed, 22 Jul 2020 20:10:56 +0000
Subject: Re: [PATCH v2] KEYS: remove redundant memset
Message-Id: <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200722134610.31947-1-trix@redhat.com>
 <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
In-Reply-To: <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
To: Joe Perches <joe@perches.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org


On 7/22/20 1:02 PM, Joe Perches wrote:
> On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Reviewing use of memset in keyctrl_pkey.c
>>
>> keyctl_pkey_params_get prologue code to set params up
>>
>> 	memset(params, 0, sizeof(*params));
>> 	params->encoding = "raw";
>>
>> keyctl_pkey_query has the same prologue
>> and calls keyctl_pkey_params_get.
>>
>> So remove the prologue.
>>
>> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> At best, this is a micro optimization.
Yes
> How is this appropriate for a Fixes: line?
Removing unneeded code is not a fix?
>
>> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> []
>> @@ -166,8 +166,6 @@ long keyctl_pkey_query(key_serial_t id,
>>  	struct kernel_pkey_query res;
>>  	long ret;
>>  
>> -	memset(&params, 0, sizeof(params));
>> -
>>  	ret = keyctl_pkey_params_get(id, _info, &params);
>>  	if (ret < 0)
>>  		goto error;
