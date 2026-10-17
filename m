Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CB37EFE3;
	Sat, 17 Oct 2026 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792211054; cv=none; b=PrjGwySb6Mv8yroQ4THmZ8Wse36D4liduoqh2qvqMXFfC7nyHvy3calTLJA8lTwLmlY0w4R/o6GvqGDDGU4eKTTxC6MM4wFmSopoCXLvN6TQZE01YRCOyhL0J0AxXUZakGhBv1Ph63Thk7Ew1Hk/QyeSDrIJDde54pVsO/Cd3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792211054; c=relaxed/simple;
	bh=kF2MdGqCRQBTzzrNKZ1k6+SK9U0ZkGS9vur2CpA3DeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlInBALAfYbWiA9eOyjFrJ8KapYbB13q1ozsLpsqzI3yycb5oC5xN05BmqfdhspzR8tP4Y6i/60qTnG8WfG5pTy/7cLj9XpEZM/3TwFVfPv0eE4Mvgst/Hb9pDjcQjD+Wi6aqQ57M15cnMAAoM1n54YuaZHXFlffZgT+CbG8Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=HKgSVzbn; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="HKgSVzbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1792211048; bh=kF2MdGqCRQBTzzrNKZ1k6+SK9U0ZkGS9vur2CpA3DeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKgSVzbnrBp8NH6QH51I1E/OoogNlC2zsDtJLmPjX9s6tPfY6vYAq4gVY4mDhc2dG
	 loKKSdK1FECQLJgdOfzzD46GmhatJYGkeJqgMasn01mbMSndQyyinPTUgBQ2+lAN7D
	 WRUUfHl8q3sf4+dD1uc61eu9XgF0ytOjb96OI6k+UxbYGXsKya7OYHisFONkUUqxW0
	 YvWcpiy1xFp4F9rS7SuGZyBt9Xti9IgnVa5OqtLhTcm7xuXq1+VLT6oLhjrEO9+iXK
	 /WO0z9oEcxDuXvHkShNc0KfvR5i9FYHm4NZrGG/dt2Ou/DTMC7LtZi6wnTnFKbU/Bw
	 5nNP0zSr192bA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3A5EE83F; Fri, 16 Oct 2026 23:24:08 -0500 (CDT)
Date: Fri, 16 Oct 2026 23:24:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] userns: record how far up CAP_SETFCAP reaches
Message-ID: <atL4aDihv/QRRHPA@hallyn.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>

On Wed, Oct 14, 2026 at 08:47:46PM +0000, Josef Bacik wrote:
> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
> 
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
> 
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/capability.h     |  3 +++
>  include/linux/user_namespace.h |  7 ++++---
>  kernel/user_namespace.c        |  4 ++--
>  security/commoncap.c           | 26 ++++++++++++++++++++++++++
>  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 622137f66f09..026974a5111b 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
>  #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
>  #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
>  
> +struct cred;
>  struct file;
>  struct inode;
>  struct dentry;
> @@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
>  int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
>  		      const void **ivalue, size_t size);
>  
> +int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
> +
>  #endif /* !_LINUX_CAPABILITY_H */
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 91232053775d..f3753b6b6d29 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -86,9 +86,10 @@ struct user_namespace {
>  	kgid_t			group;
>  	struct ns_common	ns;
>  	unsigned long		flags;
> -	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
> -	 * in its effective capability set at the child ns creation time. */
> -	bool			parent_could_setfcap;
> +	/* setfcap_level: CAP_SETFCAP held in this ns counts here and in the
> +	 * ancestors up to the one at this ->level, see cap_setfcap_level().
> +	 */
> +	int			setfcap_level;
>  
>  #ifdef CONFIG_KEYS
>  	/* List of joinable keyrings in this namespace.  Modification access of
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 50c374ed4687..a5a94367600d 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -125,7 +125,7 @@ int create_user_ns(struct cred *new)
>  	if (!ns)
>  		goto fail_dec;
>  
> -	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
> +	ns->setfcap_level = cap_setfcap_level(new, parent_ns);
>  
>  	ret = ns_common_init(ns);
>  	if (ret)
> @@ -921,7 +921,7 @@ static bool verify_root_map(const struct file *file,
>  		 * the new namespace.  Verify that the parent had CAP_SETFCAP
>  		 * when it unshared.
>  		 * */
> -		if (!file_ns->parent_could_setfcap)
> +		if (file_ns->setfcap_level >= file_ns->level)
>  			return false;
>  	} else {
>  		/* Process p1 is writing to uid_map of p2, who is in a child
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d47ab3022343..a51b9d51d96d 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -131,6 +131,32 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
>  	return ret;
>  }
>  
> +/**
> + * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
> + * @cred: The credentials to use
> + * @ns: The user namespace of @cred or one of its descendants

Is @ns really always @cred or one of its descendants?

Should there be something like a BUG_ON(ns->level < cred->user_ns->level)
to make sure no user of this function passes in a wrong ns?

I think this function should not be directly used when doing checks in
the later patches.  Please use a clearly named helper, something like
cred_may_setfcap_userns(cred, ns).

> + * File capabilities belong to the kuid of a namespace's root user, and the
> + * same kuid can be the root user of ancestors of that namespace.  Every task
> + * gets CAP_SETFCAP when it enters a user namespace, so having it there says
> + * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
> + * from the creator when the namespace is created.
> + *
> + * Return: the ->level of the topmost namespace, from @ns upwards, for which
> + * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even over @ns.
> + */
> +int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
> +{
> +	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT))

I'd far prefer this to be

	if (cap_capable(...) != 0)

especially since the next line checks cap_raised.  I sometimes get the
urge to fix the semantics of these to be consistent...

> +		return ns->level + 1;
> +
> +	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
> +		return cred->user_ns->setfcap_level;
> +
> +	/* All we have is that we own a child of our namespace. */
> +	return cred->user_ns->level + 1;
> +}
> +
>  /**
>   * cap_settime - Determine whether the current process may set the system clock
>   * @ts: The time to set
> 
> -- 
> 2.55.0
