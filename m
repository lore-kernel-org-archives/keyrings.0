Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678308;
	b=Ev66eAb9cU0ECTCThDeuou5XKB6ccGJUHtzBEDIXJlUszcFO/2gLI2b/aKwQik0oTF72
	 vUeT4v963fHkWbbpMZ+JtjrZRv/YHUk+m3W0zkppx7uH7orC0NfwQWZiTd/oyzOSwquFb
	 41b4/2h/ygWDys2035v88bMLP4uMqUMKs1g23UFgwTtuqo8lQbPUgsoC7NluUYk2GJ2zp
	 kJbSCplmOdLm7SgIBlW8fyS+giJS2bxN55nCBaa5Ji9Wgv9FrVovgEBQhNdBJgVaajwMj
	 rIM64Vi6aGr0Qty8U5QfxnjxCUwA/kmM4/AHsWKLrmcYFdTIQYe+PM2uiFd+3t8IvAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678308;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sdWXqojfjGTSFr00juTUfrNfMW8pB30k4KgMGHp/7Zo=;
	b=KIGCGsEdUfFznzFh8+F2Vgq3BiWVnmOPTH3rj5hCrT9GubMadns3PZq0kNAQpt1mNqno
	 r4dJYid7EZ870tj4buBitlxJx6fcbIZYkUiGsOD9/2sCF+u2SUcBgayJoSi6vucadmr8o
	 DnCGW1nhYaLFvf+SvpRf0zNPB4B4ROQy2GwQQkbPn6wQAO2pfOJfvz878gFiNUI7lhDqp
	 +gCxL+BUon/nEzMZJjkD0rpJr+tGgfnXFQqOPGZGvaA9KjW/iexCaViMPjdR23aqigFoE
	 iVWYXniMpZI8W8udBYwcwo6Bn3tbsDyJ1sSJeXsnBCbnlq4RlQEl6VJzff6UXg2KY/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6NhYbZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E4FBC606A31D;
	Thu, 22 Oct 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6NhYbZT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 03AD51F000C1;
	Thu, 22 Oct 2026 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678307;
	bh=sdWXqojfjGTSFr00juTUfrNfMW8pB30k4KgMGHp/7Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6NhYbZTtd8QRlgEyiQxDwFVZJT0DMj90sP0MlItMnDIQdbJjW8RGQLtWrI9Mvzgc
	 QiOzri01afOr/HByryTDifj7XjvzNBwZ4GK5Sn4fHQ7TFJL+u+iVEVD0a/gUmbdg2k
	 S449PYAF/UcKsKZ9lKkx3M3JLbGtM7B0ZD10DE8tG8gH3QOkqqA1RoOAvpPj+XCSQZ
	 0fJ1oIDCDHPkXzxo0isGlF8KqIrbdAGfBJo3cIzrEkyapFV+RzJAITklP7DDsMPAfA
	 beuSjsb0g1PKyVKhw+pqNtCOke51sr0c6sSU9rRQEdApPbKZYv/0vCGxZrCJ/w1fDT
	 Qkad5XJrZ9uFw==
Date: Thu, 22 Oct 2026 17:11:43 +0300
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
Message-ID: <atoZnxCgdrs8HNbS@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
 <atlJPhTqLaa0EEDa@kernel.org>
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
In-Reply-To: <atlJPhTqLaa0EEDa@kernel.org>

On Thu, Oct 22, 2026 at 02:22:43AM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 17, 2026 at 12:53:03AM +0300, Jarkko Sakkinen wrote:
> > Linux keyring would be better off without struct assoc_array given the
> > overhead caused by sole ownership of it. Linux has multiple popular choices
> > for key-value store and there is nothing special in lib/assoc_array.c that
> > would make it stand out enough to be ratiaonalize the time spent on
> > maintaining it.
> > 
> > A keyring has a sparse data population, making rhashtable a plausible
> > choice. Multiple subsystems rely on it, and best of all, rhashtable has
> > dedicated maintainers.
> > 
> > Replace assoc_array with struct keyring_index, allocated for a keyring on
> > its first link attempt. Initialize its ht member with rhashtable_init()
> > to store links indexed by key type, domain tag and description.
> > 
> > Maintain two linked lists in the index:
> > 
> > - all: enumerate committed links without retrying hash table walks when
> >   the table resizes.
> > - keyrings: visit nested keyrings during recursive search without scanning
> >   links to other key types.
> > 
> > A key can belong to several keyrings. Represent each link with struct
> > keyring_link so it has separate hash table and list nodes and holds its
> > own key reference. Traverse the lists under RCU and defer freeing removed
> > links and dropping their key references until after a grace period.
> > 
> > Assisted-by: LLM
> > Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> In addition to addressing Eric's and David's comments, I'll align the
> change with Kyle's fix (and rewrite the commit message).

This turned out not to be difficult. I just purposely had retained the
original behavior of the this patch when I rebased it yesterday until I
had my keyring PR out so could not know :-)

Kyle's fix came at really great spot because if it had came after this
feature had landed stable kernels would need a different fix than the
mainline (given that they build on top of different data structures).

Br, Jarkko
