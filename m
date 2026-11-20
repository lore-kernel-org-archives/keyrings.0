Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195362;
	b=FlCiBjKuSEdlbrK6+4DURAF9UBDDCIW+SteYEL5At+uwIL8C3dW1ABX4oktTqH5ZcJUg
	 rcfETe2groLP0wLJois/C1A4zBAqUB540PbvYP1RGty6208CH0dNChOxcl2pJq6jYVt//
	 F9x4fulzTMo50sNu3XnqZcSJ8GcqSrAKXr0x6D1Lqgj/vhn1+NirKr61tutE9Ajzm98OT
	 7XRU4s+49+i2UEqSHxChb4Rr2hVRCW3qGtWwe2k+Eso91bN93AUgWYC48v4IdHqvDs6rI
	 Pj/AthAR/Pm2BS6fdK1TnFdgKKUEtGMFCnKncsNpF+Z73rQR1rybqrWvLY1BOqUYVmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195362;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hcGbtErC4qaWDNGFYvrl/+JTn+WF9z7rUZdodFxsCVM=;
	b=Qm9J4FOfkbcylzPc/aBQundRY8sQaGXkY3TjCq/wdnvHF3ZJrkp0d7d3cLGP3I/HTVra
	 uNzh5VWdLmaSS+/y4clgNRu63AG3nUJyQ7Im6D0tz2iQnjqtzpAFjw2YvGcmSGlnUxTCl
	 Fdc2ogyPMUgr0jIGfH6QHpqO4o0Sh4SqoNA0cVCMbezDjWaQgrRYBfiRYEBcwX/suPdza
	 +ORxr9x0Scjf9h5CdzbUd/X0FS4WtJUnk2vU/JW82eYd4YcIcz5dInaTeiPlYQAr6TnDy
	 TapjGGmHvCLiBvDpOyy7sSd3UMFS+UxmnZyYD7GeP42x5jy1GwvprxS9pBdpERIVAQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=LqhvxPrT;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93D60A2619;
	Fri, 20 Nov 2026 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B93D60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=LqhvxPrT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795195357; bh=1fh0CEGBoECp97YFqm5pPCrctH/nil1jed3l8kKD+p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqhvxPrTKBJRH/hn++zaICZ1golLi7TTdlWnszMGpsoqMCBEwbHxIQSexLWHm1enV
	 8EmpIgA8gRng05B9xRm80i8BdFVuePF4zHJ4SjIhNeKGEGtJ219y6t+CKK3F4GK1f+
	 iYbPd6g4qOKWLXeJjqMVVJJaGrajZ7P7YLsDJitDMi1EFRST0PJagyYC1+AAzRyPiq
	 s9JF02kse2bpj+dP5rvrRYzxG4cvveZmJIEkHRYG8bVqRYI5i5/9qeFtUZChUK38Bt
	 YTrGfQmKyu35a+kzxDXN4yZUmHnQ9vNorj1AcQCHJY9T1aUud4gy9U3Jc3n1jmz54k
	 s6MHz3FwHKDHQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C661928C; Fri, 20 Nov 2026 11:22:37 -0600 (CST)
Date: Fri, 20 Nov 2026 11:22:37 -0600
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
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v11 1/3] userns: don't let setns() lend CAP_SETFCAP
Message-ID: <awCB3UkCPzLGRBTk@hallyn.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
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
In-Reply-To: <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>

On Tue, Nov 17, 2026 at 07:54:24PM +0000, Josef Bacik wrote:
> A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
> namespace that another root task created.  Commit db2e718a4798
> ("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
> from mapping uid 0 into a namespace it creates itself, because tasks in
> that namespace could then write file capabilities for its root user.
> setns() gives a joiner a full capability set in the namespace too, so
> it can do the same there:
> 
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid == ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       A had CAP_SETFCAP -> allowed
> 
> If A's namespace already maps host uid 0, at any uid, B can set
> security.capability on a file right away.  Either way uid 1000 can then

"Either way" here means whether it already maps host uid 0, or whether
it has no mappings yet?  I'd just drop 'Either way'.

> run that file with CAP_SYS_ADMIN, which the selftest at the end of this
> series shows on an unmodified kernel.
> 
> The check doesn't look at the joiner's uids, which it can change while

From here until the 'Fix by', it is confusing whether any given statement
refers to the pre-patch or post-patch state.

> keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for

Is this a reference to the next patch?  But that's a completely different
commit.

> CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
> CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
> has no uid_map yet while its parent maps that root user, so that it can
> still be mapped.  If that is uid 0 of the parent and the creator of the
> namespace didn't have CAP_SETFCAP, the join is let through: only a
> writer with CAP_SETFCAP in the parent could map it then.  Containers
> that don't map the joiner's root user, tasks with CAP_SETFCAP and
> unprivileged users are not affected.
> 
> Like verify_root_map(), the check is about uid 0 of the joiner's own
> namespace.  The root user of an ancestor that it maps at another uid,
> and a root user stored through an idmapped mount, are left to whoever
> set up that map or mount.
> 
> Fix by refusing setns() when the joiner doesn't have CAP_SETFCAP and
> tasks in the namespace can write file capabilities for the root user of
> the joiner's namespace.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The code looks good to me,

Reviewed-by: Serge Hallyn <serge@hallyn.com>

If you don't mind making the commit message and comments shorter and
clearer, I think that would help.  In the words of the reverend
Maclean, "Half as long".  If you feel like I"m being unreasonable or
misguided, or would prefer I rewrite them, please let me know, but imo
it'd be good to keep this entirely yours :)

> ---
>  include/linux/capability.h |  3 +++
>  kernel/user_namespace.c    |  4 ++++
>  security/commoncap.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 622137f66f09..9ebcdab56937 100644
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
> +bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns);
> +
>  #endif /* !_LINUX_CAPABILITY_H */
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 50c374ed4687..34becacaccd6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1390,6 +1390,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
>  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* Don't hand back CAP_SETFCAP to a root task that gave it up. */
> +	if (cred_borrows_setfcap(current_cred(), user_ns))
> +		return -EPERM;
> +
>  	cred = nsset_cred(nsset);
>  	if (!cred)
>  		return -EINVAL;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d47ab3022343..96ac039fddad 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -131,6 +131,55 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
>  	return ret;
>  }
>  
> +/*
> + * @ns has no uid_map yet.  Could @caller_root_kuid still be mapped into it,
> + * so that tasks in @ns get CAP_SETFCAP over it?  A writer in the parent can
> + * map any uid that the parent maps.  If that is uid 0 of the parent, a task
> + * in @ns can only map it if the creator of @ns had CAP_SETFCAP, a writer in
> + * the parent only if it has CAP_SETFCAP there, see verify_root_map().
> + */
> +static inline bool userns_may_map_root(struct user_namespace *ns,
> +				       kuid_t caller_root_kuid)
> +{
> +	uid_t caller_root_in_parent = from_kuid(ns->parent, caller_root_kuid);
> +
> +	if (caller_root_in_parent == (uid_t)-1)
> +		return false;
> +	return caller_root_in_parent != 0 || ns->parent_could_setfcap;
> +}
> +
> +/**
> + * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
> + * @cred: The credentials of a task that joins @ns or traces a task in it
> + * @ns: The user namespace
> + *
> + * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
> + * namespace it creates, see verify_root_map(), as tasks there could then
> + * write file capabilities that are honoured for that root user.  Tasks in
> + * @ns can do that if @ns maps it, at any uid, or if it can still be mapped
> + * into @ns, see userns_may_map_root().
> + *
> + * Like verify_root_map(), this only looks at uid 0 of @cred's namespace, not
> + * at the root users of ancestors that it maps at another uid, and a root
> + * user stored through an idmapped mount is up to whoever sets up the mount.
> + *
> + * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
> + * file capabilities for the root user of @cred's namespace.
> + */
> +bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
> +{
> +	kuid_t caller_root_kuid = make_kuid(cred->user_ns, 0);
> +
> +	if (!uid_valid(caller_root_kuid) ||
> +	    cap_raised(cred->cap_permitted, CAP_SETFCAP))
> +		return false;
> +
> +	if (READ_ONCE(ns->uid_map.nr_extents))
> +		return kuid_has_mapping(ns, caller_root_kuid);
> +
> +	return userns_may_map_root(ns, caller_root_kuid);
> +}
> +
>  /**
>   * cap_settime - Determine whether the current process may set the system clock
>   * @ts: The time to set
> 
> -- 
> 2.55.0
