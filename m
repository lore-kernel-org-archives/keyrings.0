Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195893;
	b=ja8UYysfHN2jaj+4a+tOoydfZV2uEoLWWR8jKzTQYgoIVcNBrOAHLd7Xl1VwovezHDpU
	 yUNxv72U1tTBl1n4O4Ua+m1NHOFCYeIDsKCKinvdwpHvNoNOa1ai0ZFlQXciUAOkfC52v
	 qmedVVepq+gC6K3dTgIBna+PwO/AotEj/YYE5ntJaNmWJcYkntv10ST7llNp7EjR9+QQH
	 3Jc6StHgM8nAqWI4FtVdvQxObFdK36QR8UFgoiG9T4t19n8OaLfLAB2RZZ8e6VFHcRY+P
	 7YDhZQ6jOWa5xH2xmni+I/0eZgupRpdZph7lHzcvC9a5vSeQxHsmbMxiM5jh8r+ouzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195893;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RmXXL6prA+gj0EqPX17yTWiJ+j3T7ElTxOwOyMvMOIA=;
	b=1PgTnK3P4hRk2XrJ0C+p9MF8OWH3PHlfnGB9NhYkP4eV1gqYvz2hlLiU3bITn0BTM6Fr
	 5jHcfDa17dnbSwsqfRYdOD0a+fNd1OVHdZVJ9Yn9ZzzY+H4PmlYCkEpWNwf/jTimAgJAp
	 Y0wnbu9Ahz/0J3TH9PCAjBqyaFhe8TRw/1r8SSpV7qFLpT0HlC4G+5WqhNSme7XlDOwr+
	 cUcIVHOZuTOx/ZyN/jWEgol4Tt9N8b4d8JePh6LkHH3GciLu+GNt6/oHjyYSoofm6uEkJ
	 2/VZm+YCL95yWja8Ncr74407S/AiWUM2LsagVDbyZ461pEzfix6sxVZUe8bMcd2vKEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=BmLBlAGK;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDB60A261A;
	Fri, 20 Nov 2026 17:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4FDB60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=BmLBlAGK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795195890; bh=U3tolJxSPQb1OFSMmSa2W8e93k/5HR19c97fCZrytt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmLBlAGKb09/DhuPXciK/c1Ip7DjEmhmCF11jxqWfU3HU3iuEDw7C687Gyp2PnQSc
	 fTbiOUAkMOlB0LC/AyREO4wB5+P7ZOhkaO2Sr6tzuAJMUCmP4gndguO7ZS6ri3guGr
	 6PO/K2loed+atiSZF8sNoKEHAKnSrCo+6CmxnuvMtdsS75He5qKA+vk0LxACYqCc+i
	 mrBSMVtRoM86Eae48aWpmJdydRaWK34Z7FYSJq+xC3cAT01pmeV854+rqon43zZiTu
	 Ii5CnwFJsOoUwfdCSIDM6ra69zMdNtIf47Pn168o1PjKihntdA649SeC0ccdB48AxG
	 Th8i79YuYvZSw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1066F28C; Fri, 20 Nov 2026 11:31:30 -0600 (CST)
Date: Fri, 20 Nov 2026 11:31:30 -0600
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
Subject: Re: [PATCH v11 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
Message-ID: <awCD8l6XoAeUMF+n@hallyn.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-2-2be11a2c32f4@toxicpanda.com>
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
In-Reply-To: <20261117-b4-setfcap-userns-v11-2-2be11a2c32f4@toxicpanda.com>

On Tue, Nov 17, 2026 at 07:54:25PM +0000, Josef Bacik wrote:
> A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
> attach to a task in a user namespace that another root task created,
> and have it write file capabilities for its root user.  For a target in
> a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
> that namespace, and cap_capable() grants every capability there to a
> task whose euid owns it, whatever it gave up:
> 
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
>   unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
>                                     ptrace(PTRACE_ATTACH, A)
>                                       euid == ns->owner -> allowed
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
> 
> The same goes for /proc/<pid>/mem, process_vm_writev() and
> pidfd_getfd().  setns() refuses B now, so ptrace is the way left into
> the namespace.
> 
> The target's own capabilities are no guide.  A target that gave up
> CAP_SETFCAP can still get it back from its inheritable set on execve(),
> take it from another task of its namespace if it kept CAP_SYS_PTRACE, or
> write "0 0 1" to its namespace's uid_map while there is none yet.
> 
> Every PTRACE_MODE_ATTACH check is refused, so reading /proc/<pid>/mem,
> /proc/<pid>/stack and process_vm_readv() of such a target go too.
> PTRACE_MODE_READ, a tracer and target in the same namespace, and targets
> in namespaces that setns() lets the tracer into are not affected.
> Within one namespace the usual rules apply, as for every other
> capability.  A tracer with CAP_SYS_PTRACE but not CAP_SETFCAP is refused
> as well: whether CAP_SYS_PTRACE lets it take CAP_SETFCAP from a task of
> its own namespace depends on LSMs such as Yama.
> 
> Fix by refusing PTRACE_MODE_ATTACH and PTRACE_TRACEME across user
> namespaces when the tracer doesn't have CAP_SETFCAP and setns() would
> refuse it the target's namespace.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 96ac039fddad..4a78939d149b 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -195,14 +195,31 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
>  	return 0;
>  }
>  
> +/*
> + * A tracer that setns() keeps out of a namespace mustn't take control of a
> + * task there either, whatever that task holds itself: it can get CAP_SETFCAP
> + * back on execve(), from another task of its namespace it traces, or by
> + * writing the uid_map of a namespace that doesn't have one yet.  Within one
> + * namespace the usual rules apply, as for every other capability.
> + */
> +static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
> +				       const struct cred *child_cred)
> +{
> +	return cred->user_ns != child_cred->user_ns &&
> +	       cred_borrows_setfcap(cred, child_cred->user_ns);
> +}
> +
>  /**
>   * cap_ptrace_access_check - Determine whether the current process may access
>   *			   another
>   * @child: The process to be accessed
>   * @mode: The mode of attachment.
>   *
> - * If we are in the same or an ancestor user_ns and have all the target
> - * task's capabilities, then ptrace access is allowed.
> + * For PTRACE_MODE_ATTACH, if we don't have CAP_SETFCAP and the target task
> + * is in another user_ns that setns() would keep us out of, then ptrace
> + * access is denied.
> + * Otherwise, if we are in the same or an ancestor user_ns and have all the
> + * target task's capabilities, then ptrace access is allowed.
>   * If we have the ptrace capability to the target user_ns, then ptrace
>   * access is allowed.
>   * Else denied.
> @@ -223,11 +240,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>  		caller_caps = &cred->cap_effective;
>  	else
>  		caller_caps = &cred->cap_permitted;
> +	if ((mode & PTRACE_MODE_ATTACH) &&
> +	    cap_ptrace_borrows_setfcap(cred, child_cred))
> +		goto deny;
>  	if (cred->user_ns == child_cred->user_ns &&
>  	    cap_issubset(child_cred->cap_permitted, *caller_caps))
>  		goto out;
>  	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>  		goto out;
> +deny:
>  	ret = -EPERM;
>  out:
>  	rcu_read_unlock();
> @@ -238,8 +259,10 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>   * cap_ptrace_traceme - Determine whether another process may trace the current
>   * @parent: The task proposed to be the tracer
>   *
> - * If parent is in the same or an ancestor user_ns and has all current's
> - * capabilities, then ptrace access is allowed.
> + * If parent doesn't have CAP_SETFCAP and current is in another user_ns
> + * that setns() would keep parent out of, then ptrace access is denied.
> + * Otherwise, if parent is in the same or an ancestor user_ns and has all
> + * current's capabilities, then ptrace access is allowed.
>   * If parent has the ptrace capability to current's user_ns, then ptrace
>   * access is allowed.
>   * Else denied.
> @@ -255,11 +278,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
>  	rcu_read_lock();
>  	cred = __task_cred(parent);
>  	child_cred = current_cred();
> +	if (cap_ptrace_borrows_setfcap(cred, child_cred))
> +		goto deny;
>  	if (cred->user_ns == child_cred->user_ns &&
>  	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
>  		goto out;
>  	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
>  		goto out;
> +deny:
>  	ret = -EPERM;
>  out:
>  	rcu_read_unlock();
> 
> -- 
> 2.55.0
