Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236569;
	b=wjA4HfFMZdnRyxPMGuh4NvYVoepJNrhoi3Avn6dO/yhltuDKmIb0y8b4ahwRo6beQ0mm
	 eOAgvkace8gjWkTN+wJHpDBfIO0pW297k9LFbQFk0WQ5d0GTAerLPz91HZuMoW141TTda
	 zjNgd8FS5eOGzY9hAdVjFG2lG9EyQHS4ri0gRLd4lWpz8aKIYpxjYHYO+98ADFyXKyh8u
	 Yot2c7N4bimTIMdDrxzFX5uA8DCF1UhUeskQuj8Mm1ybchmOr5LdITP/02ner1rvG8Ge7
	 7EpK8bNrEnWyfb287DDsoGZjcf9SGb9PGhCc0aBPiLjgFTYNmBqVMqdqs7Mi50GDIRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IY9ZqLLHjvsP1ZjH5nJNxhSYcZIDkYWCPHqk+wR0lys=;
	b=Qh5ahhF4CkDzUEm20OLsIKiaxzCjndB2+eeLAwcr+z0AB61wztozQJTCJsmwVRLa8Rka
	 1gPvtZHwQKdjgS1nKeiTJB11L5X+e5klxOiYy9uJxKKxBIDbjSnsPxOgf2q/o3lQyzDA5
	 34dvKsRkPxq/my4gqoMaIKnE0eXtpKvrCzskqaoDtcFzPp4W+/k942VkH/CoP6qkDUccK
	 MDCcv5IEd3gW2jtk6Gk/pGBVJIbSVLV/p0G3XvdhMFIDwuyTz9x9xApMaXELkOEAK3bDm
	 V22OI7R4429rh0csPlFfINPRp8A8uJOI4jSwqVkqw0kP8e0pybrJPCs9F0zkTDYV9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwhLvKwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 816FC606A31C;
	Mon,  9 Nov 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwhLvKwI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9BB101F0089F;
	Mon,  9 Nov 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236569;
	bh=IY9ZqLLHjvsP1ZjH5nJNxhSYcZIDkYWCPHqk+wR0lys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CwhLvKwI7BRoFKFMhVvXEnwREVqDNNJffagevGZOIaEPVAMvv9Opkbkzgcmy6qzhk
	 /vNr8v942nn45HgpED4mMxRAwUZt/xB6afT3N/K9SP8B7ahCX1BY2hRUTfFgQm48oR
	 aIijhjG13i7HL7Q2zn3JAQ+zSrHfKaHew3kQOzzvM14z6PtVguuzOxsx9WSDUsLwKN
	 yrZ/HBErn/kqMLY8s4/AhIH+Hq0Gm7ngb1W4/CdQoP2TdSKFEK+kPwqDtuS0+JJuOK
	 Kwm8Ifh9QrG0GOSMngWctPKRcKcghUkWLCnIV4TFDq33LeXXaEZbQW8KFVt3qjmy5T
	 g9ZquNW1p2QTg==
Date: Mon, 9 Nov 2026 17:02:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: do not let an unmatched key decide the search
 result
Message-ID: <avHglR4H-YNwCTpO@kernel.org>
References: <20261109032931.80406-2-weiguixiong@bytedance.com>
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
In-Reply-To: <20261109032931.80406-2-weiguixiong@bytedance.com>

On Mon, Nov 09, 2026 at 11:29:20AM +0800, Guixiong Wei wrote:
> With the dns_resolver key type available, put a key named "foo" in a
> fresh session keyring, revoke it, and search for "bar":
> 
>   keyctl new_session >/dev/null
>   A=$(printf '127.0.0.1\0' | keyctl padd dns_resolver foo @s)
>   keyctl revoke "$A"
>   keyctl search @s dns_resolver bar
> 
> Results:
> 
>   keyctl_search: Key has been revoked
> 
> The search returns -EKEYREVOKED even though there is no key named "bar".
> It should return -ENOKEY.
> 
> A dns_resolver search walks the keys in the keyring and uses
> dns_resolver_cmp() to compare their descriptions with the requested
> name. When keyring_search_iterator() sees the revoked "foo" key, it
> records -EKEYREVOKED in ctx->result and skips the key before comparing
> its description. The search continues, but without a match it returns
> the error recorded for "foo".
> 
> Call the match callback before checking for invalidated, revoked or
> expired keys. A nonmatching key then leaves ctx->result alone.
> 
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Closes: https://lore.kernel.org/lkml/avDG8G-Jl1YsmfCs@kernel.org/
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Sorry, I could not help complaining about reproducer last time because
it was at the surface :-) It's a great sanity check to do if it is
possible without huge effort (i.e. mainly with shell scripting and
keyutils)>

And since the bug is already out in the public there's nothing
secretive showing "how it is done".

Thank you!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
