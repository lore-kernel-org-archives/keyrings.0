Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54D25EF87;
	Sat,  9 May 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342040; cv=none; b=gYUez16Xuj4saKHxQ3Qn9tWvTL6snkT7bP9UUzPAXLnfFH3EzMcdlgRCp1rTLXnGNZ7kcclnNnVSDBIEQuZb1YSRuv6nWIpJ5EnntBY0StzYIS3WMbcyphkJjna5gpR3r9nG3UG+hXwY6clnTTqj7L5E0OWNEIWr3tVOCSg1hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342040; c=relaxed/simple;
	bh=dsn6L52VxnTeNUOtGszavzH1vhlT3rK+e3GO+cFQvOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2cfHDo+8ah6M1ivlo+YRWn8TuVBQk8vX4l2t5XVBOLQ1ehG3kyscJyTRvaXni4UWri0IN7KEZIMP8nyjaS0E20jshYTHsjX8YwTfHit/ZdKTYn1B96VJvxhwQxM8n5p486QpNjCMRIkCyH0774uwSdgH7g5G/R8W5ZIhgOBaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvNeTTNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvNeTTNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ACCC2BCC4;
	Sat,  9 May 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342040;
	bh=dsn6L52VxnTeNUOtGszavzH1vhlT3rK+e3GO+cFQvOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvNeTTNkTg1YWsz/YmP52oNHnHylADIlQ+kwqGwNkQoy53JVnKO1HvH9AnXm88O/H
	 m8ZIc5iaxTcGiAqHQOrSnK0lKbY2EMNbx+dgJntlT7ZEMYpEm8tS+iTr3lLjdegmyf
	 4eBsYjLy0t0uuhVrEeA6615xBd4jqJHtZTeC5AbPSGThrN7jk/8E4aMOyWdiU3JeqV
	 yR/hsevW8XA9Rx+G4YbyQxlyzQfO8belXSacdQTvWrxxRop/EwiQTwqs5Fyz2LDE0y
	 tVmVmXTLqzUBhlvfbZgt99/kE6PFm1T7Px7mKfifpLcwJw401VhZeiRwqbFqm66NeS
	 L+6VAj9WX4eRw==
Date: Sat, 9 May 2026 18:53:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] keys: use kmalloc_flex in user_preparse
Message-ID: <af9YlFPk3VbZ1kdZ@kernel.org>
References: <20260504093058.49720-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504093058.49720-3-thorsten.blum@linux.dev>

On Mon, May 04, 2026 at 11:31:00AM +0200, Thorsten Blum wrote:
> Use kmalloc_flex() when allocating a new struct user_key_payload in
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

applied, thanks

BR, Jarkko
