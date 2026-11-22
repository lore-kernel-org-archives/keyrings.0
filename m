Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364108;
	b=TO66DzSngxwlhZntLJHBL8azNqYiCfwDDLT+GzPsW9qDxx0SKsNXKHrHdgr7q4CsApBl
	 KriANjJeAbX5E3uxiZDXunot+tA8LYk0AtGater+yQe1yHmzK3mvCAmXmjN9Oi9EL5ffm
	 dJndI5snOyIGMd8O6OOeH+VAD8EK0AEkTjvu0J5g7z44FpVHcZhs4SSWYFeiU2QW+v4xw
	 GTwhTTD++bBKADJM+GWvcyNGXGkg4zVdQ0cZuqg4uqFFP8cOLbk3B2sUjDbIBDSDZ1Fwl
	 L16yU+VwGrMf7xFRzEd6rdr5yblv5djiVmd7iD/l90ME+pVFJnm7ZQzFkd9Q+hBwPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364108;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=sidA8Eikj4NCuusYzJo7PSjkBiaXOdmJGfqzy6mhVLA=;
	b=DJfr1Sj2bqo6lmqncaN3UoxfeGrPUKSB1l6P4RhY0KBuAujEV+iXyg8hGl7A7d2gSAcp
	 9xUYJOiW3E+mFGSpr/breMMGTMHNicSu/0KyD2iXlOagGljaLTq9DI/+dPvv5wwSlyqRP
	 BSKFbjaiNAgIlGpHM1Sa3FM5Xje8SSCnIwxszuoZyKWzIGVArHz33OUAiV8d4zpDQaBaE
	 91uIaJ4dmcTPISYYYNjTcEzj3KwkJR7P5A4WdIWDSwkfE3cpzLmeDXWRjxa6q7NlVuKPm
	 DoELAq9s2MepojZkBGwrL9LRJr/aOreNSHJRNBI8XUoyrL3bYf0igvEwhibvjdozXQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=bS7tYBYm;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6E60A3820;
	Sun, 22 Nov 2026 16:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A6E60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=bS7tYBYm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795364099; bh=Jg096sU21vyNh6oEq9d3agCbhZ6LbEQFdC1QhQMToUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS7tYBYm1lS0vPKSrdKUJYU9IiyMuYvvtKSx0tDvDXpq7HM6gtnFxFLxmIStcH3et
	 3ppCZ5Iz36iQZInpcEZVc1mPA+YAeLLFfvzVXpt8CbPOhYma9+AY/1obg1N510ZcFT
	 TNoAIDzvrKJKCwbU6vc/PIYu+nYulKUZlZg9pWzcqrNHITN/Dcuf2QiiR0NwZelPKL
	 nXxLf/hXrLq8tRiJWlY4hjGeZD4uK2Mzb8/pEEfr+8h/bo6vOfpXTQGLrOf+XmgHIO
	 YeaepmOCdyiVrEZnXDVakTd3N2UHZTW8viQjzWFI8QwLR0BJj4VkcduEUpm1I5hdgx
	 9nQqWY3upTuHw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 937EFB8C; Sun, 22 Nov 2026 10:14:59 -0600 (CST)
Date: Sun, 22 Nov 2026 10:14:59 -0600
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
Message-ID: <awMVA+9Q+7mF7naH@hallyn.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
 <awCB3UkCPzLGRBTk@hallyn.com>
 <awCEjJ8syhv+f4vd@hallyn.com>
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
In-Reply-To: <awCEjJ8syhv+f4vd@hallyn.com>

On Fri, Nov 20, 2026 at 11:34:04AM -0600, Serge E. Hallyn wrote:
> On Fri, Nov 20, 2026 at 11:22:37AM -0600, Serge E. Hallyn wrote:
> > On Tue, Nov 17, 2026 at 07:54:24PM +0000, Josef Bacik wrote:
> > > A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
> > > namespace that another root task created.  Commit db2e718a4798
> > > ("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
> > > from mapping uid 0 into a namespace it creates itself, because tasks in
> > > that namespace could then write file capabilities for its root user.
> > > setns() gives a joiner a full capability set in the namespace too, so
> > > it can do the same there:
> > > 
> > >   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
> > >   unshare(CLONE_NEWUSER)
> > >                                     setns(A's user ns)
> > >                                       allowed, euid == ns->owner
> > >                                     write "0 0 1" to /proc/self/uid_map
> > >                                       A had CAP_SETFCAP -> allowed
> > > 
> > > If A's namespace already maps host uid 0, at any uid, B can set
> > > security.capability on a file right away.  Either way uid 1000 can then
> > 
> > "Either way" here means whether it already maps host uid 0, or whether
> > it has no mappings yet?  I'd just drop 'Either way'.
> > 
> > > run that file with CAP_SYS_ADMIN, which the selftest at the end of this
> > > series shows on an unmodified kernel.
> > > 
> > > The check doesn't look at the joiner's uids, which it can change while
> > 
> > >From here until the 'Fix by', it is confusing whether any given statement
> > refers to the pre-patch or post-patch state.
> > 
> > > keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for
> > 
> > Is this a reference to the next patch?  But that's a completely different
> > commit.
> > 
> > > CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
> > > CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
> > > has no uid_map yet while its parent maps that root user, so that it can
> > > still be mapped.  If that is uid 0 of the parent and the creator of the
> > > namespace didn't have CAP_SETFCAP, the join is let through: only a
> > > writer with CAP_SETFCAP in the parent could map it then.  Containers
> > > that don't map the joiner's root user, tasks with CAP_SETFCAP and
> > > unprivileged users are not affected.
> > > 
> > > Like verify_root_map(), the check is about uid 0 of the joiner's own
> > > namespace.  The root user of an ancestor that it maps at another uid,
> > > and a root user stored through an idmapped mount, are left to whoever
> > > set up that map or mount.
> > > 
> > > Fix by refusing setns() when the joiner doesn't have CAP_SETFCAP and
> > > tasks in the namespace can write file capabilities for the root user of
> > > the joiner's namespace.
> > > 
> > > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > > Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
> > > Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > The code looks good to me,
> > 
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>

I've tested that unprivileged lxc still works with these two patches, so feel
free to add

Tested-by: Serge Hallyn <serge@hallyn.com>

to the first two as well.

-serge
