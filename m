From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 25 Oct 2019 19:49:45 +0000
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on key create or update
Message-Id: <715d35ba-a102-3524-77a8-70a784628b46@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-2-nramas@linux.microsoft.com>
 <1572032428.4532.72.camel@linux.ibm.com>
In-Reply-To: <1572032428.4532.72.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 10/25/2019 12:40 PM, Mimi Zohar wrote:

> On Wed, 2019-10-23 at 16:39 -0700, Lakshmi Ramasubramanian wrote:
>> Defined an ima hook to measure keys created or updated in the system.
> 
> "IMA" is an anacronym.  Unless it is a part of a function name, it
> should be capitalized.
Will fix that.

> 
> Before describing "what" you're doing, describe the problem.  For
> example, "The asymmetric keys used for verifying file signatures or
> certificates are currently not included in the IMA measurement list.
>   This patch defines a new IMA hook named ima_key_create_or_update() to
> measure keys."
Agree - will update.


>> +
>> +	if (!ima_initialized)
>> +		return;
> 
> There's no reason to define a new variable to determine if IMA is
> initialized.  Use ima_policy_flag.
Will change it.

>  Like process_measurements, the test should be in process_buffer_measurement(), not here.

Currently, queuing of requests when IMA is not initialized is done for 
keys only. Moving that check inside process_buffer_measurement would 
mean handling queuing for all buffer measurements.

Can that be done as a separate patch set and not in this one?

>> @@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>>   		goto error_link_end;
>>   	}
>>   
>> +	/* let the ima module know about the created key. */
>> +	ima_post_key_create_or_update(keyring, key, flags, true);
>> +
>>   	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
> 
> This patch defines the new IMA hook.  This call and the subsequent one
> below can be defined in a separate patch.  The subject line of that
> patch would be "keys: Add ima_key_create_or_update call to measure
> keys".
> 
> Mimi
Agree - will change it.

thanks,
  -lakshmi
