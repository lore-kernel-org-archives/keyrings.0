Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624963;
	b=yZfVB1RRPea2Id7kPyi4Jv8OFfR0E5SZCQ7yBTCYzefnABLcKcHsBtfn3Rk7XxJrZjk6
	 eitL++ACQQPkwlBoLzQpU5t487rqO321X6adSwQyr9Hau0Tbaivx3tmslg4HcwuZvwnop
	 PqwpTC73jkSCyX1JCdLL4/AJQ4Bdy2DAbFTkl6Nc16cyhC4dQOkcgd2B22FiZ+SLwl4Kj
	 lf9QQwxyUjDNXcy5SvfbZE8A8ZTt7IDUO0MdJQzDrEeQMs5CpmV4yM1LAD0JZCUNMa4D/
	 +WADN/thtdg7tNdghpn1oRIcfOTKr3xVNPEOuW4Tq76G5f3EGQMv1GoiKfEioW1zKpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624963;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W6XIwPfFpbeL4de4MB4+vslMMPf8d2gDcxbsmH203TM=;
	b=nurNwn8yipBacz0PhTg7Rh0GWvGgWbLr8oxypnXGHZjvbgWSViKX4RXsgeAYPG+URaGz
	 SADzFiVHnsx2rd2LUOAuL5rmGhXs4Yw1xhu5B00P0/QTj82kcc3svim/n8JyegNhPp68W
	 EyX3J9GktqC7bqWHBBaChWID7SMIwJfuWQXb1r7lmXL7aLJB7EJJ/mzSK63eH3BZhjFUP
	 T4kMxJgJH4ZS7So9jbl9bqik2vBJdb+mvMJ4xezjddp/bFEIBOV6+0J47PakgrVEZ6Wfi
	 Hna25LQ7lbKd3WMb4vcfYz9rxgSrQbuDmOPgBV3zLHf5q/2htW1YK7HJW0hayA1R8ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILWMgllE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 34DE9606A319;
	Wed, 21 Oct 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILWMgllE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4FA131F000C1;
	Wed, 21 Oct 2026 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624962;
	bh=W6XIwPfFpbeL4de4MB4+vslMMPf8d2gDcxbsmH203TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ILWMgllEK8Gvsg4DEMa7laV/hkuoyKY43q7Ve3QIsUzKumWSvyUOGZy8aHZgZ7P1r
	 PPh+oGm1l/5u4M+sZ0dyYwjv0aLSYhaQslIhA3haYdw5kdLXMh98QP2AdkTDfpU8BN
	 q3DUsuFyLQky6Ad9PKluFO4ZxbvN4Ammm1IVGY/+RRRL61VqxwFrWaNM5JbFjGK8yt
	 KM45UisgAX0T6YVopVM1Hxjupl4B2nWxXE1x3NRNKFwRqTWgLOh35Pm+nCzbdLYc4u
	 Kv/t7gozZACsF5mpCFaiUk5nC8psMoSUDJF3d33bN5afEcrRWxogVC/84EqrYu7BHE
	 rt3Z/BUdQuifQ==
Date: Thu, 22 Oct 2026 02:22:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atlJPhTqLaa0EEDa@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
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
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>

On Sat, Oct 17, 2026 at 12:53:03AM +0300, Jarkko Sakkinen wrote:
> Linux keyring would be better off without struct assoc_array given the
> overhead caused by sole ownership of it. Linux has multiple popular choices
> for key-value store and there is nothing special in lib/assoc_array.c that
> would make it stand out enough to be ratiaonalize the time spent on
> maintaining it.
> 
> A keyring has a sparse data population, making rhashtable a plausible
> choice. Multiple subsystems rely on it, and best of all, rhashtable has
> dedicated maintainers.
> 
> Replace assoc_array with struct keyring_index, allocated for a keyring on
> its first link attempt. Initialize its ht member with rhashtable_init()
> to store links indexed by key type, domain tag and description.
> 
> Maintain two linked lists in the index:
> 
> - all: enumerate committed links without retrying hash table walks when
>   the table resizes.
> - keyrings: visit nested keyrings during recursive search without scanning
>   links to other key types.
> 
> A key can belong to several keyrings. Represent each link with struct
> keyring_link so it has separate hash table and list nodes and holds its
> own key reference. Traverse the lists under RCU and defer freeing removed
> links and dropping their key references until after a grace period.
> 
> Assisted-by: LLM
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

In addition to addressing Eric's and David's comments, I'll align the
change with Kyle's fix (and rewrite the commit message).

Br, Jarkko
