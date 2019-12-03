From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 03 Dec 2019 00:02:07 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <1575331327.4793.469.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
In-Reply-To: <20191127025212.3077-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi Lakshmi,

On Tue, 2019-11-26 at 18:52 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system before IMA is initialized
> should be queued up. And, keys (including any queued ones)
> should be processed when IMA initialization is completed.
> 
> This patch defines functions to queue and dequeue keys for
> measurement. A flag namely ima_process_keys_for_measurement
> is used to check if the key should be queued or should be
> processed immediately.
> 
> ima_policy_flag cannot be relied upon to make queuing decision
> because ima_policy_flag will be set to 0 when either IMA is
> not initialized or when the IMA policy itself is empty.

Already commented on the patch description.  Some additional minor
comments below.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  15 +++
>  security/integrity/ima/ima_asymmetric_keys.c | 135 ++++++++++++++++++-
>  2 files changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f06238e41a7c..f86371647707 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -205,6 +205,21 @@ extern const char *const func_tokens[];
>  
>  struct modsig;
>  
> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +/*
> + * To track keys that need to be measured.
> + */
> +struct ima_measure_key_entry {
> +	struct list_head list;
> +	void *payload;
> +	size_t payload_len;
> +	char *keyring_name;
> +};
> +void ima_process_queued_keys_for_measurement(void);
> +#else
> +static inline void ima_process_queued_keys_for_measurement(void) {}
> +#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> +
>  /* LIM API function definitions */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
>  		   int mask, enum ima_hooks func, int *pcr,
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index ca895f9a6504..10deb77b22a0 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -14,12 +14,139 @@
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> +/*
> + * Flag to indicate whether a key can be processed
> + * right away or should be queued for processing later.
> + */
> +bool ima_process_keys_for_measurement;
> +
> +/*
> + * To synchronize access to the list of keys that need to be measured
> + */
> +static DEFINE_MUTEX(ima_measure_keys_mutex);
> +static LIST_HEAD(ima_measure_keys);
> +
> +static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
> +{
> +	if (entry) {
> +		kfree(entry->payload);
> +		kfree(entry->keyring_name);
> +		kfree(entry);
> +	}
> +}
> +
> +static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
> +	struct key *keyring,
> +	const void *payload, size_t payload_len)
> +{
> +	int rc = 0;
> +	struct ima_measure_key_entry *entry = NULL;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (entry) {
> +		entry->payload > +			kmemdup(payload, payload_len, GFP_KERNEL);
> +		entry->keyring_name > +			kstrdup(keyring->description, GFP_KERNEL);

No need to break up the assignments like this.  Neither line when
joined is greater than 80 bytes.

> +		entry->payload_len = payload_len;
> +	}
> +
> +	if ((entry = NULL) || (entry->payload = NULL) ||
> +	    (entry->keyring_name = NULL)) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&entry->list);
> +	rc = 0;

"rc" was initialized in the declaration.

> +
> +out:
> +	if (rc) {
> +		ima_free_measure_key_entry(entry);
> +		entry = NULL;
> +	}
> +
> +	return entry;
> +}
> +
> +bool ima_queue_key_for_measurement(struct key *keyring,
> +				   const void *payload, size_t payload_len)
> +{
> +	bool queued = false;
> +	struct ima_measure_key_entry *entry = NULL;

No need to initialize ima_measure_key_entry here, as the first
statement sets it.
> +
> +	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
> +	if (entry) {

If we're ignoring failure to allocate memory, why not just return?

> +		/*
> +		 * ima_measure_keys_mutex should be taken before checking
> +		 * ima_process_keys_for_measurement flag to avoid the race
> +		 * condition between the IMA hook checking this flag and
> +		 * calling ima_queue_key_for_measurement() to queue
> +		 * the key and ima_process_queued_keys_for_measurement()
> +		 * setting this flag.
> +		 */
> +		mutex_lock(&ima_measure_keys_mutex);
> +		if (!ima_process_keys_for_measurement) {
> +			list_add_tail(&entry->list, &ima_measure_keys);
> +			queued = true;
> +		}
> +		mutex_unlock(&ima_measure_keys_mutex);
> +
> +		if (!queued)
> +			ima_free_measure_key_entry(entry);
> +	}
> +
> +	return queued;
> +}
> +
> +void ima_process_queued_keys_for_measurement(void)
> +{
> +	struct ima_measure_key_entry *entry, *tmp;
> +	LIST_HEAD(temp_ima_measure_keys);
> +
> +	if (ima_process_keys_for_measurement)
> +		return;
> +
> +	/*
> +	 * Any queued keys will be processed now. From here on
> +	 * keys should be processed right away.
> +	 */
> +	ima_process_keys_for_measurement = true;
> +
> +	/*
> +	 * To avoid holding the mutex when processing queued keys,
> +	 * transfer the queued keys with the mutex held to a temp list,
> +	 * release the mutex, and then process the queued keys from
> +	 * the temp list.
> +	 *
> +	 * Since ima_process_keys_for_measurement is set to true above,
> +	 * any new key will be processed immediately and not be queued.
> +	 */
> +	INIT_LIST_HEAD(&temp_ima_measure_keys);
> +	mutex_lock(&ima_measure_keys_mutex);
> +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
> +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> +	}

Parenthesis not needed.

> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp,
> +				 &temp_ima_measure_keys, list) {

No need to break up this line either.  The joined line is not greater
than 80 bytes.

> +		process_buffer_measurement(entry->payload,
> +					   entry->payload_len,
> +					   entry->keyring_name,
> +					   KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_measure_key_entry(entry);
> +	}
> +}
> +
