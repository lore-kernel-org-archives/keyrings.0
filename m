From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 19 Nov 2019 01:58:30 +0000
Subject: Re: [PATCH v8 3/5] KEYS: Call the IMA hook to measure keys
Message-Id: <3e051f5c-927e-cba6-7714-388e0216974a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-4-nramas@linux.microsoft.com>
 <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
In-Reply-To: <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 11/18/19 5:18 PM, Eric Snowberg wrote:

>> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>> +extern void ima_post_key_create_or_update(struct key *keyring,
>> +					  struct key *key,
>> +					  unsigned long flags, bool create);
>> +#endif
> 
> The extern void ima_post_key_create_or_update will only be defined if CONFIG_IMA=y.
> 

> 
> This will cause a compile error if CONFIG_IMA is not defined and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y.
> 
> security/keys/key.c: In function 'key_create_or_update':
> security/keys/key.c:940:2: error: implicit declaration of function 'ima_post_key_create_or_update'; did you mean 'key_create_or_update'? [-Werror=implicit-function-declaration]
>    ima_post_key_create_or_update(keyring, key, flags, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    key_create_or_update
> cc1: some warnings being treated as errors

You are right - Thanks for catching this error.
I'll fix this and send an update.

thanks,
  -lakshmi
