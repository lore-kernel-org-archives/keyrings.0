From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 13 Dec 2019 01:55:34 +0000
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576202134.4579.189.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
         <20191213004250.21132-2-nramas@linux.microsoft.com>
In-Reply-To: <20191213004250.21132-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

> +/*
> + * ima_process_queued_keys() - process keys queued for measurement
> + *
> + * This function sets ima_process_keys to true and processes queued keys.
> + * From here on keys will be processed right away (not queued).
> + */
> +void ima_process_queued_keys(void)
> +{
> +	struct ima_key_entry *entry, *tmp;
> +	LIST_HEAD(temp_ima_keys);
> +
> +	if (ima_process_keys)
> +		return;
> +
> +	/*
> +	 * To avoid holding the mutex when processing queued keys,
> +	 * transfer the queued keys with the mutex held to a temp list,
> +	 * release the mutex, and then process the queued keys from
> +	 * the temp list.
> +	 *
> +	 * Since ima_process_keys is set to true, any new key will be
> +	 * processed immediately and not be queued.
> +	 */
> +	INIT_LIST_HEAD(&temp_ima_keys);
> +
> +	mutex_lock(&ima_keys_mutex);

Don't you need a test here, before setting ima_process_keys?

	if (ima_process_keys)
		return;

Mimi

> +
> +	ima_process_keys = true;
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> +		list_move_tail(&entry->list, &temp_ima_keys);
> +
> +	mutex_unlock(&ima_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &temp_ima_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_key_entry(entry);
> +	}
> +}
> +
> 
