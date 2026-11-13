Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600990;
	b=Bo74vL0yoapisRhSZ3OhlcgW++jOvtNImdLPg4QZeIcJBIkEQxQuD9psk0DrxW89fafY
	 JSpIcvqci32n6pULrsC+7HEAHVt6rA5peGBM80FeUSxXufH2P1m04TIup/pRZ6DqqfFSJ
	 rfE9N1X5TnOfx/cmMiUnsGjsLZ9i8lUw5pLnRAp/565ZmoPMiCxLdvxBd4Wt1IZtCZXPI
	 T4SDDFmJkReWIg7+r451xZgM5v84xZBunq+Fg3M5gMHbSOSzAHZs561+Feh4Uae5HNGxo
	 InQvxTrYF6J7Ovq8ls2FZNdMLhoPwodIiB7QA4BNUbYPmYH/t4hlNj2ETA4nUgYWkcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600990;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HIhgKeezBVujMqDKmE8e3yGkiSxYLq3cbtD9V6odU+U=;
	b=V9yGqhM5tRzxZNS69o879rb6bcO2sVtvMtHER+8y1ueXe1DDyYbK6zWtSKJWEASomC2i
	 2vI11Dph5EFW8FGUrr98T8HboaZpny8H9fY3oVoVZkHWs8YV7ZCVN/XefyaK4uk68xg8s
	 4GZTCCT2ZK0mG5DSTAw/QOrkgMv7vtwTkyvqFxOS1ahIbyiKzqjCAsMoCbnMv8Fu6XiR8
	 3y5J4QBGKcq5GQ5Fdd+uAxi8E/dl2tKalHsIVZ6QAZp1YcAOqXRoRub1dIzyLjA/ImeIo
	 3cSRq+/sSsr+Q409EydX6qIUNn3eZA+xB5XCI0EfN2y3QNAIOoNjriH/gyyEZoUqz9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiWj1NZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB1606A339;
	Fri, 13 Nov 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiWj1NZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD81F1F000C4;
	Fri, 13 Nov 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600990;
	bh=HIhgKeezBVujMqDKmE8e3yGkiSxYLq3cbtD9V6odU+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZiWj1NZ3txFHdB7ix0JpwzcxM7L/nv3rDsKsRQARH7c5+Si2pCxpdqVG9kHeaM16r
	 YG+tvcEA7Dt6yLSFesJElv40vutWUAVbWnWgGE8kmQ4BTYHOAlEnbOVMQ+Jhvk0LWP
	 mDmkQU9BFKYKqIK+tExwaZ8SATVHomqejdgJ6LdHBkNpA4YCldS/JvWm2e9LqnDs9P
	 j8ICuHCo43BKWA113vEftsBGDE/tM9GjP3kE9wFXRQaVYNsBTHmbdY+l9QVoa2h3CP
	 JU20EfoN3X+Bj33mwpyFR+mSR4akG4ioMBsJVaW7ENhmO6FGai5ikk6E8VHPLFUDtZ
	 rIX0+PTb+cZYw==
Date: Fri, 13 Nov 2026 14:16:26 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v10 1/3] userns: don't let setns() lend CAP_SETFCAP
Message-ID: <avdwGnKfYIAZA-1f@shallyn-amd>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
 <20261112-b4-setfcap-userns-v10-1-84f6f7faa903@toxicpanda.com>
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
In-Reply-To: <20261112-b4-setfcap-userns-v10-1-84f6f7faa903@toxicpanda.com>

On Thu, Nov 12, 2026 at 10:08:22PM +0000, Josef Bacik wrote:
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
> run that file with CAP_SYS_ADMIN, which the selftest at the end of this
> series shows on an unmodified kernel.
> 
> The check doesn't look at the joiner's uids, which it can change while
> keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for
> CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
> CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
> has no uid_map yet and is owned by that root user, who could still map
> it.  Containers that
> don't map the joiner's root user, tasks with CAP_SETFCAP and
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
> ---
>  include/linux/capability.h |  3 +++
>  kernel/user_namespace.c    |  4 ++++
>  security/commoncap.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
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
> index d47ab3022343..99a77fe459e9 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -131,6 +131,44 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
>  	return ret;
>  }
>  
> +/**
> + * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
> + * @cred: The credentials of a task that joins @ns or traces a task in it
> + * @ns: The user namespace
> + *
> + * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
> + * namespace it creates, see verify_root_map(), as tasks there could then
> + * write file capabilities that are honoured for that root user.  Tasks in
> + * @ns can do that if @ns maps it, at any uid.  While @ns has no uid_map yet,
> + * they can only map the owner's uid, and if that is uid 0 of the parent
> + * only if the creator of @ns had CAP_SETFCAP.
> + *
> + * Like verify_root_map(), this only looks at uid 0 of @cred's namespace, not
> + * at the root users of ancestors that it maps at another uid, and a root
> + * user stored through an idmapped mount is up to whoever sets up the mount.
> + * A map written later from the parent counts for every task in @ns, as it
> + * does for the creator: mapping uid 0 of the parent takes CAP_SETFCAP there,
> + * any other uid CAP_SETUID.
> + *
> + * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
> + * file capabilities for the root user of @cred's namespace.
> + */
> +bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
> +{
> +	kuid_t root = make_kuid(cred->user_ns, 0);

I think you should check for uid_valid(root) here.  A namespace
doesn't have to have a mapping for 0.

Maybe call it caller_root_kuid?

> +	uid_t id;

Can we call this something like rootid_in_targetns?
caller_root_in_targetns?

> +	if (cap_raised(cred->cap_permitted, CAP_SETFCAP))
> +		return false;
> +
> +	if (READ_ONCE(ns->uid_map.nr_extents))
> +		return kuid_has_mapping(ns, root);

So if the caller's root id has a mapping in the target, then
since caller lacks CAP_SETFCAP, deny.  Good.

This next bit could maybe stand to be a clearly commented separate
static inline function.

> +	id = from_kuid(ns->parent, root);

So if there are no mappings yet into the target namespace, and if the
caller_root_kuid has a mapping into the target's parent ns,

> +	return id != (uid_t)-1 && uid_eq(ns->owner, root) &&
> +	       (id || ns->parent_could_setfcap);

then we restrict the userns_install if .. caller's root user is mapped
into the target namespace parent, and that user is the target
namespace's owner (creating user) and that user, at time of ns creation,
had setfcap?

I don't think the 'uid_eq(ns->owner, root)' is right, though.  So
long as it is the case that

	from_kuid(ns->parent, caller_root_kuid) != (uid_t)-1

then that means that, caller_root_kuid could get mapped into ns,
and a root process in ns could have setfcap over it.

> +}
> +
>  /**
>   * cap_settime - Determine whether the current process may set the system clock
>   * @ts: The time to set
> 
> -- 
> 2.55.0
> 
