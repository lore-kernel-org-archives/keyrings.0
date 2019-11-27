From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 27 Nov 2019 20:38:57 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <1574887137.4793.346.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
In-Reply-To: <20191127025212.3077-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>

Hi Lakshmi,

Janne Karhunen is defining an IMA workqueue in order to more
frequently update the on disk security xattrs.  The Subject line on
this patch needs to be more explicit (eg. define workqueue for early
boot "key" measurements).

On Tue, 2019-11-26 at 18:52 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system before IMA is initialized

Keys created or updated before a custom policy is loaded are currently
not measured.

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

I'm not sure why you want to differentiate between IMA being
initialized vs. an empty policy.  I would think you would want to know
when a custom policy has been loaded.

Until ima_update_policy() is called, "ima_rules" points to the
architecture specific and configured policy rules, which are
persistent, and the builtin policy rules.  Once a custom policy is
loaded, "ima_rules" points to the architecture specific, configured,
and custom policy rules.

I would define a function that determines whether or not a custom
policy has been loaded.

(I still need to review adding/removing from the queue.)

> 
> @@ -27,14 +154,14 @@
>   * The payload data used to instantiate or update the key is measured.
>   */
>  void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> -				   const void *payload, size_t plen,
> +				   const void *payload, size_t payload_len,
>  				   unsigned long flags, bool create)

This "hunk" and subsequent one seem to be just a variable name change.
 It has nothing to do with queueing "key" measurements and shouldn't
be included in this patch.

Mimi

>  {
>  	/* Only asymmetric keys are handled by this hook. */
>  	if (key->type != &key_type_asymmetric)
>  		return;
>  
> -	if (!payload || (plen = 0))
> +	if (!payload || (payload_len = 0))
>  		return;
>  
>  	/*
> @@ -52,7 +179,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	 * if the IMA policy is configured to measure a key linked
>  	 * to the given keyring.
>  	 */
> -	process_buffer_measurement(payload, plen,
> +	process_buffer_measurement(payload, payload_len,
>  				   keyring->description, KEY_CHECK, 0,
>  				   keyring->description);
>  }
