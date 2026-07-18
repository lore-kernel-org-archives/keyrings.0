Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0481A0728;
	Sat, 18 Jul 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399883; cv=none; b=snlK3m52KITrm2j+fh/fpw64giG+tiChQVI4ibgxRBEbYrO5VYMWU2BbIXy9EPU/A4tMTRjCNECtdJoAY1VPMs+uTLuH09Ifgbsh7KHEqDyZG+H2SQurkGkF5ygXuxwSFzWYVO/AXlZXYaG8b0zjvHNGXldLi1Irp/tPDO/Lkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399883; c=relaxed/simple;
	bh=yTpfi5evPdzYgpJNBWuSyVaW924Va8IbbwvNtn6v4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6aKqS1ngwA6ovbYv0JCk2MUJPOQ8aacbqr5+2g5CvcDDijgfsO0URjM5fhmHa5F+/+Wmx/ih4mmJZvy3GjS2smCgsvLcdG74j862Q1TCDENrinUkOWBdNUMEnlnoOA6of9HUefpThXU9JOXkyvkr+jXCTEl31GP3JJkSx5L8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvEKeHWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvEKeHWh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F26A01F000E9;
	Sat, 18 Jul 2026 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399881;
	bh=E3zzHuHP0j4uCuo0L4YoYxnqoGQ+xsWpY7i4//7Q6jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EvEKeHWhKIraQ9Lm6R+gajjEqjGZDPBSM8UTbQtcrBRSsa5UJaF3+yk4oKfdZqMv3
	 Lw5FuO1p2rqbYWKXgU41f4OncMwI2PgB4XQyXq1bRjx6Pq7FbS/ywKp5WawHHU67b5
	 SBQtcFz69HUfBg2jYr1wklWjdLrI6vZIwKG7b7fgG5PFdXIwo7eoRD/d3YjvUC3XDC
	 TLfOYIi4lQLYAFg83Rq6cIbqqg0wfEWpUeHE7Pl47cMO1ADrWtkOa6ai14T/TVc86X
	 RcrlH7lazIj9OgwgJWAWbyuXu5mP+vWeOf3ljc+SjFL1OW0OCcyja2qXl2bdcNcbaZ
	 q80foPyU+PW2g==
Date: Sat, 18 Jul 2026 21:37:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] assoc_array: trim the final shortcut word using
 the current chunk end
Message-ID: <alvIBm3Po_1gX6g_@kernel.org>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-4-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714115451.3773164-4-michael.bommarito@gmail.com>

On Tue, Jul 14, 2026 at 07:54:51AM -0400, Michael Bommarito wrote:
> assoc_array_walk() masks off the bits past shortcut->skip_to_level in the
> word that contains skip_to_level, gated on
> round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > skip_to_level.
> 
> That guard is wrong in two opposite ways:
> 
>  - When sc_level is word-aligned (every word after the first) round_up()
>    is a no-op, so the guard is sc_level > skip_to_level and never fires for
>    the word that holds skip_to_level.  A shortcut that spans more than one
>    word and ends in the middle of its last word leaves that word untrimmed,
>    and its stale high bits leak into the dissimilarity word and can steer
>    the walk down the wrong descendant.
> 
>  - When sc_level is unaligned (the first word) and skip_to_level sits on
>    the next chunk boundary, sc_level + CHUNK would exceed skip_to_level and
>    fire the trim with shift = skip_to_level & CHUNK_MASK == 0, which clears
>    the whole dissimilarity word and makes a differing shortcut compare
>    equal.
> 
> Use the end of the chunk that contains sc_level instead:
> 
> 	skip_to_level < round_down(sc_level, CHUNK) + CHUNK
> 
> For an aligned sc_level whose word holds skip_to_level this now fires (the
> first bug); for an unaligned sc_level with skip_to_level on the following
> boundary it does not, so shift is never 0 when the branch runs and the trim
> never clears the whole word.
> 
> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  lib/assoc_array.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index bcc6e0a013eb8..b6c9723e12ced 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -255,7 +255,8 @@ assoc_array_walk(const struct assoc_array *array,
>  		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
>  		dissimilarity = segments ^ sc_segments;
>  
> -		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
> +		if (shortcut->skip_to_level < round_down(sc_level,
> +				ASSOC_ARRAY_KEY_CHUNK_SIZE) + ASSOC_ARRAY_KEY_CHUNK_SIZE) {
>  			/* Trim segments that are beyond the shortcut */
>  			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
>  			dissimilarity &= ~(ULONG_MAX << shift);
> -- 
> 2.53.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
