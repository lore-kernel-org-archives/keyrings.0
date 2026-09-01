Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074992D1911;
	Tue,  1 Sep 2026 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303661; cv=none; b=fA468bGzrpcMDH1SsjKsls/wOI9429lOEtrCtqFTHTe3NuEwI5ZUdRDUgXIMg+BsJ5ckEipv1FlUjj/bVBwPxIp3N7gEgeUymBsMWl5MXS4iKM8jH9LhbOdXD3+hErSvBbFQX43AigPwrnklN7PZp9tRWZhkn1LTIeItK/cs3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303661; c=relaxed/simple;
	bh=9TBc2TSNKd8wom1BAsKVsfqQ7GveYX2PqH6iKaZzJ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPtn86fUxVr1IIjXzkeLMaLOQqC0sVF7KrJaExYyYbZdYVnN2s+wiVMd4fVGm9POpfVnCNLq+8685O47hbZLJ8GojJ5reCvtPfohTaGe+Bgq74Z1zW7luIkjNE1eIBLSGOFwGVJUlWkbQsPpYZVC2E/tKVYOpuRj/bAC4qjniKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1L2wgjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1L2wgjo"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 32A121F000E9;
	Tue,  1 Sep 2026 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303659;
	bh=yopPsOeV+Vj+/WVfoA5yU2nIAO4oHT7ZU/Lq7XqWAr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T1L2wgjoAkwcUtCLGfPFcb52NDBgQyKyj9ZYjT+Ddt70tjQPWkLq7iPCA6jHWRUSO
	 YFWCUcfYSBF1gghGKu65PEeuJjvH5bSgwG5F1lyRMCMMyAUkT9wM0bVHfjXgSGwYaC
	 RT5OxNvCbRKD3thKXFKp4ObM3wwbsCWlfivVf/NPZp8wZU5Ijxs5E84rHSzCGgDmKd
	 TbPQQPLKSKLtQKjsIXj4X/QXALyBBsq72KRIBsr6o/RR1+AdNbuzwnPTK6XX8OQJ2f
	 CDLCJRdFEccTYjQHVkVmQbjg1Bh7jQ/7OEHmKh4x3xi2FYjmWE8weC/1iZ5bxZVNyT
	 LMG2pVA/IShnA==
Date: Wed, 2 Sep 2026 02:00:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: finalize persistent keyring timeout after link
 attempt
Message-ID: <apdZKMddhZoASXmL@kernel.org>
References: <20260901191743.39210-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901191743.39210-1-kmehltretter@gmail.com>

On Tue, Sep 01, 2026 at 09:17:43PM +0200, Karl Mehltretter wrote:
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
> index 97af230aa4b22..e99929b81a1a2 100644
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
> + * Return 0 if a keyring was created, 1 if an existing keyring was found, or a
> + * negative error.  On a nonnegative return, persistent_ref holds a reference
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

I'd return -ENOENT here instead and not make return value tristate.

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

BR, Jarkko
