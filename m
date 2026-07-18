Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055C175A84;
	Sat, 18 Jul 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399400; cv=none; b=K59LwPPI4whX7TmE5CqRqGrHfTmx7ovELX+4/cI8sKrV88R09lgN/Z08Rn/opiqBNK6etT/ruMpBtWUJPlPJ/6JG35byJOGw3/VHQBRVmpceZcBBWI97N52b7YScFpLgZeDpGIPDw8c11gn6qI88JlPFknU3jxekZuw+8yO051U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399400; c=relaxed/simple;
	bh=tvGvnFc893xuNgewU5zp63xWKrZBef6lub1xxFGqU14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdAhjZpAozuqhV1Mf4srvPrTJ0HheFzx2uejR2QHC8RsJRSqgxL4aPrAJhchvnPU9HdmdvWKXALAmEBF+DPZktPgMIjCQNTmDhlJJLeIotQRGpZxjlP6FvV3iIVbLM6kVZWG0U6X4k5jhcQutvo4HYZu/6Hnm201VVC9IKNGTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw/ixMF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw/ixMF8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 154481F000E9;
	Sat, 18 Jul 2026 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399399;
	bh=6AvkPOKgxwBxs19nAkYt3Wwq3SVPQcZ0S5BNBSfozsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iw/ixMF8vp4Zxt8NnLSTneRuQKH5C81Zz9A1DMd4nQkMeRyW2YkqKJPDFpC81gUhv
	 Ti/Cpm0vGZ76LPWy3WLcTahIUqfhVD5FxRxER0/dmrAqRH7hkLYHAgm0nAqa9rpH94
	 LOgQpHi+x77S6+c1KbLH060uy4fBpF7rcr8dPjUeWWJXKJ2vQbAfeWCw022OiBYf/8
	 pf12+uaM9eMXW/KUvBEORxI7tmezp1zbfc9sXWlSnxYz1/TVpZzGf+PLPhSeT58AWg
	 I0rdm9/jb6fV8ySxY6PWOy0ADgXLfhRG94uQBqDsBvcoBga+/eAjEHtRaMXGzUVgxt
	 T9A4Rr0gx46GQ==
Date: Sat, 18 Jul 2026 21:29:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] keys: fix out-of-bounds read in
 keyring_get_key_chunk()
Message-ID: <alvGI4JL4qaiun2z@kernel.org>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
 <20260712014500.480410-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712014500.480410-2-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 09:44:58PM -0400, Michael Bommarito wrote:
> For description-level chunks keyring_get_key_chunk() advances the read
> pointer by level * sizeof(long) past the inline prefix but only
> bounds-checks the prefix, so a long enough key description is read past
> its kmemdup(desc, desc_len + 1) allocation.  Compute the full byte
> offset and bounds-check the description against it before reading.
> 
> The walk only reaches a description-level chunk when two keys collide
> through the hash, x, type and domain_tag chunks, so this is reached from
> an unprivileged add_key(2) with a crafted pair of same-type keys whose
> index hashes collide; KASAN reports a slab-out-of-bounds read.
> 
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  security/keys/keyring.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> KASAN, x86_64: add_key(2) of a crafted hash-colliding "user"-key pair
> (~63-byte descriptions) reports
> 
>   BUG: KASAN: slab-out-of-bounds in keyring_get_key_chunk
>   keyring_get_key_chunk <- assoc_array_insert <- __key_link_begin
>     <- __do_sys_add_key
> 
> reading one byte past the description allocation; the same trigger is
> KASAN-clean with this patch.  On a kernel built without init-on-alloc,
> reading the colliding keyring back with KEYCTL_READ returns
> uninitialized slab until patches 2 and 3 are applied too.  Trigger
> available off-list.
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 7a2ee0ded7c93..1739373172ad5 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -270,7 +270,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
>  	const struct keyring_index_key *index_key = data;
>  	unsigned long chunk = 0;
>  	const u8 *d;
> -	int desc_len = index_key->desc_len, n = sizeof(chunk);
> +	int desc_len = index_key->desc_len, n = sizeof(chunk), offset;

Just a nut but this is quite nasty looking statement to begin with, so
at least I would not extend it.

I'd add "int offset" to its own line. Maybe for the sake of clarity it
should be also unsigned int unless negative values hold some merit.

>  
>  	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
>  	switch (level) {
> @@ -284,12 +284,12 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
>  		return (unsigned long)index_key->domain_tag;
>  	default:
>  		level -= 4;
> -		if (desc_len <= sizeof(index_key->desc))
> +		offset = sizeof(index_key->desc) + level * sizeof(long);
> +		if (desc_len <= offset)
>  			return 0;
>  
> -		d = index_key->description + sizeof(index_key->desc);
> -		d += level * sizeof(long);
> -		desc_len -= sizeof(index_key->desc);
> +		d = index_key->description + offset;
> +		desc_len -= offset;
>  		if (desc_len > n)
>  			desc_len = n;
>  		do {
> -- 
> 2.53.0
> 

BR, Jarkko
