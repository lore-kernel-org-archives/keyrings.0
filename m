Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5D385D7C;
	Sat, 10 Oct 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662020; cv=none; b=MhFS1VhoGg/hUhXMf4EZxl0JSAwlaTkjpdgwfq/3YdqPfnxve1HNn9iqvAQ/ByqWgOEbTAbtUrQyDp8fz2pBNUvsrYxT0jvpfxFARFD/IjsL/KPq8C4QMEEc0e6uqZGf+dl2F8akKpc1rQhulRQDNnbjSw5eVEMLu0RuhYfU/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662020; c=relaxed/simple;
	bh=o25rMvwXhN6gagijvoSmhCKUwRkyBq9pC7OQJg0KhKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo3rCdcv5zGMr/t0o/xsmGOPv1nlBGqeJkJ0I1uk1kDJ3SGWGysaqi323/F4AFPyCLUtWUGnEAxBfbW9SrKavX9/swEDpB5TBmaxKObjkU96A5ZBvdmOkk9DIVYXt4scMdAtOjZBQfSYoXoHS7jSZWT5wSGT6wihhCUs+CRWq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQqR2sz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQqR2sz7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A46F1F000FF;
	Sat, 10 Oct 2026 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791662016;
	bh=TuRXeDXfZM/+AKwdYxRXsJ9n/9s3vZGm6snWt6hQnZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LQqR2sz7ExdOO5sAV44PFFE3ZUMkkgMM9wtzTdT3jsUr9xTABlRtSe2OI4js6oXGV
	 Z8FSFVn6B1bqtIvW5nih1eJlavBRRI+xt0CUgFSbIyt7kKK9lGOiZQj6xdeQiK5nKa
	 tpIvj4f+XHpAa/LG6DiADdz3FtBCY0TAOmg/KK6bZTEd8Z2t1OsbwvVpGcF5rqqVn8
	 giU107VWyk0is4wnQa3WKAj7Ko6A8G7BDulqog/RKZsMWW+ilBBM7XnpW2WQKvqEtB
	 OGnyikRkpnBwaLOGRXCsBbgs0OoZwML3/Qb3iuO/n7a0HQIjr6a5Dll9SbpwVjP+05
	 5Fusy2OlWVtyA==
Date: Sat, 10 Oct 2026 22:53:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Protect the type name while describing a key
Message-ID: <asqXvNRlSgXYn2C5@kernel.org>
References: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>

On Fri, Oct 09, 2026 at 01:11:03PM +0800, Cen Zhang wrote:
> keyctl_describe_key() must keep the key type's name alive until
> kasprintf() has consumed it. The retained key reference keeps the key
> and its description alive, but does not pin the module providing its
> type. The name is passed to kasprintf() without holding key->sem.
> 
> kvasprintf() uses the saved name pointer in two formatting passes, with
> a GFP_KERNEL allocation between them. With AF_RXRPC=m, a task that
> passes View permission before type retirement can overlap a privileged
> module unload in this order:
> 
> 1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
>    kasprintf() arguments and completes the first formatting pass.
> 2. While the formatter is delayed before its second pass,
>    af_rxrpc_exit() calls unregister_key_type(), which removes the type
>    from the registry and waits for key_gc_keytype().
> 3. The collector takes key->sem for writing, retypes the retained key
>    to key_type_dead and completes retirement. Unregistration and module
>    exit return, allowing free_module() to release the type and name.
> 4. The formatter resumes its second pass and reads the saved name from
>    released module storage, which can fault in string().
> 
> Hold key->sem for reading across kasprintf(). The collector then cannot
> retype the key or complete retirement until both formatting passes have
> finished. If retirement wins the lock first, formatting uses the core
> key_type_dead name instead. Release the semaphore immediately after
> kasprintf(), including on allocation failure, before copying to
> userspace.
> 
> Oops report as below:
> 
>     BUG: unable to handle page fault for address: fffffbfff8054794
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:string+0x23f/0x470
>     Call Trace:
>      vsnprintf+0x330/0x1110
> 
> Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to/from userspace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Changes in v2:
> - Trim the Oops report to the fault location and vsnprintf frame.
> 
> Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529cb77de5386f1f3a99905d4b7688c..5a5efa26ed0ece3a5ab22e37ad7bda7a5a744b83 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
>  
>  	/* calculate how much information we're going to return */
>  	ret = -ENOMEM;
> +	down_read(&key->sem);
>  	infobuf = kasprintf(GFP_KERNEL,
>  			    "%s;%d;%d;%08x;",
>  			    key->type->name,
>  			    from_kuid_munged(current_user_ns(), key->uid),
>  			    from_kgid_munged(current_user_ns(), key->gid),
>  			    key->perm);
> +	up_read(&key->sem);
>  	if (!infobuf)
>  		goto error2;
>  	infolen = strlen(infobuf);

This would be even clear without scenario as it is quite obvious that
key->type can swap but I do appreciate having one of the scenarios
documented. Just saying that this is much better commit that would
have gone through :-)

Great work, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
