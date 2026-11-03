Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719084;
	b=Ba+cG1hhF9uCq4N9PjTc3ERFUzMWEaMYRtzq96mcQwRJjsayEszzYs5tfeKEY55vcDgr
	 izAp94eP45KErtd23/FR1kTG7DC9HP7Wn0+zS0nRuilW1wrZgOBJfjLu1TRJoN6z4f+/K
	 T+OCPQ6EuTkD714kC3WSSCa//7C/+jMVaf+QtQjyPEtLKS0WXXJHr+v8fjV4HSq5GUUc4
	 Pt3uRPJLJDduh8K3OKCPjCghJfXD7CiwG+5a4HLS65bhGC1RjnuVCPc4PWY9wYKEkXRWf
	 mAEieMUGLi5ri0pN3QSZ4uhN981SIX/3wXF+IARJl5T6HhRpRMYWPZXq5MOG4qZev/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719084;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x24HWcesDLkzwKMsxfUyjrFNk3ZcW1m0h09LmKp8pFw=;
	b=bua955JAf0navOqxCyoAaIX2nYjTwpw9A+3Q8L37rkc7Pxo26Jr00FSodAtpufMLglro
	 srl8XA/uJ9W4B7YNtgy6vEe2t3eRT/bLh0JsU25AJbQMJ2h/ELsuBXwsobEVPNA9txK4f
	 ao3iiww7RAC2OmY+enIZrxShbA4olETsaJvwrS99HycN2VXzhnxXzn+DfVdXg5nhd5dA1
	 t6eFTGqh3lAK1RbydCJUSWndwkjoG/CMtNX1sAklQtPTuIiAta/PiDAZrFIXTwsFEX0tY
	 UtAPi1/0o3Y8QyJ5uFOjzQZwDJhVgS0R0/HsBedVaF6m1uZ/b5Gcy2+UpJao0eDKHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy9ARUW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 77438606A7AB;
	Tue,  3 Nov 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy9ARUW0
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 56E081F00919;
	Tue,  3 Nov 2026 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719083;
	bh=x24HWcesDLkzwKMsxfUyjrFNk3ZcW1m0h09LmKp8pFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zy9ARUW0h5LN/Odh3E2AhEkSUzwgz0etIabqlw3K2PWSYih1Rcb7rK9s05d75BI/x
	 TsJGCW4+OxnAwJknVC3uOActRJ1eZ5oqUpL8vkbrm+XfYpOWIr1U7Or2eu042soHBb
	 RY/8aZ4R5i7bO41GLCLr82B1bEQubCLfxb8xt00RialjNp+0ljfGt0+D22GZExC+OR
	 5NmuKLA9h5kqBA5ae8oP/IYWXa53JsALhA6ZCxdBwQOAR8ToMDuLZFYxa9omJHrNV1
	 LzycX6HZOjH9srqmOtIfs4ykYjWiQ4WvWOUgduiTqGN6pbF2PvzjsgIpt7ZF7Otq/2
	 NiwROVcpRnOSw==
Date: Tue, 3 Nov 2026 17:17:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: BeaCox <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Protect pkey method checks against type removal
Message-ID: <aun7J2NGn57RGS5J@kernel.org>
References: <20261103032940.51826-1-0xbeac@gmail.com>
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
In-Reply-To: <20261103032940.51826-1-0xbeac@gmail.com>

On Tue, Nov 03, 2026 at 11:29:40AM +0800, BeaCox wrote:
> keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
> key->type->asym_* outside key->sem.  A reference keeps the key alive, but
> does not pin the module providing its type.
> 
> unregister_key_type() calls key_gc_keytype(), which retypes every
> remaining key of the type to key_type_dead under key->sem for writing.
> The pkey paths read key->type again after their checks, so a concurrent
> module unload can turn the checked callback into the NULL key_type_dead
> member and call through a NULL function pointer, e.g.:
> 
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
>                                        GC: down_write(&key->sem)
>                                        GC: retype to key_type_dead
>                                        GC: up_write(&key->sem)
>                                      free_module()
>     in = memdup_user(...)
>     key->type->asym_eds_op(...)      -> NULL call
> 
> In-tree, turris-signing-key provides such methods; out-of-tree asymmetric
> key types are affected as well.

OOT-whatever should be knowingly ignored. We do not care about that
side.

> 
> Hold key->sem for reading from the lookup until the parameter block is
> freed, so the type cannot be retired between the method check and the
> matching call.
> 
> This is the same type-removal problem recently fixed for the read
> (925c84e3cc21) and update (aef3a8a4f988) methods.

This is not as this code change effectively changes ownership of the
semaphore, which is not a great idea.

> 
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>
> ---
>  security/keys/keyctl_pkey.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6..b7e3648 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -17,7 +17,10 @@
>  static void keyctl_pkey_params_free(struct kernel_pkey_params *params)
>  {
>  	kfree(params->info);
> -	key_put(params->key);
> +	if (params->key) {
> +		up_read(&params->key->sem);
> +		key_put(params->key);
> +	}
>  }
>  
>  enum {
> @@ -100,6 +103,7 @@ static int keyctl_pkey_params_get(key_serial_t id,
>  		return PTR_ERR(key_ref);
>  	params->key = key_ref_to_ptr(key_ref);
>  
> +	down_read(&params->key->sem);
>  	if (!params->key->type->asym_query)
>  		return -EOPNOTSUPP;
>  
> 

Br, Jarkko
