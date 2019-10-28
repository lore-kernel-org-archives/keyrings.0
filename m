From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 28 Oct 2019 15:12:16 +0000
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure keys added to builtin_trusted_ke
Message-Id: <8494baa1-c4db-f08b-26c9-2e56279075d0@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-4-nramas@linux.microsoft.com>
 <1572186810.4532.206.camel@linux.ibm.com>
In-Reply-To: <1572186810.4532.206.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 10/27/19 7:33 AM, Mimi Zohar wrote:

> .builtin_trusted_keys is a trusted keyring, which is created by the
> kernel.  It cannot be deleted or replaced by userspace, so it should
> be possible to correlate a keyring name with a keyring number on
> policy load.

Yes - at policy load we can map a keyring name to a keyring number.

But at runtime we still need to know if the keyring parameter passed to 
the IMA hook function is configured to be measured.

void ima_post_key_create_or_update(struct key *keyring, struct key *key,
				   unsigned long flags, bool create);
{
    => Get the keyring number for the given "keyring".
    => Check if the keyring number is in the configured IMA policy.
    => If yes, measure the key.
    => Else, do nothing.
}

Did I misunderstand what you had stated?

>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>> index fc376a323908..25566c74e679 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -29,6 +29,7 @@ Description:
>>   				[FIRMWARE_CHECK]
>>   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>>   				[KEXEC_CMDLINE]
>> +				[BUILTIN_TRUSTED_KEYS]
> 
> The .builtin_trusted_keys is the name of a keyring, not of an IMA
> hook.  Define a new IMA policy "keyring=" option, where keyring is
> optional.  Some IMA policy rules might look like:
> 
> # measure all keys
> measure func=KEYRING_CHECK
> 
> # measure keys on the IMA keyring
> measure func=KEYRING_CHECK keyring=".ima"
> 
> # measure keys on the BUILTIN and IMA keyrings into a different PCR
> measure func=KEYRING_CHECK keyring=".builtin_trusted_keys|.ima" pcr

I agree - I'll take a look at this.

> "func", in this case, should be something like "KEYRING_CHECK".  No
> mapping is necessary.
Agree.

> 
>>   	if (!ima_initialized) {
>> -		ima_queue_key_for_measurement(key, NONE);
>> +		ima_queue_key_for_measurement(key, func);
>>   		return;
>>   	}
>>   
>>   	pk = key->payload.data[asym_crypto];
>>   	process_buffer_measurement(pk->key, pk->keylen,
>>   				   key->description,
>> -				   NONE, 0);
>> +				   func, 0);
> 
> Pass the "keyring" to process_buffer_measurement() and on to
> ima_get_action(), so that ima_get_action() determines whether the
> keyring is in policy.

Agree.

thanks,
  -lakshmi
