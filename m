From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 10 Dec 2019 23:23:01 +0000
Subject: Re: [PATCH v10 5/6] IMA: Add support to limit measuring keys
Message-Id: <07c231c9-509e-cd1f-9ea0-bfb20f9a0070@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
 <20191204224131.3384-6-nramas@linux.microsoft.com>
 <1576017805.4579.44.camel@linux.ibm.com>
In-Reply-To: <1576017805.4579.44.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/10/19 2:43 PM, Mimi Zohar wrote:

>> +static bool ima_match_keyring(struct ima_rule_entry *rule,
>> +			      const char *keyring, const struct cred *cred)
>> +{
>> +	char *keyrings, *next_keyring, *keyrings_ptr;
>> +	bool matched = false;
>> +
>> +	/* If "keyrings=" is not specified all keys are measured. */
> 
> With the addiitonal "uid" support this isn't necessarily true any
> more.
> 
> Mimi

Will move the check for uid ahead of the check for keyrings.

if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
	return false;

> 
>> +	if (!rule->keyrings)
>> +		return true;
>> +
>> +	if (!keyring)
>> +		return false;
>> +
>> +	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>> +		return false;
>> +

thanks,
  -lakshmi
