Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA523451B5;
	Sat, 10 Oct 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667465; cv=none; b=Xb9fNAKtK8Xn0UZOfpaAFq89eczIbTrylrGIZa1E4z6y5wEDEJubNkhhuM+gdHSKHje0iIVvzIrqSm3EyLeN3s4Hjjmtwg5jve7pjWafq6WQdrj7ZnIB5pnNzD550TG1xPJhD3AGWYjXbqMvE/jRRDsgmdvBJHleSywg5RCUJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667465; c=relaxed/simple;
	bh=PQIc33haqgfB37R9stfcBA66YFExdO+vCOa5OnWXm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkeA8qRdl9jm03lNBz3xi0yYlImI6ymPamMyYV7XozGxMUrKp55UQ9fSMnVfe4Wfu2KKXZImdvNU1SEvLxviw8OlPfm0AabmoP14+sjlIeQ6+T7A6RhxP5MV2Zpf4VsD+hQjp0u2YjajkE7cQ+O0eRxh+UcKEWzGEUYJAdr/L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwM/2b1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwM/2b1e"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C6EF31F000FF;
	Sat, 10 Oct 2026 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791667464;
	bh=QWHSjEKCe02bd/smuesOf/w4AU5v5XzesQ7Kwu/UJXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AwM/2b1ezf1XGwLA3JWq72alTLNCufFZ+3trhjUQGYCMA2sr2pU6CCyGQ2tOswaio
	 VPKOGOQUaQgrTO5AX2EMRuRceZBW5eGoTjHVkzycuSDK4sI4CnON5g9x6FHZQ24tny
	 1UF+39EGSGSAW49E8ipoQ9dxMX9VEviffkA1CPlBaivRWh8VY6CYQA5dMFMgs96QWR
	 eQj7iHZ1a5drnr5Ba7lbtbWc9cDFa8/1ptN+HP+RG5uLuGkbAYzyBemT6HNAmlZD7w
	 tTONRBFASI758ZboJdA1gEM2MWus307K2dWIzm1GD8n4dNXqYU0fY4is6mF6TBBx0+
	 J8dkYJRndbmpQ==
Date: Sun, 11 Oct 2026 00:24:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Check the authorization payload in process keyring
 searches
Message-ID: <asqtBDX8112XvcRT@kernel.org>
References: <pm-key-management-objects-candidate-0004-v3-598361863b76bc25d58d@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0004-v3-598361863b76bc25d58d@gmail.com>

On Fri, Oct 09, 2026 at 01:52:16PM +0800, Cen Zhang wrote:
> An authorization payload and its saved credentials must remain valid
> while search_process_keyrings_rcu() searches the requestor's keyrings.
> The function validates the authorization key, then separately loads
> payload.data[0] and unconditionally reads rka->cred. Validation does
> not prevent request_key_auth_revoke() from clearing the payload.
> 
> A request-key helper can assume authority and fork a descendant that
> inherits the authorization key. If the descendant misses in its own
> keyrings, it falls back to the saved requestor credentials. Successful
> target instantiation invalidates the authorization key without clearing
> the payload. After the helper exits, UMH_WAIT_PROC returns to the
> requester, which calls complete_request_key() and revokes that key.
> 
> With the descendant paused after validation, the paths can interleave
> as follows:
> 
>   1. The descendant enters search_process_keyrings_rcu() under RCU and
>      key_validate() succeeds.
>   2. The helper instantiates the target, invalidates the authorization
>      key, and exits.
>   3. The requester resumes from UMH_WAIT_PROC, calls
>      complete_request_key(), and revokes the authorization key.
>      request_key_auth_revoke() sets its payload pointer to NULL.
>   4. The descendant loads NULL and dereferences rka->cred.
> 
> This NULL dereference can oops the kernel. RCU delays payload disposal
> but does not prevent the pointer from being cleared.
> 
> Load the payload with dereference_key_rcu() and require a non-NULL
> result before validating the authorization key and searching its saved
> credentials. A non-NULL payload and its credentials remain alive for
> the caller's RCU read-side section; a cleared payload skips the fallback
> search and follows the existing error selection.
> 
> KASAN report as below:
> 
>     Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
>     KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>     RIP: 0010:search_process_keyrings_rcu+0x32b/0x790
> 
> Fixes: e59428f721ee ("keys: Move the RCU locks outwards from the keyring search functions")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index a63c46bb2d148080add6a194579f7b1093c04d82..76da13fa07fab70115966e9ea8360af66390dd85 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -556,9 +556,8 @@ key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
>  	    ) {
>  		const struct cred *cred = ctx->cred;
>  
> -		if (key_validate(cred->request_key_auth) == 0) {
> -			rka = ctx->cred->request_key_auth->payload.data[0];
> -
> +		rka = dereference_key_rcu(cred->request_key_auth);
> +		if (rka && key_validate(cred->request_key_auth) == 0) {
>  			//// was search_process_keyrings() [ie. recursive]
>  			ctx->cred = rka->cred;
>  			key_ref = search_cred_keyrings_rcu(ctx);

Thanks.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


Br, Jarkko
