Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0F49620;
	Sat, 18 Jul 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400405; cv=none; b=WTrjEOGru9r9GWHQayrVa+hqq0MyJzIQoUjLloIgH//TETHfEzcGIXVEThhM/f/E9i+C6ip2OSNjS/R20U2oR/A3MYXsQyf6Se8W0f0C57k9bi+SvTxTCADBrV/yKqx1WCy+X7mgBbrnTfwVL+K2Ef3D44wsOtnQNY/RzEvGeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400405; c=relaxed/simple;
	bh=8Vkd0KRfqaHkHb6QC4dszDVYBJTMN0l9e1rRr06nd0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtgQWDpvhr6PtIldJtfSFh+felRT0w4uhJUQxNEjgc5f7NU/q7ud6SRavFmVElP661cSBGVAxnhZtDLG8f3UMu2uGs3PcXnCaYTscoMemn9armwJYqFz0HQmSaRFGGv5YWhjwwAposbufieN8zroXmY08pydnDOW7uWXquCA32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQv2TjqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQv2TjqK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 258E21F000E9;
	Sat, 18 Jul 2026 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784400403;
	bh=r+sTzpKNGblb486fJ1NlR64/DGMdiOabiFDyov973yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQv2TjqKsbCCqQf3IhWsk5GHxzgCi6LRx7cVC3yZHwdbnYnf4ERAqglzmrB9zTHt3
	 im+4oXXaU4V9SEqJrCLN1P+uJqE1ueigTGQlzovRFjCmlqhSi5X8i66dGeDGoc/kYo
	 RqzL+DCCkgq+VbADPZa/1mP7D1qLfWgcwwqt4S+c0zfbqwEqUxzS16Sm8zmCwsSH9G
	 yqnTjcOF2+/BY9ayf7WjK2YxhDBiGsFTZU/Kvanrv0ydbDdSkdZZBQodj6Jm4Sth7B
	 /zh9Rc62U9Lt3WpAygKkSatj5lXDWarRmlfa8/q1TL+yCqBgHLihzAdZYVqJJLsjqZ
	 enah2sNfqWwgA==
Date: Sat, 18 Jul 2026 21:46:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] assoc_array: trim the final shortcut word using
 the current chunk end
Message-ID: <alvKED66fSFFcl1Z@kernel.org>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-4-michael.bommarito@gmail.com>
 <alvIBm3Po_1gX6g_@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alvIBm3Po_1gX6g_@kernel.org>

On Sat, Jul 18, 2026 at 09:38:01PM +0300, Jarkko Sakkinen wrote:
> On Tue, Jul 14, 2026 at 07:54:51AM -0400, Michael Bommarito wrote:
> > assoc_array_walk() masks off the bits past shortcut->skip_to_level in the
> > word that contains skip_to_level, gated on
> > round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > skip_to_level.
> > 
> > That guard is wrong in two opposite ways:
> > 
> >  - When sc_level is word-aligned (every word after the first) round_up()
> >    is a no-op, so the guard is sc_level > skip_to_level and never fires for
> >    the word that holds skip_to_level.  A shortcut that spans more than one
> >    word and ends in the middle of its last word leaves that word untrimmed,
> >    and its stale high bits leak into the dissimilarity word and can steer
> >    the walk down the wrong descendant.
> > 
> >  - When sc_level is unaligned (the first word) and skip_to_level sits on
> >    the next chunk boundary, sc_level + CHUNK would exceed skip_to_level and
> >    fire the trim with shift = skip_to_level & CHUNK_MASK == 0, which clears
> >    the whole dissimilarity word and makes a differing shortcut compare
> >    equal.
> > 
> > Use the end of the chunk that contains sc_level instead:
> > 
> > 	skip_to_level < round_down(sc_level, CHUNK) + CHUNK
> > 
> > For an aligned sc_level whose word holds skip_to_level this now fires (the
> > first bug); for an unaligned sc_level with skip_to_level on the following
> > boundary it does not, so shift is never 0 when the branch runs and the trim
> > never clears the whole word.
> > 
> > Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> >  lib/assoc_array.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> > index bcc6e0a013eb8..b6c9723e12ced 100644
> > --- a/lib/assoc_array.c
> > +++ b/lib/assoc_array.c
> > @@ -255,7 +255,8 @@ assoc_array_walk(const struct assoc_array *array,
> >  		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
> >  		dissimilarity = segments ^ sc_segments;
> >  
> > -		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
> > +		if (shortcut->skip_to_level < round_down(sc_level,
> > +				ASSOC_ARRAY_KEY_CHUNK_SIZE) + ASSOC_ARRAY_KEY_CHUNK_SIZE) {
> >  			/* Trim segments that are beyond the shortcut */
> >  			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
> >  			dissimilarity &= ~(ULONG_MAX << shift);
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

Were you able to reproduce this with basic command-line tools? The
patches are verifiable by reading the code but asking this just in
case if you had a snippet at hand (not interested on complex
reproducers).

BR, Jarkko
