Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5281A0728;
	Sat, 18 Jul 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399824; cv=none; b=rGl3RDDxzY0etbcgaZrvE2uKv74tz43Pnk1WpU4tHsImwvO/qu/8Oo4ujTPvDzhUj503HlcmZworjnXg2KkkWbgER8v0UAITApjwZ2GHBujBRM8BPJLWsvek0QoRSdW8zHIiJJcU1d2UQ186bRI9b8iq2D2VGjdGLv88dvGcdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399824; c=relaxed/simple;
	bh=cT4Nuv1eYnk23NZ/RJOQ/i4lzukt/S2KJPwtLSelnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL7oh4MiqO1iR6pt6KlAXMTkssM3QtnVSOvl+xWDW4C1lyPE369jSUB3ujM4/AMb4SyCmZKUwoFFWpwOR+9hA6zL4QNElZJI8AMmB4by/R8uLTVAgQOxCLRqAyXl6NWzPB8vL1tPQFtqxUmSTL15whOUeNvyLwaCv+YerjWKZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6TjrZEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6TjrZEb"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CA2A1F000E9;
	Sat, 18 Jul 2026 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399822;
	bh=8LlfVvNwrMOJ1ggyzD+Dx0aRdzwBugcijA8sylDEI+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6TjrZEb4msoOc7BoscYIRCXzRsqNo+83MB8WtYokT7uX4Mi4vgSzyQvdlgCtFzX3
	 J02V1d1Bq/ur9bQXNMc6XHcBhf8A7906UR46NPM6Oy0YYPFYDL/TV+qH4zXWEBJZ2e
	 yB2kyAxkyzVMfbEa2HBChRMvxiZPRXClquA6ZOLmFVQFVLzPv1ltlet0Eq3U72ftqz
	 IW0UIllqAabUzHiTVVbQvU9OKw47lK7GpVQioow8dU3Zdg21QyMKzXp8n7xyuDoyYS
	 oORlQwaGdrDCzF9lEIOBSb0FltBnY6aBYBQpqmDwwY1nT8lNZ4Q6FQyCEtcLs99bEv
	 iA+d29i3V30ww==
Date: Sat, 18 Jul 2026 21:36:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] keys: make keyring key-chunk byte order agree
 with keyring_diff_objects()
Message-ID: <alvHy7Rvn5So1IQI@kernel.org>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-3-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714115451.3773164-3-michael.bommarito@gmail.com>

On Tue, Jul 14, 2026 at 07:54:50AM -0400, Michael Bommarito wrote:
> keyring_get_key_chunk() loads description bytes into the index chunk low
> address first, while keyring_diff_objects() numbers the first differing
> bit from the low end and folds the absolute byte index into the level
> without removing the inline-prefix offset the level already carries.
> The two disagree on byte order and bit position, so the array can be
> told two keys first differ at a bit that does not differ in the chunk
> the walker uses, letting crafted descriptions collide into one node.
> 
> Load the chunk in the order keyring_diff_objects() assumes and drop the
> inline-prefix length when folding the byte index into the level.  This
> only changes the in-memory ordering used to place keys within a keyring;
> add, search and read of non-colliding keys are unaffected.
> 
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  security/keys/keyring.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 1739373172ad5..e7066893e6ffc 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -292,9 +292,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
>  		desc_len -= offset;
>  		if (desc_len > n)
>  			desc_len = n;
> +		d += desc_len;
>  		do {
>  			chunk <<= 8;
> -			chunk |= *d++;
> +			chunk |= *--d;
>  		} while (--desc_len > 0);
>  		return chunk;
>  	}
> @@ -375,7 +376,7 @@ static int keyring_diff_objects(const void *object, const void *data)
>  	return -1;
>  
>  differ_plus_i:
> -	level += i;
> +	level += i - (int)sizeof(a->desc);
>  differ:
>  	i = level * 8 + __ffs(seg_a ^ seg_b);
>  	return i;
> -- 
> 2.53.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
