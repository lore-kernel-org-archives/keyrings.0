Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540718;
	b=GsZHvG+Sx2rMla5nAMBP8ec4qD7q/Ua55VmbiFRdrYM/V2DDCaLSeAzht89IAt0IlfIi
	 FHlibbJd9naZ9vMJdJPOBknmXJKvOVfAVnzzoHg9Q+b3oxUXZZuYwj2dS6vjR5wI6wS0X
	 ocHDYFLBV/S72uhAh5InG4QBb7kyL6b1I2DHFy7KjtkGqqmhbYMag4c8Wg5MDBFdp4moN
	 OW812AWqWQLf66pKrboh7qUQYoGho4G4w9quZ7eYvK6eX7CYpVSTDEOK4ycbAfdlRORg4
	 LXLZylNMiQR47cHfdXwwlXhqC68NZv+ESAY0k6zp0FSB7yYU7DWW6LpeNvh+XRwl7zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=soJkr184OzWpwDgsoaY68pRGyt4XwVTMqpDdnHjHds0=;
	b=e6aCM0A3nfPx2CZY+prnJiZcwzlxHkDh7X1WZwX2pKWH6t3i2whpaFnBX/mgJX+ZEXUd
	 Autkm+2/ZrZhvL5WdjbA9wwIJhv0ROpxSv+uDABS42kbIkyhxjUesJfQeGw094jLkFed5
	 SpjYzgtxfnaYIak8gFptQCDyc0CkZLesO6qxP6Vd+E5rtgxs+MO/tPqK8RDCnmCVQjv2B
	 unLh8viEEmYnyge0uQ3jLLLXWVPU4oeo1u7WxcnI/0O632BrWEsxB0Yl2TZTgfh/map4N
	 U/JrMMBY+FxIeqB2yoIWEw4f82cBubY+fe8zd3X9LWxGhEIE9Sz+793cYdR7UCeP6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeAJP7rq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 93295606A333;
	Tue, 24 Nov 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeAJP7rq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9E0A31F000D4;
	Tue, 24 Nov 2026 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540718;
	bh=soJkr184OzWpwDgsoaY68pRGyt4XwVTMqpDdnHjHds0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OeAJP7rqeF5fhHtCGxSIyjakVHmz9pmbHe6/jkkhDmu1cYueKA9xSezT6evR4vN5S
	 uIvxnaj+2OibkbIysQTEOD13yBmTM7ZyskbqetfrcJh1LArTwOwqd4dmdn505thhNJ
	 H631sOpWNHeyfHk9HWVdHdIJKtH8osV7tKyqfZfpKSQBvR6r+fRuFCWaOWfqogElkJ
	 xEPFuF0J3pxylSj6nXnBDVAOl6jo2j0/NxFcUKbbmnQXP/nzyUzoS79BG22+UzL6mV
	 ZSzv9dLH7dciBMggP4Ggk1mKNrQr/V697Lm4mr6DE4Y2CZ6weHIPQoCn2hTvRVTR04
	 ZuVtQEffoL33Q==
Date: Tue, 24 Nov 2026 19:18:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] KEYS: Use kfree_sensitive() in keyctl_pkey_e_d_s()
Message-ID: <awXG6k1HFYsE2wE5@kernel.org>
References: <20261124052849.940005-1-maguicai@kylinos.cn>
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
In-Reply-To: <20261124052849.940005-1-maguicai@kylinos.cn>

On Tue, Nov 24, 2026 at 12:28:49AM -0500, Guicai Ma wrote:
> keyctl_pkey_e_d_s() frees the temporary 'in' and 'out' buffers with
> kfree(). For encrypt, decrypt and sign operations these buffers hold
> plaintext or other sensitive data.
> 
> Free them with kfree_sensitive() instead.
> 
> Closes: https://sashiko.dev/#/bug/linux-4199b169-0b8d-4055-9a71-6b5b79e38eb3
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
> ---
>  security/keys/keyctl_pkey.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index e7121523b9c9..8d2c2b65f50b 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -314,9 +314,9 @@ long keyctl_pkey_e_d_s(int op,
>  		ret = -EFAULT;
>  
>  error_out:
> -	kfree(out);
> +	kfree_sensitive(out);
>  error_in:
> -	kfree(in);
> +	kfree_sensitive(in);
>  error_params:
>  	keyctl_pkey_params_free(&params);
>  	return ret;
> -- 
> 2.47.3

Thanks applied.

Br, Jarkko
