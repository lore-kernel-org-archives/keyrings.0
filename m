Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792817897;
	b=Ryn77VQhrT2+vM2a+RJhQuOoGhQJVmZGB3iMLyEyhgP+oE/PFv6rTH98hHsN5eYGzAiQ
	 UCAhoMaRSk5vEoMXRVFodHkbLaRzDEPtV3AhCe9EkqBzZj4Z9DNl4bw5iidwhWgs1sG6Q
	 j+Hyz7aGHP9XzboGCLgwURpCGv8FUFi/SakedOjBpIFFLOrpi8660CUMDHpjFtZEPFPFi
	 EhtJFQF03qpvKtYUzlSRPNfhWanfZxR2Eh93/6UsEvju5KtwLL6cMj602j3Tx8K65amL2
	 Tv+2XjtglQ1ZAWa4/6hgXCqCGbJ7fCz8o0Rur12bSDvan02tr2iFkqdIaIunOuCm4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uQmfOxNvc9iIeOJDbEHBzdrsJihOFNqCRHmYsABg43o=;
	b=ZXgR+nnkv2KkSWR2d68CQsSo9DfeafJWKeu/JMQrwQhIbOuYVOiDrp3QrlfAfZxQcgsm
	 8dtQtN64fskwkC2sYGpeXwtTxVnHH5WjNwufGoP4K70klPyfz64dqLy1DsTZix884GwCa
	 Y2QUE6kqadlRNXUMY3tN4zgmvPoH6GI1KJ/dGiNXMaC5UWdqvoDGeIykuAj0fYAt52SVM
	 XxW+M0v/o8NfJi5OXCWEAV9VzlJh/OlKnJ0ve80jprH0GuvjaXZYvZReniFe+b9XPLhfB
	 IhIy5Y+DUkZIzyx+p8A879cmqGzZCI5Q0KR8XhceOc9zVTjwFyubIQFU+lfQEVP482w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVup365A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 97501606A31A;
	Sat, 24 Oct 2026 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVup365A
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9302E1F01825;
	Sat, 24 Oct 2026 04:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792817897;
	bh=uQmfOxNvc9iIeOJDbEHBzdrsJihOFNqCRHmYsABg43o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aVup365AqJh+oAlm24iBEBkK1C+xYqVGJX7udxhoFJbdR/6Hwm6f0dwaBmo8di454
	 cHDO7c/zz+fF/XFthNcf/eZIAu0OhY7EJeWxQWMAkAMgSU49XNYhjjS358pK2DRScW
	 QgC94uRFbNSp1pBOMSYMWNHDC5dvTpIe2m6Huuy3POoQUNqhKLbytO1luz06EFmBrd
	 FS/dXRomtv8oqn2fOXwS6xmm6+8uq5VXoZQLpXzlk51vg1D1RIKnBeQom8vMKPyogn
	 7QPQHXm1wHTJbhFQWNUbjCbN02DtSuFd8O6hgBMucOr3YHdn7Ox+aEfuULQ8DyfkVY
	 ZWxKc2MG/zalQ==
Date: Sat, 24 Oct 2026 07:58:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Replace assoc_array with rhashtable
Message-ID: <atw65V6xfUJpUsN8@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-6-jarkko@kernel.org>
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
In-Reply-To: <20261023120953.1206778-6-jarkko@kernel.org>

I'll just run through three issues that I forgot to update for this
patch set version. I think it was good because probably these could
use some feedback.

On Fri, Oct 23, 2026 at 03:09:25PM +0300, Jarkko Sakkinen wrote:
> +	WARN_ON(rhashtable_remove_fast(&links->ht, &link->node,
> +				       keyring_link_params));
> +	list_del_rcu(&link->list);
> +	WRITE_ONCE(links->nr, links->nr - 1);
> +	call_rcu(&link->rcu, keyring_link_free_rcu);

keyring_remove_link() is called by __key_unlink() and keyring_gc(),
which are infallible operations.

At minimum this should be changed as:

	if (WARN_ON(rhashtable_remove_fast(/* ... */))
		return;
	
	/* ... */

Alternatively, keyring_remove_link() could be fallible operation,
and leave that decision up to the callers.

> +		WARN_ON(rhashtable_replace_fast(&links->ht, &old->node,
> +						&link->node,
> +						keyring_link_params));
> +		list_replace_rcu(&old->list, &link->list);
> +		call_rcu(&old->rcu, keyring_link_free_rcu);

__key_link() is called by __key_instantiate_and_link(), key_link(),
key_move(), construct_alloc_key() and key_reject_and_link() i.e.,
by majority fallible functions.

Are all of these call sites such that if __key_link() was a fallible
operation it would be impossible roll back, or is this something that
could be addressed better?

> +			WARN_ON(rhashtable_remove_fast(&keyring_index_locked(keyring)->ht,
> +						       &link->node,
> +						       keyring_link_params));
> +			call_rcu(&link->rcu, keyring_link_free_rcu);

__key_link_end() goes along the lines of keyring_link_remove().

However these are decided I will remove keyring_link_remove(). There's
enough symbols to get confused already, it has only two call sites and
frankly I'd just want to see its contents open-coded in those sites.
And it makes the level symmetric with __key_link_end().

keyring_link_remove() is type of slop that needs to be wiped away
constantly from any LLM sourced code, at least in my experience as models
tend to build on top of that design, and soon you have a nest.

Br, Jarkko
