Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579304;
	b=yd3Ricz7D4CTCHK6cFZB1BDINYKQwgpCQa8iv6rmsxglszAJXU1xXnwqy+J6sCe4t6kw
	 SDZjn6Vm8KpK1W+OTsIb/YOBEetLeVbxbVl7mgCIu8r8utIlSfLnmLPp+C9ziaNnI7RGW
	 WMImH+VlieoA+Q6BGW8QN1CXQV219T8YXZ/ZPj4DNlXUqpVQi/7UoHqzHOzmyW5/u126Y
	 R0+YBpiamZopTSzps7nvx0eQeYaoBAk79mH4KXuV9uJFYeCqt+RqJ2QrG3gJSyU2EV2vY
	 24wz/O2EzbqwpvYGWUGG3Vp+hEhIK8Ixo0lXrSbYQloWYNybOE4s+ARDwYsCpv21Yyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579304;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0BRupwIuqL6NOK9wHXgZQUdm9H5tKSR/x3n6IQwiFTk=;
	b=SpqlrGmpiHw0Dl7SqZYtZOWCcQvHoUdhpej6kWdp/CG87zAlqBt7VTRonwRVaf6u35Mp
	 90Nc6SFAU2rSWzZk2kVcYt0ZeXmqo6AJmZMZFSvk2hbN+1KvZlRcDta3xuxxDKyyCHG2i
	 CKQPgnZ5U7NAa4d3EIC97SxZ3pz+YuP8Zwoz32HpJXOOpdWakNjQ+PJ7mhc/Lkfvtwy6D
	 Kd0KX+XkR0x3aRWB6W9owbPP0VxZQG8R3dZo/nxEVBeriLTqDsQAUJPaSaSuR316WoIri
	 ZZjLGaUL4GGVHgIDX9PXzRyfmbIiVw5bjARzUou65b1C7w8Ka08zjppY9wL26LllcNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKEGBbQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358B606A319;
	Wed, 21 Oct 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKEGBbQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B5E1F000C9;
	Wed, 21 Oct 2026 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579303;
	bh=0BRupwIuqL6NOK9wHXgZQUdm9H5tKSR/x3n6IQwiFTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cKEGBbQ77fa0tl/Tnjh2Mn5V32Be9U9fblyTD4ZKNIXcWBHpU5XKLQoGaEj6p2JfD
	 CdnvHktuSMwwVFz6XxSoxRrEZ/APLzHHyo9MDNlilWiMR83Ojbjp15bLc+MhtBj+GY
	 pUC+AtTx5ShOYkW/xLJvjC1Db8meifECrppYT4MTCv2ENlTUzt12bskQZ1X1zm0V7X
	 yuNmYC/As2662G4lTQ4SZ48TVcMADn6owQLT42q3N045pXUtlmlbpEHg1y9vQEsD7F
	 uPWsdoLDnnQ9Zrbmq0RBEFam2AnIbhzww4ssahPNF79ssZgHBUr5BaoM0QNaEkebIf
	 7l9ETbyV6dYhg==
Date: Wed, 21 Oct 2026 12:41:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
Message-ID: <20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
 <atL0BtBrgCtb3QtY@hallyn.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atL0BtBrgCtb3QtY@hallyn.com>

On Fri, Oct 16, 2026 at 11:05:26PM -0500, Serge Hallyn wrote:
> On Wed, Oct 14, 2026 at 08:47:47PM +0000, Josef Bacik wrote:
> > Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> > because a task in such a namespace can write file capabilities that are
> > honoured in the parent.  A task that is already in the namespace has a
> > full capability set there and can't be asked any more, so
> > verify_root_map() goes by what the creator had, now ns->setfcap_level.
> > 
> > But setns() lets other tasks in, and they get the full set as well:
> > 
> >   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
> >   unshare(CLONE_NEWUSER)
> >                                     setns(A's user ns)
> >                                       allowed, euid == ns->owner
> >                                     write "0 0 1" to /proc/self/uid_map
> >                                       ns->setfcap_level is A's -> allowed
> > 
> > or, if A's namespace maps uid 0 already, B sets security.capability on a
> > file.  Either way B ends up with file capabilities that are honoured in
> > the initial namespace, which it could not have written there, nor in a
> > namespace it created itself.
> > 
> > Refuse setns() into a user namespace unless the joiner's CAP_SETFCAP
> > reaches at least as far up as the namespace's setfcap_level.  Then every
> > task in a namespace is entitled to what its setfcap_level says, and the
> > checks on the way to file capabilities can go by the namespace.  This
> > has to apply to every user namespace, also to those that don't map the
> > parent's uid 0: through an idmapped mount, a root user that only exists
> > in the namespace can be stored as the parent's.
> 
> Can you please explain what you mean by this about idmapped mounts?
> 
> It feels like something we should not be trying to protect against.  The
> mere fact that an admin can create an id wormhole with an id mapped
> mount where uid 100000 is mapped to 0 on the host, does not mean that
> everyone who wants to setns to a namespace which maps uid 100000 should
> require CAP_SETFCAP, imo.  It just means the admin should be careful.

Yep. And it is in active use and was an explicit design requirement.
Again, Incus and LXD both do this on purpose to avoid shifting an
uid/gid and ensure that access to /var/lib/containers or whatever is
restricted.
