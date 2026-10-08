Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5F370ADF;
	Thu,  8 Oct 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467882; cv=none; b=aFiX9QuQ9JuEaS4r7vybTUtySIpLjX+CnuOV7YEcvZLyXxWQlGphREtlUirB8S2ahwsdeHLdKjnry1WIstUO6WvgV35SHE03HodCosx1s3XOBMmGipyFmKN6fLCImDXFjC6L8EXHjHZeYAp3r3o8c4E2yT1g/cL07e/LZQp8UfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467882; c=relaxed/simple;
	bh=SHCFdRKZHF7nGgyUHMw8RQ1D9D8yAE8LOO7Mn3Jk8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4i5HkunZfrN3ALiIEr9ntGnGZAi4UnzlwP+hQlIhC4ROloLWBhlLAkyWyxhSYsvCmbVKHLW2aAiPdD7IHHNZlQlke3F46AR2faJuu8jji/es7flKDCryYr6mpLi9DfIdFCai7AonC+R18bCDTxo4DHW1346k0dnpIUK7Lh/QiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=wimmiNCQ; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="wimmiNCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791467876; bh=SHCFdRKZHF7nGgyUHMw8RQ1D9D8yAE8LOO7Mn3Jk8H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wimmiNCQUKqbK364mt2ag1JjHsGSUSjxxoMzawoqnhCzbIKW5NOl0Vewzngef1WBe
	 6hJZhIUAgom+vaTDdXla+V7aq9vRwDKCNkD9IiF+jy9HZ3N7xQYf+V/IzOC3g2wzFA
	 tPjSYVNI+gXZZS1DmzLdR4a2SV/kxP4VM6yFARMDB7zydYpCfKaZdMFf0HBebkq73F
	 k+b+hc/JQfMvDwrlL+uZdpXoimE+F5bG+vKRwvzdmtC31RgskloBCArSzee3FYFglw
	 /wId3ElTcksGULRbe3QvC8lHn6JzHf6x4jnJg9ydwzwnnJDqCy43p4SH60hUl8DNa5
	 HqCgD9KYUTUXw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id DDD43876; Thu,  8 Oct 2026 08:57:56 -0500 (CDT)
Date: Thu, 8 Oct 2026 08:57:56 -0500
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
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Message-ID: <asehZEWAwsJcbqvM@hallyn.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>

On Tue, Oct 06, 2026 at 03:44:16PM +0000, Josef Bacik wrote:
> Hello,
> 
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> stops a root task that has given up CAP_SETFCAP from creating a user
> namespace that maps uid 0 and then writing file capabilities in it that
> the initial namespace honours.  The check only looks at the task that
> creates the namespace, so if somebody who did have CAP_SETFCAP created
> one, there are still several ways around it:
> 
> - setns() into their namespace and write uid_map from inside (patch 2)
> - write "0 0 1" through a uid_map fd that they opened (patch 3)
> - setns() into a namespace of theirs that already maps uid 0 and set
>   security.capability there, no map write needed (patch 4)
> - ptrace one of their tasks and have it do any of the above (patch 5)
> 
> On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
> from its permitted, effective and bounding sets and, through each of
> these, ended up with a file that a uid 1000 user execs with
> CAP_SYS_ADMIN in its effective set.
> 
> Patch 1 adds cred->setfcap_level, which records how far up the
> namespace tree a task's CAP_SETFCAP reached when it entered its
> namespace, and patches 2-5 check it.  Patch 4 is the check that closes
> the class, the map patches make the uid 0 map rule mean what
> db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
> the target is entitled to.
> 
> This does change behaviour.  Everything new is -EPERM:
> 
> - a task that entered a namespace without CAP_SETFCAP outside can't map
>   uid 0 of the outside or write fscaps for that root user anymore
> - a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
>   task without it to map uid 0
> - if a privileged task maps "0 0 1" from the parent for a namespace
>   created by a task without CAP_SETFCAP, that namespace can no longer
>   write fscaps honoured outside
> - PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
>   CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
>   root user
> 
> Rootless containers, privileged runtimes writing the map from the
> parent, nested unprivileged namespaces and containers that don't map
> host uid 0 aren't affected.  The ptrace check is one compare for
> targets in the initial namespace and in namespaces entered without
> the capability.
> 
> Testing: a set of flows run on the base and patched kernels, every
> bypass route above gets -EPERM with the series and the 16 legitimate
> flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
> proc selftests give the same results before and after. Thanks,
> 
> Josef
> 
> ---
> Josef Bacik (5):
>       cred: record how far up CAP_SETFCAP reaches
>       userns: don't let setns() lend the right to map uid 0
>       userns: check the writer too before mapping uid 0
>       capabilities: limit fscaps to where CAP_SETFCAP reaches
>       capabilities: don't let ptrace borrow CAP_SETFCAP

Thanks, Josef.

Would you mind describing what other solutions you considered?  I've been
looking over this set since Tuesday, and finding it hard to reason about.
(Part of that is certainly the nature of the problem, and it's possible
that this is the best/simplest solution.)

If we replaced the userns->parent_could_setfcap bool with a ref to the
creator's cred, then at both setns and write we could check the actor's
credentials, right?  There are probably issues with that specific idea,
but that's why it would be good to see what else you've considered.

Of course UID 0 will always continue to carry privileges even with an
empty cap_eff.  Here we're stopping it from writing filecaps to uid 0
owned files, but if it can open a 0 owned file on the host, like
/bin/sh or a systemd init file, or ptrace a process (in a child ns that
maps parent uid 0) doing so, it can still cause damage.  My point being,
we do need to keep in mind the tradeoff of keeping the code simple
versus the realistic threat of the problem being addressed.

>  include/linux/capability.h   |   4 ++
>  include/linux/cred.h         |   1 +
>  kernel/user_namespace.c      |  40 +++++++++++----
>  security/commoncap.c         | 119 +++++++++++++++++++++++++++++++++++++++++--
>  security/keys/process_keys.c |   1 +
>  5 files changed, 150 insertions(+), 15 deletions(-)
> ---
> base-commit: 7909a3e30a05e40bbc8bfb7f5629ed642abeaab8
> change-id: 20261006-b4-setfcap-userns-d63185a31ce3
