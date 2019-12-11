From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 11 Dec 2019 01:40:07 +0000
Subject: Re: [PATCH v1 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576028407.4579.77.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
         <20191206012936.2814-2-nramas@linux.microsoft.com>
In-Reply-To: <20191206012936.2814-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2019-12-05 at 17:29 -0800, Lakshmi Ramasubramanian wrote:
> Measuring keys requires a custom IMA policy to be loaded.
> Keys created or updated before a custom IMA policy is loaded should
> be queued and the keys should be processed after a custom policy
> is loaded.
> 
> This patch defines workqueue for queuing keys when a custom IMA policy
> has not yet been loaded.
> 
> A flag namely ima_process_keys_for_measurement is used to check
> if the key should be queued or should be processed immediately.
> This flag is set to true when queued keys are processed.
> If this flag is set to true, keys created or updated
> will be measured immediately (not queued).

These last two lines explain how "flags" work.  They're unnecessary.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  15 +++
>  security/integrity/ima/ima_asymmetric_keys.c | 125 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
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
> index fea2e7dd3b09..fbdbe9c261cb 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -14,6 +14,131 @@
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
> +	struct ima_measure_key_entry *entry;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (entry) {
> +		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
> +		entry->keyring_name = kstrdup(keyring->description,
> +					      GFP_KERNEL);
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
> +	struct ima_measure_key_entry *entry;
> +
> +	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
> +	if (!entry)
> +		return false;
> +
> +	/*
> +	 * ima_measure_keys_mutex should be taken before checking
> +	 * ima_process_keys_for_measurement flag to avoid the race
> +	 * condition between the IMA hook checking this flag and
> +	 * calling ima_queue_key_for_measurement() to queue
> +	 * the key and ima_process_queued_keys_for_measurement()
> +	 * setting this flag.
> +	 */
> +	mutex_lock(&ima_measure_keys_mutex);
> +	if (!ima_process_keys_for_measurement) {
> +		list_add_tail(&entry->list, &ima_measure_keys);
> +		queued = true;
> +	}
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	if (!queued)
> +		ima_free_measure_key_entry(entry);
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

This function and the ima_queue_key_for_measurement() are not
exported, so don't require kernel-doc style comments, but at least
this comment should not be here.  It could be included as part of the
function description at the head of the function.

Remember we don't add code comments needlessly.  Refer to section "8)
Commenting" in Documentation/process/coding-style.rst.

Mimi

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
> +
> +	mutex_lock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list)
> +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> +
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &temp_ima_measure_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_measure_key_entry(entry);
> +	}
> +}
> +
>  /**
>   * ima_post_key_create_or_update - measure asymmetric keys
>   * @keyring: keyring to which the key is linked to
