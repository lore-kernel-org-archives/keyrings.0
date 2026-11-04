Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836764;
	b=YOS9Id2+TgScfxzfAswla4yDpoPtE8ublCggE2nx0mfWGPoLAG4hkM8RwSziGVkjPZGL
	 DBj1m+nIuSNw8HikO6iBdNztTF+pXsGS4IEWPpel10/rqm6L7R6+WeicH3TeOqfdrZ4N+
	 LrJ1uDEHYp7uqScwviDa2W7P0kxg2dSB5QT9wc13ASXx+/UUfRA6QDW9AU9rgeuxUBlno
	 6z5L48P/KAj13tNrCxEdcQAVRRXm8g3+6HfjcgmKJP3mAQqV7uCS0a4Z2FytotbxyJdM/
	 nMBuXagoLwN4VCSbYp7AJlQvtfaqBNmij1CU1KyjUAlKLVPK1wAob6bA5UlIyXZ2Hqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836764;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NNn4ad7/oPAOaXJZxJAw7tST0rdXHxDOm3+weW6Dswc=;
	b=lE/VsP2Lt9T+zavvrhLWxe/ztLZnFImevI+nIergf1jcN2Hneo6aZBPVMwyNW9nOeMWx
	 7s35utKgLOfwm0lEfzxfKsM1mCqBLoYbNTPxy8up9wiZnAg39UB8lQtJMPLLxye8yAJ2W
	 6oEFDSOYITaJerTnoNqf7cI0rEzU2iDlqOkfUrU/kxXyNlxT0o5gJ+e2hMG8qFNunuXDn
	 pACVXvW0wTRm8n4gTh2KYb7RCg/RP1e/b3+GsV3/ZWI9IW7iEijxZAYyAOeK+JO+mwPWM
	 n5EpdHyC/sKFJ6Lrv3vtCxhu3FK4kI1FPRvgnTW+MFyEhzP6BUhSTp/BciJac5qXdvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhdh2KI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 626A0606A326;
	Wed,  4 Nov 2026 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhdh2KI8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 786931F000C1;
	Wed,  4 Nov 2026 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836764;
	bh=NNn4ad7/oPAOaXJZxJAw7tST0rdXHxDOm3+weW6Dswc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mhdh2KI8bsjC19frEDqKnwLQslBBRvMo1/TZWNfisfmAX5+NUV4z9aK9W46TtW4gV
	 od+lZsr0pE3S969tT/xlZO0nyPqctyUKznDBcemcbatC01M3iDR7gXk2AsMPmxYOUG
	 R5nLPRaXtXluWFzEK17eN9MK7OJ6Kleaz5s50zGTERplERDFUl7NKh2IuE925hM+2c
	 wYgnVjq35k59X4e9utkilGHUwWTofQfWSAz3SGJbKV0n9Euf7tMv7zHrl02Rdfr11i
	 GB47TlExB5RNglUEMFqsh3WhqkKGf08P1Jg7BFqjoLXV6vSRRNi6UU41m8yP1jVkKA
	 pihfEyPIFYZ6g==
Date: Thu, 5 Nov 2026 01:59:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: BeaCox <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type removal
Message-ID: <auvG1wGifSsoCuaQ@kernel.org>
References: <aun7J2NGn57RGS5J@kernel.org>
 <20261104021414.50696-1-0xbeac@gmail.com>
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
In-Reply-To: <20261104021414.50696-1-0xbeac@gmail.com>

Please respond to any questions *before* sending a follow-up patch by
properly using email client and quoting etc.

https://docs.kernel.org/process/email-clients.html

On Wed, Nov 04, 2026 at 10:14:14AM +0800, BeaCox wrote:
> @@ -129,7 +126,14 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  	if (ret < 0)
>  		return ret;
>  
> +	down_read(&params->key->sem);
> +	ret = -EOPNOTSUPP;
> +	if (!params->key->type->asym_query) {
		ret -EOPNOTSUPP;
> +		goto out_unlock;
	}
	

> +
>  	ret = params->key->type->asym_query(params, &info);

There should be an empty line prepending the label.

> +out_unlock:
> +	up_read(&params->key->sem);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -185,15 +189,25 @@ long keyctl_pkey_query(key_serial_t id,
>  	if (ret < 0)
>  		goto error;
>  
> +	down_read(&params.key->sem);
> +	ret = -EOPNOTSUPP;
> +	if (!params.key->type->asym_query)
> +		goto error_unlock;

Ditto.

> +
>  	ret = params.key->type->asym_query(&params, &res);
>  	if (ret < 0)
> -		goto error;
> +		goto error_unlock;
> +
> +	up_read(&params.key->sem);
>  
>  	ret = -EFAULT;
>  	if (copy_to_user(_res, &res, sizeof(res)) == 0 &&
>  	    clear_user(_res->__spare, sizeof(_res->__spare)) == 0)
>  		ret = 0;

Why up_read is not here?

> +	goto error;  
> +error_unlock:
> +	up_read(&params.key->sem);
>  error:
>  	keyctl_pkey_params_free(&params);
>  	return ret;
> @@ -230,9 +244,21 @@ long keyctl_pkey_e_d_s(int op,
>  	if (ret < 0)
>  		goto error_params;
>  
> +	in = memdup_user(_in, params.in_len);
> +	if (IS_ERR(in)) {
> +		ret = PTR_ERR(in);
> +		goto error_params;
> +	}
> +
> +	ret = -ENOMEM;
> +	out = kmalloc(params.out_len, GFP_KERNEL);
> +	if (!out)
> +		goto error_in;
> +
> +	down_read(&params.key->sem);
>  	ret = -EOPNOTSUPP;
>  	if (!params.key->type->asym_eds_op)
> -		goto error_params;
> +		goto error_unlock;
>  
>  	switch (op) {
>  	case KEYCTL_PKEY_ENCRYPT:
> @@ -246,27 +272,18 @@ long keyctl_pkey_e_d_s(int op,
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;
> -		goto error_params;
> +		goto error_unlock;
>  	}
>  
> -	in = memdup_user(_in, params.in_len);
> -	if (IS_ERR(in)) {
> -		ret = PTR_ERR(in);
> -		goto error_params;
> -	}
> -
> -	ret = -ENOMEM;
> -	out = kmalloc(params.out_len, GFP_KERNEL);
> -	if (!out)
> -		goto error_in;
> -
>  	ret = params.key->type->asym_eds_op(&params, in, out);
> -	if (ret < 0)
> -		goto error_out;
> +	up_read(&params.key->sem);
>  
> -	if (copy_to_user(_out, out, ret) != 0)
> +	if (ret >= 0 && copy_to_user(_out, out, ret) != 0)
>  		ret = -EFAULT;
> +	goto error_out;

Please figure this part out it does not do a great job minimizing the diff.

There were similar repeating issues that I did not specifically point
out.

Br, Jarkko
