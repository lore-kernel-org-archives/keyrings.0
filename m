From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 10 Dec 2019 22:43:25 +0000
Subject: Re: [PATCH v10 5/6] IMA: Add support to limit measuring keys
Message-Id: <1576017805.4579.44.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-6-nramas@linux.microsoft.com>
In-Reply-To: <20191204224131.3384-6-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-12-04 at 14:41 -0800, Lakshmi Ramasubramanian wrote:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 1525a28fd705..5db990c8b02d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -356,6 +357,51 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  	return NOTIFY_OK;
>  }
>  
> +/**
> + * ima_match_keyring - determine whether the keyring matches the measure rule
> + * @rule: a pointer to a rule
> + * @keyring: name of the keyring to match against the measure rule
> + * @cred: a pointer to a credentials structure for user validation
> + *
> + * Returns true if keyring matches one in the rule, false otherwise.
> + */
> +static bool ima_match_keyring(struct ima_rule_entry *rule,
> +			      const char *keyring, const struct cred *cred)
> +{
> +	char *keyrings, *next_keyring, *keyrings_ptr;
> +	bool matched = false;
> +
> +	/* If "keyrings=" is not specified all keys are measured. */

With the addiitonal "uid" support this isn't necessarily true any
more.

Mimi

> +	if (!rule->keyrings)
> +		return true;
> +
> +	if (!keyring)
> +		return false;
> +
> +	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
> +		return false;
> +
> +	keyrings = kstrdup(rule->keyrings, GFP_KERNEL);
> +	if (!keyrings)
> +		return false;
> +
> +	/*
> +	 * "keyrings=" is specified in the policy in the format below:
> +	 * keyrings=.builtin_trusted_keys|.ima|.evm
> +	 */
> +	keyrings_ptr = keyrings;
> +	while ((next_keyring = strsep(&keyrings_ptr, "|")) != NULL) {
> +		if (!strcmp(next_keyring, keyring)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +
> +	kfree(keyrings);
> +
> +	return matched;
> +}
> +
