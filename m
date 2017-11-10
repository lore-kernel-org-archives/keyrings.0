From: Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 10 Nov 2017 20:52:31 +0000
Subject: Re: [PATCH 1/2] KEYS: trusted: Use common error handling code in trusted_update()
Message-Id: <alpine.DEB.2.20.1711102142220.2708@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net> <658d88c1-b29b-cf8c-2ce0-8a2755ec9f33@users.sourceforge.net>
In-Reply-To: <658d88c1-b29b-cf8c-2ce0-8a2755ec9f33@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, James Morris <james.l.morris@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org



On Fri, 10 Nov 2017, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 10 Nov 2017 20:50:15 +0100
>
> Adjust jump targets so that a bit of exception handling can be better
> reused at the end of this function.

Unless there is a strong motivation for doing otherwise, the goal should
be to make the code understandable and safe.  Understandable means that
issues specific to the error that occurred should be up at the place where
the error occurs, ie any prints or any setting of return code.  Safe means
that cleanup code should appear once in a cascade at the end of the
function, to minimize the chance that anything will be overlooked.

Moving the ret assignments to the end of the function and adding the
backward jumps doesn't make the code more understandable.  A lot of mental
effort is required to strace through the spaghetti code to find out what
exactly will be the impact of a given failure.

On the other hand, moving the kzalloc of new_p to the end of the function
could be helpful, because it reduces the chance that new error handling
code, if any turns out to be needed, will forget this operation.

By why not just follow standard practice and free the structures in a
cascade in the inverse of the order in which they are allocated at the end
of the function?  There can be a descriptive label for each thing that
needs to be freed.

julia

>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/keys/trusted.c | 44 ++++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index bd85315cbfeb..fd06d0c5323b 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -1078,30 +1078,18 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>  	if (!datablob)
>  		return -ENOMEM;
>  	new_o = trusted_options_alloc();
> -	if (!new_o) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!new_o)
> +		goto e_nomem;
> +
>  	new_p = trusted_payload_alloc(key);
> -	if (!new_p) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!new_p)
> +		goto e_nomem;
>
>  	memcpy(datablob, prep->data, datalen);
>  	datablob[datalen] = '\0';
>  	ret = datablob_parse(datablob, new_p, new_o);
> -	if (ret != Opt_update) {
> -		ret = -EINVAL;
> -		kzfree(new_p);
> -		goto out;
> -	}
> -
> -	if (!new_o->keyhandle) {
> -		ret = -EINVAL;
> -		kzfree(new_p);
> -		goto out;
> -	}
> +	if (ret != Opt_update || !new_o->keyhandle)
> +		goto e_inval;
>
>  	/* copy old key values, and reseal with new pcrs */
>  	new_p->migratable = p->migratable;
> @@ -1113,23 +1101,31 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>  	ret = key_seal(new_p, new_o);
>  	if (ret < 0) {
>  		pr_info("trusted_key: key_seal failed (%d)\n", ret);
> -		kzfree(new_p);
> -		goto out;
> +		goto free_payload;
>  	}
>  	if (new_o->pcrlock) {
>  		ret = pcrlock(new_o->pcrlock);
>  		if (ret < 0) {
>  			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
> -			kzfree(new_p);
> -			goto out;
> +			goto free_payload;
>  		}
>  	}
>  	rcu_assign_keypointer(key, new_p);
>  	call_rcu(&p->rcu, trusted_rcu_free);
> -out:
> +free_data:
>  	kzfree(datablob);
>  	kzfree(new_o);
>  	return ret;
> +
> +e_nomem:
> +	ret = -ENOMEM;
> +	goto free_data;
> +
> +e_inval:
> +	ret = -EINVAL;
> +free_payload:
> +	kzfree(new_p);
> +	goto free_data;
>  }
>
>  /*
> --
> 2.15.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
