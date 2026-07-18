Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637426E6F2;
	Sat, 18 Jul 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399567; cv=none; b=fL1MFgLdaU7g/STMy53pkuNrLCYhvOWLVt8Gt6G2KX3LIq26mP5Zm46EQ/Eq8vWwMCF3Jn2Aws6IFcM81a7cXQEBgYUpeEcvv5F0GDyyKqxNoYbByNXPNHaEz8/mwsH/GNLAn24Sj9OuOpTxe1z/NokqmyXtrwML/lAH/fjmAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399567; c=relaxed/simple;
	bh=judBygBy5Y0xVe1h2k476NRr0qwUcyiKcT6hqVEhHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcYmHSVbD+avYAqnrVbOgYsiPLkM+0/ki+Ss1zKkBKQ1IFtVAwongl53myhsEp1Va1b6VkT+04gRpxPKQI4sqM1eVO0wO2ExhxbgTl4GzE0E4XXwaMkaaimTVuz8MTjXcDhUXiLxCWoEJejyj+qIidRkI8YI/NW0HfCqYh+ns/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGU2fzg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGU2fzg+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BDE831F000E9;
	Sat, 18 Jul 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399566;
	bh=BbWZotIQlh5bbXybypTRJcq8h7slw8uQEKO40FJltKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BGU2fzg+OGrr8CdZBxY8i7sHPKGrhYstlwqh2UIXnSb7da2NxiopEomrYV62oDUQQ
	 pv1A2qrbpWgmh4aA2EAFIX4aawsiMw9geUnb9mQ4tu6UlePgwxc+g/OyjjNa1EVTC8
	 2PNrPzIQUbOQJxWTITyKPpi9mlywFh33tzsIBKXlWPnm8IK7FHnhACejNbryhqDXdY
	 o05wHpR6MKbrQ645YWPcZMEQlbZ8xJYQ4m+EmWQHvQa1abve5uSG2kPCy4MVpSRDCu
	 +oTkMPsevQLkbXArMDgQcPbyTpF0IYXJYIJJkEkj9xFuHOZmUg7+6tZuJ+BE4cF2xh
	 zbnBc4xhD758w==
Date: Sat, 18 Jul 2026 21:32:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] assoc_array: trim the final shortcut word when
 skip_to_level is chunk-aligned
Message-ID: <alvGyuUIvjJiRjPk@kernel.org>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
 <20260712014500.480410-4-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712014500.480410-4-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 09:45:00PM -0400, Michael Bommarito wrote:
> assoc_array_walk() masks off the bits past shortcut->skip_to_level in
> the final word of a shortcut before testing it, gated on
> round_up(sc_level, chunk_size) > skip_to_level.  Once sc_level is
> word-aligned (every word after the first) round_up() is a no-op and the
> guard never fires for the word that contains skip_to_level, so its stale
> high bits leak into the dissimilarity word and can steer the walk down
> the wrong descendant.
> 
> Test sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > skip_to_level directly; an
> exact-multiple skip_to_level ends on the boundary and stays untrimmed.
> 
> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  lib/assoc_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index bcc6e0a013eb8..1de2c337f8fcf 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -255,7 +255,7 @@ assoc_array_walk(const struct assoc_array *array,
>  		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
>  		dissimilarity = segments ^ sc_segments;
>  
> -		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
> +		if (sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > shortcut->skip_to_level) {
>  			/* Trim segments that are beyond the shortcut */
>  			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
>  			dissimilarity &= ~(ULONG_MAX << shift);
> -- 
> 2.53.0
> 

Ditto.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
