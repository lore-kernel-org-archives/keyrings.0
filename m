Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5D27A916;
	Sat, 18 Jul 2026 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399670; cv=none; b=Q4PLrj/NJVaJlXS9tE4bMj9MrIfnBswXRhldDNzN/kn6cL5SIRmi1GjrBMepluzUN5cIvWSgMrP2mWQEl3kjuAsJJ6rcDQHYNuNKDbCWShWGu0Cj2hKFQ4yvz0JH/t+Zvwac8vdn/XIFuNeqYmpc1ByJjcgOntKQd9p/ne6gF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399670; c=relaxed/simple;
	bh=9KprixqM9lOytO6XODtWIA/ujjFmGUMJSlEM78ELqVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuL2tvYryOevGzXYtfFX2xBW7CPaF2lEQTYBWM/62jNHRk81kLWVCVR8mJKAfTmot8uVpvu9juIjUe9CdqgR3uNClWxPScXsMAHCD9tzUka1vkJF7sLPoCyywDBDJmF9Y4IhpoSvS6az8fXpVZBeYPeRAqbuba+3JueGx9NP7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E979Aw9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E979Aw9p"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A10E1F000E9;
	Sat, 18 Jul 2026 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399667;
	bh=KV5EB8NavPyPw343EkSFuV4bpoaZVdOO/obDQFuFKpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E979Aw9pSl71nDBg6FhtOsr4vqPcZ8LTFLdcSmGbr4BvlVmpReBaUWQh1KQ9+BcUs
	 qZYXUNpX44pmQitW5EnoWYDFNJgnvX3XdKU9VQjRM8HCIZPpyAJwNWMtFK5a1YrKGl
	 YC+IEj2qI1BNc9/MjLlYVovAC+ifmQxoB5Y8CkywkpiWWilf6HifKJXRZdZReFWLUx
	 scSH3vitj9g7e/CSMoLaRg6GGhz5oUX4pWna3nP6PhlEapJODIfymFPViZvCVrTipX
	 /jvi5sgHdbLappZlFEFbxVV72ss8xfya02rWQMxRIQyGv/EpjHNzwqtL0AD+embLoe
	 s86dbsMgMWlzg==
Date: Sat, 18 Jul 2026 21:34:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] assoc_array: trim the final shortcut word when
 skip_to_level is chunk-aligned
Message-ID: <alvHMJ0JoRwptIff@kernel.org>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
 <20260712014500.480410-4-michael.bommarito@gmail.com>
 <alvGyuUIvjJiRjPk@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alvGyuUIvjJiRjPk@kernel.org>

On Sat, Jul 18, 2026 at 09:32:46PM +0300, Jarkko Sakkinen wrote:
> On Sat, Jul 11, 2026 at 09:45:00PM -0400, Michael Bommarito wrote:
> > assoc_array_walk() masks off the bits past shortcut->skip_to_level in
> > the final word of a shortcut before testing it, gated on
> > round_up(sc_level, chunk_size) > skip_to_level.  Once sc_level is
> > word-aligned (every word after the first) round_up() is a no-op and the
> > guard never fires for the word that contains skip_to_level, so its stale
> > high bits leak into the dissimilarity word and can steer the walk down
> > the wrong descendant.
> > 
> > Test sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > skip_to_level directly; an
> > exact-multiple skip_to_level ends on the boundary and stays untrimmed.
> > 
> > Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> >  lib/assoc_array.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> > index bcc6e0a013eb8..1de2c337f8fcf 100644
> > --- a/lib/assoc_array.c
> > +++ b/lib/assoc_array.c
> > @@ -255,7 +255,7 @@ assoc_array_walk(const struct assoc_array *array,
> >  		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
> >  		dissimilarity = segments ^ sc_segments;
> >  
> > -		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
> > +		if (sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > shortcut->skip_to_level) {
> >  			/* Trim segments that are beyond the shortcut */
> >  			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
> >  			dissimilarity &= ~(ULONG_MAX << shift);
> > -- 
> > 2.53.0
> > 
> 
> Ditto.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

On holiday up until end of this month so expect some delay in my
responses.

BR, Jarkko
