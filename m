Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF633B6FB;
	Sun, 18 Oct 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288815; cv=none; b=tn/qLA8wvizRp+LFSEQD+oLDU4UZpPd+uTuAWY+ny57+dzqcxkYCRGitRuovRFiOA0Wbo1zfi1i5FZ8GnPBAT5m/xNO07jRPMRDXdiiRJJOhDW1DqGinXKc9lhybNI8L3LRYc/C5dOPWCfcTlp3axoaxL8ZfY8t0d13KSDXAkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288815; c=relaxed/simple;
	bh=YiO4/TQJ7tRHegRgl99iob/Vjniu6waGoillfU/V2+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlolWfwHhd1AB7BNlqqzAW+i7G9fA/U09gXGdvyeXQYvHDDLSwvTrqkhBwD/nE2RRcK2WR33Gdb4neGxuM1iuZBlcPdAk2fXubjHP6oiq2I6AUCKdGPsJu59jZ1Yq5k6+UXfTrQs/RTeBe4h1u9KULJOgsZUdvBUgp5J19BTg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBVrK9YD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBVrK9YD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B2A9E1F000C4;
	Sun, 18 Oct 2026 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288814;
	bh=7nCdyqQEN3kYt2DTyrV3GI5+K6iZG9zsVLaL/EWesB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MBVrK9YDjDD44n6HSwGbR5rqLNuK/Gfd8aDXlXegELmq6vavw/ek7qEqEdUkD+stA
	 LYu6y2lQGLQtlOdwd3CJ4+wHrgSTz1KSpU6NJtoUc1MiKYrjF3qDHYWj2za+FE+6bG
	 AfaOzUFjjUesZHoii1KokRF2OSUL4l3O8M2YAZ2x/SaMvglMRbQ4NlzNZHSMgIGnOq
	 v6TP6YVV7yjkwftTIMsjyGNQWRIG9fA/SKiYQT8Y1Rrh5ZpgT2og5DsOgnkkeQaLiU
	 M9LX7D83GiJRXgG5RGze3mjMAi15g5X6gZ6V4lEenT/QVDXTy+bh7xO6/cMRy2h5yu
	 h1FOXHPyj9C4g==
Date: Sun, 18 Oct 2026 05:00:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Protect the read method check against type removal
Message-ID: <atQoKlA_JfF6JBmc@kernel.org>
References: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>

On Sat, Oct 17, 2026 at 03:30:56PM +0800, Cen Zhang wrote:
> The key type must remain alive while its read method is checked.
> keyctl_read_key() holds a reference to the key, but checks
> key->type->read without holding key->sem. The reference keeps the key
> alive, but does not pin the module containing its type.
> 
> With AF_RXRPC built as a module, a positive RxRPC key can pass
> key_read_state() and the Read permission or possession checks while
> another task unloads the module. Unload is possible once the module
> refcount reaches zero, e.g. when no RxRPC socket remains open. The
> reader can be delayed between loading key->type and reading its read
> member, allowing this order:
> 
>   KEYCTL_READ task                  Module unload and key GC
>   lookup_user_key()
>   key_read_state()
>   key_permission() / is_key_possessed()
>   load key->type
>                                     af_rxrpc_exit()
>                                     unregister_key_type()
>                                     key_gc_keytype() schedules the GC
>                                       pass and waits for it
>                                     GC takes key->sem for writing
>                                     GC retypes key to key_type_dead
>                                     GC releases key->sem
>                                     unregister_key_type() returns
>                                     free_module() frees type storage
>   read saved type's read member
> 
> The last access reads freed module storage and can fault in
> keyctl_read_key(). The later read invocation is already protected by
> key->sem and key_validate() in __keyctl_read_key(), but neither covers
> this earlier check.
> 
> Take key->sem for reading around the read-method check. The garbage
> collector retypes the key under a write hold on key->sem, so it must
> wait for the check to finish; key_gc_keytype() in turn waits for that
> GC pass before unregister_key_type() returns, so the module text cannot
> be freed until the check has completed. If retyping happens first, the
> check sees key_type_dead, which has no read method. Release the
> semaphore before returning -EOPNOTSUPP or proceeding to buffer
> allocation, preserving the early unsupported-operation result and
> keeping user copies outside the semaphore.
> 
> Oops report as below:
> 
>     BUG: unable to handle page fault for address: fffffbfff8048bc5
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:keyctl_read_key+0x1aa/0x600
>     Call Trace:
>      __do_sys_keyctl+0x2a7/0x4f0
> 
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM

Would be better to finish off the work unfinished and fix the patches
under circulation instead of spamming new ones while at it. I.e. fix
them first and don't starvate us with unfinished patches.

If this was merge ready this would be acceptable, but in this even the
tags above are in the wrong order. This is not a lottery machine where
you dump whatever LLM gives you without your attention, so please don't
do that.

> 
> ---
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 5a5efa26ed0e..756368422b7c 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -863,10 +863,13 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  
>  	/* the key is probably readable - now try to read it */
>  can_read_key:
> -	if (!key->type->read) {
> -		ret = -EOPNOTSUPP;
> +	down_read(&key->sem);
> +	ret = -EOPNOTSUPP;
> +	if (key->type->read)
> +		ret = 0;
> +	up_read(&key->sem);
> +	if (ret)
>  		goto key_put_out;
> -	}
>  
>  	if (!buffer || !buflen) {
>  		/* Get the key length from the read method */

Why did you chose this over embedding the check inside __keyctl_read_key()?

I'm assuming you have considered both options.

Br, Jarkko
