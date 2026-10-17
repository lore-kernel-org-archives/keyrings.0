Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3461DF748;
	Sat, 17 Oct 2026 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209932; cv=none; b=Gimc9mUE7S7+ht13xW9Q9U+2Lji2ynQuc5cHKoajL9akkCxY+Db9sVKSyyo7AaWxGO+n9lDK+cGKocc5382OzcAqMK5zS4eaNjmGyFTDgyleH4MfGgyH7E5ZTCG4665J071VDzRpwix072iNh4qJC3WBe6m7c8PAEWrFegfijMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209932; c=relaxed/simple;
	bh=x/KFIhMEJLSe8kwgAldigApeWRkO/OWYQ49RIyBoYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thqIi2EJK5ERSNtastjItGjhmzbXpvjeJjhIP8NrapTsxQ4jlHtWUjiECrQEN/Vnuk7AXd1NjYq/DIaoVhoETAORpDbdyH0RvKz1ZuJZzsYHCivJTZjpZHeRKulsDTQYsvMrATy9j7CcMhJvxbT+nVvt++A7jIlFGVzni+vrV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=JAoXya3F; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="JAoXya3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1792209926; bh=x/KFIhMEJLSe8kwgAldigApeWRkO/OWYQ49RIyBoYuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAoXya3Fmqehi8PuE38awEIytjtFDGztp2WP7G4vyGkiuXr1qauv4G0yzxqfuulHc
	 eneHcZ9EUnNGGu2OBsLVlOQ4/ropWrVaIPYtdmd7mnXdWHS4slbuNmR2N2JCl0J8E4
	 doSLu9GymqYHhFo87k9TL/HNPcZAvpOarG4iedgPqmEiu/WVW6cqCq0HQ5DU1Gp7JL
	 VJBQp+btir6XwulpGJzT4NisQCkgjOqQZc2i1VkNBa7y9Ll/Kd+6IQuPcMCa0HNT/T
	 tk7k+c9p5NPqnBOIrvwDh5o5ySYEEVBpKLACO5P07DlQnq93v55ezWlrZMqu2fZXiv
	 Uxsma9M2M639w==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E5FD2E20; Fri, 16 Oct 2026 23:05:26 -0500 (CDT)
Date: Fri, 16 Oct 2026 23:05:26 -0500
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
Subject: Re: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
Message-ID: <atL0BtBrgCtb3QtY@hallyn.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>

On Wed, Oct 14, 2026 at 08:47:47PM +0000, Josef Bacik wrote:
> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
> 
> But setns() lets other tasks in, and they get the full set as well:
> 
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid == ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
> 
> or, if A's namespace maps uid 0 already, B sets security.capability on a
> file.  Either way B ends up with file capabilities that are honoured in
> the initial namespace, which it could not have written there, nor in a
> namespace it created itself.
> 
> Refuse setns() into a user namespace unless the joiner's CAP_SETFCAP
> reaches at least as far up as the namespace's setfcap_level.  Then every
> task in a namespace is entitled to what its setfcap_level says, and the
> checks on the way to file capabilities can go by the namespace.  This
> has to apply to every user namespace, also to those that don't map the
> parent's uid 0: through an idmapped mount, a root user that only exists
> in the namespace can be stored as the parent's.

Can you please explain what you mean by this about idmapped mounts?

It feels like something we should not be trying to protect against.  The
mere fact that an admin can create an id wormhole with an id mapped
mount where uid 100000 is mapped to 0 on the host, does not mean that
everyone who wants to setns to a namespace which maps uid 100000 should
require CAP_SETFCAP, imo.  It just means the admin should be careful.

Though we'll definitely want Christian's opinion on it.

And I could be misunderstanding the concern.

> The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
> when it tries to setns() into a user namespace created by a task that
> had it, such as a root-created container.  Tasks with CAP_SETFCAP, and
> unprivileged users joining their own namespaces, are not affected.
> 
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  kernel/user_namespace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index a5a94367600d..330085a7d7d4 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1390,6 +1390,13 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
>  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* Everybody in the namespace gets CAP_SETFCAP that reaches as far up
> +	 * as its setfcap_level, so only let in tasks whose own reaches as far.
> +	 */
> +	if (cap_setfcap_level(current_cred(), user_ns->parent) >
> +	    user_ns->setfcap_level)
> +		return -EPERM;
> +
>  	cred = nsset_cred(nsset);
>  	if (!cred)
>  		return -EINVAL;
> 
> -- 
> 2.55.0
