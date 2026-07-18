Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81EB12F585;
	Sat, 18 Jul 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399519; cv=none; b=XET5LvmybLSVqgv+Wbmh+etlqqED1lYyVaXKyeQ67qGQtspvFqrySLUUo9xxIxua6P0WkPLgJFjVNQRxHatYfAse1QAaMdRDSM/Sbo3/+Q+tcLS1HhZaVnEI3w3beSVpVYjuT9wanQP6nyewU4z9VFIXah6iHPvEM6KZgWNsVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399519; c=relaxed/simple;
	bh=Xel70xnnb9gAyVE13B6yVCWav0JonmegNaR6PshlpfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwkx131QLYmCGt7lWH4DStb08PlSWW0QkkXGV9E4YU0kjX96yb13Me+qOSNum4hrqDZrZERY0ni059JY9XxPxrHVRbeAWkW5sLo0vRmkbVDQ/GMvpGizlKXAKFOojJHjHoFD6KSdHne6qUJ6otN2AXYOrQIN04ywzXG+uhonqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdjtkNRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdjtkNRj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7BC51F000E9;
	Sat, 18 Jul 2026 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399518;
	bh=K/moYaw0v48nPtIY2Hoe3TxLOuZ/m5whZzGVhenzI2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gdjtkNRj0W3jr1or9pOU4Gqrq5zaWki7dYuB5FPJrxk2oOQIJGS5zScWMWbQO8Fsu
	 5E8MOiejEU66MYKaCpJeKWBvVIia8uEkNCrKy0j6gTAcBBBt+ZPDoOLE80bYS7vynH
	 zFsELCtvOmiJ7qOSEjJHC6gvaoHj0jd4aNn5e+CkZsa3m/ugQXdEbN7fiKM46X0CJ1
	 LOBNCVkYcuj2tRS7THDvTgBCdCbEfaQZlMI7qw1E4NbjZGCsNTNUBJx2bnA4yNDrMP
	 uNVonvvpaDJbjj9TeCYAvrLpQMrY6/LUMjFofCTzDxcecFW0oomIiuuGibY2uOn/wZ
	 0aI2qG7NaBjZg==
Date: Sat, 18 Jul 2026 21:31:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] keys: make keyring key-chunk byte order agree with
 keyring_diff_objects()
Message-ID: <alvGmvvxz7bb0EHN@kernel.org>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
 <20260712014500.480410-3-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712014500.480410-3-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 09:44:59PM -0400, Michael Bommarito wrote:
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

Add to +1 version.

BR, Jarkko
