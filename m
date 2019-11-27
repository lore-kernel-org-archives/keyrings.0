From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 27 Nov 2019 21:11:59 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-2-nramas@linux.microsoft.com>
 <1574887137.4793.346.camel@linux.ibm.com>
In-Reply-To: <1574887137.4793.346.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>

On 11/27/19 12:38 PM, Mimi Zohar wrote:

> Hi Lakshmi,
> 
> Janne Karhunen is defining an IMA workqueue in order to more
> frequently update the on disk security xattrs.  

Has the above patch set been posted for review? I'll take a look and see 
if that one can be used for queuing keys.

The Subject line on
> this patch needs to be more explicit (eg. define workqueue for early
> boot "key" measurements).

Will update the subject line.
I was trying to keep the subject line short and have more details in the 
patch description.

> I'm not sure why you want to differentiate between IMA being
> initialized vs. an empty policy.  I would think you would want to know
> when a custom policy has been loaded.

You are right - When custom ima policy rules are loaded (in 
ima_update_policy() function), ima_process_queued_keys_for_measurement() 
function is called to process queued keys.

The flag ima_process_keys_for_measurement is set to true in 
ima_process_queued_keys_for_measurement(). And, subsequent keys are 
processed immediately.

Please take a look at ima_process_queued_keys_for_measurement() in this 
patch (v0 1/2) and the ima_update_policy() change in "PATCH v0 2/2".

> 
> I would define a function that determines whether or not a custom
> policy has been loaded.

The queued keys need to be processed once when the custom policy is 
loaded. Subsequently, keys are processed immediately (not queued).

Do you still think there is a need to have a function to determine if 
custom policy has been loaded? Wouldn't the flag 
ima_process_keys_for_measurement be sufficient?

Please take a look at "PATCH v0 2/2" and let me know if you disagree.

> (I still need to review adding/removing from the queue.)
> 
>>
>> @@ -27,14 +154,14 @@
>>    * The payload data used to instantiate or update the key is measured.
>>    */
>>   void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>> -				   const void *payload, size_t plen,
>> +				   const void *payload, size_t payload_len,
>>   				   unsigned long flags, bool create)
> 
> This "hunk" and subsequent one seem to be just a variable name change.
>   It has nothing to do with queueing "key" measurements and shouldn't
> be included in this patch.
> 
> Mimi

I'll remove this change.

thanks,
  -lakshmi
