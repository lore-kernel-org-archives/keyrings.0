Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B11FF7C8;
	Sat, 18 Jul 2026 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399806; cv=none; b=md/TrJEWu353sTY6WD8PQMBZRDJlwHUfQ2dREat6aCA6wzJqsKDI7uod6M4NXSIvkqKCSA4kjZ57LsmA2W43UP+kXoYx/9Yn3vuY1Ah9yPcWnZo08f6Ee/dYbpBOGGaWmFDvLYhSpGhhTHrU81tZZomVk9eoEsclWklg6hCj44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399806; c=relaxed/simple;
	bh=bVVF6MBgxs20VG3jOARLzVgOCgqPcBny1RZ7KCy9j6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjDSiYeyTjKXFhNeXGNNo23qSz/LRKlH5KCE/7ujnkzmCFXkDGfGRBL3c4pJgfp77Mg9xcP4ombhdObD3HdC51emQu3iDq24/HIHNTqv8ePVZwhEyrcWyufp/1TzQPj6YvTo/q0vCEnEqy7HoIYway+ETdXwrOM2mRa5IvVwI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkWdBRXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkWdBRXz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1BB441F000E9;
	Sat, 18 Jul 2026 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399804;
	bh=i3STXyzKH5SOa/kBEuxBHqxd1s5l4Ni0gM6kcG8Y2rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RkWdBRXz2mwMrHtAJQhTsvvZWYmMOeYYVm8ORN6RgMK/Gj4/cY9NvlRKcWL4c5Lwa
	 4+MMOQxIHHqR9CzvDdq8nO6OBZQRBLmEv/DhPrp5Ty4PTVmevLizYIBb4l2oPej3dR
	 iw1xQ1trtN+DOJMfxjWPo/LmsN7z6laj2qR+W6YEy2tReUxdEcc27vsFev5LJ2grk8
	 8wk42o2gJ+2sQ9H2HqNFPipov1H4nU7WLGudbHn07Fc00AKMSkUT7LzQ07w2Hs7ecq
	 WWNoFTd6ME6+8U1RV4/+0Qujqn4XgV70Vy61TVpsEXQN327TyCll5IDKfRbUpkrp9P
	 ge3axzsizOIRw==
Date: Sat, 18 Jul 2026 21:36:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] keys: fix out-of-bounds read in
 keyring_get_key_chunk()
Message-ID: <alvHuX78xVfyYclS@kernel.org>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714115451.3773164-2-michael.bommarito@gmail.com>

On Tue, Jul 14, 2026 at 07:54:49AM -0400, Michael Bommarito wrote:
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

Same feedback as before.

BR, Jarkko

