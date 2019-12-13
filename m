From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 13 Dec 2019 01:59:11 +0000
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
In-Reply-To: <1576202134.4579.189.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/12/19 5:55 PM, Mimi Zohar wrote:
>> +/*
>> + * ima_process_queued_keys() - process keys queued for measurement
>> + *
>> + * This function sets ima_process_keys to true and processes queued keys.
>> + * From here on keys will be processed right away (not queued).
>> + */
>> +void ima_process_queued_keys(void)
>> +{
>> +	struct ima_key_entry *entry, *tmp;
>> +	LIST_HEAD(temp_ima_keys);
>> +
>> +	if (ima_process_keys)
>> +		return;
>> +
>> +	/*
>> +	 * To avoid holding the mutex when processing queued keys,
>> +	 * transfer the queued keys with the mutex held to a temp list,
>> +	 * release the mutex, and then process the queued keys from
>> +	 * the temp list.
>> +	 *
>> +	 * Since ima_process_keys is set to true, any new key will be
>> +	 * processed immediately and not be queued.
>> +	 */
>> +	INIT_LIST_HEAD(&temp_ima_keys);
>> +
>> +	mutex_lock(&ima_keys_mutex);
> 
> Don't you need a test here, before setting ima_process_keys?
> 
> 	if (ima_process_keys)
> 		return;
> 
> Mimi

That check is done before the comment - at the start of 
ima_process_queued_keys().

+void ima_process_queued_keys(void)
+{
+	struct ima_key_entry *entry, *tmp;
+	LIST_HEAD(temp_ima_keys);
+
+	if (ima_process_keys)
+		return;

thanks,
  -lakshmi
