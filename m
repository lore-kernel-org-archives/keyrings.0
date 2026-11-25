Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627165;
	b=z2aInozAMHczVnKUP++fhbctVLVNYSY5AMbeD0qEgsXUCNQvyhehFfemO6UyeMbFD4ck
	 D+Y51owe2hPzkmg/3LuSs4n6Iv7wDzmxZUus63SlDlIUORTiIvl9KMdlwdzzhSqfNQliH
	 NAOqGMG1hNDWRe4aF3bZb3VvhQXCA3JuvavNuUs4/ZVYmiZZzhPoVzPk5AKJtBoAcfjqR
	 RCLJZJ7kh4Ba7bX3kZh/ZBZPLglQM5JusKo+WkYzwKOetFvojtPzrWwLsnkLIUYRkVRje
	 rVKnMT1DWQRI1Cu+MCBpMArj201SYPr2LjLUq/MvffUvDGv67ZDWhzXjSVL4nZA3ePA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zlUDtLSedtGVqw9aJT44i6qtvT7PvK8DE79lqMDex5I=;
	b=4dmDzzq/LU3XnwapslHzM7T75zM07hNLHjn0zCpkImZJMm9wT58VThkDnY4Jw4S5cUXd
	 /XkoXxjmmELobYIpetUv3k8Err/imCY4Qv7qqxyIHuhBzEGAwnN0Q3o87nlXk/3Cug8jT
	 AAbH3/Qc+zFnUVvw0NHVvaL7bJ3Qu938IUvzZjSnfM77sX4dyVWiPhRLz/XV71SuEfChJ
	 4SQuZuJxVL6DLKvRheLzaRm5Xgag2cuevkhJHtVSOoYvnex83RwbcK/eyPTxecpyEprjX
	 qtM18Qrh1+DN5bAm0Kxts2GXDJUGO4G4d7pRUU/zWkVRB5VKePE6I6wae+zHtSoPXKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mY2vPG6c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F1A84606A31E;
	Wed, 25 Nov 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mY2vPG6c
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A03911F000CA;
	Wed, 25 Nov 2026 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627164;
	bh=zlUDtLSedtGVqw9aJT44i6qtvT7PvK8DE79lqMDex5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mY2vPG6cNcQZRH4rhcFHA18JmcAtiNBnjCZT8VLygTsLVlMZdxX08/dKKCICB7hv0
	 R8xFabYiDqcsN+O4lHBLmHvQgrPW3tktJqHIi3eI7zgo0SODliFaJmqXMaK9TGzBDT
	 j3YBrxmxYzaM+V4nzatSZ2zCgV4ftIwDyKhK3n3LGsqUd1dW8kFeL7qSFJrvQ0g4L9
	 i6TDaRWPJagM+A07gCFstmKbcYTSonQW6F7CUlle0psrT9GL3uL/zfxXGgm/nBKSIB
	 nrGVO+z9xpJlzUBroTzItfiHGWfVMP1Q5fNCIMRpKtPuiTPygDvtEenhjbwabIcmMU
	 /HTPb4Z4LKT1Q==
Date: Wed, 25 Nov 2026 19:19:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: Protect key instantiation and rejection against
 type removal
Message-ID: <awcYmOxzJ9TfsdjJ@kernel.org>
References: <20261124091243.1019217-1-maguicai@kylinos.cn>
 <20261125032605.1327954-1-maguicai@kylinos.cn>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125032605.1327954-1-maguicai@kylinos.cn>

On Tue, Nov 24, 2026 at 10:26:05PM -0500, Guicai Ma wrote:
> key_instantiate_and_link() and key_reject_and_link() access key->type
> and link keys without synchronizing against unregister_key_type(). If
> the type is removed while a key is under construction, GC retypes it to
> key_type_dead (where ->instantiate is NULL) or links a dead key before
> pass 3 rewrites key->type.
> 
> key->sem cannot be used here because it inverts lock order against
> encrypted_instantiate() and references a freed lockdep class after a
> modular type unloads, while callers may already hold key_types_sem and
> ->preparse() or ->instantiate() may sleep. Guard both paths with
> key_type_srcu and a KEY_FLAG_DEAD check, and wait for in-flight calls
> with synchronize_srcu(&key_type_srcu) at the end of GC pass 1.
> 
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
> ---
> v3:
> - Shorten the commit message and focus on why SRCU is used.
> - Change Fixes tag to 0c061b5707ab.
> - No code changes.
> 
> v2:
> - Switch from key->sem to key_type_srcu and check KEY_FLAG_DEAD in
>   key_instantiate_and_link() and key_reject_and_link().
> 
>  security/keys/gc.c       |  13 +++++
>  security/keys/internal.h |   2 +
>  security/keys/key.c      | 108 +++++++++++++++++++++++++++++----------
>  3 files changed, 95 insertions(+), 28 deletions(-)
> 
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d4..61cb2b9a7aaf 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -35,6 +35,8 @@ static unsigned long key_gc_flags;
>  #define KEY_GC_REAP_KEYTYPE	1	/* A keytype is being unregistered */
>  #define KEY_GC_REAPING_KEYTYPE	2	/* Cleared when keytype reaped */
>  
> +DEFINE_SRCU(key_type_srcu);
> +
>  
>  /*
>   * Any key whose type gets unregistered will be re-typed to this if it can't be
> @@ -286,6 +288,17 @@ static void key_garbage_collector(struct work_struct *work)
>  		key_schedule_gc(new_timer);
>  	}
>  
> +	if (unlikely((gc_state & KEY_GC_REAPING_DEAD_1) &&
> +		     (gc_state & KEY_GC_FOUND_DEAD_KEY))) {
> +		/* Wait for any in-flight key_instantiate_and_link() or
> +		 * key_reject_and_link() calls that did not observe
> +		 * KEY_FLAG_DEAD before pass 2 unlinks dead keys from keyrings
> +		 * and pass 3 retypes them to key_type_dead.
> +		 */
> +		kdebug("gc dead type sync");
> +		synchronize_srcu(&key_type_srcu);
> +	}
> +
>  	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
>  	    !list_empty(&graveyard)) {
>  		/* Make sure that all pending keyring payload destructions are
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index b7b622bc36a1..73d71de274c2 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -19,6 +19,7 @@
>  #include <linux/compat.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> +#include <linux/srcu.h>
>  
>  struct iovec;
>  
> @@ -86,6 +87,7 @@ extern struct kmem_cache *key_jar;
>  extern struct rb_root key_serial_tree;
>  extern spinlock_t key_serial_lock;
>  extern struct mutex key_construction_mutex;
> +extern struct srcu_struct key_type_srcu;
>  extern wait_queue_head_t request_key_conswq;
>  
>  extern void key_set_index_key(struct keyring_index_key *index_key);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 3f1f0fc13710..d923ddf457e9 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -422,9 +422,10 @@ static void mark_key_instantiated(struct key *key, int reject_error)
>  
>  /*
>   * Instantiate a key and link it into the target keyring atomically.  Must be
> - * called with the target keyring's semaphore writelocked.  The target key's
> - * semaphore need not be locked as instantiation is serialised by
> - * key_construction_mutex.
> + * called with the target keyring's semaphore writelocked.  The caller must
> + * hold key_type_srcu (after checking !KEY_FLAG_DEAD) or key_types_sem for
> + * reading via key_type_lookup(), so the type cannot be retyped to
> + * key_type_dead or its module unloaded while its methods run.
>   */
>  static int __key_instantiate_and_link(struct key *key,
>  				      struct key_preparsed_payload *prep,
> @@ -496,7 +497,9 @@ static int __key_instantiate_and_link(struct key *key,
>   *
>   * If successful, 0 is returned, the authorisation token is revoked and anyone
>   * waiting for the key is woken up.  If the key was already instantiated,
> - * -EBUSY will be returned.
> + * -EBUSY will be returned.  If the key's type has been removed, -EKEYREVOKED
> + * will be returned.  If the key type does not provide an instantiate method,
> + * -EOPNOTSUPP will be returned.
>   */
>  int key_instantiate_and_link(struct key *key,
>  			     const void *data,
> @@ -506,7 +509,28 @@ int key_instantiate_and_link(struct key *key,
>  {
>  	struct key_preparsed_payload prep;
>  	struct assoc_array_edit *edit = NULL;
> -	int ret;
> +	int ret, srcu_idx;
> +
> +	/*
> +	 * A reference on the key does not pin the module that provides its
> +	 * type.  Hold key_type_srcu across every use of key->type
> +	 * (def_datalen, preparse, restrict_link->check, instantiate and
> +	 * free_preparse) and across linking into @keyring.  Pass 1 of
> +	 * key_garbage_collector() sets KEY_FLAG_DEAD and waits for
> +	 * synchronize_srcu(&key_type_srcu) before pass 2 unlinks dead keys
> +	 * and pass 3 retypes them to key_type_dead.
> +	 */
> +	srcu_idx = srcu_read_lock(&key_type_srcu);
> +
> +	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
> +		ret = -EKEYREVOKED;
> +		goto out;
> +	}
> +
> +	if (!key->type->instantiate) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>  
>  	memset(&prep, 0, sizeof(prep));
>  	prep.orig_description = key->description;
> @@ -517,17 +541,17 @@ int key_instantiate_and_link(struct key *key,
>  	if (key->type->preparse) {
>  		ret = key->type->preparse(&prep);
>  		if (ret < 0)
> -			goto error;
> +			goto out_free_preparse;
>  	}
>  
>  	if (keyring) {
>  		ret = __key_link_lock(keyring, &key->index_key);
>  		if (ret < 0)
> -			goto error;
> +			goto out_free_preparse;
>  
>  		ret = __key_link_begin(keyring, &key->index_key, &edit);
>  		if (ret < 0)
> -			goto error_link_end;
> +			goto out_link_end;
>  
>  		if (keyring->restrict_link && keyring->restrict_link->check) {
>  			struct key_restriction *keyres = keyring->restrict_link;
> @@ -535,19 +559,22 @@ int key_instantiate_and_link(struct key *key,
>  			ret = keyres->check(keyring, key->type, &prep.payload,
>  					    keyres->key);
>  			if (ret < 0)
> -				goto error_link_end;
> +				goto out_link_end;
>  		}
>  	}
>  
>  	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
>  
> -error_link_end:
> +out_link_end:
>  	if (keyring)
>  		__key_link_end(keyring, &key->index_key, edit);
>  
> -error:
> +out_free_preparse:
>  	if (key->type->preparse)
>  		key->type->free_preparse(&prep);
> +
> +out:
> +	srcu_read_unlock(&key_type_srcu, srcu_idx);
>  	return ret;
>  }
>  
> @@ -581,7 +608,8 @@ int key_reject_and_link(struct key *key,
>  			struct key *authkey)
>  {
>  	struct assoc_array_edit *edit = NULL;
> -	int ret, awaken, link_ret = 0;
> +	int ret, awaken, link_ret = 0, srcu_idx;
> +	bool dead;
>  
>  	key_check(key);
>  	key_check(keyring);
> @@ -589,22 +617,42 @@ int key_reject_and_link(struct key *key,
>  	awaken = 0;
>  	ret = -EBUSY;
>  
> +	/*
> +	 * Hold key_type_srcu across linking into @keyring and
> +	 * key_set_expiry() (which reads key->type->flags).  If the key is
> +	 * already marked dead, skip linking and expiry but still complete
> +	 * negative instantiation so waiters are woken and @authkey is
> +	 * invalidated.
> +	 */
> +	srcu_idx = srcu_read_lock(&key_type_srcu);
> +	dead = test_bit(KEY_FLAG_DEAD, &key->flags);
> +
>  	if (keyring) {
> -		link_ret = __key_link_lock(keyring, &key->index_key);
> -		if (link_ret == 0) {
> -			/*
> -			 * Check the restriction under the keyring semaphore.
> -			 * keyring_restrict() installs it while holding the
> -			 * semaphore, so testing it beforehand races with a
> -			 * concurrent restriction install.
> -			 */
> -			if (keyring->restrict_link) {
> -				__key_link_end(keyring, &key->index_key, edit);
> -				return -EPERM;
> +		if (dead) {
> +			link_ret = -EKEYREVOKED;
> +		} else {
> +			link_ret = __key_link_lock(keyring, &key->index_key);
> +			if (link_ret == 0) {
> +				/*
> +				 * Check the restriction under the keyring
> +				 * semaphore. keyring_restrict() installs it
> +				 * while holding the semaphore, so testing it
> +				 * beforehand races with a concurrent
> +				 * restriction install.
> +				 */
> +				if (keyring->restrict_link) {
> +					__key_link_end(keyring, &key->index_key,
> +						       edit);
> +					ret = -EPERM;
> +					goto out;
> +				}
> +				link_ret = __key_link_begin(keyring,
> +							    &key->index_key,
> +							    &edit);
> +				if (link_ret < 0)
> +					__key_link_end(keyring, &key->index_key,
> +						       edit);
>  			}
> -			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
> -			if (link_ret < 0)
> -				__key_link_end(keyring, &key->index_key, edit);
>  		}
>  	}
>  
> @@ -616,7 +664,8 @@ int key_reject_and_link(struct key *key,
>  		atomic_inc(&key->user->nikeys);
>  		mark_key_instantiated(key, -error);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> -		key_set_expiry(key, ktime_get_real_seconds() + timeout);
> +		if (!dead)
> +			key_set_expiry(key, ktime_get_real_seconds() + timeout);
>  
>  		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
>  			awaken = 1;
> @@ -641,7 +690,10 @@ int key_reject_and_link(struct key *key,
>  	if (awaken)
>  		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
>  
> -	return ret == 0 ? link_ret : ret;
> +	ret = ret == 0 ? link_ret : ret;
> +out:
> +	srcu_read_unlock(&key_type_srcu, srcu_idx);
> +	return ret;
>  }
>  EXPORT_SYMBOL(key_reject_and_link);
>  
> -- 
> 2.47.3
> 
o

LGTM with quick skim. I'll revisit later with time

Br, Jarkko
