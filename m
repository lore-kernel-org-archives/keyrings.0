Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1C3B6BF2;
	Fri, 18 Sep 2026 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697676; cv=none; b=skk6xRMo1tiHjUIbgHzZ5jUVYAmu+vBvgGYa2kJU9kyQku3SkzsnnPpJq8JtdvLJImR/x1lBECyQpWACJEUCsk9v5tLRtkUr40c7gl/HSBTGayuVoCLo9Dj3wANZv48qH56XCf5S+pufY5IG1nrCblPYS8a/zdbn7JQY3UE1NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697676; c=relaxed/simple;
	bh=XG5tXNhmHVkSr+ObLlr7vqBx3G4FZGH3QBqATB45sHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIgPyMPwLDzinwjDQ27bI0UiKddaryoE1QxnaTp4+v1G+ebUOvtd68kkKHdyiZy2B8nwgHmGSogkIFa02LmACRjapyysqcF28hrw38WcZrcPN5B2N4Qn0jAvAJ6ulV2XvUCh1QrIdkD+30tkE+RMHVtE9jGuWOncoO7m1rrGhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF8+G0iY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF8+G0iY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D194E1F000FF;
	Fri, 18 Sep 2026 02:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697673;
	bh=Cs4e9fGmvBmMllPzVQFlcqSoCGiEMLUQj/MHmC0cLds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aF8+G0iYE1ckBIWsf9fbtQCAiHhUzHqUdb1iDPgypKgaRejp31ul41xmGnMkJIBRJ
	 YdCWLb1w/DMoG7Rf74oQua0tT5N0V+/eRbkeB49c/9eyLMmkUE/aE15mR0gchRDY5S
	 YU653jB7/MsrbMheQ1Eoc3lEOIB1ThWUx3qGFQ5qCMbx2eLj0DSkC3qxTRPdnxIVxO
	 NeYP3TOtHpwo+bF8CXayKjkt00qu376iD3QAFVIvqmmbTKwZGUuAwZ7n4x7M8Wm2Xs
	 XVWs6yID193KgpN3CvfwLDWzOW+fXz2kTcNASNjoa78ZNbfn/+YEYzzXoA3WtAwJx4
	 cc10ZHizk6/AQ==
Date: Fri, 18 Sep 2026 05:14:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] keys: finalize persistent keyring timeout after link
 attempt
Message-ID: <aqyehcvl9fM6LuVw@kernel.org>
References: <20260912095440.79864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912095440.79864-1-kmehltretter@gmail.com>

On Sat, Sep 12, 2026 at 11:54:40AM +0200, Karl Mehltretter wrote:
> When no keyring exists for the requested UID, KEYCTL_GET_PERSISTENT
> creates and registers one before linking it to the requested destination.
> The configured timeout is set only after the destination link succeeds.
> 
> A destination restricted with KEYCTL_RESTRICT_KEYRING makes that link fail
> with -EPERM. With persistent_keyring_expiry set to 60 seconds, /proc/keys
> still reports the registered keyring's expiry as "perm".
> The failed call therefore leaves a quota-exempt keyring in the namespace's
> hidden register, where it may remain until namespace teardown.
> 
> Rename the write-locked helper to key_get_or_create_persistent() and return
> the key reference through a result parameter. Return 0 when it creates a
> keyring and 1 when the retry finds an existing one. Return a negative error
> on failure. Another caller may create the keyring between the initial
> read-locked lookup and the retry under the write lock.
> 
> Set the timeout after permission checking and linking. Do this on success,
> or on failure if the call allocated the keyring. This leaves a new keyring
> collectible after failure without starting its timeout while linking is
> still in progress.
> 
> Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v4:
> - tweak comment (Jarkko)
> 
> v3: https://lore.kernel.org/r/20260901191743.39210-1-kmehltretter@gmail.com/
> 
> Changes in v3:
> - Return the persistent key reference through a result parameter (Jarkko).
> - Keep lookup-or-create atomic inside the helper and use 0 for creation, 1
>   for an existing keyring, and negative values only for errors.
> 
> v2: https://lore.kernel.org/r/20260901164323.35785-1-kmehltretter@gmail.com/
> 
> Changes in v2:
> - Rewrite the commit message around the restricted-destination reproducer
>   and trim the explanation (Jarkko).
> - Track whether the persistent keyring was newly allocated and finalize its
>   timeout after the permission and link checks. This preserves an existing
>   keyring's timeout on failure and avoids expiry during linking.
> 
> Testing below was performed for v3; v4 changes only the comment.
> 
> Tested with QEMU 10.2.1 TCG on i386 and x86_64. With
> persistent_keyring_expiry set to 60 seconds, KEYCTL_GET_PERSISTENT returned
> -EPERM and /proc/keys reported "perm" before the fix and "1m" after it on
> both architectures.
> 
> Also tested on x86_64 with persistent_keyring_expiry set to 1 second and
> gc_delay set to 0. Successful calls reused the same serial, a newly created
> keyring from a failed call expired, and a failed call using an existing
> keyring left its timeout unchanged. A test-only two-second delay before
> timeout finalization did not allow the keyring to be collected before link.
> 
> Two concurrent callers returned the same serial. A test-only 100 ms delay
> after the read-locked miss forced both callers into the write-locked retry
> and confirmed that the second caller took the 1 (existing) return path.
> 
>  security/keys/persistent.c | 55 ++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/security/keys/persistent.c b/security/keys/persistent.c
> index 97af230aa4b22..bdab995393261 100644
> --- a/security/keys/persistent.c
> +++ b/security/keys/persistent.c
> @@ -33,25 +33,31 @@ static int key_create_persistent_register(struct user_namespace *ns)
>  }
>  
>  /*
> - * Create the persistent keyring for the specified user.
> + * Get or create the persistent keyring for the specified user.
>   *
>   * Called with the namespace's sem locked for writing.
> + *
> + * Returns a boolean indicating whether the keyring already existed,
> + * or a negative error. On success, *persistent_ref holds a reference
> + * to the keyring.
>   */
> -static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
> -				       struct keyring_index_key *index_key)
> +static int key_get_or_create_persistent(struct user_namespace *ns, kuid_t uid,
> +					struct keyring_index_key *index_key,
> +					key_ref_t *persistent_ref)
>  {
>  	struct key *persistent;
> -	key_ref_t reg_ref, persistent_ref;
> +	key_ref_t reg_ref;
>  
>  	if (!ns->persistent_keyring_register) {
> -		long err = key_create_persistent_register(ns);
> +		int err = key_create_persistent_register(ns);
> +
>  		if (err < 0)
> -			return ERR_PTR(err);
> +			return err;
>  	} else {
>  		reg_ref = make_key_ref(ns->persistent_keyring_register, true);
> -		persistent_ref = find_key_to_update(reg_ref, index_key);
> -		if (persistent_ref)
> -			return persistent_ref;
> +		*persistent_ref = find_key_to_update(reg_ref, index_key);
> +		if (*persistent_ref)
> +			return 1;
>  	}
>  
>  	persistent = keyring_alloc(index_key->description,
> @@ -61,9 +67,10 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
>  				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
>  				   ns->persistent_keyring_register);
>  	if (IS_ERR(persistent))
> -		return ERR_CAST(persistent);
> +		return PTR_ERR(persistent);
>  
> -	return make_key_ref(persistent, true);
> +	*persistent_ref = make_key_ref(persistent, true);
> +	return 0;
>  }
>  
>  /*
> @@ -78,6 +85,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
>  	key_ref_t reg_ref, persistent_ref;
>  	char buf[32];
>  	long ret;
> +	bool created = false;
>  
>  	/* Look in the register if it exists */
>  	memset(&index_key, 0, sizeof(index_key));
> @@ -100,23 +108,24 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
>  	 * also need to create the register.
>  	 */
>  	down_write(&ns->keyring_sem);
> -	persistent_ref = key_create_persistent(ns, uid, &index_key);
> +	ret = key_get_or_create_persistent(ns, uid, &index_key,
> +					   &persistent_ref);
>  	up_write(&ns->keyring_sem);
> -	if (!IS_ERR(persistent_ref))
> -		goto found;
> -
> -	return PTR_ERR(persistent_ref);
> +	if (ret < 0)
> +		return ret;
> +	created = ret == 0;
>  
>  found:
> +	persistent = key_ref_to_ptr(persistent_ref);
>  	ret = key_task_permission(persistent_ref, current_cred(), KEY_NEED_LINK);
> -	if (ret == 0) {
> -		persistent = key_ref_to_ptr(persistent_ref);
> +	if (ret == 0)
>  		ret = key_link(key_ref_to_ptr(dest_ref), persistent);
> -		if (ret == 0) {
> -			key_set_timeout(persistent, persistent_keyring_expiry);
> -			ret = persistent->serial;
> -		}
> -	}
> +
> +	if (ret == 0 || created)
> +		key_set_timeout(persistent, persistent_keyring_expiry);
> +
> +	if (ret == 0)
> +		ret = persistent->serial;
>  
>  	key_ref_put(persistent_ref);
>  	return ret;
> 
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> -- 
> 2.53.0

LGTM. Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
