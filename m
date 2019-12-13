From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 13 Dec 2019 17:25:55 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <1576257955.8504.20.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
In-Reply-To: <20191213171827.28657-3-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Fri, 2019-12-13 at 09:18 -0800, Lakshmi Ramasubramanian wrote:
[...]
> @@ -165,6 +167,12 @@ void ima_post_key_create_or_update(struct key
> *keyring, struct key *key,
>  	if (!payload || (payload_len = 0))
>  		return;
>  
> +	if (!ima_process_keys)
> +		queued = ima_queue_key(keyring, payload,
> payload_len);
> +
> +	if (queued)
> +		return;
> +
>  	/*
>  	 * keyring->description points to the name of the keyring
>  	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c
> index a4dde9d575b2..04b9c6c555de 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -807,6 +807,9 @@ void ima_update_policy(void)
>  		kfree(arch_policy_entry);
>  	}
>  	ima_update_policy_flag();
> +
> +	/* Custom IMA policy has been loaded */
> +	ima_process_queued_keys();
>  }

There's no locking around the ima_process_keys flag.  If you get two
policy updates in quick succession can't this flag change as you're
processing the second update meaning you lose it because the flag was
false when you decided to build it for the queue but becomes true
before you check above whether you need to queue it?

Note you don't need locking to fix this, you just need to ensure that
you use the same copy of the flag value for both tests.

James
