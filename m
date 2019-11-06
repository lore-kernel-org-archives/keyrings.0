From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 06 Nov 2019 22:44:41 +0000
Subject: Re: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue keys for measurement
Message-Id: <1573080281.5028.314.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-9-nramas@linux.microsoft.com>
In-Reply-To: <20191106190116.2578-9-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 11:01 -0800, Lakshmi Ramasubramanian wrote:

> +int ima_queue_or_process_key_for_measurement(struct key *keyring,
> +					     struct key *key)
> +{
> +	int rc = 0;
> +	struct ima_measure_key_entry *entry = NULL;
> +	const struct public_key *pk;
> +
> +	if (key->type != &key_type_asymmetric)
> +		return 0;
> +
> +	mutex_lock(&ima_measure_keys_mutex);

Unless the key is being queued, there's no reason to take the lock. 

> +
> +	if (ima_initialized) {

ima_initialized is being set in ima_init(), before a custom policy is
loaded.  I would think that is too early.  ima_update_policy() is
called after loading a custom policy.  Please see how to detect when a
custom policy is loaded.

> +		/*
> +		 * keyring->description points to the name of the keyring
> +		 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> +		 * which the given key is linked to.
> +		 *
> +		 * The name of the keyring is passed in the "eventname"
> +		 * parameter to process_buffer_measurement() and is set
> +		 * in the "eventname" field in ima_event_data for
> +		 * the key measurement IMA event.
> +		 *
> +		 * The name of the keyring is also passed in the "keyring"
> +		 * parameter to process_buffer_measurement() to check
> +		 * if the IMA policy is configured to measure a key linked
> +		 * to the given keyring.
> +		 */
> +		pk = key->payload.data[asym_crypto];
> +		process_buffer_measurement(pk->key, pk->keylen,
> +					   keyring->description,
> +					   KEYRING_CHECK, 0,
> +					   keyring->description);

Measuring the key should be done in ima_post_key_create_or_update()
unless, it is being deferred.  Please update the function name to
reflect this.

Mimi


> +	} else {
> +		entry = ima_alloc_measure_key_entry(keyring, key);
> +		if (entry != NULL) {
> +			INIT_LIST_HEAD(&entry->list);
> +			list_add_tail(&entry->list, &ima_measure_keys);
> +		} else
> +			rc = -ENOMEM;
> +	}
> +
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	return rc;
> +}
