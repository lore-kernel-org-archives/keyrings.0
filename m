Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423041;
	b=cnqZmizg0gyaiMnc3zzA8Z9V8ZsCFdBGy+ahXAi/LeA7+ml/L2SBdquUqp4HZAYJLlfs
	 eslcd0l2XxdJMIPcsqtal05G4aXtBS1/+ISv474LajnSnNfNeTGIGSrj8HJg+SKqXKfO2
	 3WcdO85XfN1Afj+YIDhpVHrx0hWQ1r8vRSbThxZt4vqXPvai2pnezKiIF2BI6C2GqNmvO
	 ZKbaw89cYdrqG+7d90WV5fcVoSdEmyVtKov+r8k5jep9up5urqvs0m3TWwmHeh4o5R7C0
	 cQpoiSBGBP04MqhBeul2Z6DrbhjBH3zdWNh350Kig6AK7vNnTPa9YOc60PdDWeEs4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423041;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xy4l8wG3rG513QI4qabh/2kPl1xY6iKJl/GLujmE8Wk=;
	b=k8GTtLEsFalHLKpZJSdexWfVntLxvXLXZrvlgd7ba0ZfnxL2GQ4tYGvguyt9xOtbnbhB
	 2nymzCvY7HP8c0H4aWCO5z2+7Z6tBfn8Wp1dl+e5yuwzZrSc5axUS3NJH/r5u/Q3e3/a4
	 UqWXe6z/8jNFYkKwqNMHX7/EdTW39ZRAfNM94DD5mbuA4AY5HWAno5+iu+NWg+1GzDB8W
	 vjB9XoMMv2DaEOTtZ2G7+tAJ9AT9MKwWgOjyY08M0aUS6U6qrDSidDEFbO6L1pWj4DaKE
	 AqVt3AwRK7W4Xk9KUnn+9wOPRdPh83XI7Uic7mprhSzW5u0wv4fSHaCk5N3I+EinS7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czZpKznS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 307A360A2600;
	Mon, 19 Oct 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czZpKznS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 42F3C1F000C4;
	Mon, 19 Oct 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423040;
	bh=xy4l8wG3rG513QI4qabh/2kPl1xY6iKJl/GLujmE8Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=czZpKznSwxC4JDW4LuOEXxP3atqG0WXomfog1EIFOe6ohBndM72v8oBEI3kCwCKWQ
	 ohbwyNEq67JmhvMH0EfV/lR71Ejb3dG/O+1bA9WGy5v8G89BWDaSnSRFJUb+OYHtVY
	 abTxH+lRFVa215Zczz4sVzZPTGx8oyJrbi9x/ZxjOHLcHNzIDz7rZ+qqpy70OlJeFV
	 UkEiS7o4GtsmkR6JTacv8jB1Yq/q3ZyAhOglB6Mye8d0fjqWP4oBu+7JprqmOX6hP5
	 DESY0hGR6L6fdwXjStQjG5hUYPT4TNJBQgg5K3o1DD7xPFvXY6udMnMsrX68VKrhiq
	 aeHCLHrm8U/CA==
Date: Mon, 19 Oct 2026 18:17:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Protect the read method check against type
 removal
Message-ID: <atY0fRZ_s5UQk8Fk@kernel.org>
References: <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>
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
In-Reply-To: <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>

On Mon, Oct 19, 2026 at 10:57:21PM +0800, Cen Zhang wrote:
> keyctl_read_key() checks key->type->read without holding key->sem.
> A reference keeps the key alive, but does not pin the module containing
> its type. A surviving RxRPC key can therefore be read while AF_RXRPC
> is being unloaded:
> 
>   KEYCTL_READ task                    Module unload and key GC
>   ----------------                   ------------------------
>   lookup_user_key()
>   permission / possession checks
>   load key->type
>                                      af_rxrpc_exit()
>                                        unregister_key_type()
>                                          GC: down_write(key->sem)
>                                          GC: retype to key_type_dead
>                                          GC: up_write(key->sem)
>                                        unregister_key_type() returns
>                                      free_module()
>   read saved type's read member
> 
> The final access can read freed module storage. The read invocation in
> __keyctl_read_key() is already protected by key->sem, but the earlier
> method check is outside that critical section.
> 
> Move the method check into __keyctl_read_key(), after key_validate() and
> under its existing read hold on key->sem. The check and invocation then
> use the same protected type for length queries and every read retry.
> The GC cannot retype the key until the semaphore is released, and type
> unregistration waits for that GC pass before the module can be freed.
> 
> Return -EOPNOTSUPP when validation succeeds and the type has no read
> method. A temporary buffer may now be allocated before this result;
> allocation and copying to userspace remain outside the semaphore.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

I literally described the fix to the reported bug instead of reviewing a
bug fix. That means by practical means that you only reported a bug.
This cannot happen again and if it does, next time I'll just do the
right fix myself and commit to the Git because that matches the reality
the best.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> 
> ---
> Changes in v2:
> - Move the method check into __keyctl_read_key() under its existing read
>   hold on key->sem and remove the outer check.
> - Perform key validation before checking and invoking the read method.
> 
> Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com
> 
>  security/keys/keyctl.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 5a5efa26ed0e..36ffba0ebba6 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -808,8 +808,12 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
>  
>  	down_read(&key->sem);
>  	ret = key_validate(key);
> -	if (ret == 0)
> -		ret = key->type->read(key, buffer, buflen);
> +	if (ret == 0) {
> +		if (key->type->read)
> +			ret = key->type->read(key, buffer, buflen);
> +		else
> +			ret = -EOPNOTSUPP;
> +	}
>  	up_read(&key->sem);
>  	return ret;
>  }
> @@ -863,11 +867,6 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  
>  	/* the key is probably readable - now try to read it */
>  can_read_key:
> -	if (!key->type->read) {
> -		ret = -EOPNOTSUPP;
> -		goto key_put_out;
> -	}
> -
>  	if (!buffer || !buflen) {
>  		/* Get the key length from the read method */
>  		ret = __keyctl_read_key(key, NULL, 0);
> 
> base-commit: 89f5f41d296889f3b896c3ca67fcdf7d42bbdf10
> -- 
> 2.43.0

Br, Jarkko
