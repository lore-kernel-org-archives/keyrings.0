Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164469;
	b=Kwnnk//vcEK4iJy7xfSSFdRtZAFQF9SJSAu6+qPFOfc4Ql764K461UDAoppFcpMMNiN6
	 p5RTDDaA5793U0FcUk4nf6v1WlY2f4uF1PaLW8P0wIdpJoj0SSFAs1hCD84xMe7FW8ljT
	 j0csS3YDMRrf+fQHRFqAHwAX58JsA8ArMNCx4pJcPm7Vyijo9bp0EUsq5pEQC0BcZqhZt
	 10zANl4Sk0jcC+txcQcB/n3CSmyisGvzigwesBFCfj+y6kxYc8BKCAZ++LFQzvkzvDsfZ
	 ysA8Xm1anoui1EijscQX8epm2gfsHomtK59QTjVStuycILTodzaZtTiHo8H58Rbkf2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J2OZnMRPZWDr0Ehw9VOaD0buj7IMXLulkbhp4A0eTa4=;
	b=z8UV5HG9kkGd5EH65b13HIoXcoXWZ67RnSvt4BzrS8oyLz6altbXDU7tC6ehfyHqCadO
	 opWJpwCc/Y4rVRk+pxoA4l4ZWtr+ITFMoFYvuvmODCNrLSEPgMw4iiYLIv+5gxADIlz+6
	 QKYy+3IvJOLEeiCm0jOafL9t+Y1Fjjsd1XvHvMnNRUWni3R969hXGm9jSJDW+ybiMfR2g
	 O40xbM9Smd49PTQT8fTypgKs8onTG50N81/36qwF75YGPDS8lYM5xYjF+iIlYlZRXdSqx
	 M5/MPy1u0VHAMKyN16AJnO3lLBy5sbbb5Fn73sg4yMHvBtDQNUbEPSZ2DrzCsCijQ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGCK5gXB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F12ED606A31C;
	Sun,  8 Nov 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGCK5gXB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F199B1F0089F;
	Sun,  8 Nov 2026 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794164468;
	bh=J2OZnMRPZWDr0Ehw9VOaD0buj7IMXLulkbhp4A0eTa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGCK5gXBoyab/ta/SrHISmqSENnoR5Yy57b6ND2h21QajmEXa4Nzeex3iAw43Wn4y
	 xr4OGx7G1azZrBkbe6y6guMYZGtnktPN9v9hvve6rFvziMAeifc1S4WBAAwXpP3e/6
	 Oba+FdG0DW4qYqZ1B6uYGp4P4MYBHDwTiLTDYL83bNnSfwUjp5ooHdCif2LMO9AtoZ
	 hQdhv2urLRYojj1FTzs3B+gQkwXKVv8NS4ByCfC+Wf9q/YCDdGtLjyn5jHOVBsiURR
	 wun2eP0y5HxLXrkvPMF6xH+cXDjnpNkMT/i/sHTZXgOIzjsgNRX2NL27O6Un00lDNs
	 AKsDNIsKrQ41Q==
Date: Sun, 8 Nov 2026 21:01:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: do not let an unmatched key decide the search
 result
Message-ID: <avDG8G-Jl1YsmfCs@kernel.org>
References: <20261108131413.12012-2-weiguixiong@bytedance.com>
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
In-Reply-To: <20261108131413.12012-2-weiguixiong@bytedance.com>

On Sun, Nov 08, 2026 at 09:14:12PM +0800, Guixiong Wei wrote:
> KEYCTL_SEARCH returns -ENOKEY, -EKEYREVOKED, or -EKEYEXPIRED for the key
> selected by type and description.  keyring_search_iterator() currently
> records revoked or expired state before asking the key type whether the key
> matches.

I don't understand the "asking the key type or" part here. Please,
explain what you mean.

> 
> Direct lookup visits the indexed description, so that ordering normally

"Direct lookup visits the indexed description"

I don't honestly understand this type of jargon, which is all over the
place.

> does not matter.  Iterative lookup visits every key of the requested type,
> however.  The in-tree asymmetric id/ex/dn lookups and dns_resolver use this
> mode.  A revoked key with a different description can therefore make
> KEYCTL_SEARCH return -EKEYREVOKED instead of continuing the search.  It can
> also prevent request_key_and_link() from issuing an upcall because that
> path only upcalls after -EAGAIN.  An unmatched expired key similarly
> pollutes searches that do not set KEYRING_SEARCH_SKIP_EXPIRED; the request
> path itself sets that flag.
> 
> Run the type comparator before recording state errors, so only a key that
> matches the caller's criterion can decide the search result.


Can you describe instead describe the what goes wrong with an example,
which does not require much effort:

	keyctl new_session >/dev/null
	A=$(printf '127.0.0.1\0' | keyctl padd dns_resolver foo @s)
	keyctl revoke "$A"
	keyctl search @s dns_resolver bar

Results:

	keyctl_search: Key has been revoked

This example alone is not of course enough because it is lacking
explanation what goes wrong, which is neither clearly described by
the commit message but you could add my reported-by because at
least I constructe a real bug report that justifies this fix.


> 
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> ---
>  security/keys/keyring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 7143f3079d200..39645b8f9b30c 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -598,6 +598,12 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
>  		return 0;
>  	}
>  
> +	/* A key the caller did not ask for must not decide the result. */
> +	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
> +		kleave(" = 0 [!match]");
> +		return 0;
> +	}
> +
>  	/* skip invalidated, revoked and expired keys */
>  	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
>  		time64_t expiry = READ_ONCE(key->expiry);
> @@ -617,12 +623,6 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
>  		}
>  	}
>  
> -	/* keys that don't match */
> -	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
> -		kleave(" = 0 [!match]");
> -		return 0;
> -	}
> -
>  	/* key must have search permissions */
>  	if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
>  	    key_task_permission(make_key_ref(key, ctx->possessed),
> -- 
> 2.55.0

Br, Jarkko
