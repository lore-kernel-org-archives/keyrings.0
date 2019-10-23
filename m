From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 23 Oct 2019 14:49:57 +0000
Subject: Re: [PATCH v1 3/6] KEYS: ima hook to measure builtin_trusted_keys
Message-Id: <6a3f2efa-fc05-7bfd-368a-910dd4525f4c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
 <20191023001818.3684-4-nramas@linux.microsoft.com>
 <1571836931.5104.95.camel@linux.ibm.com>
In-Reply-To: <1571836931.5104.95.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 10/23/19 6:22 AM, Mimi Zohar wrote:

Thanks for reviewing the changes Mimi.
I'll address your comments and post an updated patch set shortly.

>> Add a new ima hook to measure keys added to builtin_trusted_keys
>> keyring.
> 
> There is no IMA hook in this patch.
> 

>> +			else if (strcmp(args[0].from,
>> +					"BUILTIN_TRUSTED_KEYS") = 0)
>> +				entry->func = BUILTIN_TRUSTED_KEYS;
>>   			else
>>   				result = -EINVAL;
>>   			if (!result)
> 
> Any new options need to be displayed as well.

Not that I can think of. Please correct me if I am wrong.

Thanks,
  -lakshmi
