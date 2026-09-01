Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5648167D;
	Tue,  1 Sep 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283660; cv=none; b=pid/ZlftMaAvPgb38yRrGafAEmCERnuhCKLOHFp7ipqniN4n1c4ZYvZZZzSQ2iSrTcXNnGJqODs8D6Pz3EgizRGogXIEQJ64HPepx0BlchpNW2xY0JpXHUDItX+MV3eqdi7BfZpZiNYXaOXRQ6EDGrGVoWOwPXsfynSwEiVnzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283660; c=relaxed/simple;
	bh=FFHHj/YnUJLGo0Scwhc9K5J4z7594gwESBENnUwUhhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+LfKlNSQFdcJgtTHa5Kh/WBzF7RYxgPwfEuV3VzrVRRnuEKX+fh/iq4idxV1NcwbsvEvikE/DZhOUNs69pJ7V0pfZDD3vi8G4pAAcdfOvXrcVidPkzHwK9NvXlFUN0yI9O/+xAczEryVE2QhYsIuDEpopVcbR4CMgpcaI3+OQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP24nTD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP24nTD4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B60691F000E9;
	Tue,  1 Sep 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283658;
	bh=aTwlpmOvAQ71IYhnTYCnrg//vc3S/rTawhFOMue/47U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EP24nTD4OYgRIf1TCjf9G76oyYixMuoypjy4T/v/WyFNkEYqCCTBCsVH8TA16ts2m
	 qoaLsb3xxHvIG5+yn+jqViRenY1VHLVFcZ+5YMrDF6pc4S2OsRqChb4YFkFLmXTTAz
	 CnxdlZ1YCuvYH1KHRE0HlDMOto8bEjXoGV81tVf9aXCIDEyBfu1hXs/tjlrStIRAcy
	 7pcqDbIZRuc7lHHSOMzdHAQSCIRJy6A4YYLou+D8hAKMvcieNrR5cpiePDnoTcr4tG
	 FXzUnrm1un6h3m8ZG1VxUnDjA+GiI+4yDv4zR8IV/B+iCfCA3X3TeBjEYbtr6II05I
	 pJA5iHCyknRCw==
Date: Tue, 1 Sep 2026 20:27:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: finalize persistent keyring timeout after link
 attempt
Message-ID: <apcK6bcJfGED53a3@kernel.org>
References: <20260901164323.35785-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901164323.35785-1-kmehltretter@gmail.com>

On Tue, Sep 01, 2026 at 06:43:23PM +0200, Karl Mehltretter wrote:
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
> Have key_create_persistent() report whether it allocated a new keyring.
> Another caller may create one between the initial read-locked lookup and
> the retry under the write lock. Set the timeout after permission checking
> and linking. Do this on success, or on failure if the call allocated the
> keyring.
> 
> This leaves a new keyring collectible after failure without starting its
> timeout while linking is still in progress.
> 
> Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
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
>  security/keys/persistent.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/security/keys/persistent.c b/security/keys/persistent.c
> index 97af230aa4b22..f356df8f3c973 100644
> --- a/security/keys/persistent.c
> +++ b/security/keys/persistent.c
> @@ -38,7 +38,8 @@ static int key_create_persistent_register(struct user_namespace *ns)
>   * Called with the namespace's sem locked for writing.
>   */
>  static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
> -				       struct keyring_index_key *index_key)
> +				       struct keyring_index_key *index_key,
> +				       bool *created)

I'd instead convert the interface to have a result parameter:

static int key_create_persistent(struct user_namespace *ns, kuid_t uid,
				 struct keyring_index_key *index_key,
				 key_ref_t *persistent_ref)

And then return -ENOENT here:

	} else {
		reg_ref = make_key_ref(ns->persistent_keyring_register, true);
		*persistent_ref = find_key_to_update(reg_ref, index_key);
		if (*persistent_ref)
			return -ENOENT;
	}

Then deal with that errno at the call sites.

I think this make intuitively much more sense.

>  {
>  	struct key *persistent;
>  	key_ref_t reg_ref, persistent_ref;
> @@ -63,6 +64,8 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
>  	if (IS_ERR(persistent))
>  		return ERR_CAST(persistent);
>  
> +	*created = true;
> +
>  	return make_key_ref(persistent, true);
>  }
>  
> @@ -78,6 +81,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
>  	key_ref_t reg_ref, persistent_ref;
>  	char buf[32];
>  	long ret;
> +	bool created = false;
>  
>  	/* Look in the register if it exists */
>  	memset(&index_key, 0, sizeof(index_key));
> @@ -100,7 +104,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
>  	 * also need to create the register.
>  	 */
>  	down_write(&ns->keyring_sem);
> -	persistent_ref = key_create_persistent(ns, uid, &index_key);
> +	persistent_ref = key_create_persistent(ns, uid, &index_key, &created);
>  	up_write(&ns->keyring_sem);
>  	if (!IS_ERR(persistent_ref))
>  		goto found;
> @@ -108,15 +112,16 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
>  	return PTR_ERR(persistent_ref);
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
