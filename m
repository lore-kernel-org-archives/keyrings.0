Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196049;
	b=yB4xl0B4FTQkxBNsDy3BobZVk4IaqDHkHz/RyRZpJAfNXOZYqcAzQEIG6cXNIzihnAPi
	 d3YL3SfWUxqk5YHZYoo4AutFbAkE/t1GzO9RDxlhLHXFJIO0EOZanyDEffE0N1oLGOE4J
	 rICB+FZt5agOxeCT4F7EgjUCyMks0FMCu7XDEDA87NZ7r9hgS0gXeAUvFYxPuQrnwL0nD
	 xO9eS9be02m+XMCwfkQceX0j54wDSi357LzE0IddWKVMUIUUCzGrl3czye4VUNEuC87PD
	 6/VscNKhscm+B9BGL6KCb+1G/zNcZFf4Hdym9Ql+mFN6Lw+wFhb6Mgk29NCEFmn+Bzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196049;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=77/C6SYfI38rig3b5Xhp6zxSG4ayQ0fXmak+LEOxmn0=;
	b=r6toZx8q7i0HBAymrwKhgmTDcJFrXSpB5R9iQl03ecjzkrf42l75CbvfUCN0WJF6HsQW
	 kll2XdtWkG2IDQ3WmF85kcsPKm7cGoMjbahDJqcrVrSZcl0PM2/4c9b1iy33CTmoemQt7
	 xxrnaOleb+NYIHjmSDjasTA+6UedbxqJoBDI3vquqBpbNPEaYZKp0R112fB7nZofF8yUW
	 babA0PC8zVL8cxDtyfxX1RcaamVrKr8WAfXjD+sfQZPTU2B8xUT7ZESwp5P2SZVh6yMz+
	 GnLVqV5f60hqWxTny4y/G2r4H0+1UPR3OH5hBAn9boHaM0aQQXxz7vHfpjpLjALJPpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=OjjnOtnM;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69514606A330;
	Fri, 20 Nov 2026 17:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69514606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=OjjnOtnM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795196044; bh=tqr7JujF5uPqlUHh7F9lKO+IL/G70y7dJOo/+zScl8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjjnOtnMigu7ogGoTDg3h0S4qj/bYFjLfh33PSJkRSsFNOnUBQSWhxWWJAovRBcwt
	 hVPlPBAgmHCGPIToIygykBN/mfX2J34V83UQwX8CG0zcuQF5Z5kWE9wmrao7Imq47K
	 tTHrjTxlSwa/sbBf1m8nPUQsMXb/PYAIXJCMM03VoboukgKYezk4bK4rzZo5aAKLZH
	 aGIGNi/6rGJHjFF61569cAgrSwXaqTHz8UCnMVup4sZOQVVPjWLVOOBx0NsbdE3Rj7
	 AXHV8s7cM5CbPbMPTeW+r67raMu5DjCRZAb4M5kXUL82b0m+HM/EFOotIee/llvd4l
	 lZZJOwtdmvqtQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C11251B33; Fri, 20 Nov 2026 11:34:04 -0600 (CST)
Date: Fri, 20 Nov 2026 11:34:04 -0600
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
Message-ID: <awCEjJ8syhv+f4vd@hallyn.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
 <awCB3UkCPzLGRBTk@hallyn.com>
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
In-Reply-To: <awCB3UkCPzLGRBTk@hallyn.com>

On Fri, Nov 20, 2026 at 11:22:37AM -0600, Serge E. Hallyn wrote:
> On Tue, Nov 17, 2026 at 07:54:24PM +0000, Josef Bacik wrote:
> > A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
> > namespace that another root task created.  Commit db2e718a4798
> > ("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
> > from mapping uid 0 into a namespace it creates itself, because tasks in
> > that namespace could then write file capabilities for its root user.
> > setns() gives a joiner a full capability set in the namespace too, so
> > it can do the same there:
> > 
> >   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
> >   unshare(CLONE_NEWUSER)
> >                                     setns(A's user ns)
> >                                       allowed, euid == ns->owner
> >                                     write "0 0 1" to /proc/self/uid_map
> >                                       A had CAP_SETFCAP -> allowed
> > 
> > If A's namespace already maps host uid 0, at any uid, B can set
> > security.capability on a file right away.  Either way uid 1000 can then
> 
> "Either way" here means whether it already maps host uid 0, or whether
> it has no mappings yet?  I'd just drop 'Either way'.
> 
> > run that file with CAP_SYS_ADMIN, which the selftest at the end of this
> > series shows on an unmodified kernel.
> > 
> > The check doesn't look at the joiner's uids, which it can change while
> 
> >From here until the 'Fix by', it is confusing whether any given statement
> refers to the pre-patch or post-patch state.
> 
> > keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for
> 
> Is this a reference to the next patch?  But that's a completely different
> commit.
> 
> > CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
> > CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
> > has no uid_map yet while its parent maps that root user, so that it can
> > still be mapped.  If that is uid 0 of the parent and the creator of the
> > namespace didn't have CAP_SETFCAP, the join is let through: only a
> > writer with CAP_SETFCAP in the parent could map it then.  Containers
> > that don't map the joiner's root user, tasks with CAP_SETFCAP and
> > unprivileged users are not affected.
> > 
> > Like verify_root_map(), the check is about uid 0 of the joiner's own
> > namespace.  The root user of an ancestor that it maps at another uid,
> > and a root user stored through an idmapped mount, are left to whoever
> > set up that map or mount.
> > 
> > Fix by refusing setns() when the joiner doesn't have CAP_SETFCAP and
> > tasks in the namespace can write file capabilities for the root user of
> > the joiner's namespace.
> > 
> > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
> > Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> The code looks good to me,
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> If you don't mind making the commit message and comments shorter and
> clearer, I think that would help.  In the words of the reverend
> Maclean, "Half as long".  If you feel like I"m being unreasonable or
> misguided, or would prefer I rewrite them, please let me know, but imo
> it'd be good to keep this entirely yours :)

Never mind.  I see it has been applied to Christian's tree.  Let's just
leave it as is then.

> > ---
> >  include/linux/capability.h |  3 +++
> >  kernel/user_namespace.c    |  4 ++++
> >  security/commoncap.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> > 
> > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > index 622137f66f09..9ebcdab56937 100644
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
> >  #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
> >  #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
> >  
> > +struct cred;
> >  struct file;
> >  struct inode;
> >  struct dentry;
> > @@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
> >  int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
> >  		      const void **ivalue, size_t size);
> >  
> > +bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns);
> > +
> >  #endif /* !_LINUX_CAPABILITY_H */
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 50c374ed4687..34becacaccd6 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -1390,6 +1390,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
> >  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  
> > +	/* Don't hand back CAP_SETFCAP to a root task that gave it up. */
> > +	if (cred_borrows_setfcap(current_cred(), user_ns))
> > +		return -EPERM;
> > +
> >  	cred = nsset_cred(nsset);
> >  	if (!cred)
> >  		return -EINVAL;
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index d47ab3022343..96ac039fddad 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -131,6 +131,55 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * @ns has no uid_map yet.  Could @caller_root_kuid still be mapped into it,
> > + * so that tasks in @ns get CAP_SETFCAP over it?  A writer in the parent can
> > + * map any uid that the parent maps.  If that is uid 0 of the parent, a task
> > + * in @ns can only map it if the creator of @ns had CAP_SETFCAP, a writer in
> > + * the parent only if it has CAP_SETFCAP there, see verify_root_map().
> > + */
> > +static inline bool userns_may_map_root(struct user_namespace *ns,
> > +				       kuid_t caller_root_kuid)
> > +{
> > +	uid_t caller_root_in_parent = from_kuid(ns->parent, caller_root_kuid);
> > +
> > +	if (caller_root_in_parent == (uid_t)-1)
> > +		return false;
> > +	return caller_root_in_parent != 0 || ns->parent_could_setfcap;
> > +}
> > +
> > +/**
> > + * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
> > + * @cred: The credentials of a task that joins @ns or traces a task in it
> > + * @ns: The user namespace
> > + *
> > + * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
> > + * namespace it creates, see verify_root_map(), as tasks there could then
> > + * write file capabilities that are honoured for that root user.  Tasks in
> > + * @ns can do that if @ns maps it, at any uid, or if it can still be mapped
> > + * into @ns, see userns_may_map_root().
> > + *
> > + * Like verify_root_map(), this only looks at uid 0 of @cred's namespace, not
> > + * at the root users of ancestors that it maps at another uid, and a root
> > + * user stored through an idmapped mount is up to whoever sets up the mount.
> > + *
> > + * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
> > + * file capabilities for the root user of @cred's namespace.
> > + */
> > +bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
> > +{
> > +	kuid_t caller_root_kuid = make_kuid(cred->user_ns, 0);
> > +
> > +	if (!uid_valid(caller_root_kuid) ||
> > +	    cap_raised(cred->cap_permitted, CAP_SETFCAP))
> > +		return false;
> > +
> > +	if (READ_ONCE(ns->uid_map.nr_extents))
> > +		return kuid_has_mapping(ns, caller_root_kuid);
> > +
> > +	return userns_may_map_root(ns, caller_root_kuid);
> > +}
> > +
> >  /**
> >   * cap_settime - Determine whether the current process may set the system clock
> >   * @ts: The time to set
> > 
> > -- 
> > 2.55.0
