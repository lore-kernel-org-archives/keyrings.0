From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 19 Dec 2019 13:11:44 +0000
Subject: Re: [PATCH v5 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576761104.4579.426.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
         <20191218164434.2877-2-nramas@linux.microsoft.com>
In-Reply-To: <20191218164434.2877-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-12-18 at 08:44 -0800, Lakshmi Ramasubramanian wrote:
> +/*
> + * ima_process_queued_keys() - process keys queued for measurement
> + *
> + * This function sets ima_process_keys to true and processes queued keys.
> + * From here on keys will be processed right away (not queued).
> + */
> +void ima_process_queued_keys(void)
> +{
> +	struct ima_key_entry *entry, *tmp;
> +	bool process = false;
> +
> +	if (ima_process_keys)
> +		return;
> +
> +	/*
> +	 * Since ima_process_keys is set to true, any new key will be
> +	 * processed immediately and not be queued to ima_keys list.
> +	 * First one setting the ima_process_keys flag to true will
> +	 * process the queued keys.
> +	 */
> +	mutex_lock(&ima_keys_mutex);
> +	if (!ima_process_keys) {
> +		ima_process_keys = true;
> +		process = true;
> +	}
> +	mutex_unlock(&ima_keys_mutex);
> +
> +	if (!process)
> +		return;
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_key_entry(entry);
> +	}
> +}
> +

Getting rid of the temporary list is definitely a big improvement.  As
James suggested, using test_and_set_bit() and test_bit() would improve
this code even more.  I think, James correct me if I'm wrong, you
would be able to get rid of both the mutex and "process".

Mimi


>  /**
>   * ima_post_key_create_or_update - measure asymmetric keys
>   * @keyring: keyring to which the key is linked to
