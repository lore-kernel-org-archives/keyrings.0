Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440234;
	b=EMcUrVTysIkLjZ5sBeg6mfEbTe1ihrp1qUD7/HY2SpLB7zMbzbsIWkOHY7XcVLrjhcb/
	 5CntEw3qr2RbMnWHVJTraC+fLyIx/VNMYfk3xC0BhNczEENwvj6tr7tWy49v1mUSXKSFn
	 P9Ev5b4fL9mn53dy9gaJPh9bMgP73FXg7++R2kER77qATjDaM350L0fNSPIwbYpxkjSQz
	 1Z7D6BDPFY9hz5sR0fW9C9SKN0gTOIdgmF9Tu1mmQs+CcuIFdAcfqLtdto5n4AcWqtzq9
	 2tj0r7lwOKtUdiJH+7DXmFdhEDrDOjE6yb7A9DGMq0XdTzJIZHQHcUggEj46pXzz7Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440234;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=km7+5bxn6+/GEe9g7YXFirTDc3Wlqa6U9gbRkERxxbQ=;
	b=IKC14bpQ5CY/Sq5vFBtcUPeUCL2Ml/K/gcmZtyYc/I4yr9EmGiJYV3xvwCbbrSqrthFu
	 yeZP5pH0JM/JZGP3wcVLNjQM2ck0YEZiOgYHlvEadJ9VUClprO8KQXY4QjgDgVGU9H6WH
	 QoBLz1TghcXGgb37x1RNJmtapVuUq1aEbNFWwJ5yA9a2cUICKjHfzN+PW/GBxgQhyM+go
	 PhKZYnaPb/RRnsK47sh6FSbA5uZzqSZgiGiVIv3wVs/WBiZ4sE9aA+ka4ymSQ0Y2rBMkp
	 fTfXWifO2uK8lWuYnjC9DhdSIImFLIqaX8p6FUD5cKKwr64ec+GWr0QcY8hbfXpCDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQY6CxfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 207C1606A31F;
	Sat, 31 Oct 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQY6CxfR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 72E041F0093A;
	Sat, 31 Oct 2026 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440234;
	bh=km7+5bxn6+/GEe9g7YXFirTDc3Wlqa6U9gbRkERxxbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQY6CxfRlDxXObDjvGWVxJ4p2ErigmZMcSLrrUq/YxRq4fOP3n5fNlclzftM+gNQ5
	 v/eHLmhWAlk29TsnQ6fL5gG7nBeGIrQrXJ6Ny7M4G3ik3QY8JzrPRM6yjAjRlTicYN
	 P8h5Fnn4pPK2XZGKQeZSbAab6K0XnYUzQeh/ums/8takpqFjZ0kjdPIlPetgFsak/w
	 ai9q8N2HZ9P3NqOgBMRY7mqf8yrSXf5YI8BHLudmeNJbVgthZzA3e0YDs3e+1MPZzl
	 DjoFYj9+hd0xD4PqPh5ZSqzqVCo+dQJ71LasUHKx8J0m67GQLNkKcDdsZ7z7j6DyVP
	 fCE4hVa9ZxOlw==
Date: Sat, 31 Oct 2026 11:50:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v3] keys: Protect the update method check against type
 removal
Message-ID: <auW55lFj1MZZcWIo@kernel.org>
References: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>

On Sat, Oct 31, 2026 at 05:26:36PM +0800, Cen Zhang wrote:
> +out_free_preparse:
>  	if (key->type->preparse)
>  		key->type->free_preparse(&prep);
> +
> +out:
> +	up_write(&key->sem);
>  	return ret;
>  }
>  EXPORT_SYMBOL(key_update);
> 
> base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
> -- 
> 2.43.0
> 

Thanks for taking the trouble addressing this part.

I'll apply it soon'ish.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
