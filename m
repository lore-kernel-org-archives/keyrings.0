From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 14 Nov 2019 14:37:17 +0000
Subject: Re: [PATCH v7 4/5] IMA: Add support to limit measuring keys
Message-Id: <1573742237.4793.30.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-5-nramas@linux.microsoft.com>
In-Reply-To: <20191114031202.18012-5-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 19:12 -0800, Lakshmi Ramasubramanian wrote:
> +/**
> + * ima_match_keyring - determine whether the keyring matches the measure rule
> + * @rule: a pointer to a rule
> + * @keyring: name of the keyring to match against the measure rule
> + *
> + * If the measure action for KEY_CHECK does not specify keyrings> + * option then return true (Measure all keys).
> + * Else, return true if the given keyring name is present in
> + * the keyrings= option. False, otherwise.
> + */
> +static bool ima_match_keyring(struct ima_rule_entry *rule,
> +			      const char *keyring)
> +{
> +	if ((keyring = NULL) || (rule->keyrings = NULL)
> +		return true;

If the policy requires matching a specific keyring, then the "keyring"
needs to match.  The logic, here, isn't quite right.

> +	else
> +		return (strstr(rule->keyrings, keyring) != NULL);

    if (rule->keyrings) {
            if (!keyring)
                    return false;
		
            return (strstr(rule->keyrings, keyring) != NULL);
    }

    return true;

Keyrings may be created by userspace with any name (e.g. foo, foobar,
...).  A keyring name might be a subset of another keyring name.  For
example, with the policy "keyrings=foobar", keys being loaded on "foo"
would also be measured.  Using strstr() will not achieve what is
needed.

Mimi


> +}
> +
>  /**
>   * ima_match_rules - determine whether an inode matches the measure rule.
>   * @rule: a pointer to a rule
> @@ -364,18 +384,23 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   * @secid: the secid of the task to be validated
>   * @func: LIM hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
> + * @keyring: keyring name to check in policy for KEY_CHECK func
>   *
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			    const struct cred *cred, u32 secid,
> -			    enum ima_hooks func, int mask)
> +			    enum ima_hooks func, int mask,
> +			    const char *keyring)
>  {
>  	int i;
>  
>  	if ((func = KEXEC_CMDLINE) || (func = KEY_CHECK)) {
> -		if ((rule->flags & IMA_FUNC) && (rule->func = func))
> +		if ((rule->flags & IMA_FUNC) && (rule->func = func)) {
> +			if (func = KEY_CHECK)
> +				return ima_match_keyring(rule, keyring);
>  			return true;
> +		}
>  		return false;
>  	}
>  	if ((rule->flags & IMA_FUNC) &&
