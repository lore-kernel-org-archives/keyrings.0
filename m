Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF27224AF9;
	Wed,  4 Mar 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583426; cv=none; b=LrZodDj40yQcf9ByzF9VJQRNg0apWlFIqzRXk0rPTzrg0c9aDAYTAmW3iEcUm3u3Lyfn09Kj3Ng8GYJH6RYH0g+E2b7CvRAbiAMfbvfM4jgiOXqWSenkwkhB5YPXpKgyrLrrwAQl/qdEkoaJyiz0NBeK9rkE3c2LCvx1rY3Cv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583426; c=relaxed/simple;
	bh=RQweczyZ/GYgBbGsS+waDZCmi8Z+YLhUKDr5b6Jr5pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwzgNTN4EocrN7CTVH3NeBm4m3bruSIyejZjv9yF0zzX1eNiqWPZq+j2dGGQyE/WActzbv5tlE0DNEhwKZtuWJm1wDN3/lWArdTUfTMX3cXOsLOXIHoDpxBGI3dAcPdIFG/km9dvpI62xb1tNA7mNBxWC1z/Fw6gxfm89IxrXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRkjWgLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRkjWgLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBADC19422;
	Wed,  4 Mar 2026 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772583426;
	bh=RQweczyZ/GYgBbGsS+waDZCmi8Z+YLhUKDr5b6Jr5pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRkjWgLPI1/qKWYa4ltLRnlZ5lo9tW2HUdzNDa76IfOUsXmkk6t74q6WsUR/nBSvC
	 tiT3+FYfq27hJIsiUIMQ1wqKcBhFb3GuAds3GMcyaofrM3DkJLEOUAe1bzWIVcVyHM
	 yDOY5AEAgJDPxwl0pC/uWjOcu1CB/UNisNfxvf3l/qLPVRaM8ykm/Mu+QkWfWG0I/I
	 cVBj1yiwt7Tl8Uji7LMH1Y6PuZgTjhvXejR/m7XmI8Ckfubkl9V16MiGNARB6+xoWI
	 LzxugNes8fGy0a4oK+NCDWy3wbjqWzT0vqfmmZvI29yzf/2fAmjV8QjqZaaZxbNdks
	 zD5tDocvwuSUA==
Date: Wed, 4 Mar 2026 02:17:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Use kmalloc_flex() to improve user_preparse()
Message-ID: <aad5_jRIBZzf3s6z@kernel.org>
References: <20260302111309.937726-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302111309.937726-3-thorsten.blum@linux.dev>

On Mon, Mar 02, 2026 at 12:13:11PM +0100, Thorsten Blum wrote:
> Use kmalloc_flex() when allocating a new 'struct user_key_payload' in
> user_preparse() to replace the open-coded size arithmetic and to keep
> the size type-safe.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/keys/user_defined.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> index 686d56e4cc85..6f88b507f927 100644
> --- a/security/keys/user_defined.c
> +++ b/security/keys/user_defined.c
> @@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>  	if (datalen == 0 || datalen > 32767 || !prep->data)
>  		return -EINVAL;
>  
> -	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
> +	upayload = kmalloc_flex(*upayload, data, datalen);
>  	if (!upayload)
>  		return -ENOMEM;
>  
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 

David, do we want this?

BR, Jarkko
