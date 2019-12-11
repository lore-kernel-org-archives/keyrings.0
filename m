From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 11 Dec 2019 13:04:02 +0000
Subject: Re: [PATCH v1 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576069442.4579.131.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
         <20191206012936.2814-2-nramas@linux.microsoft.com>
         <1576028407.4579.77.camel@linux.ibm.com>
In-Reply-To: <1576028407.4579.77.camel@linux.ibm.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Tue, 2019-12-10 at 20:40 -0500, Mimi Zohar wrote:
> > +void ima_process_queued_keys_for_measurement(void)
> > +{
> > +	struct ima_measure_key_entry *entry, *tmp;
> > +	LIST_HEAD(temp_ima_measure_keys);
> > +
> > +	if (ima_process_keys_for_measurement)
> > +		return;
> > +
> > +	/*
> > +	 * Any queued keys will be processed now. From here on
> > +	 * keys should be processed right away.
> > +	 */
> > +	ima_process_keys_for_measurement = true;
> 
> This function and the ima_queue_key_for_measurement() are not
> exported, so don't require kernel-doc style comments, but at least
> this comment should not be here.  It could be included as part of the
> function description at the head of the function.

Sorry, one more comment.  Appending "_for_measurement" or inserting
"_measure_" makes these function names unnecessarily long.  This
information can be included in the function descriptions.

Mimi


> 
> Remember we don't add code comments needlessly.  Refer to section "8)
> Commenting" in Documentation/process/coding-style.rst.
> 
> > +
> > +	/*
> > +	 * To avoid holding the mutex when processing queued keys,
> > +	 * transfer the queued keys with the mutex held to a temp list,
> > +	 * release the mutex, and then process the queued keys from
> > +	 * the temp list.
> > +	 *
> > +	 * Since ima_process_keys_for_measurement is set to true above,
> > +	 * any new key will be processed immediately and not be queued.
> > +	 */
> > +	INIT_LIST_HEAD(&temp_ima_measure_keys);
> > +
> > +	mutex_lock(&ima_measure_keys_mutex);
> > +
> > +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list)
> > +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> > +
> > +	mutex_unlock(&ima_measure_keys_mutex);
> > +
> > +	list_for_each_entry_safe(entry, tmp, &temp_ima_measure_keys, list) {
> > +		process_buffer_measurement(entry->payload, entry->payload_len,
> > +					   entry->keyring_name, KEY_CHECK, 0,
> > +					   entry->keyring_name);
> > +		list_del(&entry->list);
> > +		ima_free_measure_key_entry(entry);
> > +	}
> > +}
> > +
> >  /**
> >   * ima_post_key_create_or_update - measure asymmetric keys
> >   * @keyring: keyring to which the key is linked to
> 
