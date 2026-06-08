Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DE282F09;
	Mon,  8 Jun 2026 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887983; cv=none; b=fknnrlpNN0C0u2gLXJAD4DIW7Pzqjv0etGY/TrneG2CmhVN+T+86vo/s7UO9aKG2bqmId0EyzO0hYeXPrDnvczt8r4M1xl5pWQLBZLOuge5djIyxGDjXZo8LssIBSEm2N5nkauXd93vEST7qqwLIOvJdb0x/5pQeNHx/J6PlMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887983; c=relaxed/simple;
	bh=OPemLf/Cp+gPaBEDcGVjjv8y09tB2RMi2EllBfW+SMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QioZwvP9EuIfq3e0vWTOWiY1gTINXlOSkYHMSaW5+BOo38aOTwRv76vTRRf0aeJZkfES6RVO9ZU9HmJGACzI8IFAMW1F/ecHaaJP+T650s3V6u+VejHJwS0O5YvCK8bJX+HIBHNARETwKdiDgs8L2TSelUYpEUFmqB02PzzDx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZTmZC9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZTmZC9B"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 75C231F00893;
	Mon,  8 Jun 2026 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780887981;
	bh=BgehQ2hxI799VtQ6jFnldS7TjxvN8d0UDYYkiNF9vRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iZTmZC9BjJ5WWRBe1qAmI9zp9Jkeqs/kvpD82nkxpXsbZJRA+mHsSW5tH5BjZah6+
	 JFa2VY9kJDdW6rZvzGRTH4vj39PsYKYxG273Lbg/MaJ1Tw0DBPoJdsGN/CPmsOsxR4
	 VyQDIGMK9OmPAn3Cf4Q4e7rXxy9acKXvgGKVULnWkNuoYqi5OgsIAuWWe5MtpRrz9k
	 bWMiVFGru5DCX0wvaCZZW9Sv3bUkHLZSgR8eLkZ8Zp4Cgma7zEmrDS/QF5ehni03xp
	 L/po+dNUuB+oWXWIBC48NC1NqkCQjL1GW0h6qKhv7LtLxUaQJOsQiSQBXdfIVLTqaH
	 8Rp+hZI+ZNc4w==
Date: Mon, 8 Jun 2026 06:06:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <aiYxqTyfHwrDOTCs@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526024838.3368409-1-eeesssooo020@gmail.com>

On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> keyctl_instantiate_key_common() reads request_key_auth from the assumed
> auth key before copying an instantiation payload from userspace.  The copy
> can fault and sleep.  If the request completes and revokes the auth key in
> that window, the auth payload can be detached and freed before the
> instantiate path uses it again.
> 
> A request-key helper reproducer can trigger this race.  One helper child
> blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> requested key and returns.  KASAN then reports a use-after-free from the
> stale request_key_auth payload in keyctl_instantiate_key_common().
> 
> Give request_key_auth payloads a refcount.  Take a payload reference while

Please, name concrete things accurately. I.e. 'usage' in this case. If
you have a name, use it instead of obfuscating generalizations.

> authkey->sem stabilizes the payload and revocation state.  Hold that
> reference across the instantiate and reject paths.  Drop the auth key
> owning reference from revoke and destroy.
> 
> Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> ---
>  include/keys/request_key_auth-type.h |  2 ++
>  security/keys/internal.h             |  2 ++
>  security/keys/keyctl.c               | 24 +++++++++++++++-----
>  security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
>  4 files changed, 53 insertions(+), 8 deletions(-)

So first, couple of things.

I'm not going to test not that well documented involving OOT driver.

That does necessarily mean same as NAK but we need much more clarity
here. 

You should start off not mentioning 'reproducer'. If it does not
exist in public, it does not exist. It's not good for anything
here.

Then, put a concurrency scenario with A/B sidecars.

Some comments below.

> 
> diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
> index 36b89a933310..01e42ee5f409 100644
> --- a/include/keys/request_key_auth-type.h
> +++ b/include/keys/request_key_auth-type.h
> @@ -9,12 +9,14 @@
>  #define _KEYS_REQUEST_KEY_AUTH_TYPE_H
>  
>  #include <linux/key.h>
> +#include <linux/refcount.h>

BTW, did you test compilation w/o adding this? Just potential
low-hanging fruit diff to remove.

>  
>  /*
>   * Authorisation record for request_key().
>   */
>  struct request_key_auth {
>  	struct rcu_head		rcu;
> +	refcount_t		usage;
>  	struct key		*target_key;
>  	struct key		*dest_keyring;
>  	const struct cred	*cred;
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 2cffa6dc8255..b7b622bc36a1 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -208,6 +208,8 @@ extern struct key *request_key_auth_new(struct key *target,
>  					const void *callout_info,
>  					size_t callout_len,
>  					struct key *dest_keyring);
> +struct request_key_auth *request_key_auth_get(struct key *authkey);
> +void request_key_auth_put(struct request_key_auth *rka);
>  
>  extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
>  
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index ef855d69c97a..d14ace88e529 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1197,9 +1197,13 @@ static long keyctl_instantiate_key_common(key_serial_t id,
>  	if (!instkey)
>  		goto error;
>  
> -	rka = instkey->payload.data[0];
> -	if (rka->target_key->serial != id)
> +	rka = request_key_auth_get(instkey);
> +	if (!rka) {
> +		ret = -EKEYREVOKED;
>  		goto error;
> +	}
> +	if (rka->target_key->serial != id)
> +		goto error_put_rka;

This label should not be introduced and generally please do everything
not add extra fat to diff. This is already fat for a claiming to be
bug fix.

>  
>  	/* pull the payload in if one was supplied */
>  	payload = NULL;
> @@ -1208,7 +1212,7 @@ static long keyctl_instantiate_key_common(key_serial_t id,
>  		ret = -ENOMEM;
>  		payload = kvmalloc(plen, GFP_KERNEL);
>  		if (!payload)
> -			goto error;
> +			goto error_put_rka;
>  
>  		ret = -EFAULT;
>  		if (!copy_from_iter_full(payload, plen, from))
> @@ -1234,6 +1238,8 @@ static long keyctl_instantiate_key_common(key_serial_t id,
>  
>  error2:
>  	kvfree_sensitive(payload, plen);
> +error_put_rka:
> +	request_key_auth_put(rka);
>  error:
>  	return ret;
>  }
> @@ -1358,15 +1364,19 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
>  	if (!instkey)
>  		goto error;
>  
> -	rka = instkey->payload.data[0];
> -	if (rka->target_key->serial != id)
> +	rka = request_key_auth_get(instkey);
> +	if (!rka) {
> +		ret = -EKEYREVOKED;
>  		goto error;
> +	}
> +	if (rka->target_key->serial != id)
> +		goto error_put_rka;
>  
>  	/* find the destination keyring if present (which must also be
>  	 * writable) */
>  	ret = get_instantiation_keyring(ringid, rka, &dest_keyring);
>  	if (ret < 0)
> -		goto error;
> +		goto error_put_rka;
>  
>  	/* instantiate the key and link it into a keyring */
>  	ret = key_reject_and_link(rka->target_key, timeout, error,
> @@ -1379,6 +1389,8 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
>  	if (ret == 0)
>  		keyctl_change_reqkey_auth(NULL);
>  
> +error_put_rka:
> +	request_key_auth_put(rka);
>  error:
>  	return ret;
>  }
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> index a7d7538c1f70..282e09d8fa46 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -23,6 +23,7 @@ static void request_key_auth_describe(const struct key *, struct seq_file *);
>  static void request_key_auth_revoke(struct key *);
>  static void request_key_auth_destroy(struct key *);
>  static long request_key_auth_read(const struct key *, char *, size_t);
> +static void request_key_auth_rcu_disposal(struct rcu_head *);
>  
>  /*
>   * The request-key authorisation key type definition.
> @@ -115,6 +116,31 @@ static void free_request_key_auth(struct request_key_auth *rka)
>  	kfree(rka);
>  }
>  
> +/*
> + * Take a reference to the request-key authorisation payload so callers can
> + * drop authkey->sem before doing operations that may sleep.
> + */
> +struct request_key_auth *request_key_auth_get(struct key *authkey)
> +{
> +	struct request_key_auth *rka;
> +
> +	down_read(&authkey->sem);
> +	rka = dereference_key_locked(authkey);
> +	if (rka && !test_bit(KEY_FLAG_REVOKED, &authkey->flags))
> +		refcount_inc(&rka->usage);
> +	else
> +		rka = NULL;
> +	up_read(&authkey->sem);
> +
> +	return rka;
> +}

Instead add fast-path return here. Then request_key_auth can be called
called in keyctl_instantiate_key_common and all that extra cruft in
this patch won't be needed.

> +
> +void request_key_auth_put(struct request_key_auth *rka)
> +{
> +	if (rka && refcount_dec_and_test(&rka->usage))
> +		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
> +}
> +
>  /*
>   * Dispose of the request_key_auth record under RCU conditions
>   */
> @@ -136,8 +162,10 @@ static void request_key_auth_revoke(struct key *key)
>  	struct request_key_auth *rka = dereference_key_locked(key);
>  
>  	kenter("{%d}", key->serial);
> +	if (!rka)
> +		return;
>  	rcu_assign_keypointer(key, NULL);
> -	call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
> +	request_key_auth_put(rka);
>  }
>  
>  /*
> @@ -150,7 +178,7 @@ static void request_key_auth_destroy(struct key *key)
>  	kenter("{%d}", key->serial);
>  	if (rka) {
>  		rcu_assign_keypointer(key, NULL);
> -		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
> +		request_key_auth_put(rka);
>  	}
>  }
>  
> @@ -174,6 +202,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
>  	rka = kzalloc_obj(*rka);
>  	if (!rka)
>  		goto error;
> +	refcount_set(&rka->usage, 1);
>  	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
>  	if (!rka->callout_info)
>  		goto error_free_rka;
> -- 
> 2.47.3

Looking forward for v2. These requests are for being able to make
reasonable review for the actual logical change. Now there's
that and "decorations".

Thanks!

BR, Jarkko
