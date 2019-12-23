From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 23 Dec 2019 16:02:46 +0000
Subject: Re: [PATCH v1] IMA: Defined timer to free queued keys
Message-Id: <1577116966.5241.116.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191223032454.2797-1-nramas@linux.microsoft.com>
In-Reply-To: <20191223032454.2797-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Sun, 2019-12-22 at 19:24 -0800, Lakshmi Ramasubramanian wrote:
> keys queued for measurement should still be processed even if
> a custom IMA policy was not loaded. Otherwise, the keys will
> remain queued forever consuming kernel memory.
> 
> This patch defines a timer to handle the above scenario. The timer
> is setup to expire 5 minutes after IMA initialization is completed.
> 
> If a custom IMA policy is loaded before the timer expires, the timer
> is removed and any queued keys are processed for measurement.
> But if a custom policy was not loaded, on timer expiration
> any queued keys are just freed.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

This patch description, and the comments below, read as though the
queued keys are measured based on policy.  The queued keys should be
removed, not "processed".  Please rewrite this patch description and
update the comments below.

> ---
>  security/integrity/ima/ima.h                 |  2 +
>  security/integrity/ima/ima_asymmetric_keys.c | 46 ++++++++++++++++++--
>  security/integrity/ima/ima_init.c            |  8 +++-
>  3 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 97f8a4078483..c483215a9ee5 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -216,8 +216,10 @@ struct ima_key_entry {
>  	char *keyring_name;
>  };
>  void ima_process_queued_keys(void);
> +void ima_init_key_queue(void);
>  #else
>  static inline void ima_process_queued_keys(void) {}
> +static inline void ima_init_key_queue(void) {}
>  #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
>  
>  /* LIM API function definitions */
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 4124f10ff0c2..e1c4e1e7d9a1 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -11,6 +11,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/timer.h>
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> @@ -26,6 +27,34 @@ static bool ima_process_keys;
>  static DEFINE_MUTEX(ima_keys_mutex);
>  static LIST_HEAD(ima_keys);
>  
> +/*
> + * If custom IMA policy is not loaded then keys queued up
> + * for measurement should be freed. This timer is used
> + * for handling this scenario.
> + */
> +static long ima_key_queue_timeout = 300000; /* 5 Minutes */
> +static struct timer_list ima_key_queue_timer;
> +
> +/*
> + * This timer callback function processes keys that may still be
> + * queued up in case custom IMA policy was not loaded.
> + */

"processes keys" implies measuring keys based on policy.  Please
update this and the comment below.

> +static void ima_timer_handler(struct timer_list *timer)
> +{
> +	ima_process_queued_keys();
> +}
> +
> +/*
> + * This function sets up a timer to process queued keys in case
> + * custom IMA policy was never loaded.
> + */
> +void ima_init_key_queue(void)
> +{
> +	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
> +	mod_timer(&ima_key_queue_timer,
> +		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
> +}
> +
>  static void ima_free_key_entry(struct ima_key_entry *entry)
>  {
>  	if (entry) {
> @@ -100,6 +129,7 @@ void ima_process_queued_keys(void)
>  {
>  	struct ima_key_entry *entry, *tmp;
>  	bool process = false;
> +	int timer_removed;
>  
>  	if (ima_process_keys)
>  		return;
> @@ -120,10 +150,20 @@ void ima_process_queued_keys(void)
>  	if (!process)
>  		return;
>  
> +	/*
> +	 * Timer is no longer needed. If the timer was removed
> +	 * (i.e., the timer had not expired) the queued keys are
> +	 * processed for measurement. Else, the keys are just freed.
> +	 */
> +	timer_removed = del_timer(&ima_key_queue_timer);

Interesting, but wouldn't it be simpler to define a static variable
named timer_expired and set it in ima_timer_handler()?  With that
change, the code would be easier to read and this comment would be
superfluous.

Mimi

> +
>  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> -		process_buffer_measurement(entry->payload, entry->payload_len,
> -					   entry->keyring_name, KEY_CHECK, 0,
> -					   entry->keyring_name);
> +		if (timer_removed)
> +			process_buffer_measurement(entry->payload,
> +						   entry->payload_len,
> +						   entry->keyring_name,
> +						   KEY_CHECK, 0,
> +						   entry->keyring_name);
>  		list_del(&entry->list);
>  		ima_free_key_entry(entry);
>  	}
